import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/connected_social_media.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/passkeys.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/recovery_methods.dart';
import 'package:taxi_driver_24_7/widgets/specialized/delete_account_dialog.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignInAndSecurity extends StatefulWidget {
  const SignInAndSecurity({super.key});

  @override
  State<SignInAndSecurity> createState() => _SignInAndSecurityState();
}

class _SignInAndSecurityState extends State<SignInAndSecurity> {
   String? userID;
 @override
  void initState() {
    super.initState();
    main();
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString(PrefConstant.userid);
    
  }

  @override
  Widget build(BuildContext context) {
     final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: SingleChildScrollView(
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
                          AppStrings.signinandsecurity.toUpperCase(),
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
              const SizedBox(
                height: 40,
              ),
              accountRows(
                  () {},
                  'assets/images/emailAddress.svg',
                  'Email Address',

                   
                  Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: AppColors.redColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Add Email',
                        style: redBody,
                      )
                    ],
                  )),
              SizedBox(
                height: 80,
                child: ListView.separated(
                  itemCount: 2,
                  padding: EdgeInsets.zero,
                  separatorBuilder: (context, index) => const Padding(
                    padding: EdgeInsets.symmetric(vertical: 2.0),
                    child: Divider(
                      height: 1,
                      color: AppColors.creamColor,
                      indent: 30,
                    ),
                  ),
                  itemBuilder: (context, index) => Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.abc,
                            size: 25,
                            color: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'abc@gmail.com',
                            style: greyTitle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          index == 0
                              ? Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.greenColor
                                              .withOpacity(0.1),
                                          AppColors.greenColor
                                              .withOpacity(0.04),
                                        ],
                                      )),
                                  child: Center(
                                    child: Text('Primary', style: smallGreen),
                                  ),
                                )
                              : const SizedBox(),
                          PopupMenuButton(
                                    padding: EdgeInsets.zero,
                                    iconSize: 15,
                                    menuPadding: EdgeInsets.zero,
                                    color: Colors.white,
                                    position: PopupMenuPosition.under,
                                    icon: const Icon(
                                      CupertinoIcons.ellipsis_vertical,
                                      
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          onTap: () {},
                                          child: Text(
                                            'Delete ',
                                            style: blackBody,
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {},
                                          child: Text(
                                            'Make it Default',
                                            style: blackBody,
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40.0),
                child: accountRows(
                    () {},
                    'assets/images/phoneNumber.svg',
                    'Phone Number',
                    Row(
                      children: [
                        const Icon(
                          Icons.add_circle,
                          color: AppColors.redColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Text(
                          'Add Phone',
                          style: redBody,
                        )
                      ],
                    )),
              ),
              Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          const Icon(
                            Icons.abc,
                            size: 25,
                            color: Colors.transparent,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            '+91-1234561234',
                            style:greyTitle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                               Container(
                                  width: MediaQuery.of(context).size.width / 6,
                                  padding: const EdgeInsets.symmetric(
                                      vertical: 4, horizontal: 10),
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(40),
                                      gradient: LinearGradient(
                                        begin: Alignment.centerLeft,
                                        end: Alignment.centerRight,
                                        colors: [
                                          AppColors.greenColor
                                              .withOpacity(0.1),
                                          AppColors.greenColor
                                              .withOpacity(0.04),
                                        ],
                                      )),
                                  child: Center(
                                    child: Text('Primary', style: smallGreen),
                                  ),
                                ),
                          PopupMenuButton(
                                    padding: EdgeInsets.zero,
                                    menuPadding: EdgeInsets.zero,
                                    color: Colors.white,
                                    position: PopupMenuPosition.under,
                                    shadowColor: Colors.white,
                                    icon: const Icon(
                                      CupertinoIcons.ellipsis_vertical,
                                      size: 15,
                                    ),
                                    itemBuilder: (context) {
                                      return [
                                        PopupMenuItem(
                                          onTap: () {},
                                          child: Text(
                                            'Delete ',
                                            style: blackBody,
                                          ),
                                        ),
                                        PopupMenuItem(
                                          onTap: () {},
                                          child: Text(
                                            'Make it Default',
                                            style: blackBody,
                                          ),
                                        ),
                                      ];
                                    },
                                  ),
                        ],
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 20,
                  ),
              const SizedBox(
                height: 20,
              ),
              accountRows(() {}, 'assets/images/changePassword.svg', 'Change Password', null),
              accountRows(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const Passkeys(),
                    ));
              }, 'assets/images/passkeys.svg', 'Passkeys', null),
              accountRows(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const RecoveryMethods(),
                    ));
              }, 'assets/images/recoveryMethods.svg', 'Recovery Methods', null),
              accountRows(() {
                Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => const ConnectedSocialMedia(),
                    ));
              }, 'assets/images/connectedApps.svg', AppStrings.connectedsocialmedia, null),
              accountRows(() {}, 'assets/images/downloadData.svg', 'Download Your Data', null),
              GestureDetector(
                onTap: () {
                  showDialog(
                      context: context,
                      builder: (_) => StatefulBuilder(
                        builder: (context, snapshot) {
                          return DeleteAccountDialog(profileProvider: profileProvider, userId: userID.toString());
                        }
                      ));
                },
                child: Row(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.delete,
                          size: 25,
                          color: AppColors.redColor,
                        ),
                        const SizedBox(
                          width: 15,
                        ),
                        Text(
                          'Delete Account',
                          style:redTitle,
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

Widget accountRows(
  Function()? onTap,
  String image,
  String title,
  Widget? trailing,
) {
  return Column(
    children: [
      GestureDetector(
        onTap: onTap,
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
               SvgPicture.asset(image,width: 25,height: 25,color: AppColors.redColor,),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  title,
                  style: blackTitle,
                ),
              ],
            ),
            trailing ??
                Image.asset(
                  'assets/images/arrowforward.png',
                  height: 13,
                  color: AppColors.blackColor,
                ),
          ],
        ),
      ),
      const SizedBox(
        height: 15,
      ),
      const Divider(
        height: 1,
        color: AppColors.creamColor,
      ),
      const SizedBox(
        height: 15,
      ),
    ],
  );
}
