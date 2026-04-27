import 'package:taxi_driver_24_7/environment.dart';
import 'package:taxi_driver_24_7/model/adddrivinglic_model.dart';
import 'package:taxi_driver_24_7/model/addprofilephoto_model.dart';
import 'package:taxi_driver_24_7/model/addrcphoto_model.dart';
import 'package:taxi_driver_24_7/model/addvehicleinsu_model.dart';
import 'package:taxi_driver_24_7/model/addvehiclemodel.dart';
import 'package:taxi_driver_24_7/model/current_ride_driver_model.dart';
import 'package:taxi_driver_24_7/model/driver_accept_stops_model.dart';
import 'package:taxi_driver_24_7/model/driver_ridecancel_model.dart';
import 'package:taxi_driver_24_7/model/driver_offer_by_driver_model.dart';
import 'package:taxi_driver_24_7/model/driverridehistory_model.dart';
import 'package:taxi_driver_24_7/model/get_document_status.dart';
import 'package:taxi_driver_24_7/model/get_stops_model.dart';
import 'package:taxi_driver_24_7/model/getnearbyride_model.dart';
import 'package:taxi_driver_24_7/model/getvehicleinfo_model.dart';
import 'package:taxi_driver_24_7/model/getvehiclelis_model.dart';
import 'package:taxi_driver_24_7/model/ride_accept_model.dart';
import 'package:taxi_driver_24_7/model/ride_decline_model.dart';
import 'package:taxi_driver_24_7/model/scheduleride_driver_model.dart';
import 'package:taxi_driver_24_7/model/setdefaultvehicle_model.dart';
import 'package:taxi_driver_24_7/model/startride_model.dart';
import 'package:taxi_driver_24_7/model/userrating_model.dart';
import 'package:taxi_driver_24_7/model/userridedetails_model.dart';
import 'package:taxi_driver_24_7/model/vehicle_type_model.dart';
import 'package:taxi_driver_24_7/model/walletbalance_model.dart';
import 'package:taxi_driver_24_7/model/weaklygraph_model.dart';
import 'package:taxi_driver_24_7/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:taxi_driver_24_7/services/api_endpoints.dart';

class DriverApiCall {
  static String key = Environment.encryptionKey;
  String? deviceType;
  VehicleTypeModel? vichleTypeDataModel;
  VehicleTypesDataModel? vehicleTypesDataModel;
  AddVehicleModel? addVehicleModel;
  GetDocumentStatus? getDocumentStatus;
  AddProfilePhotoModel? addProfilePhotoModel;
  AddDrivingLicModel? addDrivingLicModel;
  AddVehicleInsuModel? addVehicleInsuModel;
  AddRCPhotoModel? addRCPhotoModel;
  GetNearByRides? getNearByRides;
  RideAccept? rideAcceptModel;
  DeclineRide? rideRejectModel;
  UserRideDetails? userRideDetails;
  StartRideDetails? startRideDetails;
  UserRatingsModel? ratingsModel;
  DriverCancelModel? driverCancelModel;
  GetVehicleList? getVehicleList;
  GetVehicleInfoModel? getVehicleInfoModel;
  SetDefaultOrDeleteModel? setDefaultModel;
  WalletBalanceModel? walletBalanceModel;
  WeaklyGrapDataModel? weaklyGrapDataModel;
  DriverRideHistory? driverRideHistory;
  ScheduleRideDriver? scheduleRideDriverModel;
  CurrentRideDriverModel? currentRideDrivermodel;
  GetStopsModel? getStopsModel;
  DriverAcceptStopsModel? driverAcceptStopsModel;
  DriverRideHistory? filterRideHistoryModel;
  DriverOfferByDriverModel? driverOfferByDriverModel;
  ApiServices apiServices= ApiServices();

  Future<VehicleTypeModel> getvehicleType(BuildContext context,String userId) async {
    var param = {'userId': userId};
    
    vichleTypeDataModel = await apiServices.postRequest(context, param, ApiEndPoints.getvehicleType, VehicleTypeModel.fromJson, 'Get Vehicle Type');
    return vichleTypeDataModel!;
  }

  Future<VehicleTypesDataModel> getvehicleTypeData(BuildContext context,String userId) async {
    var param = {'userId': userId};
    vehicleTypesDataModel =await apiServices.postRequest(context, param, ApiEndPoints.getvehicleTypeData, VehicleTypesDataModel.fromJson, 'Get VehicleTypeData');
     return vehicleTypesDataModel!;
  }

