// ignore_for_file: must_be_immutable
import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

class RCPhoto extends StatefulWidget {
  List<File>? image;
  List<String>? path;
  bool isNewVehicel = false;
  RCPhoto({super.key, this.image, this.path, required this.isNewVehicel});
  @override
  State<RCPhoto> createState() => RCPhotoState();
}

class RCPhotoState extends State<RCPhoto> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<File> imageFiles = [];
  SharedPreferences? prefs;
  List<String> imageFilesPath = [];
  String? driverId;
  String? vehicledetailid;

  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero).then((value) {
      if (prefs?.getString(PrefConstant.userid) != null) {
        driverId = prefs!.getString(PrefConstant.userid);
        vehicledetailid = prefs!.getString(PrefConstant.vehicleId);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final docProvider = Provider.of<DocProvider>(context);
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
                    left: 0.0, right: 0.0, top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    
                    Expanded(
                      flex: 4,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Center(
                          child: Text(
                            AppStrings.registrationCert.toUpperCase(),
                            style: greyHeading,
                          ),
                        ),
                      ),
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              const SizedBox(
                                height: 50,
                              ),
                              Image.file(
                                widget.image!.first,
                                width: 200,
                                height: 200,
                                fit: BoxFit.fill,
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                AppStrings.continueUploadingRc,
                                style: blackTitle,
                                textAlign: TextAlign.center,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppStrings.takeAdditionalPhoto,
                                style: greyBodyNormal,
                                textAlign: TextAlign.center,
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
                      ),
                    ),
                    Expanded(
                        flex: 1,
                        child: Padding(
                          padding:
                              const EdgeInsets.only(left: 25.0, right: 25.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Expanded(
                                flex: 1,
                                child: SizedBox(
                                  height: 60,
                                  child: ElevatedButton(
                                    onPressed: () {
                                      showOptions();
                                    },
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.transparent,
                                      elevation: 0,
                                      padding: EdgeInsets.zero,
                                      side: const BorderSide(
                                        width: 1,
                                        color: AppColors.greyColor,
                                      ),
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(30),
                                      ),
                                    ),
                                    child: Text(
                                      AppStrings.retake,
                                      style: blackTitle,
                                    ),
                                  ),
                                ),
                              ),
                              const SizedBox(
                                width: 10,
                              ),
                              docProvider.isloading
                                  ? const Center(
                                      child: CircularProgressIndicator(
                                        color: AppColors.blackColor,
                                        strokeWidth: 1,
                                      ),
                                    )
                                  : Expanded(
                                      flex: 1,
                                      child: SizedBox(
                                        height: 60,
                                        child: ElevatedButton(
                                          onPressed: () {
                                            docProvider.addRCPhoto(
                                                context,
                                                driverId!,
                                                widget.path,
                                                widget.isNewVehicel,
                                                vehicledetailid!);
                                          },
                                          style: ElevatedButton.styleFrom(
                                            backgroundColor:
                                                AppColors.primaryBlueStart,
                                            padding: EdgeInsets.zero,
                                            shape: RoundedRectangleBorder(
                                              borderRadius:
                                                  BorderRadius.circular(30),
                                            ),
                                          ),
                                          child: Text(
                                            AppStrings.submit,
                                            style: whiteTitle,
                                          ),
                                        ),
                                      ),
                                    )
                            ],
                          ),
                        )),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Future<void> pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        imageFiles.add(File(pickedFile.path));
        imageFilesPath.add(pickedFile.path);

        widget.image = imageFiles;
        widget.path = imageFilesPath;
      }
    });
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.photoGallery,
              style: blackBody,
            ),
            onPressed: () {
                imageFiles.clear();
              imageFilesPath.clear();
              Navigator.of(context).pop();

              pickImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.camera,
              style: blackBody,
            ),
            onPressed: () {
                imageFiles.clear();
              imageFilesPath.clear();
              Navigator.of(context).pop();

              pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
