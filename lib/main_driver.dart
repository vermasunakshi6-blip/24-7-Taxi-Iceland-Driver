import 'dart:developer';

import 'dart:io';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:provider/provider.dart';

import 'package:taxi_driver_24_7/app_type.dart';
import 'package:taxi_driver_24_7/config/default_firebase_options.dart';
import 'package:taxi_driver_24_7/notifications_shared.dart';
import 'package:taxi_driver_24_7/provider/authprovider/googlesigninprovider.dart';
import 'package:taxi_driver_24_7/provider/authprovider/login_provider.dart';
import 'package:taxi_driver_24_7/provider/authprovider/register_provider.dart';
import 'package:taxi_driver_24_7/provider/authprovider/sharedprefprovider.dart';
import 'package:taxi_driver_24_7/provider/chatprovider/chatprovider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/profile_provider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/watchtoearnprovider.dart';
import 'package:taxi_driver_24_7/provider/common/language_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/doc_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/driverside_googlemaps_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/get_vehicle_info_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/getnearbyriders_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/managevehicle_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/vehicle_type_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/vehicle_provider.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/walletscreen_provider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/coinmarketprovider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/googlemaps_provider.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/mytrips_provider.dart';
import 'package:taxi_driver_24_7/screen/authscreen/splash_screen.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/app_system_ui.dart';

import 'apppackages.dart';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform);
    }
  } catch (e) {
    final errorString = e.toString().toLowerCase();
    if (!errorString.contains('duplicate-app') &&
        !errorString.contains('already exists') &&
        !errorString.contains('[default]')) {
      rethrow;
    }
  }
  try {
    log('notification data: ${message.toString()}');
  } catch (e) {
    log('notification data log error: $e');
  }
}

/// Entry point for the Driver app. Call from Leggoo-Driver project or use main().
Future<void> runDriverApp() async {
  currentAppType = AppType.driver;

  SystemChrome.setSystemUIOverlayStyle(AppSystemUi.driverDefault);

  WidgetsFlutterBinding.ensureInitialized();
  final savedLocale = await LanguageProvider.loadSavedLocale();
  await Firebase.initializeApp();
  try {
    if (Firebase.apps.isEmpty) {
      await Firebase.initializeApp();
    }
  } catch (e) {
    final errorString = e.toString().toLowerCase();
    if (errorString.contains('duplicate-app') ||
        errorString.contains('already exists') ||
        errorString.contains('[default]') ||
        errorString.contains('firebase app')) {
      try {
        Firebase.app();
      } catch (_) {}
    } else {
      rethrow;
    }
  }

  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  const AndroidInitializationSettings androidInit =
      AndroidInitializationSettings('launch_background');
  const DarwinInitializationSettings iosInit = DarwinInitializationSettings();
  await flutterLocalNotificationsPlugin.initialize(
    settings: const InitializationSettings(android: androidInit, iOS: iosInit),
  );

  if (Platform.isAndroid) {
    await flutterLocalNotificationsPlugin
        .resolvePlatformSpecificImplementation<
            AndroidFlutterLocalNotificationsPlugin>()
        ?.createNotificationChannel(channel);
  }
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]).then((_) {
    runApp(DriverApp(initialLocale: savedLocale));
  });
}

void main() async => runDriverApp();

class DriverApp extends StatelessWidget {
  final Locale? initialLocale;
  const DriverApp({super.key, this.initialLocale});