  Future<AddVehicleModel> addVehicle(
      BuildContext context,
      String driverid,
      vehicleId,
      vehiclename,
      String vehiclemake,
      String vehiclemodel,
      String? vehicleYearValue,
      String registrationnumber,
      String vehiclecolor,
      List<String> imageFiles) async {
    var param = {
      'driverid': driverid,
      'vehicle_id': vehicleId,
      'vehicle_type': vehiclename,
      'vehicle_make': vehiclemake,
      'vehicle_model': vehiclemodel,
      'vehicle_year': vehicleYearValue,
      'registration_number': registrationnumber,
      'vehicle_color': vehiclecolor,
    };
    addVehicleModel = await apiServices.multipleImagesRequest(context, param, ApiEndPoints.addvehicleDetail, AddVehicleModel.fromJson, 'Add Vehicle', imageFiles, 'vehicle_images');
     return addVehicleModel!;
  }

  Future<GetDocumentStatus> getDocStatus(BuildContext context,
      String driverId, String vehicledetailId) async {
    var param = {'driverid': driverId, 'vehicledetail_id': vehicledetailId};

    getDocumentStatus = await apiServices.postRequest(context, param, ApiEndPoints.getDocumentStatus, GetDocumentStatus.fromJson, 'Get Document Status');
    return getDocumentStatus!;
  }

  Future<AddProfilePhotoModel> addProfilePhoto(BuildContext context,
      String driverid, List<String> path, String vehicledetailId) async {
    var param = {'driverid': driverid, 'vehicledetail_id': vehicledetailId};

    addProfilePhotoModel = await apiServices.singleImageRequest(context, param, ApiEndPoints.addProfilePhoto, AddProfilePhotoModel.fromJson, 'Add Driver Doc Profile Photo', path[0].toString(), 'profile_photo');
    return addProfilePhotoModel!;
  }

  Future<AddDrivingLicModel> addDrivingPhoto(
      BuildContext context,
      String driverid,
      List<String> path,
      List<String> path1,
      String vehicledetailId) async {
    var param = {'driverid': driverid, 'vehicledetail_id': vehicledetailId};

    addDrivingLicModel = await apiServices.twoImagesRequest(context, param, ApiEndPoints.addDrivingLicenceFrontback, AddDrivingLicModel.fromJson, 'Add Driving Lic Photo', 'driving_licence_front', 'driving_licence_back', path[0].toString(), path1[0].toString(), );
    return addDrivingLicModel!;
    
  }

  Future<AddVehicleInsuModel> addVehicleInsPhoto(BuildContext context,
      String driverid, List<String> path, String vehicledetailId) async {
    var param = {'driverid': driverid, 'vehicledetail_id': vehicledetailId};

    addVehicleInsuModel= await apiServices.singleImageRequest(context, param, ApiEndPoints.addVehicleInsurance, AddVehicleInsuModel.fromJson, 'Add Vehicle Insurance Photo', path[0].toString(), 'vehicle_insurance');
    return addVehicleInsuModel!;
  }

  // Add RC Photo ApiCall
  Future<AddRCPhotoModel> addRCPhoto(BuildContext context, String driverid,
      List<String> path, String vehicledetailId) async {
    var param = {'driverid': driverid, 'vehicledetail_id': vehicledetailId};


    addRCPhotoModel = await apiServices.singleImageRequest(context, param, ApiEndPoints.addRegistrationCertificate, AddRCPhotoModel.fromJson, 'Add Rc Photo', path[0].toString(), 'registration_certificate');
    return addRCPhotoModel!;
  }

  //getNearby Ride Api Function ---------->
  Future<GetNearByRides> getNearbyRides(BuildContext context,
      String driverId, String fromlongitude, String fromlatitude,) async {
    var param = {
      'driverId': driverId,
      'from_longitude': fromlongitude,
      'from_latitude': fromlatitude,
    };
    
    getNearByRides = await apiServices.postRequest(context, param, ApiEndPoints.getNearbyRides, GetNearByRides.fromJson, 'Get Nearby Rides');
    return getNearByRides!;
  }
  
  //Ride Accept api function --->
  Future<RideAccept> rideAccept(BuildContext context,String rideId, String driverId) async {
    var params = {'rideid': rideId, 'driverid': driverId, 'type': 'Accept'};
    rideAcceptModel = await apiServices.postRequest(context, params, ApiEndPoints.rideAcceptOrReject, RideAccept.fromJson, 'Ride Accept');
    return rideAcceptModel!;
  }

