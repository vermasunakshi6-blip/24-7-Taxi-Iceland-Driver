
// ignore_for_file: use_build_context_synchronously

import 'dart:async';
import 'dart:developer';

 import 'package:taxi_driver_24_7/model/get_document_status.dart';
import 'package:taxi_driver_24_7/provider/driverprovider/doc_provider.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/addprofilephoto.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/drivinglicinfo.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/rcinfo.dart';
import 'package:taxi_driver_24_7/screen/driver/registerdocument/vehicleinsurinfo.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:taxi_driver_24_7/widgets/common/button_widget.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';

class AddDoc extends StatefulWidget {
  const AddDoc({super.key});
  @override
  State<AddDoc> createState() => AddDocState();
}

class AddDocState extends State<AddDoc> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
  SharedPreferences? prefs;
  String? userID, vehicleId;

  Data? docData;

  @override
  void initState() {
    super.initState();
    Timer(const Duration(seconds: 0), () {
      getData();
    });
  }

  Future<void> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    if (prefs!.getString(PrefConstant.userid) != null) {
      userID = prefs!.getString(PrefConstant.userid);
      vehicleId = prefs!.getString(PrefConstant.vehicleId);
      log('userID && vehicleId--/. $userID $vehicleId',);

      Provider.of<DocProvider>(context, listen: false)
          .getDocStatus(context,userID!, vehicleId!);
    }
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
                              width: 10,
                              color: Colors.transparent,
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
                            offset: Offset(2.0, 2.0),
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
                                      Row(
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
                                                        color: AppColors
                                                            .redColor),
                                                    borderRadius:
                                                        const BorderRadius.all(
                                                            Radius.circular(
                                                                50))),
                                                child: const Center(
                                                  child: Image(
                                                      width: 25,
                                                      color: AppColors
                                                          .redColor,
                                                      image: AssetImage(
                                                          'assets/images/profileicons.png')),
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
                                                    AppStrings.profilePhoto,
                                                    style: blackBody,
                                                  ),
                                                  const SizedBox(
                                                    height: 5,
                                                  ),
                                                  if (docData != null) ...{
                                                    if (docData!
                                                            .profilePhotoStatus ==
                                                        0) ...{
                                                      Text(
                                                        AppStrings.getStarted,
                                                        style: greyBodyNormal,
                                                      ),
                                                    } else if (docData!
                                                            .profilePhotoStatus ==
                                                        1) ...{
                                                      Text(
                                                        AppStrings.inProgress,
                                                        style: greyBodyNormal,
                                                      ),
                                                    } else if (docData!
                                                            .profilePhotoStatus ==
                                                        1) ...{
                                                      Text(
                                                        AppStrings.complete,
                                                        style: greyBodyNormal,
                                                      ),
                                                    } else
                                                      ...{},
                                                  } else ...{
                                                    Text(
                                                      AppStrings.getStarted,
                                                      style: greyBodyNormal,
                                                    ),
                                                  }
                                                ],
                                              ),
                                            ],
                                          ),
                                          docData != null &&
                                                  docData!.profilePhotoStatus ==
                                                      0
                                              ? GestureDetector(
                                                  onTap: () {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                            builder: (context) =>
                                                                const AddProfilePhoto()));
                                                    getData();
                                                  },
                                                  child: 
                                                  Transform.rotate(
                                                     angle: 3.14,
                                                    child: const Image(
                                                        height: 25,
                                                        image: AssetImage(
                                                            AppImages.arrowback)),
                                                  ),
                                                )
                                              : const SizedBox()
                                        ],
                                      ),
                                    ],
                                  ),
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
                                                    color: AppColors
                                                        .redColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50))),
                                            child: const Center(
                                              child: Image(
                                                  width: 25,
                                                  image: AssetImage(
                                                      'assets/images/licenseicon.png')),
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
                                                AppStrings.drivingLicenseFront,
                                                style: blackBody,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              if (docData != null) ...{
                                                if (docData!
                                                        .drivingLicenceFrontStatus ==
                                                    0) ...{
                                                  Text(
                                                    AppStrings.getStarted,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else if (docData!
                                                        .drivingLicenceFrontStatus ==
                                                    1) ...{
                                                  Text(
                                                    AppStrings.inProgress,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else if (docData!
                                                        .drivingLicenceFrontStatus ==
                                                    1) ...{
                                                  Text(
                                                    AppStrings.complete,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else
                                                  ...{},
                                              } else ...{
                                                Text(
                                                  AppStrings.getStarted,
                                                  style: greyBodyNormal,
                                                ),
                                              }
                                            ],
                                          ),
                                        ],
                                      ),
                                      docData != null &&
                                              docData!.drivingLicenceFrontStatus ==
                                                  0
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            const DrivingLicInfo()));
                                                getData();
                                              },
                                              child: Transform.rotate(
                                                     angle: 3.14,
                                                    child: const Image(
                                                        height: 25,
                                                        image: AssetImage(
                                                            AppImages.arrowback)),
                                                  ),
                                            )
                                          : const SizedBox()
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
                                                    color: AppColors
                                                        .redColor),
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
                                              if (docData != null) ...{
                                                if (docData!
                                                        .vehicleInsuranceStatus ==
                                                    0) ...{
                                                  Text(
                                                    AppStrings.getStarted,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else if (docData!
                                                        .vehicleInsuranceStatus ==
                                                    1) ...{
                                                  Text(
                                                    AppStrings.inProgress,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else if (docData!
                                                        .vehicleInsuranceStatus ==
                                                    1) ...{
                                                  Text(
                                                    AppStrings.complete,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else
                                                  ...{},
                                              } else ...{
                                                Text(
                                                  AppStrings.getStarted,
                                                  style: greyBodyNormal,
                                                ),
                                              },
                                              const SizedBox(
                                                height: 5,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                      docData != null &&
                                              docData!.vehicleInsuranceStatus ==
                                                  0
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            VehicleInsurInfo(
                                                              isNewVehicel:
                                                                  false,
                                                            )));
                                                getData();
                                              },
                                              child:  Transform.rotate(
                                                     angle: 3.14,
                                                    child: const Image(
                                                        height: 25,
                                                        image: AssetImage(
                                                            AppImages.arrowback)),
                                                  ),
                                            )
                                          : const SizedBox()
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
                                                    color: AppColors
                                                        .redColor),
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
                                              if (docData != null) ...{
                                                if (docData!
                                                        .registrationCertificateStatus ==
                                                    0) ...{
                                                  Text(
                                                    AppStrings.getStarted,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else if (docData!
                                                        .registrationCertificateStatus ==
                                                    1) ...{
                                                  Text(
                                                    AppStrings.inProgress,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else if (docData!
                                                        .registrationCertificateStatus ==
                                                    1) ...{
                                                  Text(
                                                    AppStrings.complete,
                                                    style: greyBodyNormal,
                                                  ),
                                                } else
                                                  ...{},
                                              } else
                                                ...{}
                                            ],
                                          ),
                                        ],
                                      ),
                                      docData != null &&
                                              docData!.registrationCertificateStatus ==
                                                  0
                                          ? GestureDetector(
                                              onTap: () {
                                                Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                        builder: (context) =>
                                                            RCInfo(
                                                              isNewVehicel:
                                                                  false,
                                                            )));
                                                getData();
                                              },
                                              child:  Transform.rotate(
                                                     angle: 3.14,
                                                    child: const Image(
                                                        height: 25,
                                                        image: AssetImage(
                                                            AppImages.arrowback)),
                                                  ),
                                            )
                                          : const SizedBox()
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
                        Expanded(
                          flex: 1,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0, right: 25.0),
                                child: ButtonWidget(
                                  text: AppStrings.next,
                                  onPressed: () {
                                    if (docData != null) {
                                      if (docData!.profilePhotoStatus == 0) {
                                        CSnackBar.showSnackBarError(
                                            AppStrings.addProfileToMove,
                                            context);
                                      } else if (docData!
                                              .drivingLicenceFrontStatus ==
                                          0) {
                                        CSnackBar.showSnackBarError(
                                            AppStrings.addDrivingLicenseToMove,
                                            context);
                                      } else if (docData!
                                              .vehicleInsuranceStatus ==
                                          0) {
                                        CSnackBar.showSnackBarError(
                                            AppStrings.addVehicleInsuranceToMove,
                                            context);
                                      } else if (docData!
                                              .registrationCertificateStatus ==
                                          0) {
                                        CSnackBar.showSnackBarError(
                                            AppStrings.addRcToMove,
                                            context);
                                      } else {
                                        Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                                builder: (context) =>
                                                    const DriverHome()));
                                      }
                                    }
                                  },
                                  color: AppColors.primaryBlueStart,
                                ),
                              ),
                            ],
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
