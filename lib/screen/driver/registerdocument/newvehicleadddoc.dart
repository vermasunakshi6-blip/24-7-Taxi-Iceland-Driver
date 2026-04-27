
import 'dart:async';
import 'package:taxi_driver_24_7/model/get_document_status.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/doc_provider.dart';
   import 'package:taxi_driver_24_7/screen/driver/registerdocument/newvehicleinsuinfo.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/newvehiclercinfo.dart';
  import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';
 import 'package:taxi_driver_24_7/utils/styles.dart';
  import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class NewVehicleAddDoc extends StatefulWidget {
 final  int? vehicleInsuranceStatus;
  final  int? registrationCertificateStatus;
  final   String?  vehicleid;
   const NewVehicleAddDoc({super.key,  
    this.vehicleInsuranceStatus,
    this.registrationCertificateStatus,this.vehicleid});
  @override
  State<NewVehicleAddDoc> createState() => NewVehicleAddDocState();
}

class NewVehicleAddDocState extends State<NewVehicleAddDoc> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
  SharedPreferences? prefs;
  String? userID, vehicleId;
  
  Data? docData;

  @override
  void initState() {
    super.initState();
         Timer(const Duration(seconds: 1), () {
       getData();
    });
  
  }

  

  Future<void> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Consumer<DocProvider>(builder: (context, value, child) {
        if (value.docData != null) {
          docData = value.docData;
        }

        if (value.isloading) {
          return const Center(
            child: CircularProgressIndicator(
              color: AppColors.primaryBlueStart,
              strokeWidth: 1,
            ),
          );
        } else {
          return Container(
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  flex: 1,
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 5.0, right: 35.0, top: 0, bottom: 0),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        InkWell(
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: const Padding(
                            padding: EdgeInsets.only(left: 20.0, right: 20.0),
                            child: Image(
                              image: AssetImage('assets/images/backarrow.png'),
                              height: 25,
                              
                            ),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15.0),
                          child: Text(
                            AppStrings.adddoc.toUpperCase(),
                            style: greyHeading,
                          ),
                        ),
                        const Icon(
                          Icons.arrow_back,
                          color: Colors.transparent,
                        ),
                      ],
                    ),
                  ),
                ),
                Expanded(
                  flex: 5,
                  child: Container(
                    width: MediaQuery.of(context).size.width,
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        boxShadow: [
                          BoxShadow(
                            color:AppColors.greyColor,
                            blurRadius: 10.0,
                            spreadRadius: 0.0,
                            offset: Offset(
                                2.0, 2.0),
                          )
                        ],
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(40),
                          topRight: Radius.circular(40),
                        )),
                    child: Column(
                      children: [
                        Expanded(
                          flex: 5,
                          child: SingleChildScrollView(
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0,
                                      right: 25.0,
                                      top: 40,
                                      bottom: 5),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        AppStrings.fillRequiredSteps,
                                        style: blackTitle,
                                      ),
                                      const SizedBox(
                                        height: 15,
                                      ),
                                      Text(
                                        AppStrings.whatyouneedtodo,
                                        style: greyBodyNormal,
                                      ),
                                      const SizedBox(
                                        height: 5,
                                      ),
                                      const SizedBox(
                                        height: 20,
                                      ),
                                      
                                    ],
                                  ),
                                ),
                              
                               
                               
                               
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.redColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50))),
                                            child: const Center(
                                              child: Image(
                                                  width: 25,
                                                  image: AssetImage(
                                                      'assets/images/insuranceicon.png')),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppStrings.vehicleInsurance,
                                                style: blackBody,
                                              ),
 
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      widget.vehicleInsuranceStatus==0 ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewVehicleInsurInfo(
                                                              vehicleid: widget.vehicleid

                                                                  
                                                            )));
                                                             
                                              },
                                              child: Transform.rotate(
                                                     angle: 3.14,
                                                    child: const Image(
                                                        height: 25,
                                                        image: AssetImage(
                                                            AppImages.arrowback)),
                                                  ),
                                            )
                                          :   Center(child: Text(AppStrings.waitingForAdminApproval,style: redBody,))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: AppColors.greyColor,
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(
                                      left: 25.0, right: 25),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      Row(
                                        children: [
                                          Container(
                                            width: 48,
                                            height: 48,
                                            decoration: BoxDecoration(
                                                border: Border.all(
                                                    color:
                                                        AppColors.redColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50))),
                                            child: const Center(
                                              child: Image(
                                                  width: 25,
                                                  image: AssetImage(
                                                      'assets/images/rcimage.png')),
                                            ),
                                          ),
                                          const SizedBox(
                                            width: 15,
                                          ),
                                          Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              Text(
                                                AppStrings
                                                    .registrationCertificate,
                                                style: blackBody,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              
                                            ],
                                          ),
                                        ],
                                      ),
                                      widget.registrationCertificateStatus ==
                                                  0
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            NewVehicleRCInfo(
                                                              vehicleid: widget.vehicleid,
                                                             
                                                            )));
                                                             
                                              },
                                              child:  Transform.rotate(
                                                     angle: 3.14,
                                                    child: const Image(
                                                        height: 25,
                                                        image: AssetImage(
                                                            AppImages.arrowback)),
                                                  ),
                                            )
                                          :Center(child: Text(AppStrings.waitingForAdminApproval,style: redBody,))
                                    ],
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                const Divider(
                                  color: AppColors.greyColor,
                                ),
                               
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          );
        }
      }),
    );
  }
}