  //Ride reject api function --->
  Future<DeclineRide> rideReject(BuildContext context,String rideId, String driverId) async {
    var params = {'rideid': rideId, 'driverid': driverId, 'type': 'Decline'};

    rideRejectModel =await apiServices.postRequest(context, params, ApiEndPoints.rideAcceptOrReject, DeclineRide.fromJson, 'Ride Reject');
    return rideRejectModel!;
    
  }

  Future<UserRideDetails> userRideDetail(BuildContext context,String rideId, String driverId) async {
    var params = {'rideid': rideId, 'driverid': driverId};

   userRideDetails= await apiServices.postRequest(context, params, ApiEndPoints.userRideDetail, UserRideDetails.fromJson, 'User Ride Details');
   return userRideDetails!;
  }

  Future<void> arrivetoCustomer(BuildContext context,String rideId, String driverId) async {
    var params = {'rideid': rideId, 'driverid': driverId, 'type': 'arrive'};
    await apiServices.postRequest(context, params, ApiEndPoints.arrivetoCustomer, null , 'Arrive Customer');
  }

  Future<StartRideDetails> startRide(BuildContext context,
      String rideId, String driverId, String otp) async {
    var params = {
      'rideid': rideId,
      'driverid': driverId,
      'type': 'start',
      'otp': otp
    };

    startRideDetails = await apiServices.postRequest(context, params, ApiEndPoints.startRide, StartRideDetails.fromJson, 'Start Ride');
    return startRideDetails!;
  }

  Future<StartRideDetails> endRide(BuildContext context,String rideId, String driverId) async {
    var params = {'rideid': rideId, 'driverid': driverId, 'type': 'endRide'};
    
    startRideDetails = await apiServices.postRequest(context, params, ApiEndPoints.endRide, StartRideDetails.fromJson, 'End Ride');
    return startRideDetails!;
  }

  // Ratings Api Function
  Future<UserRatingsModel> sendFeedback(BuildContext context,String rideid, String userId,
      String driverid, String tripRating, String comment) async {
    var params = {
      "rideid": rideid,
      "driverid": driverid,
      "userId": userId,
      "tripRating": tripRating,
      "comment": comment
    };
    ratingsModel = await apiServices.postRequest(context, params, ApiEndPoints.userRating, UserRatingsModel.fromJson, 'Send FeedBack');
    return ratingsModel!;
  }

  Future<DriverCancelModel> driverCancelRide(BuildContext context,
      String rideid, String driverid, String reason) async {
    var params = {
      "rideid": rideid,
      "driverid": driverid,
      "type": "Cancel",
      "reason": reason
    };
    driverCancelModel = await apiServices.postRequest(context, params, ApiEndPoints.driverCancelRide, DriverCancelModel.fromJson, 'Driver Cancel');
    return driverCancelModel!;
  }

  //getVehiclelist api for sideMenu
  Future<GetVehicleList> getVehicleListApi(BuildContext context,String driverId) async {
    var param = {'driverid': driverId};

    getVehicleList = await apiServices.postRequest(context, param, ApiEndPoints.getVehicleList, GetVehicleList.fromJson, 'Get Vehicle List');
    return getVehicleList!;
  }

  Future<GetVehicleInfoModel> getVehicleInfo(BuildContext context,
      String driverId, String vehicleId) async {
    var param = {"driverid": driverId, "vehicledetail_id": vehicleId};
    getVehicleInfoModel= await apiServices.postRequest(context, param, ApiEndPoints.getVehicleInfo, GetVehicleInfoModel.fromJson, 'Vehicle Info');
    return getVehicleInfoModel!;
  }

  Future<SetDefaultOrDeleteModel> setDefaultVehicle(BuildContext context,
      String driverId, String vehicleId) async {
    var param = {"driverid": driverId, "vehicledetail_id": vehicleId};

    setDefaultModel = await apiServices.postRequest(context, param, ApiEndPoints.setDefaultVehicle, SetDefaultOrDeleteModel.fromJson, 'Set Default Vehicle');
    return setDefaultModel!;
  }

  Future<SetDefaultOrDeleteModel> deleteVehicle(BuildContext context,
      String driverId, String vehicleId) async {
    var param = {"driverid": driverId, "vehicleDeleteId": vehicleId};

    setDefaultModel = await apiServices.postRequest(context, param, ApiEndPoints.deleteVehicle, SetDefaultOrDeleteModel.fromJson, 'Delete Vehicle');
    return setDefaultModel!;
  }

