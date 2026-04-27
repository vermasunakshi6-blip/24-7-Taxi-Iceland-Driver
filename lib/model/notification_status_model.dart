class NotificationStatusModel {
  int? status;
  String? message;
  NotificationData? data;
 
  NotificationStatusModel({this.status, this.message, this.data});
 
  NotificationStatusModel.fromJson(Map<String, dynamic> json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? NotificationData.fromJson(json['data']) : null;
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['status'] = status;
    data['message'] = message;
    if (this.data != null) {
      data['data'] = this.data!.toJson();
    }
    return data;
  }
}
 
class NotificationData {
  String? sId;
  String? userId;
  int? pushNotification;
  int? rideAlerts;
  int? bookingConfirmation;
  int? rideStatusUpdate;
  int? pickUpDropOff;
  int? driverDetail;
  int? paymentConfirmation;
  int? ratintRequests;
  int? rideCompletion;
  int? promotionsAndOffers;
  int? discountsAndCoupons;
  int? referralProgramOffers;
  int? holidaySeasonalPromotions;
  int? subscriptionBasedOffers;
  int? partnerOffers;
  int? eventNotifications;
  int? inAppEvents;
  int? specialOffersRelatedEvents;
  int? eventReminder;
  int? eventCancellations;
  int? liveEventsUpdate;
  int? syatemUpdate;
  int? featureUpdate;
  int? securityUpdate;
  int? performanceImprovements;
  int? mandatoryUpdate;
  String? createdAt;
  String? updatedAt;
  int? iV;
 
  NotificationData(
      {this.sId,
      this.userId,
      this.pushNotification,
      this.rideAlerts,
      this.bookingConfirmation,
      this.rideStatusUpdate,
      this.pickUpDropOff,
      this.driverDetail,
      this.paymentConfirmation,
      this.ratintRequests,
      this.rideCompletion,
      this.promotionsAndOffers,
      this.discountsAndCoupons,
      this.referralProgramOffers,
      this.holidaySeasonalPromotions,
      this.subscriptionBasedOffers,
      this.partnerOffers,
      this.eventNotifications,
      this.inAppEvents,
      this.specialOffersRelatedEvents,
      this.eventReminder,
      this.eventCancellations,
      this.liveEventsUpdate,
      this.syatemUpdate,
      this.featureUpdate,
      this.securityUpdate,
      this.performanceImprovements,
      this.mandatoryUpdate,
      this.createdAt,
      this.updatedAt,
      this.iV});
 
  NotificationData.fromJson(Map<String, dynamic> json) {
    sId = json['_id'];
    userId = json['userId'];
    pushNotification = json['pushNotification'];
    rideAlerts = json['rideAlerts'];
    bookingConfirmation = json['bookingConfirmation'];
    rideStatusUpdate = json['rideStatusUpdate'];
    pickUpDropOff = json['pickUpDropOff'];
    driverDetail = json['driverDetail'];
    paymentConfirmation = json['paymentConfirmation'];
    ratintRequests = json['ratintRequests'];
    rideCompletion = json['rideCompletion'];
    promotionsAndOffers = json['promotionsAndOffers'];
    discountsAndCoupons = json['discountsAndCoupons'];
    referralProgramOffers = json['referralProgramOffers'];
    holidaySeasonalPromotions = json['holidaySeasonalPromotions'];
    subscriptionBasedOffers = json['subscriptionBasedOffers'];
    partnerOffers = json['partnerOffers'];
    eventNotifications = json['eventNotifications'];
    inAppEvents = json['inAppEvents'];
    specialOffersRelatedEvents = json['specialOffersRelatedEvents'];
    eventReminder = json['eventReminder'];
    eventCancellations = json['eventCancellations'];
    liveEventsUpdate = json['liveEventsUpdate'];
    syatemUpdate = json['syatemUpdate'];
    featureUpdate = json['featureUpdate'];
    securityUpdate = json['securityUpdate'];
    performanceImprovements = json['performanceImprovements'];
    mandatoryUpdate = json['mandatoryUpdate'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
  }
 
  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = <String, dynamic>{};
    data['_id'] = sId;
    data['userId'] = userId;
    data['pushNotification'] = pushNotification;
    data['rideAlerts'] = rideAlerts;
    data['bookingConfirmation'] = bookingConfirmation;
    data['rideStatusUpdate'] = rideStatusUpdate;
    data['pickUpDropOff'] = pickUpDropOff;
    data['driverDetail'] = driverDetail;
    data['paymentConfirmation'] = paymentConfirmation;
    data['ratintRequests'] = ratintRequests;
    data['rideCompletion'] = rideCompletion;
    data['promotionsAndOffers'] = promotionsAndOffers;
    data['discountsAndCoupons'] = discountsAndCoupons;
    data['referralProgramOffers'] = referralProgramOffers;
    data['holidaySeasonalPromotions'] = holidaySeasonalPromotions;
    data['subscriptionBasedOffers'] = subscriptionBasedOffers;
    data['partnerOffers'] = partnerOffers;
    data['eventNotifications'] = eventNotifications;
    data['inAppEvents'] = inAppEvents;
    data['specialOffersRelatedEvents'] = specialOffersRelatedEvents;
    data['eventReminder'] = eventReminder;
    data['eventCancellations'] = eventCancellations;
    data['liveEventsUpdate'] = liveEventsUpdate;
    data['syatemUpdate'] = syatemUpdate;
    data['featureUpdate'] = featureUpdate;
    data['securityUpdate'] = securityUpdate;
    data['performanceImprovements'] = performanceImprovements;
    data['mandatoryUpdate'] = mandatoryUpdate;
    data['createdAt'] = createdAt;
    data['updatedAt'] = updatedAt;
    data['__v'] = iV;
    return data;
  }
}