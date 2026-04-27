import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class RCInfo extends StatefulWidget {
  RCInfo({super.key, required this.isNewVehicel});
  bool isNewVehicel = false;
  @override
  State<RCInfo> createState() => RCInfoState();
}

class RCInfoState extends State<RCInfo> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;
  List<File> imageFiles = [];
  List<String> imageFilesPath = [];

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
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 30.0, right: 30.0, top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Row(
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
                                image: AssetImage(AppImages.arrowback)),
                          ),
                        ),
                      ],
                    ),
                    Expanded(
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Center(
                          child: Text(
                            'Registration Certificate'.toUpperCase(), 
                            style: greyHeading,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      ),
                    ),
                    Image(
                                  height: 25,
                                  image: AssetImage(AppImages.arrowback),color: Colors.transparent,)
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
                      flex: 1,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              const SizedBox(
                                height: 30,
                              ),
                              Text(
                                AppStrings.takePhotoRc,
                                style: blackTitle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Text(
                                AppStrings.makeSureRc,
                                style: greyBodyNormal,
                                maxLines: 8,
                              ),
                              const SizedBox(
                                height: 10,
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
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Image(
                                  width: double.infinity,
                                  height: 180,
                                  image: AssetImage(
                                    'assets/images/rc_demo.png',
                                  ),
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Expanded(
                                    child: SizedBox(
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () {
                                          showOptions(widget.isNewVehicel);
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryBlueStart,
                                          padding: EdgeInsets.zero,
                                          shape: RoundedRectangleBorder(
                                            borderRadius:
                                                BorderRadius.circular(30),
                                          ),
                                        ),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            const Icon(
                                              Icons.camera_alt,
                                              color: Colors.white,
                                            ),
                                            const SizedBox(
                                              width: 15,
                                            ),
                                            Text(
                                              AppStrings.takephoto,
                                              style: whiteHeading,
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              const SizedBox(
                                height: 20,
                              ),
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

  Future<void> pickImage(ImageSource source, bool isNewVehicel) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        imageFiles.add(File(pickedFile.path));
        imageFilesPath.add(pickedFile.path);

        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => RCPhoto(
                      image: imageFiles,
                      path: imageFilesPath,
                      isNewVehicel: isNewVehicel,
                    )));
      }
    });
  }

  Future showOptions(bool isNewVehicel) async {
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
              Navigator.of(context).pop();

              pickImage(ImageSource.gallery, isNewVehicel);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.camera,
              style: blackBody,
            ),
            onPressed: () {
              Navigator.of(context).pop();

              pickImage(ImageSource.camera, isNewVehicel);
            },
          ),
        ],
      ),
    );
  }
}