  Future<WalletBalanceModel> getWalletBalance(BuildContext context,
      String driverId, String currencySymbol) async {
    var param = {'driverId': driverId, 'currencySymbol': currencySymbol};
    walletBalanceModel = await apiServices.postRequest(context, param, ApiEndPoints.getWalletBalance, WalletBalanceModel.fromJson, 'Wallet balance');
    return walletBalanceModel!;
  }

  Future<WeaklyGrapDataModel> getWalletGraph(BuildContext context,String driverId,
      String currencySymbol, String startdate, String enddate) async {
    var param = {
      'driverId': driverId,
      'currencySymbol': currencySymbol,
      'startdate': startdate,
      'enddate': enddate
    };

    weaklyGrapDataModel = await apiServices.postRequest(context, param, ApiEndPoints.getWalletGraph, WeaklyGrapDataModel.fromJson, 'Get Wallet Graph');
    return weaklyGrapDataModel!;
  }

  Future<DriverRideHistory> getRideHistory(BuildContext context,String driverId,
      String currencySymbol, String startdate, String enddate,int offset) async {
    var param = {
      'driverId': driverId,
      'currencySymbol': currencySymbol,
      'startdate': startdate,
      'enddate': enddate,
      'offset':offset*10
    };
    driverRideHistory = await apiServices.postRequest(context, param, ApiEndPoints.rideHistory, DriverRideHistory.fromJson, 'Driver History');
    return driverRideHistory ?? DriverRideHistory(status: 0, message: 'Unable to load', rideHistory: []);
  }



  

  Future<ScheduleRideDriver> getScheduledRideDriver(BuildContext context,String driverId,) async {
    var param = {'driverId': driverId,
    };
    scheduleRideDriverModel= await apiServices.postRequest(context, param, ApiEndPoints.getScheduledRideDriver, ScheduleRideDriver.fromJson, 'Get Scheduled rides');
    return scheduleRideDriverModel!;
  }

  Future<DriverOfferByDriverModel?> getOfferByDriver(
    BuildContext context,
    String driverId,
    double lat,
    double lng,
  ) async {
    final Map<String, Object> param = {
      'driverId': driverId,
      'lat': lat,
      'lng': lng,
    };
    driverOfferByDriverModel = await apiServices.postRequest(
      context,
      param,
      ApiEndPoints.getOfferByDriver,
      DriverOfferByDriverModel.fromJson,
      'Get Offer By Driver',
    );
    return driverOfferByDriverModel;
  }
  Future<CurrentRideDriverModel> getCurrentRideDriver(BuildContext context,String driverId,) async {
    var param = {'driverId': driverId,
    };
    currentRideDrivermodel = await apiServices.postRequest(context, param, ApiEndPoints.getCurrentRideDriver, CurrentRideDriverModel.fromJson, 'Get Current Ride Driver');
    return currentRideDrivermodel!;
  }

  Future<GetStopsModel> getStopsOngoing(BuildContext context,String rideId,) async {
    var param = {'rideId': rideId,
    };

    getStopsModel = await apiServices.postRequest(context, param, ApiEndPoints.getStopsOngoing, GetStopsModel.fromJson, 'Get Stops Ongoing');
    return getStopsModel!;
  }

  Future<DriverAcceptStopsModel> driverAcceptStops(BuildContext context,String rideId,int driverAcceptRequest) async {
    var param = {'rideId': rideId,
    'DriverAcceptRequest':driverAcceptRequest
    };

    driverAcceptStopsModel = await apiServices.postRequest(context, param, ApiEndPoints.driverAcceptStops, DriverAcceptStopsModel.fromJson, 'Driver Accept Stop');
    return driverAcceptStopsModel!;
  }
  Future<DriverRideHistory> filterPastTripsDriver(BuildContext context,
    String driverId,
    String type,
    String distanceType,
    String timeRangeType,
    int offset,
  ) async {
    var param = {
      'driverId': driverId,
      'type':type,
      'distanceType':distanceType,
      'timeRangeType':timeRangeType,
      'offset':offset
    };
  filterRideHistoryModel = await apiServices.postRequest(context, param, ApiEndPoints.filterPastTripsDriver, DriverRideHistory.fromJson, 'Filter Past Trips Driver');
  return filterRideHistoryModel!;
  }
}
