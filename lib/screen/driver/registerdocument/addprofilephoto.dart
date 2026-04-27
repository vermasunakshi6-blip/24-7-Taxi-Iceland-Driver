import 'package:flutter/cupertino.dart';

import '../../../apppackages.dart';

class AddProfilePhoto extends StatefulWidget {
  const AddProfilePhoto({super.key});
  @override
  State<AddProfilePhoto> createState() => AddProfilePhotoState();
}

class AddProfilePhotoState extends State<AddProfilePhoto> {
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
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 20.0, right: 20.0, top: 0, bottom: 0),
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
                            AppStrings.profilePhoto.toUpperCase(),
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
                      flex: 4,
                      child: SingleChildScrollView(
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, top: 40, bottom: 5),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                AppStrings.takeProfilePhoto,
                                style: blackTitle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                child: Text(
                                  AppStrings.profilePhotoHelps,
                                  style: greyBodyNormal,
                                  textAlign: TextAlign.start,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    Expanded(
                        flex: 3,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 25.0, right: 25.0, bottom: 10),
                          child: Column(
                            children: [
                              const Align(
                                alignment: Alignment.center,
                                child: Image(
                                  height: 180,
                                  width: 180,
                                  image: AssetImage(
                                    'assets/images/profile_demo.png',
                                  ),
                                  fit: BoxFit.fitWidth,
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
                                          showOptions();
                                        },
                                        style: ElevatedButton.styleFrom(
                                          backgroundColor:
                                              AppColors.blackColor,
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
        Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) =>
                    ProfilePhoto(image: imageFiles, path: imageFilesPath)));
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
              style: blackTitle,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              pickImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.camera,
              style: blackTitle,
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
