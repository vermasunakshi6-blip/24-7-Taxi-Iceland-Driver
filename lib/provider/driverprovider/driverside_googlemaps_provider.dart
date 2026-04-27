// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'package:taxi_driver_24_7/model/current_ride_driver_model.dart' ;
import 'package:taxi_driver_24_7/model/get_stops_model.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';
import 'package:taxi_driver_24_7/screen/driver/home/ratecustomer.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/progress_dialog.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';

import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';

class DriveSideGoogleMapsProvider extends ChangeNotifier {
  final cancelResons = [
    'No face cover or mask',
    'Not safe to pick up',
    'Customer has an animal',
    'Personal issue',
    'Customer behavior',
    'Rider doesn’t show up',
    'Problem with pick up route',
    'Too many riders',
    'Unaccompanied minor',
    'Vehicle issue',
    'Rider’s items don’t fit',
    'No where to stop',
  ];
  List<Polyline> polylines = [];
  String? reason;
  double rating = 0.0;
  final TextEditingController comments = TextEditingController();
  bool isArrived = false;
  bool isRideStart = false;
  final DriverApiCall apiCall = DriverApiCall();
  bool isloading = false;
  LocationData? currentLocation;
  final Completer<GoogleMapController> controller = Completer();
  Data? userRideDetail;
Data? get userRideDetaildata => userRideDetail;
  String? fromLocationLangitute;
  String? fromLocationlatitute;
  String? tolocationlangitute;
  String? tolocationlatitute;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverIcon = BitmapDescriptor.defaultMarker;
  List<StopsData> stopsList =  [];

  void init(BuildContext context,String rideId, String driverId)async {
   await checks();
    await currentRideDetails(context,driverId);
   await getCurrentLocation();
  
    notifyListeners();
  }
  void selectCancelReason(String value){
    reason = value;
    notifyListeners();
  }

  Future<void> checks() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getBool(PrefConstant.isArrived) ?? false) {
      isArrived = false;
    } else if (prefs.getBool(PrefConstant.isStart) ?? false) {
      isArrived = true;
      isRideStart = true;
      notifyListeners();
    }
  }
Future<void> currentRideDetails( BuildContext context,String driverId) async {
    isloading = true;
    notifyListeners();
    final response = await apiCall.getCurrentRideDriver( context,driverId);
    isloading = false;
    notifyListeners();
    if (response.status == 1) {
      fromLocationlatitute = response.data![0].fromLocation!.coordinates![1].toString();
      fromLocationLangitute = response.data![0].fromLocation!.coordinates![0].toString();
      tolocationlatitute = response.data![0].toLocation!.coordinates![1].toString();
      tolocationlangitute = response.data![0].toLocation!.coordinates![0].toString();
      userRideDetail = response.data![0];
    
      notifyListeners();
    }
    else{
      userRideDetail = null;
    }
  }

  Future<void> getCurrentLocation() async {
    // Defer to avoid iOS main-thread location warning (authorization callback)
    await Future.delayed(Duration.zero);
    Location location = Location();
   await location.getLocation().then(
      (location) {
        currentLocation = location;
        notifyListeners();
      },
    );

    GoogleMapController googleMapController = await controller.future;
    location.onLocationChanged.listen(
      (newLoc) {
        currentLocation = newLoc;
        notifyListeners(); // Rebuild map so driver car marker moves
        googleMapController.animateCamera(
          CameraUpdate.newCameraPosition(
            CameraPosition(
              zoom: 14.5,
              target: LatLng(
                newLoc.latitude!,
                newLoc.longitude!,
              ),
            ),
          ),
        );
      },
    );
    notifyListeners();
  }

  Future<void> arrivetoCustomer(BuildContext context,String rideId, String driverId) async {
    apiCall.arrivetoCustomer(context,rideId, driverId);
    SharedPreferences prefs = await SharedPreferences.getInstance();
    prefs.setBool(PrefConstant.isArrived, true);
    isArrived = true;
    notifyListeners();
  }

  Future<void> startRide(
      String rideId, String driverId, String otp, BuildContext context) async {
    final res = await apiCall.startRide(context,rideId, driverId, otp);
    if (res.status == 1) {
      isRideStart = true;
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.setBool(PrefConstant.isStart, true);
      prefs.remove(PrefConstant.isArrived);
      CSnackBar.showSnackBar('Ride Started..', context);
    
      notifyListeners();
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }

  Future<void> endRide(
      String rideId, String driverId, BuildContext context) async {
        ProgressDialog.show(context);
        notifyListeners();
    final res = await apiCall.endRide(context,rideId, driverId);
    if (res.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(PrefConstant.status);
      prefs.remove(PrefConstant.rideId);
      prefs.remove(PrefConstant.isStart);
      ProgressDialog.hide(context);
      CSnackBar.showSnackBar('ride completed succesfully', context);
      isArrived = false;
      isRideStart = false;
      notifyListeners();
      polylines.clear();
      Navigator.push(context,
          MaterialPageRoute(builder: (context) => const RateCustomer()));
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }

  Future<void> sendFeedback(String rideid, String userId, String driverid,
      String tripRating, String comment, BuildContext context) async {
    final response = await apiCall.sendFeedback(context,
        rideid, userId, driverid, tripRating, comment);
    if (response.status == 1) {
      CSnackBar.showSnackBar(response.message.toString(), context);
      comments.clear();
      Navigator.pushReplacement(context,
          MaterialPageRoute(builder: (context) => const DriverHomeNew()));
          rating= 0.0;
          
    }
  }

  Future<void> driverCancelRide(String rideid, String driverid, String reason,
      BuildContext context) async {
    final res = await apiCall.driverCancelRide(context,rideid, driverid, reason);
    if (res.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
      prefs.remove(PrefConstant.status);
      prefs.remove(PrefConstant.rideId);
      notifyListeners();
      CSnackBar.showSnackBar(res.message.toString(), context);
      Future.delayed(const Duration(seconds: 1),(){
        Navigator.pushReplacement(
          context, MaterialPageRoute(builder: (context) => const DriverHome()));

      });
      
    }
  }
  Future<void> getStopsOngoing(String rideid,
      BuildContext context) async {
    final res = await apiCall.getStopsOngoing(context,rideid,);
    if (res.status == 1) {
      stopsList= res.data!;
      notifyListeners();
      CSnackBar.showSnackBar(res.message.toString(), context);
    }
    else{
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }

  Future<void> driverAcceptStops(String rideid,int acceptStop,
      BuildContext context) async {
        ProgressDialog.show(context);
        notifyListeners();
    final res = await apiCall.driverAcceptStops(context,rideid, acceptStop,);
    ProgressDialog.hide(context);
        notifyListeners();
    if (res.status == 1) {
      Navigator.pop(context);
      notifyListeners();
      
      
    }
    else{
      ProgressDialog.hide(context);
        notifyListeners();
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }
}
