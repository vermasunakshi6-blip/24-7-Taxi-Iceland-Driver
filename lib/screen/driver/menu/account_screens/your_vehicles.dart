// ignore_for_file: use_build_context_synchronously
import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/widgets/common/shimmer_loader.dart';

class YourVehicle extends StatefulWidget {
  const YourVehicle({super.key});
  @override
  State<YourVehicle> createState() => YourVehicleState();
}

class YourVehicleState extends State<YourVehicle> {
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
            padding: const EdgeInsets.only(left: 20.0, right: 20.0, top: 60.0),
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
                          padding:
                              EdgeInsets.only(right: 30, top: 0, bottom: 0),
                          child: Image(
                              height: 25,
                              color: AppColors.blackColor,
                              image: AssetImage(AppImages.arrowback)),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Center(
                    child: Text(
                      AppStrings.yourVehicles.toUpperCase(),
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
          Expanded(
            child: Padding(
              padding:
                  const EdgeInsets.only(top: 20.0, left: 20.0, right: 20.0),
              child: Column(
                children: [
                  Expanded(
                    flex: 8,
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            AppStrings.yourVehicles,
                            style: blackHeading,
                          ),
                          SizedBox(
                              height: MediaQuery.of(context).size.height,
                              child: manageVehicleProvider.isloading
                                  ? ShimmerLoader(count: 6, height: MediaQuery.of(context).size.height/7)
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
                                            return Container(
                                              margin: const EdgeInsets.only(bottom: 12),
                                              padding: const EdgeInsets.all(12),
                                              decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius: BorderRadius.circular(16),
                                                border: Border.all(
                                                  color: AppColors.primaryBlueStart.withOpacity(0.12),
                                                  width: 1,
                                                ),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.black.withOpacity(0.06),
                                                    blurRadius: 14,
                                                    offset: const Offset(0, 6),
                                                  ),
                                                ],
                                              ),
                                              child: Row(
                                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                children: [
                                                  Expanded(
                                                    child: Row(
                                                      crossAxisAlignment: CrossAxisAlignment.start,
                                                      children: [
                                                        Container(
                                                          width: MediaQuery.of(context).size.width / 3.1,
                                                          height: MediaQuery.of(context).size.width / 4.5,
                                                          decoration: BoxDecoration(
                                                            color: AppColors.primaryBlueStart.withOpacity(0.08),
                                                            border: Border.all(
                                                              color: AppColors.primaryBlueStart.withOpacity(0.10),
                                                              width: 1,
                                                            ),
                                                            borderRadius: const BorderRadius.all(Radius.circular(10)),
                                                          ),
                                                          child: ClipRRect(
                                                            borderRadius: BorderRadius.circular(10),
                                                            child: Image.network(
                                                              data.vehicleImages!,
                                                              fit: BoxFit.cover,
                                                            ),
                                                          ),
                                                        ),
                                                        const SizedBox(width: 12),
                                                        Expanded(
                                                          child: Column(
                                                            crossAxisAlignment: CrossAxisAlignment.start,
                                                            children: [
                                                              Row(
                                                                crossAxisAlignment: CrossAxisAlignment.start,
                                                                children: [
                                                                  Expanded(
                                                                    child: Text(
                                                                      data.vehicleType!,
                                                                      style: blackTitle,
                                                                      maxLines: 1,
                                                                      overflow: TextOverflow.ellipsis,
                                                                    ),
                                                                  ),
                                                                  if (data.isDefault == 1)
                                                                    Padding(
                                                                      padding: const EdgeInsets.only(left: 8, top: 2),
                                                                      child: Image.asset(
                                                                        "assets/images/DefaultTag.png",
                                                                        color: AppColors.redColor,
                                                                      ),
                                                                    ),
                                                                ],
                                                              ),
                                                              const SizedBox(height: 2),
                                                              Text(
                                                                data.registrationNumber!,
                                                                style: greyBody,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              const SizedBox(height: 2),
                                                              Text(
                                                                data.vehicleColor!,
                                                                style: greyBody,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                              const SizedBox(height: 2),
                                                              Text(
                                                                data.vehicleModel!,
                                                                style: greyBody,
                                                                maxLines: 1,
                                                                overflow: TextOverflow.ellipsis,
                                                              ),
                                                            ],
                                                          ),
                                                        ),
                                                      ],
                                                    ),
                                                  ),
                                                  const SizedBox(width: 8),
                                                  data.backgroundVerification == 1
                                                      ? Padding(
                                                          padding: const EdgeInsets.only(top: 2.0),
                                                          child: InkWell(
                                                            onTap: () {
                                                              showDialog(
                                                                barrierDismissible: false,
                                                                context: context,
                                                                builder: (BuildContext context) {
                                                                  return AlertDialog(
                                                                      insetPadding: const EdgeInsets.all(0),
                                                                      backgroundColor: Colors.transparent,
                                                                      elevation: 0.0,
                                                                      content: SizedBox(
                                                                        width: MediaQuery.of(context).size.width,
                                                                        child: Column(
                                                                          mainAxisAlignment: MainAxisAlignment.end,
                                                                          children: [
                                                                            Container(
                                                                              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                                                              decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(10.0))),
                                                                              child: Column(
                                                                                children: [
                                                                                  InkWell(
                                                                                    onTap: () {
                                                                                      Navigator.pop(context);
                                                                                      manageVehicleProvider.deleteVehicle(driverId, data.sId!, context);
                                                                                    },
                                                                                    child: Row(
                                                                                      mainAxisAlignment: MainAxisAlignment.center,
                                                                                      children: [
                                                                                        Text(AppStrings.deleteVehicles, style: redTitle),
                                                                                      ],
                                                                                    ),
                                                                                  ),
                                                                                ],
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                                Navigator.push(
                                                                                    context,
                                                                                    MaterialPageRoute(
                                                                                        builder: (context) => ViewDoc(
                                                                                              vehicleId: data.sId!,
                                                                                            )));
                                                                              },
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(bottom: 0),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                                                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                                                child: Center(child: Text(AppStrings.viewDocuments, style: blackTitle)),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                                manageVehicleProvider.setDefaultVehicle(driverId, data.sId!, context);
                                                                              },
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(bottom: 0),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                                                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                                                child: Center(child: Text(AppStrings.setAsDefault, style: blackTitle)),
                                                                              ),
                                                                            ),
                                                                            const SizedBox(height: 5),
                                                                            InkWell(
                                                                              onTap: () {
                                                                                Navigator.pop(context);
                                                                              },
                                                                              child: Container(
                                                                                margin: const EdgeInsets.only(bottom: 0),
                                                                                padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 15),
                                                                                decoration: const BoxDecoration(color: Colors.white, borderRadius: BorderRadius.all(Radius.circular(12.0))),
                                                                                child: Center(child: Text(AppStrings.cancel, style: blackTitle)),
                                                                              ),
                                                                            )
                                                                          ],
                                                                        ),
                                                                      ));
                                                                },
                                                              );
                                                            },
                                                            child: Icon(
                                                              Icons.more_vert,
                                                              color: AppColors.greyColor.withOpacity(0.9),
                                                            ),
                                                          ),
                                                        )
                                                      : GestureDetector(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder: (context) => NewVehicleAddDoc(
                                                                        vehicleInsuranceStatus: data.vehicleInsuranceStatus,
                                                                        registrationCertificateStatus: data.registrationCertificateStatus,
                                                                        vehicleid: data.sId)));
                                                          },
                                                          child: Text(
                                                            AppStrings.view,
                                                            style: redBody.copyWith(color: AppColors.primaryBlueStart),
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
                          text: AppStrings.addVehicles,
                          icon: Icons.add_circle,
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
