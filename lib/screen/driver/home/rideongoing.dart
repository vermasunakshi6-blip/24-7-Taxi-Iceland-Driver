// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:developer';
import 'package:taxi_driver_24_7/provider/driverprovider/driverside_googlemaps_provider.dart';
import 'package:taxi_driver_24_7/screen/chat_screen.dart';
import 'package:taxi_driver_24_7/screen/driver/home/cancelridedriver.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:taxi_driver_24_7/widgets/common/button_widget.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:taxi_driver_24_7/widgets/specialized/add_stops_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_field_style.dart';
import 'package:otp_text_field/style.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';
import 'dart:ui';

// ignore: must_be_immutable
class RideOngoing extends StatefulWidget {
  String? otpValue;
  RideOngoing({
    super.key,
  });

  @override
  State<RideOngoing> createState() => RideOngoingState();
}

class RideOngoingState extends State<RideOngoing> {
  Socket? socket;
  MediaQueryData? queryData;
  SharedPreferences? prefs;
  String rideId = "";
  String parcelType = '';
  String deliveryType = '';
  DriveSideGoogleMapsProvider? googleMapsProvider;
  bool _isAddStopsSheetOpen = false;

  BitmapDescriptor? customIcon;
  BitmapDescriptor? customIcon1;
  BitmapDescriptor? carIcon;
  @override
  void initState() {
    loadCustomMarker();
    super.initState();
    socket = io('https://taxi-api.testdrivesite.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      log('Connected to Server');
    });

    socket!.on('current_lat_long', (message) {
      setState(() {
        final data = message.toString().split(" ");
        log("Newmessgae====>>>>>$data");
      });
    });

