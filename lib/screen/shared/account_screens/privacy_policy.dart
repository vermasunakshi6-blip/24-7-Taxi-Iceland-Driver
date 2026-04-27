import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/model/legal_data_model.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({
    super.key,
  });
  @override
  State<PrivacyPolicy> createState() => PrivacyPolicyState();
}

class PrivacyPolicyState extends State<PrivacyPolicy> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityController connectivityController = ConnectivityController();
  @override
  void initState() {
    connectivityController.init();
    
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final supportProvider = Provider.of<SupportLegalProvider>(context);
    final list = supportProvider.legalData ?? [];
    LegalData? privacyItem;
    for (final e in list) {
      if ((e.title ?? '').toLowerCase().contains('privacy')) {
        privacyItem = e;
        break;
      }
    }
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: connectivityController.isConnected,
            builder: (context, value, child) {
              if (value) {
                return supportProvider.legalisLoading
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: AppColors.blackColor,
                          strokeWidth: 2,
                        ),
                      )
                    : Container(
                        decoration: const BoxDecoration(
                            image: DecorationImage(
                              image: AssetImage(
                                  'assets/images/curvelogin.png'), 
                              fit: BoxFit.cover,
                            ),
                            color: Colors.white),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Expanded(
                              flex: 1,
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 20.0, right: 0.0, top: 20.0),
                                child: Row(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Expanded(
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        crossAxisAlignment:
                                            CrossAxisAlignment.start,
                                        children: [
                                          InkWell(
                                            onTap: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Image(
                                                height: 25,
                                                image: AssetImage(
                                                  AppImages.arrowback,
                                                )),
                                          ),
                                        ],
                                      ),
                                    ),
                                    Expanded(
                                      flex: 3,
                                      child: Padding(
                                        padding:
                                            const EdgeInsets.only(left: 0.0),
                                        child: Center(
                                          child: Text(
                                            AppStrings.privacy.toUpperCase(),
                                            style: greyHeading,
                                          ),
                                        ),
                                      ),
                                    ),
                                    const Expanded(
                                      child:
                                          SizedBox(),
                                    ),
                                  ],
                                ),
                              ),
                            ),
                            Expanded(
                              flex: 5,
                              child: Container(
                                height: 100,
                                width: MediaQuery.of(context).size.width,
                                decoration: const BoxDecoration(
                                    color: Colors.white,
                                    boxShadow: [
                                      BoxShadow(
                                        color:AppColors.greyColor,
                                        blurRadius: 10.0,
                                        spreadRadius: 0.0,
                                        offset: Offset(2.0,
                                            2.0),
                                      )
                                    ],
                                    borderRadius: BorderRadius.only(
                                      topLeft: Radius.circular(40),
                                      topRight: Radius.circular(40),
                                    )),
                                child: SingleChildScrollView(
                                    child: Padding(
                                        padding: const EdgeInsets.all(20.0),
                                        child: Html(
                                            data: privacyItem?.content ?? ''))),
                              ),
                            ),
                          ],
                        ),
                      );
              } else {
                return const NetworkAlertBar();
              }
            }));
  }
}
