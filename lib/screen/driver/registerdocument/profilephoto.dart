// ignore_for_file: must_be_immutable, use_build_context_synchronously
import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

class ProfilePhoto extends StatefulWidget {
  List<File>? image;
  List<String>? path;
  ProfilePhoto({super.key, this.image, this.path});
  @override
  State<ProfilePhoto> createState() => ProfilePhotoState();
}

class ProfilePhotoState extends State<ProfilePhoto> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  List<File> imageFiles = [];
  SharedPreferences? prefs;
  List<String> imageFilesPath = [];
  String? driverId;
  String? vehicleId;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();

    if (prefs!.getString(PrefConstant.userid) != null) {
      driverId = prefs!.getString(PrefConstant.userid);

      vehicleId = prefs!.getString(PrefConstant.vehicleId);

      Provider.of<DocProvider>(context, listen: false)
          .getDocStatus(context,driverId!, vehicleId!);
    }
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
                                borderRadius: BorderRadius.circular(10),
                                child: Image.file(
                                  widget.image!.first,
                                  width: 180,
                                  height: 180,
                                  fit: BoxFit.fitWidth,
                                ),
                              ),
                              const SizedBox(
                                height: 50,
                              ),
                              Text(
                                AppStrings.usethisphoto,
                                style: blackTitle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.byTappingYes,
                                  style: greyBodyNormal,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.vendorCanCollect,
                                  style: greyBodyNormal,
                                ),
                              ),
                              Align(
                                alignment: Alignment.center,
                                child: Text(
                                  AppStrings.technologyThatAllows,
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
                                            docProvider.addProfilePhoto(
                                                context,
                                                driverId!,
                                                widget.path,
                                                vehicleId!);
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
                                            AppStrings.save,
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
              style: Theme.of(context).textTheme.bodyLarge,
            ),
            onPressed: () {
              Navigator.of(context).pop();

              pickImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.camera,
              style: Theme.of(context).textTheme.bodyLarge,
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
