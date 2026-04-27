// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:lottie/lottie.dart';
import 'package:app_links/app_links.dart';


import '../../apppackages.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});
  @override
  SplashScreenState createState() => SplashScreenState();
}

class SplashScreenState extends State<SplashScreen> {
  String? token;
  Timer? _timer;
  StreamSubscription? sub;
  SharedPreferences? prefs;
  String? userId;
 Future<void> setupInteractedMessage() async {
    await FirebaseMessaging.instance.getInitialMessage().then((value) {
    });
  }

  Future<void> _printFcmToken() async {
    try {
      final token = await FirebaseMessaging.instance.getToken();
      log('FCM Token: $token');
    } catch (e) {
      log('FCM Token error: $e');
    }
  }
  
  @override
  void initState() {
    super.initState();
    _init();
    _handleIncomingLinks();
    FirebaseMessaging.instance.requestPermission();
    setupInteractedMessage();
    _printFcmToken();
 
   FirebaseMessaging.onMessage.listen((message) async {
        try {
          final RemoteNotification? notification = message.notification;
          if (notification == null || kIsWeb) return;
          final AndroidNotification? android = notification.android;

          String payload = '{}';
          try {
            payload = jsonEncode(message.data);
          } catch (_) {
            payload = message.data.toString();
          }

          await flutterLocalNotificationsPlugin.show(
            id: notification.hashCode & 0x7FFFFFFF,
            title: notification.title ?? '',
            body: notification.body ?? '',
            notificationDetails: NotificationDetails(
              android: android != null
                  ? AndroidNotificationDetails(
                      channel.id,
                      channel.name,
                      priority: Priority.high,
                      importance: Importance.max,
                      styleInformation: const DefaultStyleInformation(true, true),
                      setAsGroupSummary: false,
                      channelShowBadge: true,
                      autoCancel: true,
                      icon: 'launch_background',
                    )
                  : null,
              iOS: const DarwinNotificationDetails(),
            ),
            payload: payload,
          );
        } catch (e, stack) {
          log('FCM onMessage error: $e');
          log('Stack: $stack');
        }
      });

    FirebaseMessaging.onMessageOpenedApp.listen((RemoteMessage message) {
      try {
        if (message.data.isNotEmpty) {
          log('Message data================: ${message.data}');
        }
      } catch (e, stack) {
        log('FCM onMessageOpenedApp error: $e');
        log('Stack: $stack');
      }
    });

  }
      void _init() async {
    prefs = await SharedPreferences.getInstance();
      }
  void getuserId() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs!.getString(PrefConstant.userid);
    
  }

  Future<void> _handleIncomingLinks() async {
    final appLinks = AppLinks();
    try {
      Uri? initialUri = await appLinks.getInitialLink();
      if (initialUri != null) {
        log('initialUril URI: $initialUri');
        handleIncomingLink(initialUri);
      } else {
        prefs = await SharedPreferences.getInstance();
        prefs!.remove(PrefConstant.refcode);
        main();
      }
    } on Exception catch (e) {
      log('Failed to get initial URI: $e');
    }

    sub = appLinks.uriLinkStream.listen((Uri uri) async {
      log('initialUril URI: $uri');
      handleIncomingLink(uri);
    }, onError: (err) {
      log('Error receiving URI: $err');
    });
  }

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();

    if (prefs!.getString(PrefConstant.userid) == null) {
      _timer = Timer(const Duration(seconds: 4), () {
        if (mounted) {
          Navigator.pushReplacement(context,
              MaterialPageRoute(builder: (context) => const Onboarding()));
        }
      });
    } else {
      // Driver app: always go to driver home when logged in
      _timer = Timer(const Duration(seconds: 4), () {
        if (mounted) {
          Navigator.pushReplacement(
              context,
              MaterialPageRoute(
                  builder: (context) => const DriverHomeNew()));
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      width: double.infinity,
      height: MediaQuery.of(context).size.height,
      color: Colors.white,
      child: Stack(
        children: [
          SizedBox(
            height: MediaQuery.of(context).size.height / 3,
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.end,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Center(child: const AppLogo()),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Choose your destination\n and we’ll drive",
                    style: greyHeading,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
          Align(
            alignment: Alignment.center,
            child: Lottie.asset(
              'assets/json/splashlottie.json',
              width: MediaQuery.of(context).size.width,
              fit: BoxFit.contain,
            ),
          ),
        ],
      ),
    ));
  }

  @override
  void dispose() {
    _timer?.cancel();
    sub?.cancel();
    super.dispose();
  }

  Future<void> handleIncomingLink(Uri uri) async {
    getuserId();
    prefs = await SharedPreferences.getInstance();
    if (uri.pathSegments.contains('userid')) {
      log("Driver app: share trip link ignored (rider feature).");
    } else if (uri.pathSegments.contains('eventid')) {
      log("Driver app: event link ignored (rider feature).");
    } else if (uri.pathSegments.contains('refcode')) {
      log("The URL contains 'refcode'.");

      final refcodeIndex = uri.pathSegments.indexOf('refcode');

      // Get the userid value (the next segment after 'userid')
      if (refcodeIndex != -1 && refcodeIndex + 1 < uri.pathSegments.length) {
        final refercode = uri.pathSegments[refcodeIndex + 1];

        
          prefs!.setString(PrefConstant.authType, AppStrings.register);
          prefs!.setString(PrefConstant.refcode, refercode);

          log("Extracted ReferCode: $refercode");
          CSnackBar.showSnackBar(
              "ReferCode=====>>>>>" +
                  prefs!.getString(PrefConstant.refcode).toString(),
              context);

          prefs!.setString(PrefConstant.userType, AppStrings.driver);
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(
                builder: (context) => const Register(),
            ),
          );
       
      } else {
         prefs = await SharedPreferences.getInstance();
        prefs!.remove(PrefConstant.refcode);
        log("Either you are already registered or The URL does not contain the refercode");
      }
    } else {
       prefs = await SharedPreferences.getInstance();
      prefs!.remove(PrefConstant.refcode);
      log("The URL does NOT contain 'refercode'.");
    }
  }
}
