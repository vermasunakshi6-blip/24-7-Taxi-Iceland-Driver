// ignore_for_file: use_build_context_synchronously

import 'dart:convert';
import 'dart:developer';
import 'package:taxi_driver_24_7/environment.dart';
import 'package:taxi_driver_24_7/model/accept_reject_shared_ride_model.dart';
import 'package:taxi_driver_24_7/model/add_address_model.dart';
import 'package:taxi_driver_24_7/model/add_contact_model.dart';
import 'package:taxi_driver_24_7/model/add_drafts_model.dart';
import 'package:taxi_driver_24_7/model/add_event_model.dart';
import 'package:taxi_driver_24_7/model/add_ongoing_stop_model.dart';
import 'package:taxi_driver_24_7/model/add_parcel_model.dart';
import 'package:taxi_driver_24_7/model/add_premium_package_model.dart';
import 'package:taxi_driver_24_7/model/add_stops_model.dart';
import 'package:taxi_driver_24_7/model/addcontacts_model.dart';
import 'package:taxi_driver_24_7/model/all_events_model.dart';
import 'package:taxi_driver_24_7/model/all_notification_model.dart';
import 'package:taxi_driver_24_7/model/all_rewards_model.dart';
import 'package:taxi_driver_24_7/model/blockuser_model.dart';
import 'package:taxi_driver_24_7/model/cancel_event_model.dart';
import 'package:taxi_driver_24_7/model/chat_model.dart';
import 'package:taxi_driver_24_7/model/coinmaket_model.dart';
import 'package:taxi_driver_24_7/model/contactlist_model.dart';
import 'package:taxi_driver_24_7/model/create_ride_new_model.dart';
import 'package:taxi_driver_24_7/model/createride_model.dart';
import 'package:taxi_driver_24_7/model/cryptorate_model.dart';
import 'package:taxi_driver_24_7/model/customer_profile_model.dart';
import 'package:taxi_driver_24_7/model/delete_account_model.dart';
import 'package:taxi_driver_24_7/model/delete_address_model.dart';
import 'package:taxi_driver_24_7/model/distance_model.dart';
import 'package:taxi_driver_24_7/model/distance_time_model.dart';
import 'package:taxi_driver_24_7/model/edit_event_model.dart';
import 'package:taxi_driver_24_7/model/edit_profile_model.dart';
import 'package:taxi_driver_24_7/model/estimated_price_model.dart';
import 'package:taxi_driver_24_7/model/event_detail_model.dart';
import 'package:taxi_driver_24_7/model/eventcategories_model.dart';
import 'package:taxi_driver_24_7/model/faq_model.dart';
import 'package:taxi_driver_24_7/model/get_contact_support_model.dart';
import 'package:taxi_driver_24_7/model/get_drafts_model.dart';
import 'package:taxi_driver_24_7/model/get_faq_titles_model.dart';
import 'package:taxi_driver_24_7/model/get_referred_friends_model.dart';
import 'package:taxi_driver_24_7/model/get_report_reasons.dart';
import 'package:taxi_driver_24_7/model/get_saved_address_model.dart';
import 'package:taxi_driver_24_7/model/get_share_ride_request_model.dart';
import 'package:taxi_driver_24_7/model/get_total_rewards_model.dart';
import 'package:taxi_driver_24_7/model/getall_banners_model.dart';
import 'package:taxi_driver_24_7/model/invite_contact_model.dart';
import 'package:taxi_driver_24_7/model/legal_data_model.dart';
import 'package:taxi_driver_24_7/model/likeeventmodel.dart';
import 'package:taxi_driver_24_7/model/my_events_model.dart';
import 'package:taxi_driver_24_7/model/mytrips_details_model.dart';
import 'package:taxi_driver_24_7/model/notification_status_model.dart';
import 'package:taxi_driver_24_7/model/places_search_model.dart';
import 'package:taxi_driver_24_7/model/placesapidata_model.dart';
import 'package:taxi_driver_24_7/model/privacy_model.dart';
import 'package:taxi_driver_24_7/model/ratings_model.dart';
import 'package:taxi_driver_24_7/model/refer_a_friend_model.dart';
import 'package:taxi_driver_24_7/model/report_problem_model.dart';
import 'package:taxi_driver_24_7/model/ride_max_count_model.dart';
import 'package:taxi_driver_24_7/model/ridedetails_model.dart';
import 'package:taxi_driver_24_7/model/rider_cancel_model.dart';
import 'package:taxi_driver_24_7/model/rolechange_model.dart';
import 'package:taxi_driver_24_7/model/schedule_ride_model.dart';
import 'package:taxi_driver_24_7/model/send_email_support_model.dart';
import 'package:taxi_driver_24_7/model/send_shareriderequest_model.dart';
import 'package:taxi_driver_24_7/model/sendotpforemailupdate_model.dart';
import 'package:taxi_driver_24_7/model/share_trip_model.dart';
import 'package:taxi_driver_24_7/model/specific_coin_model.dart';
import 'package:taxi_driver_24_7/model/split_amount_model.dart';
import 'package:taxi_driver_24_7/model/subscription_history_model.dart';
import 'package:taxi_driver_24_7/model/update_default_address_model.dart';
import 'package:taxi_driver_24_7/model/vehicle_type_model.dart';
import 'package:taxi_driver_24_7/model/view_watch_to_earn.dart';
import 'package:taxi_driver_24_7/model/watch_to_earn_model.dart';
import 'package:taxi_driver_24_7/model/weather_model.dart';
import 'package:taxi_driver_24_7/services/api_endpoints.dart';
import 'package:taxi_driver_24_7/services/api_services.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class CustomerApiCall {
  final apiKey = Environment.gApiKey;
  static String key = Environment.encryptionKey;
  String? deviceType;
  VehicleTypeModel? vehicleTypeModel;
  CreateRide? createRideModel;
  RideDetails? rideDetails;
  PlacesApiModel? placesApiModel;
  CryptoRatesModel? cryptoRatesModel;
  DistanceModel? distanceModel;
  EstimatedPriceModel? estimatedPriceModel;
  CustomerProfileModel? customerProfileModel;
  EditProfileModel? editProfileModel;
  RatingsModel? ratingsModel;
  RiderCancelRide? riderCancelRides;
  MyTripsDetails? myTripsDetails;
  SendOtpForEmailModel? sendOtpForEmailModel;
  RoleChangeModel? roleChangeModel;
  ChatModel? chatModel;
  AddStopsModel? addStopsModel;
  ContactListModel? contactListModel;
  AddContactsModel? addContactsModel;
  RideMaxCountModel? rideMaxCountModel;
  CreateRideNewModel? createRideNewModel;
  CoinMarketModel? coinMarketModel;
  PrivacyModel? privacyModel;
  WeatherModel? weatherModel;
  PlacesSearchModel? placesSearchModel;
  DistanceTimeModel? distanceTimeModel;
  String appid = Environment.weatherApiKey;
  InviteContactsModel? inviteContactsModel;
  SplitAmountModel? splitAmountModel;
  EventCategoriesModel? eventCategoriesModel;
  AddEventModel? addEventModel;
  EventDetailModel? eventDetailModel;
  LikeEventModel? likeEventModel;
  AllEventsModel? allEventsModel;
  ScheduleRideModel? scheduleRideModel;
  WatchtoEarnModel? watchtoEarnModel;
  VideoRewardsModel? videoRewardsModel;
  TotalRewardsModel? totalRewardsModel;
  SharedTripModel? sharedTripModel;
  GetAllBannersModel? getAllBannersModel;
  AddPremiumPackageModel? addPremiumPackageModel;
  AddParcelModel? addParcelModel;
  SubscriptionHistoryModel? subscriptionHistoryModel;
  SpecificCoinModel? specificCoinModel;
  ViewWatchtoEarnModel? viewWatchtoEarnModel;
  GetReferredFriendsModel? getReferredFriendsModel;
  ReferaFriendModel? referaFriendModel;
  DeleteAccountModel? deleteAccountModel;
  AddAddressModel? addAddressModel;
  GetSavedAddressesModel? getSavedAddressesModel;
  UpdateDefaultAddressModel? updateDefaultAddressModel;
  DeleteAddressModel? deleteAddressModel;
  BlockUserModel? blockUserModel;
  MyEventsModel? myEventsModel;
  CancelEventModel? cancelEventModel;
  EditEventModel? editEventModel;
  AddDraftModel? addDraftModel;
  GetDraftsModel? getDraftsModel;
  GetReportReasonModel? getReportReasonModel;
  AddOngoingStopModel? addOngoingStopModel;
  SendShareRideRequestModel? sendShareRideRequestModel;
  GetShareRideRequestModel? getShareRideRequestModel;
  AcceptShareRideRequestModel? acceptShareRideRequestModel;
  MyTripsDetails? filterPastTripsModel;
  FaqTitlesModel? faqTitlesModel;
  FaqModel? faqModel;
  SendEmailSupportModel? sendEmailSupportModel;
  ReportProblemModel? reportProblemModel;
  AddContactModel? addContactModel;
  GetContactModel? getContactModel;
  LegalDataModel? legalDataModel;
  AllNotificationModel? allNotificationModel;
  NotificationStatusModel? getNotificationStatusModel;
  ApiServices apiServices = ApiServices();

  Future<WeatherModel> getWaetherApi(double latt, double lonn) async {
    Uri url = Uri.parse(
        'https://api.openweathermap.org/data/2.5/weather?lat=$latt&lon=$lonn&appid=$appid&units=metric');
    var res = await http.get(
      url,
    );
    if (res.statusCode == 200) {
      log('Waether Api Response:${res.body}');
      weatherModel = WeatherModel.fromJson(jsonDecode(res.body));
      return weatherModel!;
    } else {
      log('Waether Api Response:${res.body}');
      return weatherModel!;
    }
  }

  Future<CoinMarketModel> getcoinmarketdata(BuildContext context) async {
    coinMarketModel = await apiServices.getRequest(context, ApiEndPoints.getTopCoins, CoinMarketModel.fromJson, 'Coin Market Data');
    return coinMarketModel!;
  }
  Future<VehicleTypeModel> getvehicleType(
    BuildContext context,
      String userId,
      int? maxRiders,
      String? selectedValue,
      List<Map<String, String>> list,
      int deliveryType,
      int bookingRideStatus) async {
    Map<String, Object> param = {
      'userId': userId,
      'numberOfPerson': maxRiders!,
      'tokenType': selectedValue!,
      'legs': list,
      "deliveryType": deliveryType,
      "bookingRideStatus": bookingRideStatus,
    };
     
    vehicleTypeModel = await apiServices.postRequest(context, param, ApiEndPoints.getvehicleType, VehicleTypeModel.fromJson, 'Vehicle Type');
    return vehicleTypeModel!;
  }

  Future<CreateRideNewModel> createRideNew(
    BuildContext context,
      String userId,
      String fromaddress,
      String toaddress,
      String fromlatitude,
      String fromlongitude,
      String tolatitude,
      String tolongitude,
      String vehicleType,
      String price,
      String currencySymbol,
      List<Map<String, dynamic>> stops,
      List<Map<String, dynamic>> split,
      String rideType,
      List<Map<String, dynamic>> customerData,
      String ridebookingDate,
      String ridebookingTime,
      int isScheduledRide) async {
    var param = {
      'userId': userId,
      'from_address': fromaddress,
      'to_address': toaddress,
      'from_latitude': fromlatitude,
      'from_longitude': fromlongitude,
      'to_latitude': tolatitude,
      'to_longitude': tolongitude,
      'vehicleType': vehicleType,
      'price': price,
      'currencySymbol': currencySymbol,
      'stops': stops,
      'splits': split,
      'ridebooking_date': ridebookingDate,
      'ridebooking_time': ridebookingTime,
      'rideType': rideType,
      'customerData': customerData,
      'isScheduledRide': isScheduledRide,
      'eventId': '',
      'shareRideData': []
    };
    createRideNewModel = await apiServices.postRequest(context, param, ApiEndPoints.addRide, CreateRideNewModel.fromJson, 'Create ride new');
     return createRideNewModel!;
  }

  Future<CreateRide> createRide(
    BuildContext context,
      String userId,
      String fromaddress,
      String toaddress,
      String fromlatitude,
      String fromlongitude,
      String tolatitude,
      String tolongitude,
      String vehicleType,
      String price,
      String currencySymbol,
      List<Map<String, dynamic>> stops,
      String rideType,
      List<Map<String, dynamic>> customerData,
      String ridebookingDate,
      String ridebookingTime,
      int isScheduledRide,
      String? id,
      String? eventId,
      List<Map<String, dynamic>>? shareRideData) async {
    var param = {
      'userId': userId,
      'from_address': fromaddress,
      'to_address': toaddress,
      'from_latitude': fromlatitude,
      'from_longitude': fromlongitude,
      'to_latitude': tolatitude,
      'to_longitude': tolongitude,
      'vehicleType': vehicleType,
      'price': price,
      'currencySymbol': currencySymbol,
      'stops': stops,
      'splits': [],
      'ridebooking_date': ridebookingDate,
      'ridebooking_time': ridebookingTime,
      'rideType': rideType,
      'customerData': customerData,
      'isScheduledRide': isScheduledRide,
      'shareuserId': id ?? "",
      'eventId': eventId ?? '',
      'shareRideData': shareRideData ?? []
    };
    createRideModel = await apiServices.postRequest(context, param, ApiEndPoints.addRide, CreateRide.fromJson, 'Create Ride ');
     return createRideModel!;
  }

  Future<RideDetails> getRideDetails(
    BuildContext context,
    String userId,
  ) async {
    var param = {
      'userId': userId,
    };
    rideDetails = await apiServices.postRequest(context, param, ApiEndPoints.getRide, RideDetails.fromJson, 'Get Ride Customer ');
     return rideDetails!;
  }

  Future<RatingsModel> sendFeedback(BuildContext context,String rideid, String userId,
      String driverid, String tripRating, String comment) async {
    var params = {
      "rideid": rideid,
      "userId": userId,
      "driverid": driverid,
      "tripRating": tripRating,
      "comment": comment
    };
    ratingsModel = await apiServices.postRequest(context, params, ApiEndPoints.sendFeedback, RatingsModel.fromJson, 'Rating');
     return ratingsModel!;
  }

  Future<RiderCancelRide> riderCancelRide(BuildContext context,
      String rideid, String userId, String reason) async {
    var params = {
      "rideid": rideid,
      "userId": userId,
      "type": "Cancel",
      "reason": reason
    };
    riderCancelRides = await apiServices.postRequest(context, params, ApiEndPoints.riderCancelRide, RiderCancelRide.fromJson, 'Rider Cancel Ride');
     return riderCancelRides!;
  }

  Future<CustomerProfileModel> getCustomerProfile(BuildContext context,
    String userId,
  ) async {
    var params = {
      "userId": userId,
    };
    customerProfileModel = await apiServices.postRequest(context, params, ApiEndPoints.getCustomerProfile, CustomerProfileModel.fromJson, 'Customer Profile');
     return customerProfileModel!;
  }

  Future<EditProfileModel> editProfile(
    String userId,
    String fname,
    String lname,
    BuildContext context,
    List<String> path,
  ) async {
    var param = {
      'userId': userId,
      'firstName': fname,
      'lastName': lname,
    };
   editProfileModel = await apiServices.singleImageRequest(context, param, ApiEndPoints.editProfile, EditProfileModel.fromJson, 'Edit Profile', path.first, 'profilePic');
   return editProfileModel!;
  }

  Future<EditProfileModel> editProfileWithoutImage(
    String userId,
    String fname,
    String lname,
    BuildContext context,
  ) async {
    var param = {
      'userId': userId,
      'firstName': fname,
      'lastName': lname,
    };
    editProfileModel = await apiServices.multipartWithoutImageRequest(context, param, ApiEndPoints.editProfile, EditProfileModel.fromJson, 'Edit profile');
    return editProfileModel!;
  }

  Future<MyTripsDetails> getAllTrips(BuildContext context,String userId, int? offset) async {
    var param = {"userId": userId, "offset": (offset ?? 0) * 10};
    myTripsDetails = await apiServices.postRequest(context, param, ApiEndPoints.getAllTrips, MyTripsDetails.fromJson, 'Get All Trips');
     return myTripsDetails!;
  }

  Future<SendOtpForEmailModel> resetEmailId(BuildContext context,
      String oldEmail, String newEmail, String otp) async {
    var params = {"oldEmail": oldEmail, "newEmail": newEmail, "otp": otp};
    sendOtpForEmailModel = await apiServices.postRequest(context, params, ApiEndPoints.resetEmail, SendOtpForEmailModel.fromJson, 'Reset Email');
     return sendOtpForEmailModel!;
  }

  Future<RoleChangeModel> changeRole(BuildContext context,
    String userId,
    String currentType,
  ) async {
    var params = {
      "userId": userId,
      "regType": currentType,
    };
    roleChangeModel = await apiServices.postRequest(context, params, ApiEndPoints.switchUser, RoleChangeModel.fromJson, 'Change Role');
     return roleChangeModel!;
    
  }

  Future<ChatModel> getChat(BuildContext context,
    String rideid,
  ) async {
    var params = {
      "rideid": rideid,
    };
    chatModel = await apiServices.postRequest(context, params, ApiEndPoints.getChat, ChatModel.fromJson, 'Chat');
     return chatModel!;
  }

  Future<AddStopsModel> addOtherStops(BuildContext context,String userId, String rideId,
      List<Map<String, dynamic>> stops, String price) async {
    var params = {
      "userId": userId,
      "rideid": rideId,
      "stops": stops,
      "price": price
    };
    addStopsModel = await apiServices.postRequest(context, params, ApiEndPoints.addStops, AddStopsModel.fromJson, 'Add Stops');
     return addStopsModel!;
  }

  Future<ContactListModel> getContacts(BuildContext context,String userId) async {
    var param = {'userId': userId};
    contactListModel = await apiServices.postRequest(context, param, ApiEndPoints.getContacts, ContactListModel.fromJson, 'Get Contacts Details');
     return contactListModel!;
  }

  Future<AddContactsModel> addContacts(BuildContext context,String userId, List contactsD) async {
    var param = {'userId': userId, 'contact': contactsD};
    addContactsModel = await apiServices.postRequest(context, param, ApiEndPoints.addContacts, AddContactsModel.fromJson, 'Add Contacts Details');
     return addContactsModel!;
  }

  Future<RideMaxCountModel> getMaxRiders(
      String userId, BuildContext context) async {
    var param = {'userId': userId};
    rideMaxCountModel = await apiServices.postRequest(context, param, ApiEndPoints.getControlls, RideMaxCountModel.fromJson, 'Get Max Riders');
     return rideMaxCountModel!;
  }


  Future<PrivacyModel> getTerms(BuildContext context) async {
    
    privacyModel = await apiServices.getRequest(context, ApiEndPoints.getTermsConditions, PrivacyModel.fromJson, 'Get Terms and Condition');
    return privacyModel!;

  }

  

  Future<PlacesSearchModel> placesSearch(BuildContext context,String query) async {
    var params = {
      "query": query,
    };
     placesSearchModel = await apiServices.postRequest(context, params, ApiEndPoints.serachGooglePlaces, PlacesSearchModel.fromJson, 'Search Places');
     return placesSearchModel!;
  }

  Future<DistanceTimeModel> fetchdistancetimeapi(BuildContext context,double? fromlatitude,
      double? fromlongitude, double? tolatitude, double? tolongitude) async {
    Map<String, Object> params = {
      "startLat": fromlatitude!,
      "startLng": fromlongitude!,
      "endLat": tolatitude!,
      "endLng": tolongitude!,
    };
distanceTimeModel = await apiServices.postRequest(context, params, ApiEndPoints.fetchdistancetime, DistanceTimeModel.fromJson, 'Fetch Distance');
     return distanceTimeModel!;
  }

  Future<InviteContactsModel> inviteContacts(BuildContext context,
      String userId, String contactNumber) async {
    var params = {
      "userId": userId,
      "contactNumber": contactNumber,
    };
    inviteContactsModel = await apiServices.postRequest(context, params, ApiEndPoints.contactsUpdateInvite, InviteContactsModel.fromJson, 'Invite Contacts');
     return inviteContactsModel!;
  }

  Future<DistanceTimeModel> fetchdistancetimestopsapi(BuildContext context,
      double? fromlatitude,
      double? fromlongitude,
      double? tolatitude,
      double? tolongitude,
      List<Map<String, Object?>> waypoints) async {
    Map<String, Object> params = {
      "stopname": "Pickup",
      "startLat": fromlatitude!,
      "startLng": fromlongitude!,
      "endLat": tolatitude!,
      "endLng": tolongitude!,
      "waypoints": waypoints,
    };
    distanceTimeModel = await apiServices.postRequest(context, params, ApiEndPoints.fetchdistancetime, DistanceTimeModel.fromJson, 'Fetch distance time');
     return distanceTimeModel!;
  }

  Future<SplitAmountModel> splitamount(BuildContext context,
      String userId,
      String totalPrice,
      String tokenType,
      List<Map<String, dynamic>> allUsers,
      List<Map<String, dynamic>> splitUsers,
      List<Map<String, dynamic>> mySplit) async {
    var params = {
      "userId": userId,
      "totalPrice": totalPrice,
      "tokenType": tokenType,
      "allUsers": allUsers,
      "splitUsers": splitUsers,
      "mySplit": mySplit,
    };
   splitAmountModel = await apiServices.postRequest(context, params, ApiEndPoints.splitamount, SplitAmountModel.fromJson, 'Split Amount');
     return splitAmountModel!;
  }

  Future<AddEventModel> addevent(BuildContext context,
      String userId,
      String userName,
      String eventName,
      String eventDate,
      String eventTime,
      String eventType,
      String address1,
      String state,
      String city,
      String eventPic,
      String latitude,
      String longitude,
      String description,
      String sponsorName,
      String eventEndDate,
      String eventEndTime,
      String eventDraftId)async{
var param = {
      "userId": userId,
      "userName": userName,
      "eventName": eventName,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "eventType": eventType,
      "state": state,
      "city": city,
      "address1": address1,
      "latitude": latitude,
      "longitude": longitude,
      "description": description,
      "sponsorName": sponsorName,
      "eventEndDate": eventEndDate,
      "eventEndTime": eventEndTime,
      "eventDraftId": eventDraftId
    };
     addEventModel =await ApiServices().singleImageRequest(context, param, ApiEndPoints.addevent, AddEventModel.fromJson, 'Add Events', eventPic, 'eventPic');
     return addEventModel!;
  }

  Future<EventCategoriesModel> geteventcategories(BuildContext context,
    String userId,
  ) async {
    var params = {
      "userId": userId,
    };
    eventCategoriesModel = await apiServices.postRequest(context, params, ApiEndPoints.getEventCategories, EventCategoriesModel.fromJson, 'Get Event Categories');
     return eventCategoriesModel!;
  }

  Future<EventDetailModel> getEventDetail(BuildContext context,
    String userId,
    String eventId,
  ) async {
    var params = {
      "eventId": eventId,
      "userId": userId,
    };
    eventDetailModel = await apiServices.postRequest(context, params, ApiEndPoints.getEventDetails, EventDetailModel.fromJson, 'Get Events');
     return eventDetailModel!;
  }

  Future<LikeEventModel> likeEvents(BuildContext context,
      String userId, String eventId, String islike) async {
    var params = {
      "userId": userId,
      "eventId": eventId,
      "is_like": islike,
    };
    likeEventModel = await apiServices.postRequest(context, params, ApiEndPoints.likeEvents, LikeEventModel.fromJson, 'Like Events');
     return likeEventModel!;
  }

  Future<AllEventsModel> getAllEvents(
    BuildContext context, String userId,String eventType,
  ) async {
    var params = {"userId": userId, "eventType": eventType, "offset": 0};
    allEventsModel = await apiServices.postRequest<AllEventsModel>(
        context,
        params,
        ApiEndPoints.getAllEvents,
        AllEventsModel.fromJson,
        'Get All Events');
    return allEventsModel!;
  }

  Future<void> eventViews(BuildContext context,String userId, String eventId) async {
    var params = {
      "userId": userId,
      "eventId": eventId,
    };
     await apiServices.postRequest(context, params, ApiEndPoints.eventViews, null, 'View Events');
  }

  Future<AllEventsModel> filterEvent(BuildContext context,
      String userId,
      String eventType,
      String filterType,
      String latitude,
      String longitude,
      String distanceFilter) async {
    var params = {
      "userId": userId,
      "eventType": eventType,
      "filterType": filterType,
      "longitude": longitude,
      "latitude": latitude,
      "distanceFilter": distanceFilter
    };
    allEventsModel = await apiServices.postRequest(context, params, ApiEndPoints.filterEvents, AllEventsModel.fromJson, 'Events Filter');
     return allEventsModel!;
  }

  Future<ScheduleRideModel> getScheduledRide(BuildContext context,
    String userId,
  ) async {
    var param = {
      'userId': userId,
    };
    scheduleRideModel = await apiServices.postRequest(context, param, ApiEndPoints.getScheduledRide, ScheduleRideModel.fromJson, 'Get Scheduled Rides');
     return scheduleRideModel!;
  }

  Future<WatchtoEarnModel> getAllWatchtoEarn(BuildContext context,
    String userId,
  ) async {
    var param = {
      'userId': userId,
    };
    watchtoEarnModel = await apiServices.postRequest(context, param, ApiEndPoints.getAllWatchtoEarn, WatchtoEarnModel.fromJson, 'Get all watch to earn');
     return watchtoEarnModel!;
  }

  Future<WatchtoEarnModel> getWatchtoEarnDetail(BuildContext context,
      String userId, String watchId) async {
    var param = {'userId': userId, 'watchId': watchId};
    watchtoEarnModel = await apiServices.postRequest(context, param, ApiEndPoints.getWatchtoEarnDetail, WatchtoEarnModel.fromJson, 'Get all watch to earn detail');
     return watchtoEarnModel!;
  }

  Future<LikeEventModel> likeWatchtoEarn(BuildContext context,
      String userId, String watchId, String islike) async {
    var params = {"userId": userId, "watchId": watchId, "is_like": islike};
    likeEventModel = await apiServices.postRequest(context, params, ApiEndPoints.likeWatchtoEarn, LikeEventModel.fromJson, 'Like Watch to earn');
     return likeEventModel!;
  }

  Future<ViewWatchtoEarnModel> viewWatchtoEarn(BuildContext context,
      String userId, String watchId) async {
    var params = {
      "userId": userId,
      "watchId": watchId,
    };
    viewWatchtoEarnModel = await apiServices.postRequest(context, params, ApiEndPoints.viewWatchtoEarn, ViewWatchtoEarnModel.fromJson, 'View Watch to earn');
     return viewWatchtoEarnModel!;
  }

  Future<VideoRewardsModel> getRecentRewards(BuildContext context,
    String userId,
  ) async {
    var params = {
      "userId": userId,
    };
    videoRewardsModel = await apiServices.postRequest(context, params, ApiEndPoints.getRecentRewards, VideoRewardsModel.fromJson, 'Watch to earn Rewards');
     return videoRewardsModel!;
  }

  Future<TotalRewardsModel> getTotalRewards(BuildContext context,String userId, String type) async {
    var params = {"userId": userId, "type": type};
    totalRewardsModel = await apiServices.postRequest(context, params, ApiEndPoints.getTotalRewards, TotalRewardsModel.fromJson, 'Watch to earn total Rewards');
     return totalRewardsModel!;
  }

  Future<SharedTripModel> getRides(BuildContext context,
      String userId, String date, String time) async {
    var param = {
      'rideId': userId,
    };
    sharedTripModel = await apiServices.postRequest(context, param, ApiEndPoints.getCurrentRide, SharedTripModel.fromJson, 'Get Shared Ride Details');
     return sharedTripModel!;
  }

  Future<GetAllBannersModel?> getAllBannerType(BuildContext context,
      String userId, String startDate, String startTime) async {
    var params = {
      "userId": userId,
      "startDate": startDate,
      "startTime": startTime
    };
    getAllBannersModel = await apiServices.postRequest(context, params, ApiEndPoints.getAllBannerType, GetAllBannersModel.fromJson, 'Get All banners');
    return getAllBannersModel;
  }

  Future<AddPremiumPackageModel> addPremiumPackage(BuildContext context,
      String userId, String price, String packageDate) async {
    var params = {
      "userId": userId,
      "price": price,
      "packageDate": packageDate,
      "type": "premium",
      "validate": "1 month"
    };
    addPremiumPackageModel = await apiServices.postRequest(context, params, ApiEndPoints.addPremiumPackage, AddPremiumPackageModel.fromJson, 'Add Premium Package');
     return addPremiumPackageModel!;
  }

  Future<CreateRide> rescheduleRide(BuildContext context,
    String rideId,
    String ridebookingDate,
    String ridebookingTime,
  ) async {
    var param = {
      'rideId': rideId,
      'ridebooking_date': ridebookingDate,
      'ridebooking_time': ridebookingTime,
    };
    createRideModel = await apiServices.postRequest(context, param, ApiEndPoints.rescheduleride, CreateRide.fromJson, 'Reschedule Ride');
     return createRideModel!;
  }

  Future<AddParcelModel> addParcelRide(BuildContext context,
    String userId,
    String price,
    String fromAddress,
    String toAddress,
    String fromLongitude,
    String fromLatitude,
    String toLongitude,
    String toLatitude,
    String vehicleType,
    String currencySymbol,
    int packageType,
    String packageWeight,
    int deliveryType,
    String recipientsName,
    String recipientsContact,
    int bookingRideStatus,
    List<Map<String, dynamic>> customerData,
    List<Map<String, dynamic>> stops,
  ) async {
    var params = {
      "userId": userId,
      "from_address": fromAddress,
      "to_address": toAddress,
      "from_latitude": fromLatitude,
      "from_longitude": fromLongitude,
      "to_latitude": toLatitude,
      "to_longitude": toLongitude,
      "vehicleType": vehicleType,
      "price": price,
      "currencySymbol": currencySymbol,
      "packageType": packageType,
      "packageWeight": packageWeight,
      "deliveryType": deliveryType,
      "recipientsName": recipientsName,
      "recipientsNumber": recipientsContact,
      "bookingRideStatus": bookingRideStatus,
      "customerData": customerData,
      "shareuserId": [userId, ''],
      "stops": stops,
    };
    addParcelModel = await apiServices.postRequest(context, params, ApiEndPoints.addRideParcelPickup, AddParcelModel.fromJson, 'Add Parcel Ride');
    return addParcelModel!;
  }

  Future<SubscriptionHistoryModel> getSubscriptionHistory(BuildContext context,
    String userId,
  ) async {
    var param = {
      'userId': userId,
    };
    subscriptionHistoryModel = await apiServices.postRequest(context, param, ApiEndPoints.getsubscriptionHistory, SubscriptionHistoryModel.fromJson, 'Get Subscription History');
    return subscriptionHistoryModel!;
  }

  Future<SpecificCoinModel> getSpecificCoins(BuildContext context,String symbol, String type) async {
    Uri url = Uri.parse(ApiEndPoints.apiBaseUrl +
        ApiEndPoints.getSpecificCoins +
        '?symbol=$symbol&type=$type');
    var res = await http.get(
      url,
    );
    if (res.statusCode == 200) {
      specificCoinModel = SpecificCoinModel.fromJson(jsonDecode(res.body));
      log('Coin Market data response' + res.body);
      return specificCoinModel!;
    } else {
      return specificCoinModel!;
    }
  }

  Future<ReferaFriendModel> referAFriend(BuildContext context,
      String userId, String phone, String name) async {
    var param = {'userId': userId, 'phone': phone, 'name': name};
     referaFriendModel = await apiServices.postRequest(context, param, ApiEndPoints.referafriend, ReferaFriendModel.fromJson, 'Refer a Friend');
     return referaFriendModel!;
  }

  Future<GetReferredFriendsModel> getreferredFriends(BuildContext context,
      String userId, int offset) async {
    var param = {
      'userId': userId,
      'offset': offset,
    };
    getReferredFriendsModel = await apiServices.postRequest(context, param, ApiEndPoints.getreferredfriends, GetReferredFriendsModel.fromJson, 'Get Referred Friend');
     return getReferredFriendsModel!;
  }

  Future<AddAddressModel> addAddress(BuildContext context,
      String userId,
      String address,
      String aptSuit,
      String country,
      String state,
      String city,
      String zipcode,
      String addressName,
      String latitude,
      String longitude) async {
    var param = {
      'userId': userId,
      'address': address,
      'aptSuite': aptSuit,
      'country': country,
      'state': state,
      'cityProvince': city,
      'zipcode': zipcode,
      'addressName': addressName,
      'latitude': latitude,
      'longitude': longitude
    };
    addAddressModel = await apiServices.postRequest(context, param, ApiEndPoints.addAddress, AddAddressModel.fromJson, 'Add Address');
     return addAddressModel!;
  }

  Future<GetSavedAddressesModel> getSavedAddress(BuildContext context,
      String userId, int offset) async {
    var param = {
      'userId': userId,
      'offset': offset,
    };
    getSavedAddressesModel = await apiServices.postRequest(context, param, ApiEndPoints.getSavedAddress, GetSavedAddressesModel.fromJson, 'Get Saved Address');
     return getSavedAddressesModel!;
  }

  Future<UpdateDefaultAddressModel> updateDefaultAddress(BuildContext context,
      String userId, String addressId) async {
    var param = {
      'userId': userId,
      'addressId': addressId,
    };
     updateDefaultAddressModel = await apiServices.postRequest(context, param, ApiEndPoints.udateDefaultAddress, UpdateDefaultAddressModel.fromJson, 'Update Default Address');
     return updateDefaultAddressModel!;
  }

  Future<DeleteAddressModel> deleteAddress(BuildContext context,
      String userId, String addressId) async {
    var param = {
      'userId': userId,
      'addressId': addressId,
    };
    deleteAddressModel = await apiServices.postRequest(context, param, ApiEndPoints.deleteAddress, DeleteAddressModel.fromJson, 'Delete Address');
     return deleteAddressModel!;
  }

  Future<DeleteAccountModel> deleteAccount(BuildContext context,String userId, String reason) async {
    var params = {
      "userId": userId,
      "reason": reason,
    };
    deleteAccountModel = await apiServices.postRequest(context, params, ApiEndPoints.deleteAccount, DeleteAccountModel.fromJson, 'Delete Account');
     return deleteAccountModel!;
  }

  Future<BlockUserModel> blockUser(BuildContext context,String userId, String blockUserId) async {
    var params = {
      "userId": userId,
      "blockUserId": blockUserId,
    };
    blockUserModel = await apiServices.postRequest(context, params, ApiEndPoints.blockUser, BlockUserModel.fromJson, 'Block User');
     return blockUserModel!;
  }

  Future<BlockUserModel> reportUser(BuildContext context,
      String userId, String blockUserId, String reason) async {
    var params = {
      "userId": userId,
      "reportUserId": blockUserId,
      "reason": reason,
    };
     blockUserModel = await apiServices.postRequest(context, params, ApiEndPoints.reportUser, BlockUserModel.fromJson, 'Report User');
     return blockUserModel!;
  }

  Future<BlockUserModel> reportEvent(BuildContext context,
      String userId, String eventid, String reason) async {
    var params = {
      "userId": userId,
      "eventId": eventid,
      "reason": reason,
    };
    blockUserModel = await apiServices.postRequest(context, params, ApiEndPoints.reportEvent, BlockUserModel.fromJson, 'Report Event');
     return blockUserModel!;
  }

  Future<MyEventsModel> getMyEvents(BuildContext context,String userId, int offset) async {
    var params = {
      "userId": userId,
      "search": '',
      "filters": {
        "eventStatus": '',
        "category": [],
        "withInDate": '',
        "location": ''
      },
      "offset": offset * 10,
    };
    myEventsModel = await apiServices.postRequest(context, params, ApiEndPoints.getmyEvents, MyEventsModel.fromJson, 'Get My Events');
     return myEventsModel!;
  }

  Future<MyEventsModel> filterMyEvents(BuildContext context,
      String userId,
      int offset,
      List<String> categories,
      String eventStatus,
      String withinDate,
      String withinLocation) async {
    var params = {
      "userId": userId,
      "search": '',
      "filters": {
        "eventStatus": eventStatus,
        "category": categories,
        "withInDate": withinDate,
        "location": withinLocation
      },
      "offset": offset * 10,
    };
    myEventsModel = await apiServices.postRequest(context, params, ApiEndPoints.getmyEvents, MyEventsModel.fromJson, 'Filter My Events');
     return myEventsModel!;
  }

  Future<EditEventModel> editMyEvent(BuildContext context,
    String eventId,
    String userId,
    String userName,
    String eventName,
    String eventDate,
    String eventTime,
    String eventType,
    String address1,
    String state,
    String city,
    String eventPic,
    String latitude,
    String longitude,
    String description,
    String sponsorName,
    String eventEndDate,
    String eventEndTime,
  ) async {
    var param = {
      "eventId": eventId,
      "userId": userId,
      "userName": userName,
      "eventName": eventName,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "eventType": eventType,
      "state": state,
      "city": city,
      "address1": address1,
      "latitude": latitude,
      "longitude": longitude,
      "description": description,
      "sponsorName": sponsorName,
      "eventEndDate": eventEndDate,
      "eventEndTime": eventEndTime,
    };
    editEventModel = await apiServices.singleImageRequest(context, param, ApiEndPoints.editmyEvents, EditEventModel.fromJson, 'Edit Events', eventPic, 'eventPic');
    return editEventModel!;
  }

  Future<CancelEventModel> cancelMyEvents(BuildContext context,
    String eventId,
    String userId,
  ) async {
    var params = {
      "eventId": eventId,
      "userId": userId,
    };
    cancelEventModel = await apiServices.postRequest(context, params, ApiEndPoints.cancelmyEvents, CancelEventModel.fromJson, 'Cancel My Events');
     return cancelEventModel!;
  }

  Future<AddDraftModel> addDraftEvents(BuildContext context,
    String userId,
    String userName,
    String eventName,
    String eventDate,
    String eventTime,
    String eventType,
    String address1,
    String state,
    String city,
    String eventPic,
    String latitude,
    String longitude,
    String description,
    String sponsorName,
    String eventEndDate,
    String eventEndTime,
  ) async {
    var param = {
      "userId": userId,
      "userName": userName,
      "eventName": eventName,
      "eventDate": eventDate,
      "eventTime": eventTime,
      "eventType": eventType,
      "state": state,
      "city": city,
      "address1": address1,
      "latitude": latitude,
      "longitude": longitude,
      "description": description,
      "sponsorName": sponsorName,
      "eventEndDate": eventEndDate,
      "eventEndTime": eventEndTime,
    };
    addDraftModel = await apiServices.singleImageRequest(context, param, ApiEndPoints.addDraftEvents, AddDraftModel.fromJson, 'Add Draft Events', eventPic.isEmpty?'':eventPic, 'eventPic');
    return addDraftModel!;
  }

  Future<GetDraftsModel> getDraftEvents(BuildContext context,
    String userId,
  ) async {
    var params = {
      "userId": userId,
    };
    getDraftsModel = await apiServices.postRequest(context, params, ApiEndPoints.getDraftEvents, GetDraftsModel.fromJson, 'get Event Drafts');
     return getDraftsModel!;
  }

  Future<GetReportReasonModel> getReportReasons(BuildContext context,
    String type,
  ) async {
    var params = {
      "type": type,
    };
    getReportReasonModel = await apiServices.postRequest(context, params, ApiEndPoints.getReportReasons, GetReportReasonModel.fromJson, 'get Report Reasons');
     return getReportReasonModel!;
  }

  Future<AddOngoingStopModel> addStopRide(BuildContext context,
    String rideId,
    Map<String, Object?> stops1,
  ) async {
    var param = {
      'rideId': rideId,
      'stop1': stops1,
      'stop2': "",
    };
    addOngoingStopModel = await apiServices.postRequest(context, param, ApiEndPoints.addStopsRide, AddOngoingStopModel.fromJson, 'Add Stop Ride');
     return addOngoingStopModel!;
  }

  Future<AddOngoingStopModel> addStopRidemultiple(BuildContext context,
    String rideId,
    Map<String, Object?> stops1,
    Map<String, Object?> stops2,
  ) async {
    var param = {
      'rideId': rideId,
      'stop1': stops1,
      'stop2': stops2,
    };
    addOngoingStopModel = await apiServices.postRequest(context, param, ApiEndPoints.addStopsRide, AddOngoingStopModel.fromJson, 'Add Stop Ride');
     return addOngoingStopModel!;
  }

  Future<SendShareRideRequestModel> sendShareRideRequest(BuildContext context,
      String userId,
      String fromAddress,
      String toAddress,
      String fromLatitude,
      String fromLongitude,
      String toLatitude,
      String toLongitude,
      List<Map<String, dynamic>> contactData) async {
    var param = {
      'userId': userId,
      'from_address': fromAddress,
      'to_address': toAddress,
      'from_latitude': fromLatitude,
      'from_longitude': fromLongitude,
      'to_latitude': toLatitude,
      'to_longitude': toLongitude,
      'contactData': contactData,
    };
    sendShareRideRequestModel = await apiServices.postRequest(context, param, ApiEndPoints.sendShareRideRequest, SendShareRideRequestModel.fromJson, 'Send Share Ride Request');
     return sendShareRideRequestModel!;
  }

  Future<GetShareRideRequestModel> getShareRideRequest(BuildContext context,
    String userId,
  ) async {
    var param = {
      'userId': userId,
    };
    getShareRideRequestModel = await apiServices.postRequest(context, param, ApiEndPoints.getShareRideRequest, GetShareRideRequestModel.fromJson, 'Get Share Ride Request');
     return getShareRideRequestModel!;
  }

  Future<AcceptShareRideRequestModel> acceptShareRideRequest(BuildContext context,
    String userId,
    String shareRideId,
    int status,
  ) async {
    var param = {
      'userId': userId,
      'ShareRideId': shareRideId,
      'status': status
    };
    acceptShareRideRequestModel = await apiServices.postRequest(context, param, ApiEndPoints.acceptShareRideRequest, AcceptShareRideRequestModel.fromJson, 'Accept Share Ride Request');
     return acceptShareRideRequestModel!;
  }

  Future<GetShareRideRequestModel> getAcceptedRequests(BuildContext context,
    String shareRideId,
  ) async {
    var param = {
      'ShareRideId': shareRideId,
    };
    getShareRideRequestModel = await apiServices.postRequest(context, param, ApiEndPoints.getAcceptedShareRideRequests, GetShareRideRequestModel.fromJson, 'Get Accepted Share Ride Request');
     return getShareRideRequestModel!;
  }

  Future<MyTripsDetails> filterPastTrips(BuildContext context,
    String userId,
    List<int> months,
    int year,
  ) async {
    var param = {'userId': userId, 'months': months, 'year': year};
    filterPastTripsModel = await apiServices.postRequest(context, param, ApiEndPoints.filterPastTrips, MyTripsDetails.fromJson, 'Filter Past Trips');
     return filterPastTripsModel!;
  }
  Future<FaqTitlesModel> getFaqTitles(BuildContext context)async{
   var params ={
    "type":'',
   };
  faqTitlesModel =  await apiServices.postRequest(context, params, ApiEndPoints.getFaqTitles, FaqTitlesModel.fromJson, 'Get Faq titles');
  return faqTitlesModel!;
  }



  Future<FaqModel> getFaqs(BuildContext context,String faqId)async{
   var params ={
    "faqid":faqId,
   };
 faqModel = await apiServices.postRequest(context, params, ApiEndPoints.getFaqQuestionAns, FaqModel.fromJson, 'Get Faq Question Answer');
 return faqModel!;
  }


  Future<SendEmailSupportModel> sendemailsupport(BuildContext context,String userId, String subject, String message)async{
   var params ={
    "userId":userId,
    "subject":subject,
    "message":message,
   };
 sendEmailSupportModel = await apiServices.postRequest(context, params, ApiEndPoints.sendEmailMsg, SendEmailSupportModel.fromJson, 'Email Sent Response');
 return sendEmailSupportModel!;
  }
 


 Future<ReportProblemModel> reportproblem(BuildContext context,
      String userId,String issue, String description,List<String> path) async {
    var param = {'userId': userId, 'issue': issue,'description': description};
    
    reportProblemModel = await apiServices.singleImageRequest(context, param, ApiEndPoints.reportproblem, ReportProblemModel.fromJson, 'Report Problem', path.first.toString(), 'image');
    return reportProblemModel!;
  }


   Future<AddContactModel> addContact(BuildContext context,String userId, String name, String number)async{
   var params ={
    "userId":userId,
    "name":name,
    "phone":number,
   };
 addContactModel = await apiServices.postRequest(context, params, ApiEndPoints.addEmergencyContact, AddContactModel.fromJson, 'Add Contact Response');
 return addContactModel!;
  }

  Future<GetContactModel> getEmergencyContacts(BuildContext context,String userId)async{
   var params ={
    "userId":userId,
   };
 getContactModel = await apiServices.postRequest(context, params, ApiEndPoints.getEmergencyContact, GetContactModel.fromJson, 'Get Emergency Contact Response');
 return getContactModel!;
  }




  Future<LegalDataModel> getlegaldata(BuildContext context,String userId)async{
    final param = {};
 
 legalDataModel = await apiServices.getRequestWithHmac(context,param,ApiEndPoints.getTermsConditions, LegalDataModel.fromJson, 'Get Legal Data');
 return legalDataModel!;
  }