    socket!.on('rideStatus', (message) {
      log('message driver side##########-->>$message');
      if (message.toString().contains('status: 6') &&
          message.toString().contains('userId: $rideId')) {
        setState(() {
          init();
        });
      } else if (message.toString().contains('status: 5')) {
        setState(() {
          prefs!.remove(PrefConstant.status);
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => const DriverHomeNew(),
              ));
        });
      } else if (message.toString().contains('status: 7')) {
        log("Ride ID: $rideId");
        if (!mounted) return;
        if (_isAddStopsSheetOpen) return;
        final rideDetail = googleMapsProvider?.userRideDetail;
        if (rideDetail == null) return;
        _isAddStopsSheetOpen = true;
        showModalBottomSheet(
          context: context,
          shape: const RoundedRectangleBorder(
              borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(28), topRight: Radius.circular(28))),
          isScrollControlled: true,
          builder: (context) => AddStopsDialog(
            rideId: rideId,
            rideData: rideDetail,
          ),
        ).whenComplete(() {
          _isAddStopsSheetOpen = false;
        });
      } else if (message.toString().contains('status: 8')) {
        log("status 8");
        log('checking 8 status=============???????');
        init();
      }
    });

    socket!.onDisconnect((_) {
      log('Disconnected from server');
    });
    init();
  }

  void init() async {
    prefs = await SharedPreferences.getInstance();
    rideId = prefs!.getString(PrefConstant.rideId) ?? '';
    prefs!.setString(PrefConstant.status, '1');
    Future.delayed(Duration.zero).then((value) {
      Provider.of<DriveSideGoogleMapsProvider>(context, listen: false)
          .init(context, rideId, prefs!.getString(PrefConstant.userid) ?? '');
    });
  }

  void copyToClipboardWithFeedback(BuildContext context, String text) {
    Clipboard.setData(ClipboardData(text: text));
    CSnackBar.showSnackBar('Copied to Clipboard', context);
  }

  @override
  Widget build(BuildContext context) {
    googleMapsProvider = Provider.of<DriveSideGoogleMapsProvider>(context);
    queryData = MediaQuery.of(context);
    Future.delayed(const Duration(seconds: 0), () {
      if (!mounted) return;
      final provider = googleMapsProvider;
      final location = provider?.currentLocation;
      final userId = prefs?.getString(PrefConstant.userid) ?? '';
      if (location != null && socket != null && userId.isNotEmpty) {
        final lat = location.latitude.toString();
        final lang = location.longitude.toString();
        socket!.emit('current_lat_long', '$lat $lang $userId');
      }
    });
    if (googleMapsProvider!.userRideDetaildata != null) {
      switch (googleMapsProvider!.userRideDetaildata!.packageType) {
        case 0:
          parcelType = "Documents";
          break;
        case 1:
          parcelType = "Small Package";
          break;
        case 2:
          parcelType = "Big Package";
          break;
        case 3:
          parcelType = "Fragile Items";
          break;
        default:
          parcelType = "Documents";
      }
      switch (googleMapsProvider!.userRideDetaildata!.deliveryType) {
        case 0:
          deliveryType = "Express Delivery";
          break;
        case 1:
          deliveryType = "Standard Delivery";
          break;

        default:
          deliveryType = 'Standard Delivery';
      }
    }

    return googleMapsProvider!.isloading
        ? const Scaffold(
            body: Center(
              child: CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                ),
            ),
          )
        : Scaffold(
            bottomSheet: InteractiveBottomSheet(
              options: const InteractiveBottomSheetOptions(
                  initialSize: 0.50, maxSize: 0.75),
              draggableAreaOptions:  DraggableAreaOptions(
                  topBorderRadius: 20,
                  indicatorWidth: 120,
                  indicatorColor: AppColors.greyColor.withOpacity(0.3),
                  indicatorHeight: 8),
              child: Padding(
                  padding: const EdgeInsets.all(0),
                  child: SingleChildScrollView(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(20.0),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                width: 10,
                              ),
                              Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  CircleAvatar(
                                    radius: 32,
                                    backgroundImage: NetworkImage(
                                        googleMapsProvider!
                                            .userRideDetaildata!.userPhoto
                                            .toString()),
                                  ),
                                  const SizedBox(
                                    width: 8,
                                  ),
                                  Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      googleMapsProvider!.userRideDetaildata!
                                              .customerData!.isNotEmpty
                                          ? Text(
                                              googleMapsProvider!
                                                  .userRideDetaildata!
                                                  .customerData![0]
                                                  .name!,
                                              style:blackTitle,
                                            )
                                          : Text(
                                              '',
                                              style:blackTitle,
                                            ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      RatingBarIndicator(
                                          rating: double.parse(
                                              googleMapsProvider!
                                                  .userRideDetaildata!
                                                  .userRating
                                                  .toString()),
                                          itemCount: 5,
                                          itemSize: 20.0,
                                          itemBuilder: (context, _) =>
                                              const Icon(
                                                Icons.star,
                                                color:AppColors.redColor,
                                              )),
                                      Row(
                                        children: [
                                          Text(
                                            "${googleMapsProvider!.userRideDetaildata!.price } ${googleMapsProvider!.userRideDetaildata!.currencySymbol}",
                                            style: blackTitle,
                                          ),
                                          
                                        ],
                                      ),
                                    ],
                                  )
                                ],
                              ),
                              const SizedBox(
                                height: 10,
                              ),
                              Text(
                                AppStrings.tripRoute,
                                style: blackTitle,
                              ),
                              googleMapsProvider!.userRideDetaildata!
                                          .driverAcceptRequest ==
                                      0
                                  ? Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        if (googleMapsProvider!
                                                .userRideDetaildata!
                                                .stops!
                                                .length ==
                                            1) ...{
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, left: 0),
                                                  child: Column(
                                                    children: [
                                                      Image(
                                                        width: 12,
                                                        image: AssetImage(
                                                            'assets/images/circlegreen.png'),
                                                        color: AppColors.redColor,
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      Image(
                                                        width: 12,
                                                        image: AssetImage(
                                                            'assets/images/location.png'),
                                                        color: AppColors.redColor,
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 240,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              googleMapsProvider!
                                                                  .userRideDetaildata!
                                                                  .fromAddress!,
                                                              style: blackBody,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                            Text(
                                                              AppStrings.pickup,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .stops![0]
                                                                    .stopAddress!,
                                                                style: blackBody,
                                                                overflow:
                                                                    TextOverflow.ellipsis),
                                                            Text(
                                                              AppStrings.destination,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        } else if (googleMapsProvider!
                                                .userRideDetaildata!
                                                .stops!
                                                .length ==
                                            2) ...{
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                const Padding(
                                                  padding: EdgeInsets.only(
                                                      top: 10.0, left: 0),
                                                  child: Column(
                                                    children: [
                                                      Image(
                                                        width: 12,
                                                        image: AssetImage(
                                                            'assets/images/circlegreen.png'),
                                                      ),
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          color: AppColors
                                                              .greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          color: AppColors
                                                              .greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                    top: 5.0,
                                                  ),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment
                                                            .start,
                                                    children: [
                                                      SizedBox(
                                                        width: 240,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                              googleMapsProvider!
                                                                  .userRideDetaildata!
                                                                  .fromAddress!,
                                                              style: blackBody,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                            Text(
                                                              AppStrings.source,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .stops![0]
                                                                    .stopAddress!,
                                                                style: blackBody,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                            Text(
                                                              AppStrings.stop1,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        height: 20,
                                                      ),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment
                                                                  .start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .stops![1]
                                                                    .stopAddress!,
                                                                style: blackBody,
                                                                overflow:
                                                                    TextOverflow
                                                                        .ellipsis),
                                                            Text(
                                                              AppStrings.destination,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow
                                                                      .ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        } else if (googleMapsProvider!
                                                .userRideDetaildata!
                                                .stops!
                                                .length >=
                                            3) ...{
                                          Padding(
                                            padding: const EdgeInsets.only(
                                              top: 8,
                                              bottom: 8,
                                            ),
                                            child: Row(
                                              mainAxisAlignment:
                                                  MainAxisAlignment.start,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.start,
                                              children: [
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(
                                                          top: 10.0, left: 0),
                                                  child: Column(
                                                    children: [
                                                      const Image(
                                                        width: 12,
                                                        image: AssetImage(
                                                            'assets/images/circlegreen.png'),
                                                        color: AppColors.redColor,
                                                      ),
                                                      const SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      const SizedBox(
                                                        height: 35,
                                                        child: VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      const SizedBox(
                                                        height: 35,
                                                        child: VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      const SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                    ],
                                                  ),
                                                ),
                                                const SizedBox(width: 10),
                                                Padding(
                                                  padding:
                                                      const EdgeInsets.only(top: 5.0),
                                                  child: Column(
                                                    mainAxisAlignment:
                                                        MainAxisAlignment.start,
                                                    crossAxisAlignment:
                                                        CrossAxisAlignment.start,
                                                    children: [
                                                      SizedBox(
                                                        width: 240,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                              googleMapsProvider!
                                                                  .userRideDetaildata!
                                                                  .fromAddress!,
                                                              style: blackBody,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                            Text(
                                                              AppStrings.source,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .stops![0]
                                                                    .stopAddress!,
                                                                style: blackBody,
                                                                overflow:
                                                                    TextOverflow.ellipsis),
                                                            Text(
                                                              AppStrings.stop1,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .stops![1]
                                                                    .stopAddress!,
                                                                style: blackBody,
                                                                overflow:
                                                                    TextOverflow.ellipsis),
                                                            Text(
                                                              AppStrings.stop2,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .stops![2]
                                                                    .stopAddress!,
                                                                style: blackBody,
                                                                overflow:
                                                                    TextOverflow.ellipsis),
                                                            Text(
                                                              AppStrings.destination,
                                                              style: smallGrey,
                                                              overflow:
                                                                  TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ),
                                                ),
                                              ],
                                            ),
                                          ),
                                        }
                                      ],
                                    )
                                  : Builder(
                                      builder: (context) {
                                        final stops = googleMapsProvider!
                                            .userRideDetaildata!.stops!;
                                        final stopCount = stops.length;
                                        final hasStops = stopCount >= 1;
                                        return Padding(
                                          padding: const EdgeInsets.only(
                                            top: 8,
                                            bottom: 8,
                                          ),
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.start,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    top: 10.0, left: 0),
                                                child: Column(
                                                  children: [
                                                    const Image(
                                                      width: 12,
                                                      image: AssetImage(
                                                          'assets/images/circlegreen.png'),
                                                    ),
                                                    const SizedBox(
                                                      height: 40,
                                                      child: VerticalDivider(
                                                        color: AppColors.greyColor,
                                                        thickness: 0.5,
                                                      ),
                                                    ),
                                                    if (stopCount >= 1) ...[
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      SizedBox(
                                                        height: stopCount > 1 ? 35 : 40,
                                                        child: const VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                    if (stopCount >= 2) ...[
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      SizedBox(
                                                        height: stopCount > 2 ? 35 : 40,
                                                        child: const VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                    if (stopCount >= 3) ...[
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                      const SizedBox(
                                                        height: 40,
                                                        child: VerticalDivider(
                                                          color: AppColors.greyColor,
                                                          thickness: 0.5,
                                                        ),
                                                      ),
                                                    ],
                                                    if (!hasStops)
                                                      const Image(
                                                          width: 12,
                                                          image: AssetImage(
                                                              'assets/images/location.png')),
                                                  ],
                                                ),
                                              ),
                                              const SizedBox(width: 10),
                                              Padding(
                                                padding: const EdgeInsets.only(top: 5.0),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.start,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    SizedBox(
                                                      width: 240,
                                                      child: Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment.start,
                                                        children: [
                                                          Text(
                                                            googleMapsProvider!
                                                                .userRideDetaildata!
                                                                .fromAddress!,
                                                            style: blackBody,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                          Text(
                                                            AppStrings.source,
                                                            style: smallGrey,
                                                            overflow: TextOverflow.ellipsis,
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    if (stopCount >= 1) ...[
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                stops[0].stopAddress!,
                                                                style: blackBody,
                                                                overflow: TextOverflow.ellipsis),
                                                            Text(
                                                              stopCount == 1
                                                                  ? AppStrings.destination
                                                                  : AppStrings.stop1,
                                                              style: smallGrey,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (stopCount >= 2) ...[
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                stops[1].stopAddress!,
                                                                style: blackBody,
                                                                overflow: TextOverflow.ellipsis),
                                                            Text(
                                                              stopCount == 2
                                                                  ? AppStrings.destination
                                                                  : AppStrings.stop2,
                                                              style: smallGrey,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (stopCount >= 3) ...[
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                stops[2].stopAddress!,
                                                                style: blackBody,
                                                                overflow: TextOverflow.ellipsis),
                                                            Text(
                                                              AppStrings.destination,
                                                              style: smallGrey,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                    if (!hasStops) ...[
                                                      const SizedBox(height: 20),
                                                      SizedBox(
                                                        width: 260,
                                                        child: Column(
                                                          crossAxisAlignment:
                                                              CrossAxisAlignment.start,
                                                          children: [
                                                            Text(
                                                                googleMapsProvider!
                                                                    .userRideDetaildata!
                                                                    .toAddress!,
                                                                style: blackBody,
                                                                overflow: TextOverflow.ellipsis),
                                                            Text(
                                                              AppStrings.destination,
                                                              style: smallGrey,
                                                              overflow: TextOverflow.ellipsis,
                                                            ),
                                                          ],
                                                        ),
                                                      ),
                                                    ],
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    ),
                            ],
                          ),
                        ),
                        googleMapsProvider!.isRideStart == false
                            ? const SizedBox(
                                height: 10,
                                child: Divider(
                                  color: AppColors.greyColor,
                                  thickness: 0.5,
                                ),
                              )
                            : const SizedBox(),
                        googleMapsProvider!.userRideDetaildata!.shareRideData ==
                                    null ||
                                googleMapsProvider!
                                    .userRideDetaildata!.shareRideData!.isEmpty
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 20.0, vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.splittedPrice,
                                      style: blackTitle,
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          googleMapsProvider!
                                              .userRideDetaildata!.userName
                                              .toString(),
                                          style: blackBody,
                                        ),
                                        Text(
                                          (double.parse(
                                                        googleMapsProvider!
                                                            .userRideDetaildata!
                                                            .price
                                                            .toString(),
                                                      ) /
                                                      (googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .shareRideData!
                                                              .length +
                                                          1))
                                                  .toStringAsFixed(4) +
                                              ' ${googleMapsProvider!.userRideDetaildata!.currencySymbol!} (\$${(double.parse(
                                                    googleMapsProvider!
                                                        .userRideDetaildata!
                                                        .priceInUSD
                                                        .toString(),
                                                  ) / (googleMapsProvider!.userRideDetaildata!.shareRideData!.length + 1)).toStringAsFixed(4)})',
                                          style: blackBody,
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: googleMapsProvider!
                                              .userRideDetaildata!
                                              .shareRideData!
                                              .length *
                                          20,
                                      child: ListView.builder(
                                        padding: EdgeInsets.zero,
                                        itemCount: googleMapsProvider!
                                            .userRideDetaildata!
                                            .shareRideData!
                                            .length,
                                        itemBuilder: (context, index) {
                                          final data = googleMapsProvider!
                                              .userRideDetaildata!;
                                          final pricePerPerson = (double.parse(
                                                    data.price.toString(),
                                                  ) /
                                                  (data.shareRideData!.length +
                                                      1))
                                              .toStringAsFixed(4);
                                          final usdPricePerPerson =
                                              (double.parse(
                                                        data.priceInUSD
                                                            .toString(),
                                                      ) /
                                                      (data.shareRideData!
                                                              .length +
                                                          1))
                                                  .toStringAsFixed(4);
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceBetween,
                                            children: [
                                              Text(
                                                data.shareRideData![index].name
                                                    .toString(),
                                                style: blackBody,
                                              ),
                                              Text(
                                                pricePerPerson +
                                                    ' ${data.currencySymbol!} (\$$usdPricePerPerson)',
                                                style:blackBody,
                                              ),
                                            ],
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                        googleMapsProvider!.isRideStart == true
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: Row(
                                  children: [
                                    GestureDetector(
                                      onTap: () {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    ChatScreen(
                                                      rideid: googleMapsProvider!
                                                          .userRideDetaildata!
                                                          .sId,
                                                      senderid:
                                                          googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .userId,
                                                      reciverid:
                                                          googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .driverId,
                                                      receieverImage:
                                                          googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .userPhoto
                                                              .toString(),
                                                      recieverName:
                                                          googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .userName
                                                              .toString(),
                                                      source: googleMapsProvider!
                                                          .userRideDetaildata!
                                                          .fromAddress,
                                                      destination:
                                                          googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .toAddress,
                                                      fare: googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .price! +
                                                          googleMapsProvider!
                                                              .userRideDetaildata!
                                                              .currencySymbol!,
                                                      usd: googleMapsProvider!
                                                          .userRideDetaildata!
                                                          .priceInUSD,
                                                    )));
                                      },
                                      child: Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              border: Border.all(
                                                color:
                                                    AppColors.greenColor,
                                              ),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(30))),
                                          child: const Icon(
                                            CupertinoIcons.bubble_left_fill,
                                            color: AppColors.greenColor,
                                          )),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Text(
                                      AppStrings.chat,
                                      style:blackTitle,
                                    ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                    googleMapsProvider!.isRideStart
                                        ? const SizedBox()
                                        : InkWell(
                                            onTap: () {
                                              Navigator.push(
                                                  context,
                                                  MaterialPageRoute(
                                                      builder: (context) =>
                                                          Cancelridedriver(
                                                            rideId: googleMapsProvider!
                                                                .userRideDetaildata!
                                                                .sId
                                                                .toString(),
                                                          )));
                                            },
                                            child: Row(
                                              children: [
                                                const Icon(
                                                  Icons.cancel,
                                                  size: 35,
                                                  color: AppColors.redColor,
                                                ),
                                                const SizedBox(
                                                  width: 10,
                                                ),
                                                Text(
                                                  AppStrings.cancel,
                                                  style:blackTitle,
                                                ),
                                              ],
                                            ),
                                          ),
                                    const SizedBox(
                                      width: 30,
                                    ),
                                  ],
                                ),
                              ),
                        googleMapsProvider!
                                    .userRideDetaildata!.bookingRideStatus ==
                                1
                            ? Padding(
                                padding: const EdgeInsets.only(
                                    left: 15.0, right: 15),
                                child: Column(
                                  children: [
                                    SizedBox(
                                      height: 10,
                                      child: Divider(
                                        color: AppColors.greyColor
                                            .withOpacity(0.3),
                                        thickness: 0.5,
                                      ),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          'assets/images/parcel.png',
                                          width: 32,
                                          height: 32,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(parcelType.toString(),
                                                  style:
                                                      blackBody),
                                              Row(
                                                children: [
                                                  Text(
                                                      googleMapsProvider!
                                                          .userRideDetaildata!
                                                          .packageWeight
                                                          .toString(),
                                                      style: blackBody),
                                                  const SizedBox(
                                                    width: 5,
                                                  ),
                                                  Text(deliveryType.toString(),
                                                      style: blackBody),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      children: [
                                        const Icon(
                                          Icons.call,
                                          size: 25,
                                          color: AppColors.blackColor,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Expanded(
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                  googleMapsProvider!
                                                      .userRideDetaildata!
                                                      .recipientsName
                                                      .toString(),
                                                  style:
                                                      blackBody),
                                              Row(
                                                children: [
                                                  Text(
                                                      googleMapsProvider!
                                                          .userRideDetaildata!
                                                          .recipientsNumber
                                                          .toString(),
                                                      style: blackBody),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                        InkWell(
                                          onTap: () {
                                            copyToClipboardWithFeedback(
                                                context,
                                                googleMapsProvider!
                                                    .userRideDetaildata!
                                                    .recipientsNumber
                                                    .toString());
                                          },
                                          child: const Icon(
                                            Icons.copy,
                                            size: 25,
                                            color: AppColors.blackColor,
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ))
                            : const SizedBox(),
                        googleMapsProvider!.isArrived == false
                            ? Padding(
                                padding: const EdgeInsets.all(20.0),
                                child: ButtonWidget(
                                  text: AppStrings.arrive,
                                  onPressed: () {
                                    setState(() {
                                      googleMapsProvider!.arrivetoCustomer(
                                          context,
                                          googleMapsProvider!
                                              .userRideDetaildata!.sId!,
                                          googleMapsProvider!
                                              .userRideDetaildata!.driverId!);
                                    });
                                  },
                                  color: AppColors.primaryBlueStart,
                                ),
                              )
                            : googleMapsProvider!.isRideStart == false
                                ? Center(
                                    child: Column(
                                      children: [
                                        Text(
                                          AppStrings.enterPickupOtp,
                                          style:greyTitle,
                                        ),
                                        OTPTextField(
                                            length: 6,
                                            width: 280,
                                            otpFieldStyle: OtpFieldStyle(
                                              disabledBorderColor:AppColors.greyColor,
                                              enabledBorderColor:AppColors.greyColor,
                                              focusBorderColor: AppColors.greyColor,borderColor: AppColors.greyColor
                                            ),
                                            textFieldAlignment:
                                                MainAxisAlignment.spaceAround,
                                            fieldStyle: FieldStyle.underline,
                                            outlineBorderRadius: 5,
                                            style: blackHeading.copyWith(fontSize: 24),
                                            onChanged: (pin) {
                                              widget.otpValue = pin;
                                            },
                                            onCompleted: (pin) {
                                              widget.otpValue = pin;
                                            }),
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        Padding(
                                          padding: const EdgeInsets.all(20.0),
                                          child: ButtonWidget(
                                            text: AppStrings.startRide,
                                            onPressed: () {
                                              googleMapsProvider!.startRide(
                                                  googleMapsProvider!
                                                      .userRideDetaildata!.sId!,
                                                  googleMapsProvider!
                                                      .userRideDetaildata!
                                                      .driverId!,
                                                  widget.otpValue!,
                                                  context);
                                            },
                                            color: AppColors.primaryBlueStart,
                                          ),
                                        ),
                                      ],
                                    ),
                                  )
                                : Padding(
                                    padding: const EdgeInsets.all(20.0),
                                    child: ButtonWidget(
                                      text: AppStrings.endRide,
                                      onPressed: () {
                                        googleMapsProvider!.endRide(
                                            googleMapsProvider!
                                                .userRideDetaildata!.sId!,
                                            googleMapsProvider!
                                                .userRideDetaildata!.driverId!,
                                            context);
                                        socket!.disconnect();
                                      },
                                      color: AppColors.primaryBlueStart,
                                    ),
                                  )
                      ],
                    ),
                  )),
            ),
            body: Stack(children: [
              googleMapsProvider!.currentLocation == null
                  ? const Center(child: CircularProgressIndicator(
                    color: AppColors.blackColor,

                  ))
                  : GoogleMap(
                      initialCameraPosition: CameraPosition(
                        target: LatLng(
                            double.parse(
                                googleMapsProvider!.fromLocationlatitute!),
                            double.parse(
                                googleMapsProvider!.fromLocationLangitute!)),
                        zoom: 12.5,
                      ),
                      markers: {
                        Marker(
                          markerId: const MarkerId("source"),
                          icon: customIcon ??
                              BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueGreen),
                          position: LatLng(
                              double.parse(
                                  googleMapsProvider!.fromLocationlatitute!),
                              double.parse(
                                  googleMapsProvider!.fromLocationLangitute!)),
                        ),
                        Marker(
                          markerId: const MarkerId("driver"),
                          icon: carIcon ??
                              BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueAzure),
                          position: LatLng(
                            googleMapsProvider!.currentLocation!.latitude!,
                            googleMapsProvider!.currentLocation!.longitude!,
                          ),
                        ),
                        googleMapsProvider!.userRideDetaildata!.stops![0]
                                    .stopLatitude !=
                                googleMapsProvider!.userRideDetaildata!
                                    .toLocation!.coordinates![1]
                                    .toString()
                            ? Marker(
                                markerId: const MarkerId("stop1"),
                                icon: customIcon1 ??
                                    BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRed),
                                position: LatLng(
                                    double.parse(googleMapsProvider!
                                        .userRideDetaildata!
                                        .stops![0]
                                        .stopLatitude!),
                                    double.parse(googleMapsProvider!
                                        .userRideDetaildata!
                                        .stops![0]
                                        .stopLongitude!)),
                              )
                            : const Marker(markerId: MarkerId('Empty')),
                        googleMapsProvider!.userRideDetaildata!.stops!.length >=
                                2
                            ? Marker(
                                markerId: const MarkerId("stop2"),
                                icon: customIcon1 ??
                                    BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRed),
                                position: LatLng(
                                    double.parse(googleMapsProvider!
                                        .userRideDetaildata!
                                        .stops![1]
                                        .stopLatitude!),
                                    double.parse(googleMapsProvider!
                                        .userRideDetaildata!
                                        .stops![1]
                                        .stopLongitude!)),
                              )
                            : const Marker(markerId: MarkerId("empty")),
                        googleMapsProvider!.userRideDetaildata!.stops!.length ==
                                3
                            ? Marker(
                                markerId: const MarkerId("stop3"),
                                icon: customIcon1!,
                                position: LatLng(
                                    double.parse(googleMapsProvider!
                                        .userRideDetaildata!
                                        .stops![2]
                                        .stopLatitude!),
                                    double.parse(googleMapsProvider!
                                        .userRideDetaildata!
                                        .stops![2]
                                        .stopLongitude!)),
                              )
                            : const Marker(markerId: MarkerId("empty")),
                        Marker(
                          markerId: const MarkerId("to"),
                          icon: customIcon1 ??
                              BitmapDescriptor.defaultMarkerWithHue(
                                  BitmapDescriptor.hueRed),
                          position: LatLng(
                              double.parse(googleMapsProvider!
                                  .userRideDetaildata!
                                  .toLocation!
                                  .coordinates![1]
                                  .toString()),
                              double.parse(googleMapsProvider!
                                  .userRideDetaildata!
                                  .toLocation!
                                  .coordinates![0]
                                  .toString())),
                        )
                      },
                      onMapCreated: (mapController) {
                        googleMapsProvider!.controller.complete(mapController);
                        WidgetsBinding.instance.addPostFrameCallback((_) {
                          if (mounted) _fitDriverAndFromLocation(mapController);
                        });
                      },
                    ),
              Positioned(
                child: InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const DriverHomeNew(),
                        ));
                  },
                  child: const Padding(
                    padding: EdgeInsets.only(left: 20.0, right: 20.0, top: 60),
                    child: Image(
                      image: AssetImage('assets/images/backarrow.png'),
                      width: 25,
                    ),
                  ),
                ),
              )
            ]));
  }

  void _fitDriverAndFromLocation(GoogleMapController mapController) {
    final loc = googleMapsProvider!.currentLocation;
    if (loc == null || googleMapsProvider!.fromLocationlatitute == null) return;
    final fromLat = double.tryParse(googleMapsProvider!.fromLocationlatitute!);
    final fromLng = double.tryParse(googleMapsProvider!.fromLocationLangitute!);
    if (fromLat == null || fromLng == null) return;
    final driverLat = loc.latitude!;
    final driverLng = loc.longitude!;
    final southWest = LatLng(
      driverLat < fromLat ? driverLat : fromLat,
      driverLng < fromLng ? driverLng : fromLng,
    );
    final northEast = LatLng(
      driverLat > fromLat ? driverLat : fromLat,
      driverLng > fromLng ? driverLng : fromLng,
    );
    final bounds = LatLngBounds(southwest: southWest, northeast: northEast);
    mapController.moveCamera(
      CameraUpdate.newLatLngBounds(bounds, 80),
    );
  }

  Future<void> loadCustomMarker() async {
    customIcon =
        await _resizeMarker('assets/images/CurrentLocation.png', 100, 100);

    customIcon1 =
        await _resizeMarker('assets/images/destination.png', 100, 100);

    try {
      carIcon = await _resizeMarker('assets/images/caricons.png', 140, 140);
    } catch (_) {
      carIcon = BitmapDescriptor.defaultMarkerWithHue(BitmapDescriptor.hueAzure);
    }
  }

  Future<BitmapDescriptor> _resizeMarker(
      String assetPath, int width, int height) async {
    ByteData data = await rootBundle.load(assetPath);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width,
      targetHeight: height,
    );
    FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData = await fi.image.toByteData(format: ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }
}
