import 'package:taxi_driver_24_7/provider/authprovider/login_provider.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';

import '../../apppackages.dart';

class Login extends StatefulWidget {
  const Login({super.key});

  @override
  State<Login> createState() => _LoginState();
}

class _LoginState extends State<Login> {
  bool showIcon = false;
  final FocusNode _focusNode = FocusNode();
  final GlobalKey _phoneFieldKey = GlobalKey();
  // final TextEditingController phoneNumberc = TextEditingController();
  LoginProvider? loginProvider;

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      if (_focusNode.hasFocus) {
        WidgetsBinding.instance.addPostFrameCallback((_) {
          final context = _phoneFieldKey.currentContext;
          if (context != null) {
            Scrollable.ensureVisible(
              context,
              alignment: 0.5,
              duration: const Duration(milliseconds: 300),
            );
          }
        });
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final sharedPrefProvider = Provider.of<SharedPrefProvider>(context);
    loginProvider = Provider.of<LoginProvider>(context);
    String raw = sharedPrefProvider.getString(PrefConstant.userType);
    String userType = raw.isEmpty ? AppStrings.driver : raw;
    final keyboardVisible = MediaQuery.of(context).viewInsets.bottom > 0;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: GestureDetector(
        onTap: () {
          _focusNode.unfocus();
        },
        child: Container(
          color: Colors.white,
          child: Padding(
            padding: const EdgeInsets.only(
                left: 0.0, right: 0.0, top: 80, bottom: 5),
            child: Column(
              children: [
                Expanded(
                  flex: 4,
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
                                            image: AssetImage(
                                                AppImages.arrowback)),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                              Expanded(
                                child: Padding(
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Center(
                                    child: Text(
                                      AppStrings.login.toUpperCase(),
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
                          height: 10,
                        ),
                        Center(
                            child: const AppLogo()),
                        const SizedBox(
                          height: 20,
                        ),
                        Container(
                          foregroundDecoration: BoxDecoration(
                              gradient: LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                Colors.white,
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0),
                                Colors.white.withOpacity(0),
                                Colors.white,
                              ])),
                          child: const Image(
                              image: AssetImage('assets/images/loginimg.png')),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        Padding(
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Text(
                            AppStrings.entermobilenumber,
                            style: blackHeading,
                          ),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Padding(
                          key: _phoneFieldKey,
                          padding:
                              const EdgeInsets.only(left: 30.0, right: 30.0),
                          child: Row(
                            children: [
                              SizedBox(
                                width: 100,
                                child: Column(
                                  children: [
                                    CountryCodePicker(
                                        padding:
                                            const EdgeInsets.only(bottom: 0.0),
                                        showDropDownButton: true,
                                        onChanged: (code) {
                                          setState(() {
                                            loginProvider!.setCountryCode(
                                                code.dialCode.toString());
                                          });
                                        },
                                        searchStyle: blackTitle,
                                        textStyle: blackTitle,
                                        initialSelection: 'IN',
                                        
                                        countryFilter: const ['IN', 'IS'],
                                        showCountryOnly: true,
                                        showFlag: false,
                                        showFlagDialog: true,
                                        dialogSize: Size(
                                            MediaQuery.of(context).size.width,
                                            280),
                                        searchDecoration: InputDecoration(
                                          hintText: 'Search Country',
                                          hintStyle: greyBodyNormal,
                                        ),
                                        comparator: (a, b) =>
                                            b.name!.compareTo(a.name!),
                                        onInit: (code) {
                                          loginProvider!.setCountryCode(
                                              code!.dialCode.toString());
                                        }),
                                    Divider(
                                      color:
                                          AppColors.greyColor.withOpacity(0.3),
                                    )
                                  ],
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                child: TextFormField(
                                  controller: loginProvider!.phoneNumberc,
                                  textInputAction: TextInputAction.done,
                                  keyboardType: TextInputType.number,
                                  style: blackTitle,
                                  cursorColor: AppColors.blackColor,
                                  focusNode: _focusNode,
                                  onChanged: (value) {
                                    if (showIcon) {
                                      setState(() {
                                        showIcon = false;
                                      });
                                    }
                                  },
                                  onEditingComplete: () {
                                    setState(() {
                                      showIcon = true;
                                      _focusNode.unfocus();
                                    });
                                  },
                                  decoration: InputDecoration(
                                    enabledBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.greyColor
                                              .withOpacity(0.3),
                                          width: 1.0),
                                    ),
                                    focusedBorder: UnderlineInputBorder(
                                      borderSide: BorderSide(
                                          color: AppColors.greyColor
                                              .withOpacity(0.3),
                                          width: 1.0),
                                    ),
                                    contentPadding: const EdgeInsets.only(
                                        bottom: 5, top: 4),
                                    hintText: '',
                                    suffixIcon: showIcon
                                        ? const Icon(Icons.check_circle_outline,
                                            color: AppColors.skyBlue)
                                        : const Icon(Icons.check_circle_outline,
                                            color: Colors.transparent),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 0,
                  child: Padding(
                    padding: EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                        top: keyboardVisible ? 24.0 : 0,
                        bottom: 0),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        loginProvider!.isLoading
                            ? const CircularProgressIndicator(
                                color: AppColors.blackColor,
                              )
                            : ButtonWidget(
                                text: AppStrings.login,
                                onPressed: () async {
                                  loginProvider!.validation(context, userType);
                                },
                                color: AppColors.primaryBlueStart,
                                gradient: AppColors.primaryBlueGradient,
                              ),
                        const SizedBox(
                          height: 40,
                        )
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }
}
