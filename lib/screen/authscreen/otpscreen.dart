import 'dart:developer';
import 'package:taxi_driver_24_7/provider/authprovider/login_provider.dart';
import 'package:pin_code_fields/pin_code_fields.dart';

import '../../apppackages.dart';

// ignore: must_be_immutable
class OTPScreen extends StatefulWidget {
  final String verificationid;
  final String countryCode;
  final String phoneNumber;
   

  const OTPScreen({
    super.key,
    required this.verificationid,
    required this.countryCode,
    required this.phoneNumber,
   
  });

  @override
  State<OTPScreen> createState() => _OTPScreenState();
}

class _OTPScreenState extends State<OTPScreen> {
  String? otpValue;
  String? userType;
  // OtpFieldController otpController = OtpFieldController();
  TextEditingController otpController = TextEditingController();
  late FocusNode otpFocusNode;
  FirebaseAuth auth = FirebaseAuth.instance;
  int remainingTime = 120;
  Timer? countdownTimer;
  bool resendOtp = false;
  @override
  void initState() {
    super.initState();
    startCountdown();
    getToken();
    otpFocusNode = FocusNode();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      otpFocusNode.requestFocus(); // Auto open keyboard
    });
  }

  @override
  void dispose() {
    countdownTimer?.cancel();
    otpFocusNode.dispose();
    otpController.dispose();
    super.dispose();
  }

  void getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    FirebaseMessaging messaging = FirebaseMessaging.instance;

    String? token = await messaging.getToken();
    if (token != null) {
      setState(() {
        prefs.setString(PrefConstant.token, token);
      });
    }
  }

  void startCountdown() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setString('rideType', 'myself');
    countdownTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (!mounted) {
        timer.cancel();
        return;
      }
      if (remainingTime > 0) {
        setState(() {
          remainingTime--;
        });
      } else {
        setState(() {
          resendOtp = true;
        });
        timer.cancel();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    String minutes = (remainingTime ~/ 60).toString().padLeft(2, '0');
    String seconds = (remainingTime % 60).toString().padLeft(2, '0');
    final registerProvider = Provider.of<RegisterProvider>(context);
    final loginProvider = Provider.of<LoginProvider>(context);
    final sharedprefprovider = Provider.of<SharedPrefProvider>(context);
    String authType = sharedprefprovider.getString(PrefConstant.authType);
    String token = sharedprefprovider.getString(PrefConstant.token);
    userType = sharedprefprovider.getString(PrefConstant.userType);
    final String phoneNumberWithCode =
        '${widget.countryCode} ${widget.phoneNumber}';

    return Scaffold(
      resizeToAvoidBottomInset: false,
      backgroundColor: Colors.white,
      body: Container(
        
        child: Padding(
          padding:
              const EdgeInsets.only(left: 0.0, right: 0.0, top: 80, bottom: 5),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                          left: 30.0,
                          right: 30.0,
                        ),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              child: Row(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  InkWell(
                                    onTap: () {
                                      Navigator.pop(context);
                                    },
                                    child: const Padding(
                                      padding: EdgeInsets.only(
                                          right: 30, top: 0, bottom: 0),
                                      child: Image(
                                          height: 25,
                                          image:
                                              AssetImage(AppImages.arrowback)),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                            Expanded(
                              flex: 3,
                              child: Padding(
                                padding: const EdgeInsets.only(left: 0.0),
                                child: Center(
                                  child: Text(
                                    AppStrings.verification.toUpperCase(),
                                    style: greyHeading,
                                  ),
                                ),
                              ),
                            ),
                            const Expanded(
                              child: SizedBox(),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      Center(
                          child: const AppLogo()),
                      const SizedBox(
                        height: 50,
                      ),
                      Padding(
                        padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text(
                              AppStrings.verifymobilenumber,
                              style: blackHeading,
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            RichText(
                              textAlign: TextAlign.center,
                              text: TextSpan(
                                text:
                                    'Check your SMS messages. We have sent you\nthe code at ',
                                style: greyBody,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: authType == AppStrings.login
                                        ? phoneNumberWithCode
                                        : registerProvider.phoneNumberWithCode,
                                    style: blackBody,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding: const EdgeInsets.only(top: 110.0),
                              child: PinCodeTextField(
                                appContext: context,
                                length: 6,
                                focusNode: otpFocusNode,
                                controller: otpController,
                                keyboardType: TextInputType.number,
                                autoFocus: true,
                                blinkWhenObscuring: false,
                                blinkDuration: const Duration(milliseconds: 0),
                                animationType: AnimationType.scale,
                                textStyle: blackHeading.copyWith(
                                    fontSize: 28),
                                cursorColor: AppColors.blackColor,
                                pinTheme: PinTheme(
                                  shape: PinCodeFieldShape.underline,
                                  fieldOuterPadding:
                                      const EdgeInsets.only(bottom: 10),
                                  fieldWidth: 45,
                                  fieldHeight: 60,
                                  activeColor: AppColors.greyColor,
                                  selectedColor: AppColors.greyColor,
                                  inactiveColor: AppColors.greyColor,
                                ),
                                onChanged: (value) {},
                                onCompleted: (value) {
                                  otpValue = value;
                                },
                              ),
                            ),
                            const SizedBox(
                              height: 40,
                            ),
                            resendOtp
                                ? GestureDetector(
                                    onTap: () async {
                                      otpController.clear();
                                      final resendUserType = authType == AppStrings.login
                                          ? loginProvider.userTypes
                                          : (userType ?? '');
                                      await loginProvider.resendvalidation(
                                          context,
                                          widget.phoneNumber,
                                          widget.countryCode.toString(),
                                          resendUserType);
                                    },
                                    child: Align(
                                      alignment: Alignment.center,
                                      child: RichText(
                                        text: TextSpan(
                                          text: AppStrings.didnotrec,
                                          style: greyBodyNormal,
                                          children: <TextSpan>[
                                            TextSpan(
                                              text: AppStrings.resendCode,
                                              style: blackTitleNormal,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  )
                                : Center(
                                    child: Container(
                                        padding: const EdgeInsets.symmetric(
                                            horizontal: 20, vertical: 3),
                                        decoration: BoxDecoration(
                                          borderRadius:
                                              BorderRadius.circular(24),
                                          border: Border.all(
                                              color: (minutes == '00' &&
                                                      int.parse(seconds) < 30)
                                                  ? AppColors.redColor
                                                  : AppColors.greenColor,
                                              width: 2),
                                        ),
                                        child: Text('$minutes : $seconds',
                                            style: blackBodyNormal)),
                                  ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Expanded(
                flex: 1,
                child: Padding(
                  padding: const EdgeInsets.only(left: 30.0, right: 30.0),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      (authType == AppStrings.login
                              ? loginProvider.isLoading
                              : registerProvider.isLoading)
                          ? const CircularProgressIndicator(
                              color: AppColors.blackColor,
                            )
                          : ButtonWidget(
                              text: AppStrings.verify,
                              onPressed: authType == AppStrings.login
                                  ? () async {
                                      log(widget.phoneNumber);
                                      await loginProvider
                                          .firebaseAuthForVerifyOtpCode(
                                        context,
                                        otpValue ?? '',
                                        token,
                                      );
                                    }
                                  : () {
                                      registerProvider
                                          .firebaseAuthForVerifyOtpCode(
                                              context,
                                              otpValue ?? '',
                                              widget.verificationid.toString(),
                                              token
                                              );
                                    },
                              color: AppColors.primaryBlueStart,
                              gradient: AppColors.primaryBlueGradient,
                            ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
