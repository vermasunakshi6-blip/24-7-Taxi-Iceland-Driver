// ignore_for_file: use_build_context_synchronously
import 'package:taxi_driver_24_7/apppackages.dart';

class ManageVehicle extends StatefulWidget {
  const ManageVehicle({super.key});
  @override
  State<ManageVehicle> createState() => ManageVehicleState();
}

class ManageVehicleState extends State<ManageVehicle> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isToggled = false;
  String driverId = "";
  @override
  void initState() {
    super.initState();
    main();
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    if (prefs.getString(PrefConstant.userid) != null) {
      driverId = prefs.getString(PrefConstant.userid)!;
      Provider.of<ManageVehicleProvider>(context, listen: false)
          .getVehicleListData(driverId, context);
    }
  }

  @override
  Widget build(BuildContext context) {
    final manageVehicleProvider = Provider.of<ManageVehicleProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 60.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      InkWell(
                        onTap: () {},
                        child: const Padding(
                          padding:
                              EdgeInsets.only(right: 30, top: 0, bottom: 0),
                          child: Image(
                              height: 25,
                              color: Colors.transparent,
                              image: AssetImage(AppImages.arrowback)),
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
                        AppStrings.vehicles.toUpperCase(),
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
              padding:
                  const EdgeInsets.only(top: 20.0, left: 24.0, right: 24.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text('Manage your vehicles', style: blackTitle),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            'Add or remove your vehicles and choose\n the default one for booking rides',
                            style: greyBodyNormal,
                            textAlign: TextAlign.center,
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: manageVehicleProvider.isloading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                ),
                                    )
                                  : manageVehicleProvider
                                              .getvehicleDetailData !=
                                          null
                                      ? ListView.builder(
                                          padding: EdgeInsets.zero,
                                          itemCount: manageVehicleProvider
                                              .getvehicleDetailData!.length,
                                          itemBuilder: (context, index) {
                                            final data = manageVehicleProvider
                                                .getvehicleDetailData![index];

                                            return ListTile(
                                              title: Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Row(
                                                    children: [
                                                      Container(
                                                        decoration: BoxDecoration(
                                                            color:AppColors.greyColor.withOpacity(0.2),
                                                            border: Border.all(
                                                                color: AppColors
                                                                    .blackColor,
                                                                width: 2),
                                                            borderRadius:
                                                                const BorderRadius
                                                                    .all(
                                                                    Radius.circular(
                                                                        100))),
                                                        child: Padding(
                                                          padding:
                                                              const EdgeInsets
                                                                  .all(0.0),
                                                          child: ClipRRect(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        60),
                                                            child: SizedBox(
                                                              height: 60,
                                                              width: 60,
                                                              child: Image.network(
                                                                  fit: BoxFit
                                                                      .cover,
                                                                  data.vehicleImages!),
                                                            ),
                                                          ),
                                                        ),
                                                      ),
                                                      const SizedBox(
                                                        width: 20,
                                                      ),
                                                      Column(
                                                        crossAxisAlignment:
                                                            CrossAxisAlignment
                                                                .start,
                                                        children: [
                                                          Text(
                                                            data.vehicleModel!,
                                                            style:
                                                                blackTitle,
                                                          ),
                                                          const SizedBox(
                                                            height: 2,
                                                          ),
                                                          Text(
                                                            data.registrationNumber!,
                                                            style:
                                                                greyBodyNormal,
                                                            textAlign: TextAlign
                                                                .center,
                                                          ),
                                                        ],
                                                      ),
                                                      manageVehicleProvider
                                                                  .getvehicleDetailData![
                                                                      index]
                                                                  .isDefault ==
                                                              1
                                                          ? Padding(
                                                              padding:
                                                                  const EdgeInsets
                                                                      .only(
                                                                      left: 10,
                                                                      bottom:
                                                                          20),
                                                              child: Image.asset(
                                                                  "assets/images/DefaultTag.png"),
                                                            )
                                                          : const SizedBox()
                                                    ],
                                                  ),
                                                  data.backgroundVerification ==
                                                          1
                                                      ? InkWell(
                                                          onTap: () {
                                                            showDialog(
                                                              barrierDismissible:
                                                                  false,
                                                              context: context,
                                                              builder:
                                                                  (BuildContext
                                                                      context) {
                                                                return AlertDialog(
                                                                    insetPadding:
                                                                        const EdgeInsets
                                                                            .all(
                                                                            0),
                                                                    backgroundColor:
                                                                        Colors
                                                                            .transparent,
                                                                    elevation:
                                                                        0.0,
                                                                    content:
                                                                        SizedBox(
                                                                      width: MediaQuery.of(
                                                                              context)
                                                                          .size
                                                                          .width,
                                                                      child:
                                                                          Column(
                                                                        mainAxisAlignment:
                                                                            MainAxisAlignment.end,
                                                                        children: [
                                                                          Container(
                                                                            padding:
                                                                                const EdgeInsets.all(8.0),
                                                                            decoration:
                                                                                const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                            child:
                                                                                Column(
                                                                              children: [
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.pop(context);
                                                                                    manageVehicleProvider.setDefaultVehicle(driverId, data.sId!, context);
                                                                                  },
                                                                                  child: Text("Set as Default", style: blackTitle),
                                                                                ),
                                                                                const Divider(),
                                                                                InkWell(
                                                                                  onTap: () {
                                                                                    Navigator.push(
                                                                                        context,
                                                                                        MaterialPageRoute(
                                                                                            builder: (context) => ViewDoc(
                                                                                                  vehicleId: data.sId!,
                                                                                                )));
                                                                                  },
                                                                                  child: Text("View Documents", style: blackTitle),
                                                                                ),
                                                                                data.isDefault == 0
                                                                                    ? Column(
                                                                                        children: [
                                                                                          const Divider(),
                                                                                          InkWell(
                                                                                            onTap: () {
                                                                                              Navigator.pop(context);
                                                                                              manageVehicleProvider.deleteVehicle(driverId, data.sId!, context);
                                                                                            },
                                                                                            child: Text("Delete Vehicle", style: redBody),
                                                                                          ),
                                                                                        ],
                                                                                      )
                                                                                    : const SizedBox()
                                                                              ],
                                                                            ),
                                                                          ),
                                                                          const SizedBox(
                                                                            height:
                                                                                5,
                                                                          ),
                                                                          InkWell(
                                                                            onTap:
                                                                                () {
                                                                              Navigator.pop(context);
                                                                            },
                                                                            child:
                                                                                Container(
                                                                              margin: const EdgeInsets.only(bottom: 0),
                                                                              padding: const EdgeInsets.all(12),
                                                                              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                                              child: Center(child: Text("Cancel", style: blackBody)),
                                                                            ),
                                                                          )
                                                                        ],
                                                                      ),
                                                                    ));
                                                              },
                                                            );
                                                          },
                                                          child: const Icon(
                                                              Icons.more_vert))
                                                      : GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => NewVehicleAddDoc(
                                                                        vehicleInsuranceStatus:
                                                                            data
                                                                                .vehicleInsuranceStatus,
                                                                        registrationCertificateStatus:
                                                                            data
                                                                                .registrationCertificateStatus,
                                                                        vehicleid:
                                                                            data.sId)));
                                                          },
                                                          child: Text(
                                                            'View',
                                                            style: redBody,
                                                          )),
                                                ],
                                              ),
                                            );
                                          },
                                        )
                                      : const SizedBox())
                        ],
                      ),
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        ButtonWidget(
                          text: 'Add a Vehicle',
                          onPressed: () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) => AddNewVehicle(
                                          isNewVehicel: true,
                                        )));
                          },
                          color: AppColors.primaryBlueStart,
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
}
