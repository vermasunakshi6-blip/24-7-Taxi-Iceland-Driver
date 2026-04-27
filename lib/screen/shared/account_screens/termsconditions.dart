import 'package:taxi_driver_24_7/model/legal_data_model.dart';

import 'package:taxi_driver_24_7/apppackages.dart';

class TermsConditions extends StatefulWidget {
 final List<LegalData>? legalData;
  final  String? title;

  const TermsConditions(this.legalData, this.title, {super.key});
  
  @override
  State<TermsConditions> createState() => TermsConditionsState();
}

class TermsConditionsState extends State<TermsConditions> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityController connectivityController = ConnectivityController();

  LegalData? termsItem;
  @override
  void initState() {
    connectivityController.init();
    getData();
    super.initState();
  }

  getData() {
    if(widget.title=='Terms of Service'){
      termsItem = widget.legalData!.firstWhere(
        (item) => item.title == 'Terms and Conditions',
      );
    }else if(widget.title=='Privacy Policy'){
      termsItem = widget.legalData!.firstWhere(
        (item) => item.title == 'Privacy Policy',
      );
    }else if(widget.title=='Community Guidelines'){
      termsItem = widget.legalData!.firstWhere(
        (item) => item.title == 'Community Guidelines',
      );
    }else if(widget.title=='Copyright and Trademark'){
      termsItem = widget.legalData!.firstWhere(
        (item) => item.title == 'Copyright and Trademark',
      );
    }else if(widget.title=='Refund Policy'){
    termsItem = widget.legalData!.firstWhere(
      (item) => item.title == 'Refund Policy',
    );
  }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        key: scaffoldKey,
        body: ValueListenableBuilder(
            valueListenable: connectivityController.isConnected,
            builder: (context, value, child) {
              if (value) {
                return
                    //  privacyProvider.isloading
                    //     ? const Center(
                    //         child: CircularProgressIndicator(
                    //           color: AppColors.blackColor,
                    //           strokeWidth: 2,
                    //         ),
                    //       )
                    //     :

                    Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage('assets/images/curvelogin.png'),
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
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  crossAxisAlignment: CrossAxisAlignment.start,
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
                                  padding: const EdgeInsets.only(left: 0.0),
                                  child: Center(
                                    child: Text(
                                      widget.title!,
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
                                  offset: Offset(2.0, 2.0),
                                )
                              ],
                              borderRadius: BorderRadius.only(
                                topLeft: Radius.circular(40),
                                topRight: Radius.circular(40),
                              )),
                          child: SingleChildScrollView(
                              child: Padding(
                                  padding: const EdgeInsets.all(20.0),
                                  child: Html(data: termsItem!.content))),
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
