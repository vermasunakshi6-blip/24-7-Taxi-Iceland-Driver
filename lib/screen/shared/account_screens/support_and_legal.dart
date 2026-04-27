// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/contact_us.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/emergency_assistance.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/help_center.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/report_a_problem.dart';
import 'package:flutter/cupertino.dart';

class SupportAndLegal extends StatefulWidget {
  const SupportAndLegal({super.key});

  @override
  State<SupportAndLegal> createState() => _SupportAndLegalState();
}

class _SupportAndLegalState extends State<SupportAndLegal> {
  @override
  void initState() {
    getData();
    super.initState();
  }

  void getData() async {
    SharedPreferences? prefs = await SharedPreferences.getInstance();

    String? userId = prefs.getString(PrefConstant.userid);
    await Provider.of<SupportLegalProvider>(context, listen: false)
        .getLegalData(context, userId!);
  }

  @override
  Widget build(BuildContext context) {
    SupportLegalProvider supportLegalProvider =
        Provider.of<SupportLegalProvider>(context);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
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
                          AppStrings.supportlegal.toUpperCase(),
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
                padding: const EdgeInsets.only(top: 30, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text(
                      'Support',
                      style:
                          blackHeading,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 4,
                      child: GridView.builder(
                        padding: EdgeInsets.zero,
                        itemCount: 4,
                        physics: const NeverScrollableScrollPhysics(),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                                crossAxisCount: 2,
                                crossAxisSpacing: 10,
                                mainAxisSpacing: 10,
                                childAspectRatio: 1.8),
                        itemBuilder: (context, index) {
                          final List<String> support = [
                            'Help Center',
                            'Contact Us',
                            'Emergency Assistance',
                            'Report a Problem'
                          ];
                          final List<IconData> icons = [
                            Icons.help,
                            CupertinoIcons.ellipses_bubble_fill,
                            Icons.local_police,
                            Icons.warning
                          ];
                          final List<Widget> screens = [
                            const HelpCenter(),
                            const ContactUs(),
                            const EmergencyAssistance(),
                            const ReportaProblem()
                          ];
                          return InkWell(
                            onTap: () {
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => screens[index],
                                  ));
                            },
                            child: Container(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 16,
                              ),
                              decoration: BoxDecoration(
                                  color:  AppColors.creamColor.withOpacity(0.15),
                                  border: Border.all(
                                      color:  AppColors.creamColor, width: 1),
                                  borderRadius: BorderRadius.circular(20)),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.center,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  index == 2
                                      ? const ImageIcon(
                                          AssetImage(
                                              'assets/images/emergency.png'),
                                          size: 21,
                                          color: AppColors.redColor,
                                        )
                                      :  index==0?
                                      const ImageIcon(
                                          AssetImage(
                                              'assets/images/gethelp.png'),
                                          size: 21,
                                          color: AppColors.redColor,
                                        )
                                      : Icon(
                                          icons[index],
                                          size: 21,
                                          color: AppColors.redColor,
                                        ),
                                  const SizedBox(
                                    height: 8,
                                  ),
                                  Text(support[index],
                                      maxLines: 2,
                                      style: blackTitle),
                                ],
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Text(
                      'Legal',
                      style:
                          blackHeading,
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    supportLegalProvider.legalisLoading
                        ? const Center(
                            child: CupertinoActivityIndicator(
                              radius: 15,
                            ),
                          )
                        : SizedBox(
                            height: MediaQuery.of(context).size.height / 2.5,
                            child: GridView.builder(
                              padding: EdgeInsets.zero,
                              itemCount: 5,
                              physics: const NeverScrollableScrollPhysics(),
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 2,
                                      crossAxisSpacing: 10,
                                      mainAxisSpacing: 10,
                                      childAspectRatio: 1.7),
                              itemBuilder: (context, index) {
                                final List<String> legal = [
                                  'Terms of Service',
                                  'Privacy Policy',
                                  'Community Guidlines',
                                  'Copyright and Trademark',
                                  'Refund Policy'
                                ];

                                final List<Widget> widgets = [
                                  TermsConditions(
                                      supportLegalProvider.legalData,
                                      'Terms of Service'),
                                  TermsConditions(
                                      supportLegalProvider.legalData,
                                      'Privacy Policy'),
                                  TermsConditions(
                                      supportLegalProvider.legalData,
                                      'Community Guidelines'),
                                  TermsConditions(
                                      supportLegalProvider.legalData,
                                      'Copyright and Trademark'),
                                  TermsConditions(
                                      supportLegalProvider.legalData,
                                      'Refund Policy'),
                                ];
                                final List<String> images = [
                                  'assets/images/support.png',
                                  'assets/images/termsicon.png',
                                  'assets/images/account.png',
                                  'assets/images/windows.png',
                                  'assets/images/wallet.png',
                                ];
                                return InkWell(
                                  onTap: () {
                                    setState(() {
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                            builder: (context) =>
                                                widgets[index],
                                          ));
                                    });
                                  },
                                  child: Container(
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 12, vertical: 8),
                                    decoration: BoxDecoration(
                                        color:  AppColors.creamColor.withOpacity(0.15),
                                        border: Border.all(
                                            color:  AppColors.creamColor,
                                            width: 1),
                                        borderRadius:
                                            BorderRadius.circular(20)),
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Image.asset(
                                          images[index],
                                          width: 24,
                                          height: 24,
                                          color: AppColors.redColor,
                                        ),
                                        const SizedBox(
                                          height: 6,
                                        ),
                                        Text(legal[index],
                                            style: blackTitle),
                                      ],
                                    ),
                                  ),
                                );
                              },
                            ),
                          )
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
