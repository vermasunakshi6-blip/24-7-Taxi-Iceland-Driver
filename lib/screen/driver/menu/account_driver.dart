// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/account_screens/edit_profile_driver.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/account_screens/your_vehicles.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/account_screens/about_us_static_driver.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/account_screens/privacy_policy_static_driver.dart';
import 'package:taxi_driver_24_7/screen/driver/menu/account_screens/terms_conditions_static_driver.dart';
import 'package:taxi_driver_24_7/provider/common/language_provider.dart';
class AccountDriver extends StatefulWidget {
  /// When true (pushed from home), shows a back button. When false (bottom tab), hides it.
  final bool showBackButton;
  const AccountDriver({super.key, this.showBackButton = false});
  @override
  State<AccountDriver> createState() => AccountDriverState();
}

class AccountDriverState extends State<AccountDriver> {
  late bool isToggled = false;
  var scaffoldKey = GlobalKey<ScaffoldState>();
  SharedPreferences? prefs;
  String? userID, deviceToken;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    userID = prefs!.getString(PrefConstant.userid);
    deviceToken = prefs!.getString(PrefConstant.token);
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfile(prefs!.getString(PrefConstant.userid), context);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
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
                        if (widget.showBackButton)
                          InkWell(
                            onTap: () => Navigator.pop(context),
                            child: const Padding(
                              padding: EdgeInsets.only(
                                  right: 30, top: 0, bottom: 0),
                              child: Image(
                                height: 25,
                                image: AssetImage(
                                  AppImages.arrowback,
                                ),
                              ),
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
                          AppStrings.account.toUpperCase(),
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
            Expanded(
              child: Padding(
                padding: const EdgeInsets.only(left: 8.0, right: 10,bottom: 20),
                child: ListView(
                  padding: const EdgeInsets.only(bottom: 50),
                  children: <Widget>[
                    const SizedBox(
                      height: 15,
                    ),
                    Row(
                      children: [
                        const SizedBox(
                          width: 10,
                        ),
                        InkWell(
                            onTap: () {},
                            child: profileProvider.profileDetailss != null
                                ? Container(
                                    width: 65.0,
                                    height: 65.0,
                                    decoration: const BoxDecoration(
                                      color: AppColors.greyColor,
                                      image: DecorationImage(
                                        image: AssetImage(
                                            'assets/images/roundgrey.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(0.0),
                                      child: ClipRRect(
                                        borderRadius: BorderRadius.circular(60),
                                        child: profileProvider.profileDetails!
                                                .profilePic!.isEmpty
                                            ? const CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                )
                                            : Image.network(
                                                profileProvider.profileDetails!
                                                    .profilePic!,
                                                fit: BoxFit.cover,
                                              ),
                                      ),
                                    ),
                                  )
                                : Container(
                                    width: 65.0,
                                    height: 65.0,
                                    decoration:  BoxDecoration(
                                      color:AppColors.greyColor.withOpacity(0.3),
                                      image:const DecorationImage(
                                        image: AssetImage(
                                            'assets/images/roundgrey.png'),
                                        fit: BoxFit.cover,
                                      ),
                                      borderRadius:const BorderRadius.all(
                                          Radius.circular(50.0)),
                                    ),
                                  )),
                        const SizedBox(
                          width: 20,
                        ),
                        profileProvider.profileDetailss != null
                            ? Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Padding(
                                    padding: const EdgeInsets.only(left: 5.0),
                                    child: Text(
                                      "${profileProvider.profileDetailss!.firstName!} ${profileProvider.profileDetailss!.lastName!}",
                                      style: blackHeading,
                                    ),
                                  ),
                                  Row(
                                    children: [
                                      const Icon(
                                            Icons.star,
                                            color: AppColors.redColor,
                                            size: 20,
                                          ),
                                          const SizedBox(width: 4,),
                                          Text(profileProvider
                                          .profileDetailss!.averageRating
                                          .toString(),style: blackTitle)
                                    ],
                                  )
                                ],
                              )
                            : const Text('')
                      ],
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    accountRows(
                      () {
                        movetoProfile();
                      },
                      'assets/images/editprofile.png',
                      AppStrings.profilesettings,
                    ),
                    accountRows(
                      () {
                        _showLanguageSheet();
                      },
                      'assets/images/apprefs.png',
                      AppStrings.changeLanguage,
                    ),
                    accountRows(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const PrivacyPolicyStaticDriver(),
                        ),
                      );
                    }, 'assets/images/privacypolicy.png', AppStrings.privacy),
                    accountRows(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              const TermsConditionsStaticDriver(),
                        ),
                      );
                    }, 'assets/images/privacypolicy.png', AppStrings.terms),
                    accountRows(() {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AboutUsStaticDriver(),
                        ),
                      );
                    }, 'assets/images/support.png', AppStrings.aboutus),
                    GridView.builder(
                      shrinkWrap: true,
                      padding: EdgeInsets.zero,
                      itemCount: 1,
                      physics: const NeverScrollableScrollPhysics(),
                      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                        crossAxisCount: 2,
                        mainAxisSpacing: 10,
                        crossAxisSpacing: 10,
                        childAspectRatio: 1.7,
                      ),
                      itemBuilder: (context, index) {
                        return InkWell(
                          onTap: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const YourVehicle(),
                                ));
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                color: AppColors.primaryBlueStart.withOpacity(0.14),
                                width: 1,
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: Colors.black.withOpacity(0.06),
                                  blurRadius: 14,
                                  offset: const Offset(0, 6),
                                )
                              ],
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  padding: const EdgeInsets.all(8),
                                  decoration: BoxDecoration(
                                    color: AppColors.primaryBlueStart.withOpacity(0.10),
                                    borderRadius: BorderRadius.circular(10),
                                  ),
                                  child: Image.asset(
                                    'assets/images/rideprefs.png',
                                    width: 22,
                                    height: 22,
                                    color: AppColors.primaryBlueStart,
                                  ),
                                ),
                                const SizedBox(height: 8),
                                Text(AppStrings.yourVehicles, style: blackTitle),
                              ],
                            ),
                          ),
                        );
                      },
                    )
                    
                  ],
                ),
              ),
            ),
            
            Padding(
              padding:  EdgeInsets.only(top: 10, bottom:widget.showBackButton ? 40 : 20),
              child: GestureDetector(
                onTap: () {
                  showDialog(
                    context: context,
                    builder: (_) =>
                        LogoutDialog(userid: userID, deviceToken: deviceToken),
                  );
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Image.asset(
                          'assets/images/logouticon.png',
                          width: 25,
                           color:AppColors.redColor,
                        ),
                        const SizedBox(
                          width: 10,
                        ),
                        Text(
                          AppStrings.logout,
                          style: blackTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void movetoProfile() async {
    final result = await Navigator.push(context,
        MaterialPageRoute(builder: (context) => const EditProfileDriver()));

    if (result == true) {
      setState(() {
        getData();
      });
    }
  }

  void _showLanguageSheet() {
    showDialog(
      context: context,
      builder: (context) {
        final lang = Provider.of<LanguageProvider>(context);
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Text(
            AppStrings.changeLanguage,
            style: blackHeading,
          ),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              RadioListTile<Locale>(
                value: const Locale('en'),
                groupValue: lang.locale,
                onChanged: (v) async {
                  if (v == null) return;
                  await lang.setLocale(v);
                  if (context.mounted) Navigator.pop(context);
                },
                title: Text(AppStrings.english),
              ),
              RadioListTile<Locale>(
                value: const Locale('is'),
                groupValue: lang.locale,
                onChanged: (v) async {
                  if (v == null) return;
                  await lang.setLocale(v);
                  if (context.mounted) Navigator.pop(context);
                },
                title: Text(AppStrings.icelandic),
              ),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: Text(AppStrings.cancel, style: blackTitle),
            ),
          ],
        );
      },
    );
  }
}

Widget accountRows(Function()? onTap, String image, String title) {
  return Column(
    children: [
      InkWell(
        onTap: onTap,
        radius: 0,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Image.asset(
                  image,
                  width: 25,
                  color: AppColors.redColor,
                ),
                const SizedBox(
                  width: 10,
                ),
                Text(
                  title,
                  style: blackTitle,
                ),
              ],
            ),
            Image.asset(
              'assets/images/arrowforward.png',
              height: 13,
            ),
          ],
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      title != AppStrings.supportlegal
          ? const Divider(
              height: 1,
              color: AppColors.creamColor,
            )
          : const SizedBox(),
      const SizedBox(
        height: 20,
      ),
    ],
  );
}
