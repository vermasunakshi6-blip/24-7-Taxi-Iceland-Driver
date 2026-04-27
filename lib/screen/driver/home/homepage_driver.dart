// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:taxi_driver_24_7/model/coinmaket_model.dart';
import 'package:taxi_driver_24_7/model/driver_offer_by_driver_model.dart';
import 'package:taxi_driver_24_7/model/getall_banners_model.dart';
import 'package:taxi_driver_24_7/model/neardriver_model.dart';
import 'package:taxi_driver_24_7/model/weather_model.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/coinmarketprovider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/mytrips_provider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/profile_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/managevehicle_provider.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_rides.dart';
import 'package:taxi_driver_24_7/screen/driver/home/scheduled_rides.dart';
import 'package:taxi_driver_24_7/screen/driver/offers/offers_listing_screen.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/account_driver.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/triphistorydriver.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/walletscreen.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/add_doc.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/addvehicle.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/view_doc.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/offers_validity.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:taxi_driver_24_7/widgets/common/shimmer_loader.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:lottie/lottie.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:socket_io_client/socket_io_client.dart';

class HomePageDriver extends StatefulWidget {
  const HomePageDriver({super.key});

  @override
  State<HomePageDriver> createState() => HomePageDriverState();
}

class HomePageDriverState extends State<HomePageDriver>
    with SingleTickerProviderStateMixin {
  final ScrollController scrollController = ScrollController();
  CoinMarketProvider? coinMarketProvider;
  MyTripProvider? mytripProvider;
  final PageController pageController = PageController();
  final PageController _offerPageController = PageController();
  Location location = Location();
  int currentPage = 0;
  Timer? timer1;
  Socket? socket;
  Timer? timer2;
  NearDriverModel? nearDriverModel;
  LocationData? currentLocation;
  dynamic value;
  List<BannerData> bannerData = [];
  final DriverApiCall _driverApiCall = DriverApiCall();
  List<Offers> _driverOffers = [];

  String degreeSymbol = '\u00B0';

  List<Map<String, String>> get rides => [
        {
          'title': AppStrings.accountDetails,
          'image': 'assets/json/accountdetails.json',
        },
        {
          'title': AppStrings.settings,
          'image': 'assets/images/settings.gif',
        },
      ];

  List<Map<String, String>> get rides1 => [
        {
          'title': AppStrings.rideRequests,
          'image': 'assets/images/riderequests.gif',
        },
        {
          'title': AppStrings.tripHistoryTitle,
          'image': 'assets/images/pastrips.gif',
        },
      ];

  
  String selectedInterval = '1h';
  int endValue = 0;
  bool? isNegative;
  String? timeper;
  SharedPreferences? prefs;
  List<Weather>? weatherListData;
  final DateTime datetime = DateTime.now();
  AnimationController? _animationController;
  Animation<double>? _animation;
  GetAllBannersModel? getallBannersModel;

  List<BannerData>? homebanners;
  List<String> online = [
    AppStrings.acceptingRides,
    AppStrings.rejectingRides,
  ];
  String? onlineInterval;

  Object? result;

  @override
  void initState() {
    super.initState();
    getApiData();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      timer1 = Timer.periodic(const Duration(seconds: 5), (Timer timer) {
        if (!mounted) return;
        // Only animate when PageController is attached to a PageView (e.g. banners visible)
        if (!pageController.hasClients) return;
        if (bannerData.isNotEmpty && currentPage < bannerData.length - 1) {
          currentPage++;
        } else {
          currentPage = 0;
        }
        pageController.animateToPage(
          currentPage,
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOut,
        );
      });

      Timer.periodic(const Duration(milliseconds: 100), (timer) {
        if (scrollController.hasClients) {
          double maxScroll = scrollController.position.maxScrollExtent;
          double currentScroll = scrollController.offset;
          double nextScroll = currentScroll + 2.0;

          if (nextScroll >= maxScroll) {
            scrollController.jumpTo(0.0);
          } else {
            scrollController.animateTo(
              nextScroll,
              duration: const Duration(milliseconds: 100),
              curve: Curves.linear,
            );
          }
        }
      });
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );

      final pastRidesCount = prefs?.getInt(PrefConstant.pastRidesCount) ?? 0;
      _animation = Tween<double>(
              begin: 0,
              end: pastRidesCount.toDouble())
          .animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInOut,
        ),
      );

      _animationController!.forward();
    });
  }

  void getApiData() async {
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getBool(PrefConstant.online) == true) {
      onlineInterval = AppStrings.acceptingRides;
    } else {
      onlineInterval = AppStrings.rejectingRides;
    }

    // Defer to avoid iOS main-thread location warning (wait for authorization callback)
    await Future.delayed(Duration.zero);
    currentLocation = await location.getLocation();

    socket = io('https://taxi-api.testdrivesite.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      log('Connected to Server');
    });
    var param = {
      'userid': prefs!.getString(
        PrefConstant.userid,
      ),
      'latitude': currentLocation!.latitude,
      'longitude': currentLocation!.longitude!,
      'isOnline': '0',
    };
    socket!.emit('driverLocationUpdate', param);

    socket!.on('driverLocationUpdate', (message) {
      log("driverLocationUpdate====>>>>>$message");
    });
    await Provider.of<ProfileProvider>(context, listen: false)
        .getProfile(prefs!.getString(PrefConstant.userid), context);

    await Provider.of<CoinMarketProvider>(context, listen: false)
        .getCoinMarkData(context);
    await getBanners();
    await _fetchDriverOffer();
    Timer.periodic(const Duration(minutes: 2), (timer) async {
      getBanners();
    });

    await Provider.of<ManageVehicleProvider>(context, listen: false)
        .getVehicleListData(prefs!.getString(PrefConstant.userid)!, context);

    await Provider.of<MyTripProvider>(context, listen: false)
        .getRideHistory(context, prefs!.getString(PrefConstant.userid)!, 0);

    endValue = prefs!.getInt(PrefConstant.pastRidesCount) ?? 0;
    if (!mounted) return;
    setState(() {
      _animation = Tween<double>(begin: 0, end: endValue.toDouble()).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInOut,
        ),
      );
      _animationController!.forward();
    });
  }

  Future<void> getBanners() async {
    if (prefs == null) return;
    final userId = prefs!.getString(PrefConstant.userid);
    if (userId == null || userId.isEmpty) return;
    try {
      final date = datetime.toString().split(' ')[0];
      final time = DateFormat('hh:mm').format(datetime);
      final provider = Provider.of<CoinMarketProvider>(context, listen: false);
      await provider.getAllBanners(context, userId, date, time);
      if (!mounted) return;
      final homebanners = provider.homebanners;
      setState(() {
        bannerData = homebanners ?? <BannerData>[];
      });
    } catch (e) {
      if (kDebugMode) {
        log('getBanners error: $e');
      }
      if (mounted) {
        setState(() => bannerData = <BannerData>[]);
      }
    }
  }

  Future<void> _fetchDriverOffer() async {
    final userId = prefs?.getString(PrefConstant.userid);
    if (userId == null || userId.isEmpty) return;
    final lat = currentLocation?.latitude;
    final lng = currentLocation?.longitude;
    if (lat == null || lng == null) return;
    try {
      final res = await _driverApiCall.getOfferByDriver(
        context,
        userId,
        lat,
        lng,
      );
      if (!mounted) return;
      var raw = res?.offers ?? [];
      var filtered = OfferFilters.apply(
        raw,
        userLat: lat,
        userLng: lng,
      );
      // If API returned rows but our client filters removed all, show API list (parsing OK).
      if (filtered.isEmpty && raw.isNotEmpty) {
        filtered = raw;
      }
      setState(() => _driverOffers = filtered);
    } catch (e) {
      if (kDebugMode) {
        log('getOfferByDriver error: $e');
      }
      if (mounted) {
        setState(() => _driverOffers = []);
      }
    }
  }

  void getDataWithInterval(USDCoin? quote) {
    switch (selectedInterval) {
      case '1h':
        value = quote!.percentChange1h;
        break;
      case '24h':
        value = quote!.percentChange24h;
        break;
      case '7d':
        value = quote!.percentChange7d;
        break;
      case '30d':
        value = quote!.percentChange30d;
        break;
      case '60d':
        value = quote!.percentChange60d;
        break;
      case '90d':
        value = quote!.percentChange90d;
        break;
      default:
        value = quote!.percentChange1h;
    }
  }

  @override
  void dispose() {
    timer2?.cancel();
    timer1?.cancel();
    pageController.dispose();
    _offerPageController.dispose();
    scrollController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    coinMarketProvider = Provider.of<CoinMarketProvider>(context);
    ProfileProvider profileProvider = Provider.of<ProfileProvider>(context);
    final manageVehicleProvider = Provider.of<ManageVehicleProvider>(context);
    mytripProvider = Provider.of<MyTripProvider>(context, listen: true);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          SizedBox(
            height: bannerData.isEmpty ? 0 : 30,
          ),
          bannerData.isEmpty
              ? const SizedBox.shrink()
              : SizedBox(
                  height: 125.0,
                  width: double.infinity,
                  child: PageView.builder(
                    controller: pageController,
                    itemCount: bannerData.length,
                    onPageChanged: (int page) {
                      setState(() {
                        currentPage = page;
                      });
                    },
                    itemBuilder: (context, index) {
                      return Column(
                        children: [
                          Image.network(
                            height: 100,
                            width: double.infinity,
                            bannerData[index].bannerPic.toString(),
                            fit: BoxFit.cover,
                          ),
                          const SizedBox(
                            height: 6,
                          ),
                          Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 24.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  bannerData[index].bannerName.toString(),
                                  style: smallBlack,
                                ),
                                SmoothPageIndicator(
                                  controller: pageController,
                                  count: bannerData.length,
                                  effect: const SwapEffect(
                                    activeDotColor: AppColors.redColor,
                                    dotColor: AppColors.greyColor,
                                    dotHeight: 8,
                                    dotWidth: 8,
                                  ),
                                ),
                                Text(
                                  'Ad',
                                  style: smallBlack,
                                )
                              ],
                            ),
                          )
                        ],
                      );
                    },
                  ),
                ),
          Expanded(
            child: SizedBox(
              width: double.infinity,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: 30,
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Text(
                                AppStrings.welcomeToDashboard,
                                style: smallGrey,
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Row(
                                    children: [
                                      Column(
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          profileProvider.profileDetails != null
                                              ? Row(
                                                  children: [
                                                    Text(
                                                      '${AppStrings.letsDrive} ',
                                                      style: blackHeading,
                                                    ),
                                                    Text(
                                                      '${profileProvider.profileDetails!.firstName!}!',
                                                      style: greyHeading,
                                                    ),
                                                  ],
                                                )
                                              : Text(
                                                  AppStrings.letsDrive,
                                                  style: blackHeading,
                                                ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(
                                  left: 20.0, right: 20.0),
                              child: Row(
                                children: [
                                  Text(
                                    '${AppStrings.youAreCurrently}  ',
                                    style: smallBlack,
                                  ),
                                  ClipRRect(
                                      borderRadius: const BorderRadius.all(
                                        Radius.circular(20.0),
                                      ),
                                      child: Container(
                                          color: AppColors.greenColor,
                                          height: 25.0,
                                          width: 120.0,
                                          child: Center(
                                            child: Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 5.0),
                                              child:
                                                  DropdownButtonHideUnderline(
                                                child: DropdownButton<String>(
                                                  value: onlineInterval,
                                                  isDense: true,
                                                  iconSize: 20,
                                                  iconEnabledColor:
                                                      Colors.white,
                                                  dropdownColor:
                                                      AppColors.redColor,
                                                  onChanged:
                                                      (String? newValue) {
                                                    if (!mounted) return;
                                                    setState(() {
                                                      onlineInterval =
                                                          newValue!;
                                                      if (onlineInterval ==
                                                          AppStrings
                                                              .acceptingRides) {
                                                        prefs!.setBool(
                                                            PrefConstant.online,
                                                            true);
                                                      } else {
                                                        prefs!.setBool(
                                                            PrefConstant.online,
                                                            false);
                                                      }

                                                      socket = io(
                                                          'https://taxi-api.testdrivesite.com/',
                                                          <String, dynamic>{
                                                            'transports': [
                                                              'websocket'
                                                            ],
                                                            'autoConnect':
                                                                false,
                                                          });
                                                      socket!.connect();
                                                      socket!.onConnect((_) {
                                                        log('Connected to Server');
                                                      });
                                                      var param = {
                                                        'userid':
                                                            prefs!.getString(
                                                          PrefConstant.userid,
                                                        ),
                                                        'latitude':
                                                            currentLocation!
                                                                .latitude,
                                                        'longitude':
                                                            currentLocation!
                                                                .longitude!,
                                                        'isOnline':
                                                            onlineInterval ==
                                                                    AppStrings
                                                                        .acceptingRides
                                                                ? '1'
                                                                : '0'
                                                      };
                                                      socket!.emit(
                                                          'driverLocationUpdate',
                                                          param);

                                                      socket!.on(
                                                          'driverLocationUpdate',
                                                          (message) {
                                                        log("driverLocationUpdate====>>>>>$message");
                                                      });
                                                    });
                                                  },
                                                  items: online.map<
                                                          DropdownMenuItem<
                                                              String>>(
                                                      (String value) {
                                                    return DropdownMenuItem<
                                                        String>(
                                                      value: value,
                                                      child: Text(
                                                        value,
                                                        style:
                                                            smallWhite,
                                                      ),
                                                    );
                                                  }).toList(),
                                                ),
                                              ),
                                            ),
                                          ))),
                                ],
                              ),
                            ),
                          ],
                        ),
                        Padding(
                          padding: const EdgeInsets.only(right: 20.0),
                          child: Column(
                            children: [
                              profileProvider.isloading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                      color: AppColors.blackColor,
                                      strokeWidth: 2,
                                    ))
                                  : profileProvider.profileDetails != null
                                      ? Container(
                                          width: 50,
                                          height: 50,
                                          decoration: BoxDecoration(
                                              color: AppColors.greyColor,
                                              border: Border.all(
                                                  color: onlineInterval ==
                                                          'Accepting Rides'
                                                      ? AppColors.greenColor
                                                      : AppColors.redColor,
                                                  width: 1),
                                              borderRadius:
                                                  const BorderRadius.all(
                                                      Radius.circular(100))),
                                          child: Padding(
                                            padding: const EdgeInsets.all(0.0),
                                            child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(60),
                                                child: Image.network(
                                                  profileProvider
                                                      .profileDetails!
                                                      .profilePic!,
                                                  fit: BoxFit.cover,
                                                )),
                                          ),
                                        )
                                      : const SizedBox(),
                              const SizedBox(
                                height: 5,
                              ),
                              Container(
                                width: 50,
                                height: 20,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    border: Border.all(
                                        color:
                                            onlineInterval == 'Accepting Rides'
                                                ? AppColors.greenColor
                                                : AppColors.redColor,
                                        width: 1),
                                    borderRadius: const BorderRadius.all(
                                        Radius.circular(100))),
                                child: Center(
                                  child: Text(
                                    onlineInterval == 'Accepting Rides'
                                        ? AppStrings.online
                                        : AppStrings.offline,
                                    style: onlineInterval == 'Accepting Rides'
                                        ? smallGreen
                                        : smallRed,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    manageVehicleProvider.isloading
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 15.0),
                            child: Row(
                              children: [
                                Expanded(
                                    child: ShimmerLoader(
                                        count: 1,
                                        height:
                                            MediaQuery.of(context).size.height /
                                                8)),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: ShimmerLoader(
                                  count: 1,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                )),
                                const SizedBox(
                                  width: 10,
                                ),
                                Expanded(
                                    child: ShimmerLoader(
                                  count: 1,
                                  height:
                                      MediaQuery.of(context).size.height / 8,
                                )),
                              ],
                            ),
                          )
                        : manageVehicleProvider.getvehicleDetailData == null ||
                                manageVehicleProvider
                                    .getvehicleDetailData!.isEmpty ||
                                (manageVehicleProvider.getvehicleDetailData!
                                    .where((data) =>
                                        data.backgroundVerification == 1)
                                    .toList()
                                    .isEmpty)
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 20.0),
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      AppStrings.yourVehicles,
                                      style: smallGrey,
                                    ),
                                    SizedBox(
                                      height:
                                          MediaQuery.of(context).size.height /
                                              6,
                                      width: double.infinity,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        itemCount: manageVehicleProvider
                                            .getvehicleDetailData!
                                            .where((data) =>
                                                data.backgroundVerification ==
                                                1)
                                            .toList()
                                            .length,
                                        itemBuilder: (context, index) {
                                          final data = manageVehicleProvider
                                              .getvehicleDetailData!
                                              .where((data) =>
                                                  data.backgroundVerification ==
                                                  1)
                                              .toList()[index];
                                          return Padding(
                                            padding: const EdgeInsets.fromLTRB(
                                                0, 8, 8, 8),
                                            child: InkWell(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) =>
                                                          ViewDoc(
                                                              vehicleId: data
                                                                  .sId
                                                                  .toString()),
                                                    ));
                                              },
                                              child: SizedBox(
                                                width: 130,
                                                child: Column(
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.start,
                                                  children: [
                                                    Container(
                                                      color:
                                                          Colors.white,
                                                      width: 130,
                                                      height: 80,
                                                      child: Padding(
                                                        padding:
                                                            const EdgeInsets
                                                                .all(13.0),
                                                        child: Image.network(
                                                            fit: BoxFit.cover,
                                                            data.vehicleImages!),
                                                      ),
                                                    ),
                                                    const SizedBox(
                                                      height: 5,
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        Text(
                                                          data.vehicleType!,
                                                          style:
                                                              smallBlack,
                                                        ),
                                                      ],
                                                    ),
                                                    Row(
                                                      mainAxisAlignment:
                                                          MainAxisAlignment
                                                              .spaceBetween,
                                                      children: [
                                                        SizedBox(
                                                          width: 70,
                                                          child: Text(
                                                            data.vehicleModel!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                smallGrey,
                                                          ),
                                                        ),
                                                        SizedBox(
                                                          width: 40,
                                                          child: Text(
                                                            data.vehicleColor!,
                                                            overflow:
                                                                TextOverflow
                                                                    .ellipsis,
                                                            style:
                                                                smallGrey,
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ],
                                                ),
                                              ),
                                            ),
                                          );
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                    mytripProvider!.isloading
                        ? Padding(
                            padding: const EdgeInsets.all(10),
                            child: Container(
                              padding: EdgeInsets.zero,
                              height: MediaQuery.of(context).size.height / 6,
                              child: ShimmerLoader(
                                  count: 1,
                                  height:
                                      MediaQuery.of(context).size.height / 6.8),
                            ),
                          )
                        : endValue == 0 ||
                                _animation == null ||
                                _animation!.value.isNaN
                            ? const SizedBox()
                            : Padding(
                                padding: const EdgeInsets.all(10.0),
                                child: Container(
                                  padding: _animation!.value < 5
                                      ? const EdgeInsets.only(
                                          left: 20,
                                          right: 10,
                                          top: 10,
                                          bottom: 10)
                                      : const EdgeInsets.symmetric(
                                          vertical: 10, horizontal: 15),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(12),
                                      border: Border.all(
                                          color: AppColors.blackColor
                                              .withOpacity(0.1))),
                                  child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(AppStrings.onYourWayToRewards,
                                          style: blackBody),
                                      const SizedBox(height: 20),
                                      AnimatedBuilder(
                                        animation: _animation!,
                                        builder: (context, child) {
                                          return LinearGauge(
                                            start: 0,
                                            end: 200,
                                            steps: 100,
                                            rulers: RulerStyle(
                                                rulerPosition:
                                                    RulerPosition.bottom,
                                                showPrimaryRulers: false,
                                                showSecondaryRulers: false,
                                                primaryRulerColor:
                                                    AppColors.blackColor,
                                                secondaryRulerColor:
                                                    AppColors.greyColor,
                                                textStyle: smallGrey),
                                            customLabels: [
                                              const CustomRulerLabel(
                                                  text: "", value: 0),
                                              CustomRulerLabel(
                                                  text:
                                                      '${_animation!.value.toInt()} ${AppStrings.of} 100',
                                                  value: _animation!.value),
                                              CustomRulerLabel(
                                                  text:
                                                      '100\n${AppStrings.rides}',
                                                  value: 100),
                                              CustomRulerLabel(
                                                  text:
                                                      '200\n${AppStrings.rides}',
                                                  value: 200),
                                            ],
                                            rangeLinearGauge: [
                                              RangeLinearGauge(
                                                start: 0,
                                                end: _animation!.value,
                                                color: AppColors.redColor,
                                              ),
                                            ],
                                            pointers: [
                                              const Pointer(
                                                value: 0,
                                                shape: PointerShape.circle,
                                                color: AppColors.redColor,
                                                showLabel: false,
                                                width: 15,
                                                height: 15,
                                              ),
                                              Pointer(
                                                value: _animation!.value,
                                                shape: PointerShape.circle,
                                                color: AppColors.redColor,
                                                showLabel: false,
                                                labelStyle: smallRed,
                                                pointerPosition: PointerPosition.center,
                                              ),
                                              Pointer(
                                                value: 100,
                                                width: 15,
                                                height: 15,
                                                shape: PointerShape.circle,
                                                color: _animation!.value < 100
                                                    ? AppColors.greyColor
                                                    : AppColors.redColor,
                                                showLabel: false,
                                              ),
                                              Pointer(
                                                value: 200,
                                                width: 15,
                                                height: 15,
                                                shape: PointerShape.circle,
                                                color: _animation!.value < 200
                                                    ? AppColors.greyColor
                                                    : AppColors.redColor,
                                                showLabel: false,
                                              ),
                                            ],
                                            enableGaugeAnimation: true,
                                            animationType: Curves.linear,
                                            gaugeOrientation:
                                                GaugeOrientation.horizontal,
                                            linearGaugeBoxDecoration:
                                                 LinearGaugeBoxDecoration(
                                                  thickness:2,
                                              backgroundColor:
                                                  AppColors.greyColor.withOpacity(0.5),
                                            ),
                                          );
                                        },
                                      ),
                                      const SizedBox(height: 20),
                                    ],
                                  ),
                                ),
                              ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rides.length,
                          itemBuilder: (context, index) {
                            final assetPath = rides[index]['image']!;
                            return GestureDetector(
                              onTap: () {
                                index == 0
                                    ? Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                          builder: (context) =>
                                              const AccountDriver(
                                                  showBackButton: true),
                                        ))
                                    : null;
                              },
                              child: SizedBox(
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: assetPath.endsWith('.json')
                                            ? Lottie.asset(
                                                assetPath,
                                                fit: BoxFit.cover,
                                                height: 130,
                                                width: double.infinity,
                                              )
                                            : Image.asset(
                                                assetPath,
                                                fit: BoxFit.cover,
                                                height: 130,
                                                width: double.infinity,
                                              ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Text(rides[index]['title']!,
                                          style: blackTitle),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                      child: SizedBox(
                        height: 200,
                        child: ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: rides1.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              onTap: () async {
                                if (index == 0) {
                                  if (onlineInterval ==
                                      AppStrings.acceptingRides) {
                                    await Provider.of<ManageVehicleProvider>(
                                            context,
                                            listen: false)
                                        .getVehicleListData(
                                            prefs!.getString(
                                                PrefConstant.userid)!,
                                            context);
                                    movetoTrips(manageVehicleProvider);
                                  } else {
                                    ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(
                                        content:
                                            Text(AppStrings.youAreOfflineGoOnline),
                                        backgroundColor: AppColors.redColor,
                                        behavior: SnackBarBehavior.fixed,
                                      ),
                                    );
                                  }
                                } else if (index == 1) {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const TripHistoryDriver(
                                          isTab: false,
                                        ),
                                      ));
                                } else {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WalletScreen(),
                                      ));
                                }
                              },
                              child: Container(
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 0.0),
                                width: MediaQuery.of(context).size.width * 0.65,
                                child: Card(
                                  color: Colors.transparent,
                                  elevation: 0,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(15),
                                  ),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      ClipRRect(
                                        borderRadius: const BorderRadius.all(
                                          Radius.circular(8),
                                        ),
                                        child: Image.asset(
                                          rides1[index]['image']!,
                                          fit: BoxFit.fill,
                                          height: 130,
                                          width: double.infinity,
                                        ),
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      Padding(
                                        padding: const EdgeInsets.symmetric(
                                            vertical: 8.0),
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(rides1[index]['title']!,
                                                style: blackTitle),
                                          ],
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ),
                    ),





                    // Padding(
                    //   padding: const EdgeInsets.only(left: 15.0, right: 20.0),
                    //   child: SizedBox(
                    //     height: 200,
                    //     child: ListView(
                    //       scrollDirection: Axis.horizontal,
                    //       children: [
                    //         GestureDetector(
                    //           onTap: () {
                    //             Navigator.push(
                    //               context,
                    //               MaterialPageRoute(
                    //                 builder: (context) =>
                    //                     const OffersListingScreen(),
                    //               ),
                    //             );
                    //           },
                    //           child: SizedBox(
                    //             width: MediaQuery.of(context).size.width * 0.65,
                    //             child: Card(
                    //               color: Colors.transparent,
                    //               elevation: 0,
                    //               shape: RoundedRectangleBorder(
                    //                 borderRadius: BorderRadius.circular(15),
                    //               ),
                    //               child: Column(
                    //                 crossAxisAlignment:
                    //                     CrossAxisAlignment.start,
                    //                 children: [
                    //                   ClipRRect(
                    //                     borderRadius: const BorderRadius.all(
                    //                       Radius.circular(8),
                    //                     ),
                    //                     child: Container(
                    //                       height: 130,
                    //                       width: double.infinity,
                    //                       decoration: BoxDecoration(
                    //                         gradient: LinearGradient(
                    //                           colors: [
                    //                             AppColors.redColor
                    //                                 .withOpacity(0.88),
                    //                             AppColors.redColor,
                    //                           ],
                    //                           begin: Alignment.topLeft,
                    //                           end: Alignment.bottomRight,
                    //                         ),
                    //                       ),
                    //                       child: const Center(
                    //                         child: Icon(
                    //                           Icons.local_offer_rounded,
                    //                           size: 56,
                    //                           color: Colors.white,
                    //                         ),
                    //                       ),
                    //                     ),
                    //                   ),
                    //                   const SizedBox(height: 8),
                    //                   Padding(
                    //                     padding: const EdgeInsets.only(
                    //                         left: 4.0, right: 4.0),
                    //                     child: Text(
                    //                       AppStrings.offers,
                    //                       style: blackTitle,
                    //                     ),
                    //                   ),
                    //                 ],
                    //               ),
                    //             ),
                    //           ),
                    //         ),
                    //       ],
                    //     ),
                    //   ),
                    // ),








                    const SizedBox(
                      height: 20,
                    ),
                    GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const ScheduleRides()),
                        );
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(
                            left: 20, right: 20, top: 10, bottom: 10),
                        child: Column(
                          children: [
                            const Padding(
                              padding: EdgeInsets.symmetric(vertical: 0.0),
                              child: ClipRRect(
                                borderRadius: BorderRadius.only(
                                  topLeft: Radius.circular(12),
                                  topRight: Radius.circular(12),
                                  bottomLeft: Radius.circular(4),
                                  bottomRight: Radius.circular(4),
                                ),
                                child: Image(
                                  image:
                                      AssetImage('assets/images/schedule.gif'),
                                  fit: BoxFit.cover,
                                  height: 145,
                                  width: double.infinity,
                                ),
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 0.0, right: 10.0),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    AppStrings.yourScheduledRides,
                                    style: blackTitle,
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    
                  ],
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }

  void movetoTrips(ManageVehicleProvider manageVehicleProvider) async {
    log('manageVehicleProvider.getvehicleDetailData!.length ${manageVehicleProvider.getvehicleDetailData!.length}');
    if (manageVehicleProvider.getvehicleDetailData!.length > 1) {
      result = await Navigator.pushReplacement(
          context,
          MaterialPageRoute(
              builder: (context) => DriverRides(
                    totalRidesCount:
                        prefs!.getInt(PrefConstant.pastRidesCount) ?? 0,
                  )));
    } else {
      if (prefs!.getString(PrefConstant.vehicleDetailStatus) == '0') {
        result = await Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => AddVehicle(
                      isNewVehicel: false,
                    )));
      } else {
        if (prefs!.getString(PrefConstant.profilePhotoStatus) == '0' ||
            prefs!.getString(PrefConstant.drivingLicenceFrontStatus) == '0' ||
            prefs!.getString(PrefConstant.vehicleInsuranceStatus) == '0' ||
            prefs!.getString(PrefConstant.registrationCertificateStatus) ==
                '0') {
          result = await Navigator.push(
              context, MaterialPageRoute(builder: (context) => const AddDoc()));
        } else {
          for (int i = 0;
              i < manageVehicleProvider.getvehicleDetailData!.length;
              i++) {
            if (manageVehicleProvider
                    .getvehicleDetailData![i].backgroundVerification ==
                1) {
              result = await Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => DriverRides(
                            totalRidesCount:
                                prefs!.getInt(PrefConstant.pastRidesCount) ?? 0,
                          )));
            } else {
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(
                  content: Text(AppStrings.pleaseWaitDocsApproval),
                  backgroundColor: AppColors.redColor,
                  behavior: SnackBarBehavior.fixed,
                ),
              );
            }
          }
        }
      }
    }
    if (result == true) {
      initState();
    }
  }
}
