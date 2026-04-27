// ignore_for_file: use_build_context_synchronously
 
import 'dart:developer';
import 'package:taxi_driver_24_7/model/driverridehistory_model.dart';
import 'package:taxi_driver_24_7/model/mytrips_details_model.dart';
import 'package:taxi_driver_24_7/services/customer_apicall.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/widgets/common/progress_dialog.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
 
class MyTripProvider extends ChangeNotifier {
  final CustomerApiCall apiCall = CustomerApiCall();
  final DriverApiCall apiCall1 = DriverApiCall();
  bool isloading = false;
  List<MyTripsData> myTripsData = [];
  List<MyTripsData> filterTripsData = [];
  List<MyTripsData> get myTripsDataList => myTripsData;
  List<MyTripsData> packageHistoryData = [];
  List<MyTripsData> get packageHistoryDataList => packageHistoryData;
  final Set<Marker> markers = {};
  List<RideHistory> rideHistoryData = [];
  List<RideHistory> filterRideHistory = [];
  int ridesLength = 0;
  SharedPreferences? prefs;
  String selectedType = '';
  String selectedStatus = '';
  String selectedtime = '';
  List<int> selectedMonths = [];
  String selectedDistance = '';
  String selectedDistanceType = '';
  bool isFilterAppliedUser = false;
  bool isFilterAppliedDriver = false;
  int offset = 0;
  int customerOffset = 0;
  int parcelOffset = 0;
  int totalRideCount = 0;
  bool hasMore = false;
 
  void disposeOffset() {
    customerOffset = 0;
    offset=0;
    log('dispose==>$offset $customerOffset');
    notifyListeners();
  }
  
 
  Future<void> getTripsDetails(
      String userId, BuildContext context, int? offset) async {
    if (offset != null) {
      myTripsData = [];
    }
    isloading = true;
    notifyListeners();
    final res = await apiCall.getAllTrips(context, userId, customerOffset);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      myTripsData.addAll(res.data!);
      log('length-->>>${myTripsData.length}');
      packageHistoryData.addAll(
          res.data!.where((data) => data.bookingRideStatus == 1).toList());
      totalRideCount = res.totalRideCount ?? 0;
      addMarkers();
      if (res.data!.isNotEmpty) {
        customerOffset++;
      }
    } else {
      CSnackBar.showSnackBar(res.message.toString(), context);
    }
     notifyListeners();
  }
 
  Future<void> getParcelHistory(String userId, BuildContext context) async {
    ProgressDialog.show(context);
    notifyListeners();
    final res = await apiCall.getAllTrips(context, userId, null);
    ProgressDialog.hide(context);
    notifyListeners();
    if (res.status == 1) {
      packageHistoryData.addAll(
          res.data!.where((data) => data.bookingRideStatus == 1).toList());
      addMarkers();
      if (res.data!.isNotEmpty) {
        parcelOffset++;
      }
    } else {
      packageHistoryData.clear();
      CSnackBar.showSnackBar(res.message.toString(), context);
    }
    notifyListeners();
  }
 
  void addMarkers() {
    for (var dataItem in myTripsDataList) {
      var tolocationlangitute = dataItem.toLocation!.coordinates![0].toString();
      var tolocationlatitute = dataItem.toLocation!.coordinates![1].toString();
      final marker = Marker(
        markerId: const MarkerId("markers"),
        position: LatLng(double.parse(tolocationlatitute),
            double.parse(tolocationlangitute)),
      );
      markers.add(marker);
    }
    notifyListeners();
  }
 
  Future<void> getRideHistory(BuildContext context, String driverId,int? offset2) async {
    prefs = await SharedPreferences.getInstance();
    if (offset2 != null) {
      rideHistoryData = [];
      offset = 0;
    }
    isloading = true;
    notifyListeners();
    try {
      final res = await apiCall1.getRideHistory(context, driverId, '', '', '', offset2 ?? offset);
      final isSuccess = res.status == 1;
      if (isSuccess) {
        final list = res.rideHistory ?? [];
        rideHistoryData.addAll(list);
        prefs!.setInt(PrefConstant.pastRidesCount, res.completedRidesCount ?? 0);
        if (list.isNotEmpty) {
          offset++;
          hasMore = true;
        } else {
          hasMore = false;
        }
      } else {
        if (offset2 == null || offset2 == 0) {
          rideHistoryData.clear();
        }
        if (context.mounted) {
          CSnackBar.showSnackBarError(res.message ?? 'No Previous Rides Found', context);
        }
      }
    } catch (e) {
      rideHistoryData.clear();
      hasMore = false;
      if (context.mounted) {
        CSnackBar.showSnackBarError('Unable to load trip history', context);
      }
    } finally {
      isloading = false;
      notifyListeners();
    }
  }
 
 
  Function() onStatusTypeSelection(String status) {
    return () {
      selectedStatus = status;
      notifyListeners();
    };
  }
 
  Function() onTimeSelection(String time) {
    return () {
      selectedtime = time;
      notifyListeners();
    };
  }
 
  Function() onDistanceSelection(String distance) {
    return () {
      selectedDistance = distance;
      switch (distance) {
        case 'Short (<5mi)':
          selectedDistanceType = '5mi';
          break;
        case 'Medium (5-20 mi)':
          selectedDistanceType = '5-20mi';
          break;
        case 'Long (20+mi)':
          selectedDistanceType = '20+mi';
          break;
        default:
          selectedDistanceType = '5mi';
      }
      notifyListeners();
    };
  }
 
  Function() onMonthselection(int month) {
    return () {
      if (selectedMonths.contains(month)) {
        selectedMonths.remove(month);
      } else {
        selectedMonths.add(month);
      }
       notifyListeners();
    };
  }
 
  void filterPastTrips(
      BuildContext context, String userId, List<int> months, int year) async {
    isloading = true;
    notifyListeners();
    Navigator.pop(context, 'Y');
    final res = await apiCall.filterPastTrips(context, userId, months, year);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      isFilterAppliedUser = true;
      filterTripsData = res.data!;
    } else {
      isFilterAppliedUser = true;
      filterTripsData = [];
      Navigator.pop(context, 'Y');
    }
    notifyListeners();
  }
 
  void removeUserFilter(BuildContext context) {
    filterTripsData.clear();
    selectedMonths.clear();
    isFilterAppliedUser = false;
    Navigator.pop(context, 'Y');
    notifyListeners();
  }
 
  void filterPastTripsDriver(
    BuildContext context,
    String driverId,
    String type,
    String distanceType,
    String timeRangeType,
    int offset,
  ) async {
    isloading = true;
    notifyListeners();
    Navigator.pop(context, 'Y');
    final res = await apiCall1.filterPastTripsDriver(
        context, driverId, type, distanceType, timeRangeType, offset);
    isloading = false;
    notifyListeners();
    if (res.status == 1) {
      isFilterAppliedDriver = true;
      filterRideHistory = res.rideHistory!;
    } else {
      isFilterAppliedDriver = true;
      filterRideHistory = [];
      Navigator.pop(context, 'Y');
    }
    notifyListeners();
  }
 
  void removeDriverFilter(BuildContext context) {
    selectedDistance = '';
    selectedDistanceType = '';
    filterRideHistory = [];
    selectedStatus = '';
    selectedtime = '';
    isFilterAppliedDriver = false;
    Navigator.pop(context, 'Y');
    notifyListeners();
  }
}