  @override
  Widget build(BuildContext context) {
    // Load saved locale once at startup.
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<GoogleSignInProvider>(
            create: (_) => GoogleSignInProvider()),
        ChangeNotifierProvider<SharedPrefProvider>(
            create: (_) => SharedPrefProvider()),
        ChangeNotifierProvider<RegisterProvider>(
            create: (_) => RegisterProvider()),
        ChangeNotifierProvider<LoginProvider>(create: (_) => LoginProvider()),
        ChangeNotifierProvider<VehicleProvider>(
            create: (_) => VehicleProvider()),
        ChangeNotifierProvider<VehicleTypeProvider>(
            create: (_) => VehicleTypeProvider()),
        ChangeNotifierProvider<DocProvider>(create: (_) => DocProvider()),
        ChangeNotifierProvider<GoogleMapsProvider>(
            create: (_) => GoogleMapsProvider()),
        ChangeNotifierProvider<DriveSideGoogleMapsProvider>(
            create: (_) => DriveSideGoogleMapsProvider()),
        ChangeNotifierProvider<GetNearByRidesProvider>(
            create: (_) => GetNearByRidesProvider()),
        ChangeNotifierProvider<CoinMarketProvider>(
            create: (_) => CoinMarketProvider()),
        ChangeNotifierProvider<ProfileProvider>(
            create: (_) => ProfileProvider()),
        ChangeNotifierProvider<MyTripProvider>(create: (_) => MyTripProvider()),
        ChangeNotifierProvider<ManageVehicleProvider>(
            create: (_) => ManageVehicleProvider()),
        ChangeNotifierProvider<GetVehicleInfoProvider>(
            create: (_) => GetVehicleInfoProvider()),
        ChangeNotifierProvider<WalletScreenProvider>(
            create: (_) => WalletScreenProvider()),
        ChangeNotifierProvider<ChatProvider>(create: (_) => ChatProvider()),
        ChangeNotifierProvider<SupportLegalProvider>(
            create: (_) => SupportLegalProvider()),
        ChangeNotifierProvider<WatchtoEarnprovider>(
            create: (_) => WatchtoEarnprovider()),
        ChangeNotifierProvider<LanguageProvider>(
          create: (_) => LanguageProvider(initialLocale: initialLocale),
        ),
      ],
      child: Consumer<LanguageProvider>(
        builder: (context, lang, _) {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            navigatorObservers: const [],
            builder: (context, child) {
              return AnnotatedRegion<SystemUiOverlayStyle>(
                value: AppSystemUi.driverDefault,
                child: child ?? const SizedBox.shrink(),
              );
            },
            title: '${AppStrings.appName} Driver',
            locale: lang.locale,
            supportedLocales: const [
              Locale('en'),
              Locale('is'),
            ],
            localizationsDelegates: const [
              GlobalMaterialLocalizations.delegate,
              GlobalWidgetsLocalizations.delegate,
              GlobalCupertinoLocalizations.delegate,
              CountryLocalizations.delegate,
            ],
            theme: ThemeData(
              appBarTheme: const AppBarTheme(
                systemOverlayStyle: AppSystemUi.driverDefault,
              ),
              fontFamily: 'CustomFont',
              floatingActionButtonTheme: const FloatingActionButtonThemeData(
                elevation: 12.0,
                backgroundColor: AppColors.redColor,
                foregroundColor: Colors.white,
              ),
              textSelectionTheme: const TextSelectionThemeData(
                  cursorColor: AppColors.blackColor),
              textTheme: const TextTheme(
                displayLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                headlineLarge: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                titleLarge: TextStyle(fontSize: 20, color: AppColors.greyColor),
                bodyLarge: TextStyle(fontSize: 20, color: Colors.black),
                labelLarge: TextStyle(fontSize: 20, color: Colors.white),
                displayMedium: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                headlineMedium: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                titleMedium:
                    TextStyle(fontSize: 17, color: AppColors.greyColor),
                bodyMedium: TextStyle(fontSize: 17, color: Colors.black),
                labelMedium: TextStyle(fontSize: 17, color: Colors.white),
                displaySmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.black),
                headlineSmall: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Colors.white),
                titleSmall: TextStyle(fontSize: 14, color: AppColors.greyColor),
                bodySmall: TextStyle(fontSize: 14, color: Colors.black),
                labelSmall: TextStyle(fontSize: 14, color: Colors.white),
              ),
              colorScheme:
                  ColorScheme.fromSeed(seedColor: AppColors.primaryBlueStart),
              useMaterial3: true,
            ),
            home: const SplashScreen(),
          );
        },
      ),
    );
  }
}
