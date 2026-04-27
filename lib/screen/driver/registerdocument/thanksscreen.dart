import 'package:taxi_driver_24_7/apppackages.dart';

// ignore: must_be_immutable
class DocumentThanksScreen extends StatefulWidget {
  String? type;

  DocumentThanksScreen({
    super.key,
    this.type,
  });
  @override
  State<DocumentThanksScreen> createState() => DocumentThanksScreenState();
}

class DocumentThanksScreenState extends State<DocumentThanksScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30.0, right: 30.0, top: 5, bottom: 5),
          child: Column(
            children: [
              Expanded(
                flex: 3,
                child: Center(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 150,
                        ),
                        const Image(
                            width: 80,
                            height: 80,
                            image: AssetImage(
                              'assets/images/check.png',
                            )),
                        const SizedBox(
                          height: 30,
                        ),
                        if (widget.type == 'profile') ...{
                          Text(
                            AppStrings.thanksforyourphoto,
                            style: blackTitle,
                          ),
                        } else if (widget.type == 'lic') ...{
                          Text(
                            AppStrings.thankyouForUploadingDriving,
                            style: blackTitle,
                            textAlign: TextAlign.center,
                          ),
                        } else if (widget.type == 'ins') ...{
                          Text(
                            AppStrings.thankyouForUploadingVehicleInsurance,
                            style: blackTitle,
                            textAlign: TextAlign.center,
                          ),
                        } else ...{
                          Text(
                            AppStrings.thankyouForUploadingRc,
                            style: blackTitle,
                            textAlign: TextAlign.center,
                          ),
                        }
                      ],
                    ),
                  ),
                ),
              ),
              Expanded(
                flex: 2,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.end,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 20,
                    ),
                    ButtonWidgetTransparent(
                      text: AppStrings.gotoaccountstatus,
                      onPressed: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const AddDoc()));
                      },
                     color: AppColors.primaryBlueStart,
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    ButtonWidget(
                      text: AppStrings.gotonextstep,
                      onPressed: () {
                        if (widget.type == 'profile') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      const DrivingLicInfo()));
                        } else if (widget.type == 'lic') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => VehicleInsurInfo(
                                        isNewVehicel: false,
                                      )));
                        } else if (widget.type == 'ins') {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => RCInfo(
                                        isNewVehicel: false,
                                      )));
                        } else {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => const DriverHome()));
                        }
                      },
                      color: AppColors.primaryBlueStart,
                    ),
                    const SizedBox(
                      height: 40,
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
