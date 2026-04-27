// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import 'package:taxi_driver_24_7/widgets/common/toggle_button.dart';

class NotificationSettingScreen extends StatefulWidget {
  const NotificationSettingScreen({super.key});

  @override
  State<NotificationSettingScreen> createState() =>
      _NotificationSettingScreenState();
}

class _NotificationSettingScreenState extends State<NotificationSettingScreen> {
  List<String> alerts = [
    'Booking Confirmation',
    'Ride Status Updates',
    'Pickup and Drop-off Alerts',
    'Driver Details',
    'Payment Confirmation',
    'Rating Requests',
    'Ride Completion'
  ];
  List<String> promolist = [
    'Discounts & Coupons',
    'Referral Program Offers',
    'Holiday or Seasonal Promotions',
    'Subscription-Based Offers',
    'Partner Offers'
  ];
  List<String> eventlist = [
    'In-App Events',
    'Special Offers Related to Events',
    'Event Reminders',
    'Event Cancellations/Changes',
    'Live Event Updates'
  ];
  List<String> systemlist = [
    'Feature Updates',
    'Security Updates',
    'Performance Improvements',
    'Mandatory Updates'
  ];
  String userId = '';

  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(PrefConstant.userid)!;
   
    await Provider.of<SupportLegalProvider>(context, listen: false)
        .getNotificationStatus(context, userId);
  }

  @override
  Widget build(BuildContext context) {
    final supportProvider =
        Provider.of<SupportLegalProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding:
                                EdgeInsets.only(right: 30, top: 0, bottom: 0),
                            child: Image(
                                height: 25,
                                image: AssetImage(
                                  AppImages.arrowback,
                                )),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Center(
                      child: Text(
                        AppStrings.notificationsetting.toUpperCase(),
                        style: greyHeading,
                      ),
                    ),
                  ),
                  const Expanded(
                    child: SizedBox(),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 0),
              child: SingleChildScrollView(
                physics: const NeverScrollableScrollPhysics(),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.symmetric(vertical: 30.0),
                      child: ToggleButton(
                        text: 'All Notifications',
                        onTap: () async {
                          supportProvider.allNotificationSettings(
                              context,
                              userId,
                              'pushNotification',
                              supportProvider
                                          .allnotifications.pushNotification ==
                                      1
                                  ? 0
                                  : 1);
                        },
                        value:
                            supportProvider.allnotifications.pushNotification ??
                                0,
                        large: true,
                      ),
                    ),
                    Text(
                      'Manage Notifications',
                      style:
                          blackHeading,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    ToggleButton(
                      text: 'Ride Alert',
                      value: supportProvider.allnotifications.rideAlerts ?? 0,
                      medium: true,
                      onTap:
                          supportProvider.allnotifications.pushNotification == 0
                              ? () {}
                              : () async {
                                  supportProvider.allNotificationSettings(
                                      context,
                                      userId,
                                      'rideAlerts',
                                      supportProvider.allnotifications
                                                  .rideAlerts ==
                                              1
                                          ? 0
                                          : 1);
                                },
                    ),
                    ToggleButton(
                      text: alerts[0],
                      onTap: supportProvider.allnotifications.rideAlerts == 0
                          ? () {}
                          : () async {
                              supportProvider.singleNotificationSettings(
                                  context,
                                  userId,
                                  'bookingConfirmation',
                                  supportProvider.allnotifications
                                              .bookingConfirmation ==
                                          1
                                      ? 0
                                      : 1);
                            },
                      value: supportProvider
                              .allnotifications.bookingConfirmation ??
                          0,
                      small: true,
                    ),
                    ToggleButton(
                      text: alerts[1],
                      onTap: supportProvider.allnotifications.rideAlerts == 0
                          ? () {}
                          : () async {
                              supportProvider.singleNotificationSettings(
                                  context,
                                  userId,
                                  'rideStatusUpdate',
                                  supportProvider.allnotifications
                                              .rideStatusUpdate ==
                                          1
                                      ? 0
                                      : 1);
                            },
                      value:
                          supportProvider.allnotifications.rideStatusUpdate ??
                              0,
                      small: true,
                    ),
                    ToggleButton(
                      text: alerts[2],
                      onTap: supportProvider.allnotifications.rideAlerts == 0
                          ? () {}
                          : () async {
                              supportProvider.singleNotificationSettings(
                                  context,
                                  userId,
                                  'pickUpDropOff',
                                  supportProvider
                                              .allnotifications.pickUpDropOff ==
                                          1
                                      ? 0
                                      : 1);
                            },
                      value:
                          supportProvider.allnotifications.pickUpDropOff ?? 0,
                      small: true,
                    ),
                    // ToggleButton(
                    //   text: alerts[3],
                    //   onTap:supportProvider.allnotifications.rideAlerts==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'driverDetail', supportProvider.allnotifications.driverDetail==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.driverDetail??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: alerts[4],
                    //   onTap:supportProvider.allnotifications.rideAlerts==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'paymentConfirmation', supportProvider.allnotifications.paymentConfirmation==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.paymentConfirmation??0,
                    //   small: true,
                    // ),
                    ToggleButton(
                      text: alerts[5],
                      onTap: supportProvider.allnotifications.rideAlerts == 0
                          ? () {}
                          : () async {
                              supportProvider.singleNotificationSettings(
                                  context,
                                  userId,
                                  'ratintRequests',
                                  supportProvider.allnotifications
                                              .ratintRequests ==
                                          1
                                      ? 0
                                      : 1);
                            },
                      value:
                          supportProvider.allnotifications.ratintRequests ?? 0,
                      small: true,
                    ),
                    ToggleButton(
                      text: alerts[6],
                      onTap: supportProvider.allnotifications.rideAlerts == 0
                          ? () {}
                          : () async {
                              supportProvider.singleNotificationSettings(
                                  context,
                                  userId,
                                  'rideCompletion',
                                  supportProvider.allnotifications
                                              .rideCompletion ==
                                          1
                                      ? 0
                                      : 1);
                            },
                      value:
                          supportProvider.allnotifications.rideCompletion ?? 0,
                      small: true,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    // ToggleButton(
                    //   text: 'Promotions and Offers',
                    //   onTap:supportProvider.allnotifications.pushNotification==0?(){} : ()async {
                    //       supportProvider.allNotificationSettings(context, userId, 'promotionsAndOffers', supportProvider.allnotifications.promotionsAndOffers==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.promotionsAndOffers??0,
                    //   medium: true,
                    // ),
                    // ToggleButton(
                    //   text: promolist[0],
                    //   onTap:supportProvider.allnotifications.promotionsAndOffers==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'discountsAndCoupons', supportProvider.allnotifications.discountsAndCoupons==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.discountsAndCoupons??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: promolist[1],
                    //   onTap:supportProvider.allnotifications.promotionsAndOffers==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'referralProgramOffers', supportProvider.allnotifications.referralProgramOffers==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.referralProgramOffers??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: promolist[2],
                    //   onTap:supportProvider.allnotifications.promotionsAndOffers==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'holidaySeasonalPromotions', supportProvider.allnotifications.holidaySeasonalPromotions==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.holidaySeasonalPromotions??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: promolist[3],
                    //   onTap:supportProvider.allnotifications.promotionsAndOffers==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'subscriptionBasedOffers', supportProvider.allnotifications.subscriptionBasedOffers==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.subscriptionBasedOffers??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: promolist[4],
                    //   onTap:supportProvider.allnotifications.promotionsAndOffers==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'partnerOffers', supportProvider.allnotifications.partnerOffers==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.partnerOffers??0,
                    //   small: true,
                    // ),
                    // const SizedBox(
                    //   height: 15,
                    // ),

                    ToggleButton(
                      text: 'Event Notifications',
                      onTap:
                          supportProvider.allnotifications.pushNotification == 0
                              ? () {}
                              : () async {
                                  supportProvider.allNotificationSettings(
                                      context,
                                      userId,
                                      'eventNotifications',
                                      supportProvider.allnotifications
                                                  .eventNotifications ==
                                              1
                                          ? 0
                                          : 1);
                                },
                      value:
                          supportProvider.allnotifications.eventNotifications ??
                              0,
                      medium: true,
                    ),

                    ToggleButton(
                      text: eventlist[0],
                      onTap:
                          supportProvider.allnotifications.eventNotifications ==
                                  0
                              ? () {}
                              : () async {
                                  supportProvider.singleNotificationSettings(
                                      context,
                                      userId,
                                      'inAppEvents',
                                      supportProvider.allnotifications
                                                  .inAppEvents ==
                                              1
                                          ? 0
                                          : 1);
                                },
                      value: supportProvider.allnotifications.inAppEvents ?? 0,
                      small: true,
                    ),
                    // ToggleButton(
                    //   text: eventlist[1],
                    //   onTap:supportProvider.allnotifications.eventNotifications==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'specialOffersRelatedEvents', supportProvider.allnotifications.specialOffersRelatedEvents==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.specialOffersRelatedEvents??0,
                    //   small: true,
                    // ),
                    ToggleButton(
                      text: eventlist[2],
                      onTap:
                          supportProvider.allnotifications.eventNotifications ==
                                  0
                              ? () {}
                              : () async {
                                  supportProvider.singleNotificationSettings(
                                      context,
                                      userId,
                                      'eventReminder',
                                      supportProvider.allnotifications
                                                  .eventReminder ==
                                              1
                                          ? 0
                                          : 1);
                                },
                      value:
                          supportProvider.allnotifications.eventReminder ?? 0,
                      small: true,
                    ),
                    ToggleButton(
                      text: eventlist[3],
                      onTap:
                          supportProvider.allnotifications.eventNotifications ==
                                  0
                              ? () {}
                              : () async {
                                  supportProvider.singleNotificationSettings(
                                      context,
                                      userId,
                                      'eventCancellations',
                                      supportProvider.allnotifications
                                                  .eventCancellations ==
                                              1
                                          ? 0
                                          : 1);
                                },
                      value:
                          supportProvider.allnotifications.eventCancellations ??
                              0,
                      small: true,
                    ),
                    ToggleButton(
                      text: eventlist[4],
                      onTap:
                          supportProvider.allnotifications.eventNotifications ==
                                  0
                              ? () {}
                              : () async {
                                  supportProvider.singleNotificationSettings(
                                      context,
                                      userId,
                                      'liveEventsUpdate',
                                      supportProvider.allnotifications
                                                  .liveEventsUpdate ==
                                              1
                                          ? 0
                                          : 1);
                                },
                      value:
                          supportProvider.allnotifications.liveEventsUpdate ??
                              0,
                      small: true,
                    ),
                    // const SizedBox(
                    //   height: 15,
                    // ),
                    // ToggleButton(
                    //   text: 'System Updates',
                    //   onTap:supportProvider.allnotifications.pushNotification==0?(){} : ()async {
                    //       supportProvider.allNotificationSettings(context, userId, 'syatemUpdate', supportProvider.allnotifications.syatemUpdate==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.syatemUpdate??0,
                    //   medium: true,
                    // ),

                    // ToggleButton(
                    //   text: systemlist[0],
                    //   onTap:supportProvider.allnotifications.syatemUpdate==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'featureUpdate', supportProvider.allnotifications.featureUpdate==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.featureUpdate??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: systemlist[1],
                    //   onTap:supportProvider.allnotifications.syatemUpdate==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'securityUpdate', supportProvider.allnotifications.securityUpdate==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.securityUpdate??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: systemlist[2],
                    //   onTap:supportProvider.allnotifications.syatemUpdate==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'performanceImprovements', supportProvider.allnotifications.performanceImprovements==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.performanceImprovements??0,
                    //   small: true,
                    // ),
                    // ToggleButton(
                    //   text: systemlist[3],
                    //   onTap:supportProvider.allnotifications.syatemUpdate==0?(){} : ()async {
                    //    supportProvider.singleNotificationSettings(context, userId, 'mandatoryUpdate', supportProvider.allnotifications.mandatoryUpdate==1?0:1);

                    //   },
                    //   value: supportProvider.allnotifications.mandatoryUpdate??0,
                    //   small: true,
                    // ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