Future<AllNotificationModel> allNotificationSettings(BuildContext context,
      String userId, String type, int pushNotification) async {
    var params = {
      "userId": userId,
      "type": type,
      "pushNotification": pushNotification
    };
    allNotificationModel = await apiServices.postRequest(
        context,
        params,
        ApiEndPoints.allNotificationSetting,
        AllNotificationModel.fromJson,
        'All Notification Settings');
    return allNotificationModel!;
  }
 
  Future<AllNotificationModel> singleNotificationSettings(
      BuildContext context, String userId, String fieldName, int value) async {
    var params = {"userId": userId, "fieldName": fieldName, "value": value};
    allNotificationModel = await apiServices.postRequest(
        context,
        params,
        ApiEndPoints.singleNotificationSetting,
        AllNotificationModel.fromJson,
        'Single Notification Settings');
    return allNotificationModel!;
  }
 
  Future<NotificationStatusModel> getNotificationStatus(
    BuildContext context,
    String userId,
  ) async {
    var params = {
      "userId": userId,
    };
    getNotificationStatusModel = await apiServices.postRequest(
        context,
        params,
        ApiEndPoints.getNotificationStatus,
        NotificationStatusModel.fromJson,
        'Get Notification Status');
    return getNotificationStatusModel!;
  }
}
