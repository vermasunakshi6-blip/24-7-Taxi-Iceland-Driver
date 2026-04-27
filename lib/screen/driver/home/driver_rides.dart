// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:math';
import 'package:taxi_driver_24_7/provider/driverprovider/driverside_googlemaps_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/getnearbyriders_provider.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home.dart';
import 'package:taxi_driver_24_7/screen/driver/home/rideongoing.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:taxi_driver_24_7/widgets/common/shimmer_loader.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DriverRides extends StatefulWidget {
  final int totalRidesCount;
  const DriverRides({super.key, required this.totalRidesCount});
  @override
  State<DriverRides> createState() => DriverRidesState();
}

class DriverRidesState extends State<DriverRides>
    with TickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Socket? socket;
  bool isToggled = false;
  LatLng? locationLatLng;
  Location location = Location();
  LocationData? currentLocation;
  String? driverId;
  TabController? _tabController;
  String? rideId;

  String? backgrounstatus;
  SharedPreferences? prefs;
  final DateTime dateTime = DateTime.now();
  int selectedTab = 0;
  String parcelType = '';
  String deliveryType = '';
  AnimationController? _animationController;
  Animation<double>? _animation;

  String? userName;

  @override
  void initState() {
    _tabController = TabController(length: 2, vsync: this);
    super.initState();
    socket = io('https://taxi-api.testdrivesite.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      debugPrint('Connected to Server');
    });

    // Defer location to avoid iOS main-thread warning (locationManagerDidChangeAuthorization)
    WidgetsBinding.instance.addPostFrameCallback((_) => getCurrentLocation());
    getstatus();
    getApiData();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );

      _animation =
          Tween<double>(begin: 0, end: widget.totalRidesCount.toDouble())
              .animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInOut,
        ),
      );
      _animationController!.forward();
    });
  }

  void getCurrentLocation() async {
    currentLocation = await location.getLocation();
    if (!mounted) return;
    setState(() {
      getRideDetails(currentLocation!);
    });
  }

  void getstatus() async {
    prefs = await SharedPreferences.getInstance();
    rideId = prefs!.getString(PrefConstant.rideId) ?? '';

    Future.delayed(Duration.zero).then((value) async {
      await Provider.of<DriveSideGoogleMapsProvider>(context, listen: false)
          .currentRideDetails(
              context, prefs!.getString(PrefConstant.userid) ?? '');
      Provider.of<DriveSideGoogleMapsProvider>(context, listen: false)
                  .userRideDetaildata !=
              null
          ? Provider.of<DriveSideGoogleMapsProvider>(context, listen: false)
                      .userRideDetaildata!
                      .status ==
                  0
              ? await prefs!.remove(
                  PrefConstant.status,
                )
              : await prefs!.setString(PrefConstant.status, '1')
          : await prefs!.remove(
              PrefConstant.status,
            );
      main();
    });
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusMiles = 3959;

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));
    return earthRadiusMiles * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  void main() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    backgrounstatus = prefs.getString(PrefConstant.backgroundverification);
    String? status = prefs.getString(PrefConstant.status);
    prefs.remove(PrefConstant.vehicleId);
    if (status == '1') {
      Timer(const Duration(seconds: 3), () {
        final result = Navigator.pushReplacement(
            context, MaterialPageRoute(builder: (context) => RideOngoing()));
        debugPrint(' Result count $result');
      });
    }
  }

  void getApiData() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userName = prefs.getString(PrefConstant.firstName)!;
  }

  void getRideDetails(LocationData currentLocation) async {
    prefs = await SharedPreferences.getInstance();
    driverId = prefs!.getString(PrefConstant.userid);
    if (driverId != null) {
      Provider.of<GetNearByRidesProvider>(context, listen: false).getRides(
          context,
          driverId!,
          currentLocation.longitude.toString(),
          currentLocation.latitude.toString());
      // Provider.of<GetNearByRidesProvider>(context, listen: false).getScheduledRides(
      // driverId!,
      // );

      // Timer.periodic(const Duration(seconds: 10), (timer) {
      //   Provider.of<GetNearByRidesProvider>(context, listen: false).getRides(
      //       driverId!,
      //       currentLocation.longitude.toString(),
      //       currentLocation.latitude.toString());
      // });
    }
  }

  /// Wraps tab content so that any Expanded used by TabBarView has a Flex parent.
  Widget _tabPage(Widget child) {
    return Column(
      mainAxisSize: MainAxisSize.max,
      children: [Expanded(child: child)],
    );
  }

  @override
  Widget build(BuildContext context) {
    final getNearByRideProvider = Provider.of<GetNearByRidesProvider>(context);
    return PopScope(
      canPop: false,
      child: Scaffold(
        backgroundColor: Colors.white,
        key: scaffoldKey,
        body: currentLocation == null ||
                getNearByRideProvider.rideDetailsList == null
            ? const Center(
                child: CircularProgressIndicator(
                                    color: AppColors.blackColor,
                                  ),
              )
            : SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 0.0, top: 50.0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Expanded(
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pushReplacement(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const DriverHome()));
                                },
                                child: const Image(
                                    height: 25,
                                    image: AssetImage(AppImages.arrowback)),
                              ),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 2,
                          child: Center(
                            child: Text(
                              AppStrings.riderequest.toUpperCase(),
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
                    padding:
                        const EdgeInsets.only(left: 20.0, top: 30, right: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.letsDrive,
                                      style: blackHeading,
                                    ),
                                    Text(
                                      userName!+'!',
                                      style: greyHeading,
                                    ),
                                  ],
                                )
                              ],
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 1,
                  ),
                  _animation == null || widget.totalRidesCount == 0
                      ? const SizedBox()
                      : Padding(
                          padding: const EdgeInsets.all(10.0),
                          child: Container(
                            padding: _animation!.value < 5
                                ? const EdgeInsets.only(
                                    left: 20, right: 10, top: 10, bottom: 10)
                                : const EdgeInsets.symmetric(
                                    vertical: 10, horizontal: 15),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(12),
                                border: Border.all(
                                    color:
                                        AppColors.blackColor.withOpacity(0.1))),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(AppStrings.onYourWayToRewards,
                                    style: blackTitle),
                                const SizedBox(height: 20),
                                AnimatedBuilder(
                                  animation: _animation!,
                                  builder: (context, child) {
                                    return LinearGauge(
                                      start: 0,
                                      end: 200,
                                      steps: 100,
                                      rulers: RulerStyle(
                                        rulerPosition: RulerPosition.bottom,
                                        showPrimaryRulers: false,
                                        showSecondaryRulers: false,
                                        primaryRulerColor: AppColors.blackColor,
                                        secondaryRulerColor:AppColors.greyColor,
                                        textStyle: smallGrey
                                      ),
                                      customLabels: [
                                        const CustomRulerLabel(
                                            text: "", value: 0),
                                        CustomRulerLabel(
                                            text:
                                                '${_animation!.value.toInt()} of 100',
                                            value: _animation!.value),
                                         CustomRulerLabel(
                                            text: '100\n${AppStrings.rides}', value: 100),
                                         CustomRulerLabel(
                                            text: '200\n${AppStrings.rides}', value: 200),
                                      ],
                                      rangeLinearGauge: [
                                        RangeLinearGauge(
                                          start: 0,
                                          end: _animation!.value,
                                          color: AppColors.redColor,
                                          edgeStyle: LinearEdgeStyle.bothCurve,
                                        ),
                                      ],
                                      pointers: [
                                        const Pointer(
                                          value: 0,
                                          shape: PointerShape.circle,
                                          isInteractive: false,
                                          color: AppColors.redColor,
                                          showLabel: true,
                                          width: 15,
                                          height: 15,
                                        ),
                                        Pointer(
                                          value: _animation!.value,
                                          shape: PointerShape.circle,
                                          isInteractive: false,
                                          color: AppColors.redColor,
                                          showLabel: true,
                                        ),
                                        Pointer(
                                          value: 100,
                                          width: 15,
                                          height: 15,
                                          shape: PointerShape.circle,
                                          color: _animation!.value < 100
                                              ? AppColors.greyColor
                                              : AppColors.redColor,
                                          showLabel: true,
                                        ),
                                        Pointer(
                                          value: 200,
                                          width: 15,
                                          height: 15,
                                          shape: PointerShape.circle,
                                          color: _animation!.value < 200
                                              ? AppColors.greyColor
                                              : AppColors.redColor,
                                          showLabel: true,
                                        ),
                                      ],
                                      enableGaugeAnimation: true,
                                      animationType: Curves.decelerate,
                                      gaugeOrientation:
                                          GaugeOrientation.horizontal,
                                      linearGaugeBoxDecoration:
                                            LinearGaugeBoxDecoration(
                                        backgroundColor: AppColors.greyColor.withOpacity(0.3),
                                      ),
                                    );
                                  },
                                ),
                                const SizedBox(height: 20),
                              ],
                            ),
                          ),
                        ),
                 
                  const SizedBox(
                    height: 15,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 20.0),
                    child: Row(
                      children: [
                        Text(
                          AppStrings.rideRequests,
                          style: blackHeading,
                        ),
                      ],
                    ),
                  ),
                  Container(
                    height: 45,
                    width: MediaQuery.of(context).size.width / 1.1,
                    margin: const EdgeInsets.only(top: 30),
                    child: TabBar(
                      controller: _tabController,
                      dividerColor: Colors.transparent,
                      indicatorSize: TabBarIndicatorSize.tab,
                      unselectedLabelStyle: blackTitle,
                      labelStyle: blackTitle,
                      indicatorPadding: const EdgeInsets.symmetric(
                          horizontal: 3.8, vertical: 1),
                      indicator: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(25),
                      ),
                      splashBorderRadius: BorderRadius.circular(25),
                      labelColor: Colors.white,
                      unselectedLabelColor: AppColors.greyColor,
                      labelPadding: const EdgeInsets.symmetric(horizontal: 5),
                      tabAlignment: TabAlignment.fill,
                      onTap: (value) {
                        setState(() {
                          selectedTab = value;
                        });
                      },
                      tabs: [
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 22),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(25),
                                border: selectedTab == 1
                                    ? Border.all(
                                        color: AppColors.blackColor, width: 1)
                                    : null),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(AppStrings.currentRides,style:selectedTab == 1
                                    ?blackTitle  :whiteTitle,),
                               getNearByRideProvider
                                        .rideDetailsList!.isNotEmpty
                                    ?  const SizedBox(width: 8,):const SizedBox(),
                                getNearByRideProvider
                                        .rideDetailsList!.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 12,
                                        backgroundColor:selectedTab == 1? AppColors.greyColor.withOpacity(0.1):Colors.white.withOpacity(0.5),
                                        child: Text(
                                          '${getNearByRideProvider.rideDetailsList?.length}',
                                          style: redTitle,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                        Tab(
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 10),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(25),
                              border: selectedTab == 0
                                  ? Border.all(
                                      color: AppColors.blackColor, width: 1)
                                  : null,
                            ),
                            alignment: Alignment.center,
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                 Text(AppStrings.scheduledRides,style: selectedTab == 0
                                    ?blackTitle  :whiteTitle,),
                                getNearByRideProvider
                                        .scheduleRideDetailsList!.isNotEmpty
                                    ?  const SizedBox(width: 8,):const SizedBox(),
                                getNearByRideProvider
                                        .scheduleRideDetailsList!.isNotEmpty
                                    ? CircleAvatar(
                                        radius: 12,
                                        backgroundColor:selectedTab == 0? AppColors.greyColor.withOpacity(0.1):Colors.white.withOpacity(0.5),
                                        child: Text(
                                          '${getNearByRideProvider.scheduleRideDetailsList?.length}',
                                          style: redTitle,
                                        ),
                                      )
                                    : const SizedBox()
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height / 1.4,
                    child: TabBarView(
                      controller: _tabController,
                      children: [
                        _tabPage(getNearByRideProvider.isloading
                                ? ShimmerLoader(
                                    count: 6,
                                    height:
                                        MediaQuery.of(context).size.height / 4)
                                : getNearByRideProvider.rideDetailsList!.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppStrings.currentlyNorides,
                                          style: blackHeading,
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: getNearByRideProvider
                                            .rideDetailsList?.length,
                                        itemBuilder:
                                            (BuildContext context1, int index) {
                                          final data = getNearByRideProvider
                                              .rideDetailsList![index];
                                          final distance = calculateDistance(
                                              data.fromLocation!
                                                  .coordinates![1],
                                              data.fromLocation!
                                                  .coordinates![0],
                                              data.toLocation!.coordinates![1],
                                              data.toLocation!.coordinates![0]);
                                          switch (data.packageType) {
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
                                          switch (data.deliveryType) {
                                            case 0:
                                              deliveryType = "Express Delivery";
                                              break;
                                            case 1:
                                              deliveryType =
                                                  "Standard Delivery";
                                              break;

                                            default:
                                              deliveryType =
                                                  'Standard Delivery';
                                          }

                                          return ListTile(
                                            title: Card(
                                              color: Colors.white,
                                              elevation: 0.5,
                                              shadowColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side:   BorderSide(
                                                      color:AppColors.greyColor.withOpacity(0.3),
                                                      width: 1)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Padding(
                                                      padding:
                                                          const EdgeInsets.only(
                                                              left: 8),
                                                      child: Row(
                                                        mainAxisAlignment:
                                                            MainAxisAlignment
                                                                .start,
                                                        children: [
                                                          data.userId!.profilePic ==
                                                                      '' ||
                                                                  data.userId!
                                                                          .profilePic ==
                                                                      null
                                                              ? const CircleAvatar(
                                                                  radius: 32,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  child: Icon(
                                                                    Icons
                                                                        .person,
                                                                    color: AppColors
                                                                        .redColor,
                                                                  ),
                                                                )
                                                              : CircleAvatar(
                                                                  radius: 32,
                                                                  backgroundColor:
                                                                      Colors
                                                                          .white,
                                                                  backgroundImage:
                                                                      NetworkImage(data
                                                                          .userId!
                                                                          .profilePic
                                                                          .toString()),
                                                                ),
                                                          const SizedBox(
                                                            width: 10,
                                                          ),
                                                          Column(
                                                            crossAxisAlignment:
                                                                CrossAxisAlignment
                                                                    .start,
                                                            children: [
                                                              Text(
                                                                data.userId!
                                                                    .firstName!,
                                                                style: blackTitle,
                                                              ),
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
                                                                crossAxisAlignment:
                                                                    CrossAxisAlignment
                                                                        .start,
                                                                children: [
                                                                  const Icon(
                                                                    Icons.star,
                                                                    color: AppColors
                                                                        .redColor,
                                                                    size: 18,
                                                                  ),
                                                                  Text(
                                                                    data.userRating
                                                                        .toString(),
                                                                    style:blackTitle,
                                                                  ),
                                                                ],
                                                              ),
                                                              Text(
                                                                data.vehicleType
                                                                    .toString(),
                                                                style: blackBody,
                                                              ),
                                                            ],
                                                          ),
                                                        ],
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                         AppStrings.route,
                                                          style: blackTitle,
                                                        ),
                                                        Text(
                                                            distance.toStringAsFixed(
                                                                    3) +
                                                                'mi',
                                                            style: blackTitle),
                                                      ],
                                                    ),
                                                    if (data.stops == null ||
                                                        data.stops!.isEmpty) ...[
                                                      Row(
                                                        mainAxisAlignment: MainAxisAlignment.start,
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              data.fromAddress!,
                                                              style: greyBody,
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                            child: Icon(
                                                              Icons.arrow_forward,
                                                              size: 12,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              data.toAddress!,
                                                              style: greyBody,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ] else if (data.stops!.length >= 1) ...[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 10.0, left: 0),
                                                              child: Column(
                                                                children: [
                                                                  const Image(
                                                                    width: 12,
                                                                    image: AssetImage('assets/images/circlegreen.png'),
                                                                  ),
                                                                  SizedBox(
                                                                    height: data.stops!.length > 1 ? 20 : 20,
                                                                    child: const VerticalDivider(
                                                                      color: AppColors.greyColor,
                                                                      thickness: 0.5,
                                                                    ),
                                                                  ),
                                                                  if (data.stops!.length >= 1)
                                                                    const Image(
                                                                        width: 12,
                                                                        image: AssetImage('assets/images/location.png')),
                                                                  if (data.stops!.length >= 1)
                                                                    SizedBox(
                                                                      height: data.stops!.length > 1 ? 20 : 20,
                                                                      child: const VerticalDivider(
                                                                        color: AppColors.greyColor,
                                                                        thickness: 0.5,
                                                                      ),
                                                                    ),
                                                                  if (data.stops!.length >= 2) ...[
                                                                    const Image(
                                                                        width: 12,
                                                                        image: AssetImage('assets/images/location.png')),
                                                                    SizedBox(
                                                                      height: data.stops!.length > 2 ? 20 : 20,
                                                                      child: const VerticalDivider(
                                                                        color: AppColors.greyColor,
                                                                        thickness: 0.5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  if (data.stops!.length >= 3) ...[
                                                                    const Image(
                                                                        width: 12,
                                                                        image: AssetImage('assets/images/location.png')),
                                                                    const SizedBox(
                                                                      height: 20,
                                                                      child: VerticalDivider(
                                                                        color: AppColors.greyColor,
                                                                        thickness: 0.5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(width: 10),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 5.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 240,
                                                                    child: Text(
                                                                      data.fromAddress!,
                                                                      style: greyBody,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    width: 260,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          data.stops![0].stopAddress!,
                                                                          style: greyBody,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          data.stops!.length == 1
                                                                              ? AppStrings.destination
                                                                              : AppStrings.stop1,
                                                                          style: smallGrey,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if (data.stops!.length >= 2) ...[
                                                                    const SizedBox(height: 20),
                                                                    SizedBox(
                                                                      width: 260,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            data.stops![1].stopAddress!,
                                                                            style: greyBody,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                          Text(
                                                                            data.stops!.length == 2
                                                                                ? AppStrings.destination
                                                                                : AppStrings.stop2,
                                                                            style: smallGrey,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  if (data.stops!.length >= 3) ...[
                                                                    const SizedBox(height: 20),
                                                                    SizedBox(
                                                                      width: 260,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            data.stops![2].stopAddress!,
                                                                            style: greyBody,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
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
                                                      ),
                                                    ],
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    data.bookingRideStatus == 1
                                                        ? Column(
                                                            children: [
                                                              Row(
                                                                mainAxisAlignment:
                                                                    MainAxisAlignment
                                                                        .start,
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
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            parcelType
                                                                                .toString(),
                                                                            style:
                                                                                blackBody),
                                                                        Row(
                                                                          children: [
                                                                            Text(data.packageWeight!.toString(),
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
                                                                    color: AppColors
                                                                        .blackColor,
                                                                  ),
                                                                  const SizedBox(
                                                                    width: 10,
                                                                  ),
                                                                  Expanded(
                                                                    child:
                                                                        Column(
                                                                      crossAxisAlignment:
                                                                          CrossAxisAlignment
                                                                              .start,
                                                                      children: [
                                                                        Text(
                                                                            data.recipientsName
                                                                                .toString(),
                                                                            style:
                                                                                blackBody),
                                                                        Row(
                                                                          children: [
                                                                            Text(data.recipientsNumber.toString(),
                                                                                style: blackBody),
                                                                          ],
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                ],
                                                              )
                                                            ],
                                                          )
                                                        : const SizedBox(),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppStrings.totalFare,
                                                          style: blackTitle,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${data.price} ${data.currencySymbol}',
                                                                style:blackTitle),
                                                            
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    const SizedBox(
                                                      height: 10,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            height: 45,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                getNearByRideProvider
                                                                    .rideDecline(
                                                                        data.sId!,
                                                                        driverId!,
                                                                        context);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                elevation: 0,
                                                                backgroundColor: Colors.white,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                side:
                                                                    const BorderSide(
                                                                  width: 1,
                                                                  color: AppColors
                                                                      .greyColor,
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                AppStrings.decline,
                                                                style:blackHeading,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            height: 45,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                getNearByRideProvider
                                                                    .rideAccept(
                                                                        data.sId!,
                                                                        driverId!,
                                                                        context,
                                                                        index);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primaryBlueStart,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                              ),
                                                              child: Text(
                                                               AppStrings.accept,
                                                                style:whiteHeading,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                            onTap: () {},
                                          );
                                        },
                                      )),
                        _tabPage(getNearByRideProvider.isloading
                            ? ShimmerLoader(
                                count: 6,
                                height:
                                    MediaQuery.of(context).size.height / 4)
                            : getNearByRideProvider
                                    .scheduleRideDetailsList!.isEmpty
                                    ? Center(
                                        child: Text(
                                          AppStrings.currentlyNoRideRequests,
                                          style: blackTitle,
                                        ),
                                      )
                                    : ListView.builder(
                                        itemCount: getNearByRideProvider
                                            .scheduleRideDetailsList?.length,
                                        itemBuilder:
                                            (BuildContext context1, int index) {
                                          final data = getNearByRideProvider
                                              .scheduleRideDetailsList![index];
                                          final formattedDate = DateFormat(
                                                  'dd MMMM, yyyy')
                                              .format(DateTime.parse(
                                                  data.ridebookingDate ?? ''));
                                          final distance = calculateDistance(
                                              data.fromLocation!
                                                  .coordinates![1],
                                              data.fromLocation!
                                                  .coordinates![0],
                                              data.toLocation!.coordinates![1],
                                              data.toLocation!.coordinates![0]);

                                          return ListTile(
                                            title: Card(
                                              color: Colors.white,
                                              elevation: 0.5,
                                              shadowColor: Colors.white,
                                              shape: RoundedRectangleBorder(
                                                  borderRadius:
                                                      BorderRadius.circular(20),
                                                  side:   BorderSide(
                                                      color: AppColors.greyColor.withOpacity(0.3),
                                                      width: 1)),
                                              child: Padding(
                                                padding:
                                                    const EdgeInsets.symmetric(
                                                        vertical: 12,
                                                        horizontal: 16),
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(formattedDate,
                                                            style:
                                                                blackHeading),
                                                        Text(
                                                          data.ridebookingTime ??
                                                              '',
                                                          style: blackHeading,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppStrings.route,
                                                          style: blackTitle,
                                                        ),
                                                        Text(
                                                            distance.toStringAsFixed(
                                                                    3) +
                                                                ' mi',
                                                            style:blackTitle),
                                                      ],
                                                    ),
                                                    if (data.stops == null ||
                                                        data.stops!.isEmpty) ...[
                                                      Row(
                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                        children: [
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              data.fromAddress!,
                                                              style: greyBody,
                                                            ),
                                                          ),
                                                          const Padding(
                                                            padding: EdgeInsets.symmetric(horizontal: 5.0),
                                                            child: Icon(
                                                              Icons.arrow_forward,
                                                              size: 12,
                                                            ),
                                                          ),
                                                          Expanded(
                                                            flex: 1,
                                                            child: Text(
                                                              data.toAddress!,
                                                              style: greyBody,
                                                            ),
                                                          ),
                                                        ],
                                                      ),
                                                    ] else if (data.stops!.length >= 1) ...[
                                                      Padding(
                                                        padding: const EdgeInsets.only(top: 8, bottom: 8),
                                                        child: Row(
                                                          mainAxisAlignment: MainAxisAlignment.start,
                                                          crossAxisAlignment: CrossAxisAlignment.start,
                                                          children: [
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 10.0, left: 0),
                                                              child: Column(
                                                                children: [
                                                                  const Image(
                                                                    width: 12,
                                                                    image: AssetImage('assets/images/circlegreen.png'),
                                                                  ),
                                                                  const SizedBox(
                                                                    height: 20,
                                                                    child: VerticalDivider(
                                                                      color: AppColors.greyColor,
                                                                      thickness: 0.5,
                                                                    ),
                                                                  ),
                                                                  if (data.stops!.length >= 1)
                                                                    const Image(
                                                                        width: 12,
                                                                        image: AssetImage('assets/images/location.png')),
                                                                  if (data.stops!.length >= 1)
                                                                    SizedBox(
                                                                      height: data.stops!.length > 1 ? 20 : 20,
                                                                      child: const VerticalDivider(
                                                                        color: AppColors.greyColor,
                                                                        thickness: 0.5,
                                                                      ),
                                                                    ),
                                                                  if (data.stops!.length >= 2) ...[
                                                                    const Image(
                                                                        width: 12,
                                                                        image: AssetImage('assets/images/location.png')),
                                                                    SizedBox(
                                                                      height: data.stops!.length > 2 ? 20 : 20,
                                                                      child: const VerticalDivider(
                                                                        color: AppColors.greyColor,
                                                                        thickness: 0.5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  if (data.stops!.length >= 3) ...[
                                                                    const Image(
                                                                        width: 12,
                                                                        image: AssetImage('assets/images/location.png')),
                                                                    const SizedBox(
                                                                      height: 20,
                                                                      child: VerticalDivider(
                                                                        color: AppColors.greyColor,
                                                                        thickness: 0.5,
                                                                      ),
                                                                    ),
                                                                  ],
                                                                ],
                                                              ),
                                                            ),
                                                            const SizedBox(width: 10),
                                                            Padding(
                                                              padding: const EdgeInsets.only(top: 5.0),
                                                              child: Column(
                                                                mainAxisAlignment: MainAxisAlignment.start,
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  SizedBox(
                                                                    width: 240,
                                                                    child: Text(
                                                                      data.fromAddress!,
                                                                      style: greyBody,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  ),
                                                                  const SizedBox(height: 20),
                                                                  SizedBox(
                                                                    width: 260,
                                                                    child: Column(
                                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                                      children: [
                                                                        Text(
                                                                          data.stops![0].stopAddress!,
                                                                          style: greyBody,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                        Text(
                                                                          data.stops!.length == 1
                                                                              ? AppStrings.destination
                                                                              : AppStrings.stop1,
                                                                          style: smallGrey,
                                                                          overflow: TextOverflow.ellipsis,
                                                                        ),
                                                                      ],
                                                                    ),
                                                                  ),
                                                                  if (data.stops!.length >= 2) ...[
                                                                    const SizedBox(height: 20),
                                                                    SizedBox(
                                                                      width: 260,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            data.stops![1].stopAddress!,
                                                                            style: greyBody,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                          Text(
                                                                            data.stops!.length == 2
                                                                                ? AppStrings.destination
                                                                                : AppStrings.stop2,
                                                                            style: smallGrey,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
                                                                        ],
                                                                      ),
                                                                    ),
                                                                  ],
                                                                  if (data.stops!.length >= 3) ...[
                                                                    const SizedBox(height: 20),
                                                                    SizedBox(
                                                                      width: 260,
                                                                      child: Column(
                                                                        crossAxisAlignment: CrossAxisAlignment.start,
                                                                        children: [
                                                                          Text(
                                                                            data.stops![2].stopAddress!,
                                                                            style: greyBody,
                                                                            overflow: TextOverflow.ellipsis,
                                                                          ),
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
                                                      ),
                                                    ],
                                                    const SizedBox(
                                                      height: 8,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          AppStrings.totalFare,
                                                          style:blackTitle,
                                                        ),
                                                        Row(
                                                          children: [
                                                            Text(
                                                                '${data.price} ${data.currencySymbol}',
                                                                style:blackTitle),
                                                            Text(
                                                              '  ',
                                                              style: greyTitle,
                                                            ),
                                                          ],
                                                        ),
                                                      ],
                                                    ),
                                                    Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .only(left: 8),
                                                        child: Row(
                                                          mainAxisAlignment:
                                                              MainAxisAlignment
                                                                  .start,
                                                          children: [
                                                            data.userId!.profilePic ==
                                                                        '' ||
                                                                    data.userId!
                                                                            .profilePic ==
                                                                        null
                                                                ? const CircleAvatar(
                                                                    radius: 32,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    child: Icon(
                                                                      Icons
                                                                          .person,
                                                                      color: AppColors
                                                                          .redColor,
                                                                    ),
                                                                  )
                                                                : CircleAvatar(
                                                                    radius: 32,
                                                                    backgroundColor:
                                                                        Colors
                                                                            .white,
                                                                    backgroundImage: NetworkImage(data
                                                                        .userId!
                                                                        .profilePic
                                                                        .toString()),
                                                                  ),
                                                            const SizedBox(
                                                              width: 10,
                                                            ),
                                                            Column(
                                                              crossAxisAlignment:
                                                                  CrossAxisAlignment
                                                                      .start,
                                                              children: [
                                                                Text(
                                                                  data.userId!
                                                                      .firstName!,
                                                                  style:blackTitle,
                                                                ),
                                                                Row(
                                                                  mainAxisAlignment:
                                                                      MainAxisAlignment
                                                                          .start,
                                                                  crossAxisAlignment:
                                                                      CrossAxisAlignment
                                                                          .start,
                                                                  children: [
                                                                    const Icon(
                                                                      Icons
                                                                          .star,
                                                                      color: AppColors
                                                                          .redColor,
                                                                      size: 18,
                                                                    ),
                                                                    Text(
                                                                      data.userRating
                                                                          .toString(),
                                                                      style:blackTitle,
                                                                    ),
                                                                  ],
                                                                ),
                                                                Text(
                                                                  data.vehicleType
                                                                      .toString(),
                                                                  style: blackBody,
                                                                ),
                                                              ],
                                                            ),
                                                          ],
                                                        )),
                                                    const SizedBox(
                                                      height: 18,
                                                    ),
                                                    Row(
                                                      children: [
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            height: 45,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                getNearByRideProvider
                                                                    .rideDecline(
                                                                        data.sId!,
                                                                        driverId!,
                                                                        context);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                        backgroundColor: Colors.white,
                                                                elevation: 0,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                side:
                                                                    const BorderSide(
                                                                  width: 1,
                                                                  color: AppColors
                                                                      .greyColor,
                                                                ),
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                AppStrings.decline,
                                                                style:blackHeading,
                                                              ),
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(
                                                          width: 10,
                                                        ),
                                                        Expanded(
                                                          flex: 1,
                                                          child: SizedBox(
                                                            height: 45,
                                                            child:
                                                                ElevatedButton(
                                                              onPressed: () {
                                                                getNearByRideProvider
                                                                    .rideAccept(
                                                                        data.sId!,
                                                                        driverId!,
                                                                        context,
                                                                        index);
                                                              },
                                                              style:
                                                                  ElevatedButton
                                                                      .styleFrom(
                                                                backgroundColor:
                                                                    AppColors
                                                                        .primaryBlueStart,
                                                                padding:
                                                                    EdgeInsets
                                                                        .zero,
                                                                shape:
                                                                    RoundedRectangleBorder(
                                                                  borderRadius:
                                                                      BorderRadius
                                                                          .circular(
                                                                              30),
                                                                ),
                                                              ),
                                                              child: Text(
                                                                AppStrings.accept,
                                                                style:whiteHeading,
                                                              ),
                                                            ),
                                                          ),
                                                        )
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      )),
                      ],
                    ),
                  )
                ],
              ),
              ),
      ),
    );
  }
}
