// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';
import 'package:taxi_driver_24_7/provider/customerprovider/profile_provider.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';
import 'package:taxi_driver_24_7/screen/driver/home/rideongoing.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:taxi_driver_24_7/widgets/common/button_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:location/location.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:socket_io_client/socket_io_client.dart';

class DriverHome extends StatefulWidget {
  const DriverHome({super.key});
  @override
  State<DriverHome> createState() => DriverHomeState();
}

class DriverHomeState extends State<DriverHome> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  Socket? socket;
  bool isToggled = false;
  LatLng? locationLatLng;
  Location location = Location();
  LocationData? currentLocation;
  String? driverId;
  String? backgrounstatus;
  SharedPreferences? prefs;
  final DateTime dateTime = DateTime.now();

  @override
  void initState() {
    super.initState();
    socket =
        io('https://taxi-api.testdrivesite.com/', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();
    socket!.onConnect((_) {
      log('Connected to Server');
    });

    // Defer location to avoid iOS main-thread warning (locationManagerDidChangeAuthorization)
    WidgetsBinding.instance.addPostFrameCallback((_) => getCurrentLocation());
    main();
    getApiData();
    
  }

  void getCurrentLocation() async {
    currentLocation = await location.getLocation();
    if (!mounted) return; 
    setState(() {});
  }

  void main() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();
    backgrounstatus = prefs.getString(PrefConstant.backgroundverification);
    String? status = prefs.getString(PrefConstant.status);
    prefs.remove(PrefConstant.vehicleId);
    log('Status driver : $status');
    if (status == '1') {
      Timer(
          const Duration(seconds: 0),
          () => Navigator.pushReplacement(
              context, MaterialPageRoute(builder: (context) => RideOngoing())));
    }
    
  }

  void getApiData() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfile(prefs!.getString(PrefConstant.userid), context);
  }

  @override
  Widget build(BuildContext context) {
    return backgrounstatus == '0'
        ? Scaffold(
            body: Container(
              color: Colors.white,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 5, bottom: 5),
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const Padding(
                          padding: EdgeInsets.all(8.0),
                          child: Image(
                              image: AssetImage(
                            'assets/images/profilecreated.png',
                          )),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.profileCreationCompleted,
                          style: blackHeading,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.youWillBeNotified,
                          style: greyTitle,
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          height: 50,
                          child: ButtonWidget(
                              text: AppStrings.moveToHome,
                              color: AppColors.greyColor,
                              onPressed: () {
                                Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const DriverHomeNew(),
                                    ));
                              }),
                        )
 
                      ],
                    ),
                  ),
                ),
              ),
            ),
          )
        : currentLocation == null
            ? const Scaffold(
                body: Center(
                  child: CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                ),
                ),
              )
            : const DriverHomeNew();
  }
}
