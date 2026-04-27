// ignore_for_file: use_build_context_synchronously



import 'package:taxi_driver_24_7/model/getnearbyride_model.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';
import 'package:taxi_driver_24_7/screen/driver/home/rideongoing.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_driver_24_7/model/scheduleride_driver_model.dart';

class GetNearByRidesProvider extends ChangeNotifier {
  final DriverApiCall apiCall = DriverApiCall();
  bool isloading = false;
  List<Data>? rideDetailsData;
  List<Data>? scheduleRideDetailsData;
  List<Data>? get rideDetailsList => rideDetailsData;
  List<Data>? get scheduleRideDetailsList => scheduleRideDetailsData;
  final DateTime datetime = DateTime.now();

  List<ScheduledData>? scheduleRidesData;
  List<ScheduledData>? get scheduleRidesList => scheduleRidesData;

  

  //api function ---->
  Future<void> getRides(BuildContext context,
      String driverId, String fromLongitude, String fromLatitude) async {
    isloading = true;
    notifyListeners();
    final res =
        await apiCall.getNearbyRides(context,driverId, fromLongitude, fromLatitude);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      rideDetailsData =
          res.data!.where((ride) => ride.isScheduledRide == 0).toList();
          scheduleRideDetailsData =
          res.data!.where((ride) => ride.isScheduledRide == 1).toList();
      
    } else {
      // CSnackBar.showSnackBar(res.message.toString(), context);
    }
  }

  //RideAccept Api call function here ----->
  Future<void> rideAccept(
      String rideId, String driverId, BuildContext context, int index) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.rideAccept(context,rideId, driverId);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      SharedPreferences prefs = await SharedPreferences.getInstance();
     await prefs.setString(PrefConstant.rideId, res.data!.rideid!);

      if (res.message == 'Your Scheduled Ride has been Accept Successfully') {
        Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DriverHomeNew()));
      } else {
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => RideOngoing()));
      }
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }

  //RideAccept Api call function here ----->
  Future<void> rideDecline(
      String rideId, String driverId, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final res = await apiCall.rideReject(context,rideId, driverId);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      CSnackBar.showSnackBar(res.message.toString(), context);
      Navigator.pushReplacement(context,
            MaterialPageRoute(builder: (context) => const DriverHomeNew()));
    } else {
      CSnackBar.showSnackBarError(res.message.toString(), context);
    }
  }
  Future<void> getScheduleRidesDriver(BuildContext context,String driverId,) async {
    isloading = true;
    notifyListeners();
    final response = await apiCall.getScheduledRideDriver(context,driverId,);
    isloading = false;
    notifyListeners();
    if (response.status == 1) {                                                                                           
      scheduleRidesData = response.data!;
      notifyListeners();
    } else {
      debugPrint(response.status.toString());
      scheduleRidesData= [];
      notifyListeners();
    }
  }
  
}
