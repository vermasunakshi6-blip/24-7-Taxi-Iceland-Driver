// ignore_for_file: must_be_immutable
import 'package:taxi_driver_24_7/apppackages.dart';

import 'package:flutter/cupertino.dart';

class DrivingLicenseFront extends StatefulWidget {
  List<File>? image;
  List<String>? path;
  DrivingLicenseFront({super.key, this.image, this.path});
  @override
  State<DrivingLicenseFront> createState() => DrivingLicenseFrontState();
}

class DrivingLicenseFrontState extends State<DrivingLicenseFront> {
  var scaffoldKey = GlobalKey<ScaffoldState>();

  List<File> imageFiles = [];

  List<String> imageFilesPath = [];

  List<File> imageFilesBack = [];

  List<String> imageFilesPathBack = [];
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
                    left: 30.0, right: 30.0, top: 0, bottom: 0),
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
                      flex: 2,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Center(
                          child: Text(
                            AppStrings.drivingLicense.toUpperCase(),
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
                              ClipRRect(
                                borderRadius: BorderRadius.circular(20),
                                child: Image.file(
                                  widget.image!.first,
                                  width: 400,
                                  height: 200,
                                  fit: BoxFit.fill,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                AppStrings.wantToUsePhoto,
                                style: blackTitle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.makeSureDrivingLicense,
                                  style: greyBodyNormal,
                                ),
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
                          child: Column(
                            children: [
                              InkWell(
                                onTap: () {
                                  showOptionsBack();
                                },
                                child: Text(
                                  AppStrings.addBackPhoto,
                                  style: blackHeading,
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
                                            borderRadius:
                                                BorderRadius.circular(30),
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
                                  Expanded(
                                    flex: 1,
                                    child: SizedBox(
                                      height: 60,
                                      child: ElevatedButton(
                                        onPressed: () {},
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor: AppColors.primaryBlueStart
                                              .withOpacity(0.1),
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
          setState(() {
             widget.image = imageFiles;
        widget.path = imageFilesPath;
     
       
          });
       
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

  Future<void> pickImageBack(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        imageFilesBack.add(File(pickedFile.path));
        imageFilesPathBack.add(pickedFile.path);
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => DrivingLicenseBack(
                    image: widget.image,
                    path: widget.path,
                    imageBack: imageFilesBack,
                    imagepathback: imageFilesPathBack)));
      }
    });
  }

  Future showOptionsBack() async {
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
              pickImageBack(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.camera,
              style: blackBody,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
