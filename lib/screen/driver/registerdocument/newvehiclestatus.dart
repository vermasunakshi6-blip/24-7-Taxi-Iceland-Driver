import 'package:taxi_driver_24_7/apppackages.dart';

class NewVehicleStatus extends StatefulWidget {
  const NewVehicleStatus({super.key});
  @override
  State<NewVehicleStatus> createState() => NewVehicleStatusState();
}

class NewVehicleStatusState extends State<NewVehicleStatus> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      body: Container(
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
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Image(
                          image: AssetImage('assets/images/backarrow.png'),
                          width: 10,
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        '${AppStrings.welcomeDriver.toUpperCase()}',
                        style: Theme.of(context).textTheme.displayLarge,
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
                                  left: 25.0, right: 25.0, top: 40, bottom: 5),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    AppStrings.completed,
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge,
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
                                                    color:
                                                        AppColors.blackColor),
                                                borderRadius:
                                                    const BorderRadius.all(
                                                        Radius.circular(50))),
                                            child: const Center(
                                              child: Image(
                                                  width: 25,
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
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .bodySmall,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Text(
                                                AppStrings.completed,
                                                style: Theme.of(context)
                                                    .textTheme
                                                    .titleSmall,
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ),
                            const Divider(
                              color: AppColors.greyColor,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, right: 25),
                              child: Text(
                                AppStrings.submitted,
                                style: Theme.of(context).textTheme.displayLarge,
                              ),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            Padding(
                              padding:
                                  const EdgeInsets.only(left: 25.0, right: 25),
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
                                                color: AppColors.blackColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50))),
                                        child: const Center(
                                          child: Image(
                                              width: 25,
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
                                            AppStrings.drivingLicenseFront,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            AppStrings.pending,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                              padding:
                                  const EdgeInsets.only(left: 25.0, right: 25),
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
                                                color: AppColors.blackColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50))),
                                        child: const Center(
                                          child: Image(
                                              width: 25,
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
                                            AppStrings.vehicleInsurance,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            AppStrings.pending,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                              padding:
                                  const EdgeInsets.only(left: 25.0, right: 25),
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
                                                color: AppColors.blackColor),
                                            borderRadius:
                                                const BorderRadius.all(
                                                    Radius.circular(50))),
                                        child: const Center(
                                          child: Image(
                                              width: 25,
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
                                            AppStrings.registrationCertificate,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall,
                                          ),
                                          const SizedBox(
                                            height: 5,
                                          ),
                                          Text(
                                            AppStrings.pending,
                                            style: Theme.of(context)
                                                .textTheme
                                                .titleSmall,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ),
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
                            padding:
                                const EdgeInsets.only(left: 25.0, right: 25.0),
                            child: ButtonWidget(
                              text: AppStrings.next,
                              onPressed: () {},
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
      ),
    );
  }
}
