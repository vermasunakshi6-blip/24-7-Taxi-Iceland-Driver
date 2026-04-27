// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';
import 'package:shimmer/shimmer.dart';

class EditProfileDriver extends StatefulWidget {
  const EditProfileDriver({super.key});
  @override
  State<EditProfileDriver> createState() => EditProfileDriverState();
}

class EditProfileDriverState extends State<EditProfileDriver> {
  bool obscureText = true;
  bool isChecked = false;
  List<File> imageFiles = [];
  String? userID;
  List<String> imageFilesPath = [];
  File? imagePath;
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  ConnectivityController connectivityController = ConnectivityController();
  ProfileProvider? profileProvider;
  final TextEditingController phoneNumberc = TextEditingController();
  String countryCode = '';
  bool showIcon = false;

  @override
  void initState() {
    connectivityController.init();
    super.initState();
    main();
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userID = prefs.getString(PrefConstant.userid);
    Provider.of<ProfileProvider>(context, listen: false)
        .getProfile(prefs.getString(PrefConstant.userid), context);
  }

  @override
  Widget build(BuildContext context) {
    profileProvider = Provider.of<ProfileProvider>(context);
    firstNameController.text = profileProvider!.profileDetailss!.firstName!;
    lastNameController.text = profileProvider!.profileDetailss!.lastName!;
    phoneNumberc.text = profileProvider!.profileDetailss!.phone!;
    return Scaffold(
        key: scaffoldKey,
        body: ValueListenableBuilder(
            valueListenable: connectivityController.isConnected,
            builder: (context, value, child) {
              if (value) {
                return Container(
                  color: AppColors.redColor,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Expanded(
                        flex: 1,
                        child: Padding(
                          padding: const EdgeInsets.only(
                              left: 30.0, right: 35.0, top: 0, bottom: 0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              InkWell(
                                onTap: () {
                                  Navigator.pop(context, true);
                                },
                                child: const Padding(
                                  padding: EdgeInsets.only(
                                      right: 30, top: 0, bottom: 0),
                                  child: ImageIcon(
                                    AssetImage(AppImages.arrowback),
                                    size: 25,
                                    color: Colors.white,
                                  ),
                                ),
                              ),
                              Padding(
                                padding: const EdgeInsets.only(left: 15.0),
                                child: Text(
                                  AppStrings.editprofile.toUpperCase(),
                                  style: whiteHeading,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  setState(() {
                                    isChecked = !isChecked;
                                  });
                                },
                                child: const Icon(
                                  Icons.edit,
                                  color: Colors.white,
                                ),
                              ),
                            ],
                          ),
                        ),
                      ),
                      Expanded(
                        flex: 4,
                        child: Padding(
                          padding: const EdgeInsets.only(top: 25.0),
                          child: profileProvider!.isloading
                              ? Container(
                                  padding: EdgeInsets.zero,
                                  child: Shimmer.fromColors(
                                    baseColor: Colors.grey[300]!,
                                    highlightColor: Colors.grey[100]!,
                                    child: Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.greyColor,
                                              blurRadius: 10.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0, 2.0),
                                            )
                                          ],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          )),
                                    ),
                                  ),
                                )
                              : Stack(
                                  clipBehavior: Clip.none,
                                  fit: StackFit.expand,
                                  children: [
                                    Container(
                                      width: MediaQuery.of(context).size.width,
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          boxShadow: [
                                            BoxShadow(
                                              color: AppColors.greyColor,
                                              blurRadius: 10.0,
                                              spreadRadius: 0.0,
                                              offset: Offset(2.0, 2.0),
                                            )
                                          ],
                                          borderRadius: BorderRadius.only(
                                            topLeft: Radius.circular(40),
                                            topRight: Radius.circular(40),
                                          )),
                                    ),
                                    Positioned(
                                      top: -60,
                                      left: 0,
                                      right: 0,
                                      child: Align(
                                        alignment: Alignment.center,
                                        child: SizedBox(
                                          height: 100,
                                          width: 100,
                                          child: Stack(
                                            clipBehavior: Clip.none,
                                            fit: StackFit.expand,
                                            children: [
                                              imageFiles.isNotEmpty
                                                  ? Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .greyColor
                                                              .withOpacity(0.2),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .greyColor,
                                                              width: 4),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
                                                                          100))),
                                                      child: ClipRRect(
                                                        borderRadius:
                                                            BorderRadius
                                                                .circular(60),
                                                        child: Image.file(
                                                          imagePath!,
                                                          width: 100,
                                                          fit: BoxFit.fill,
                                                        ),
                                                      ),
                                                    )
                                                  : Container(
                                                      decoration: BoxDecoration(
                                                          color: AppColors
                                                              .greyColor
                                                              .withOpacity(0.2),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .greyColor,
                                                              width: 2),
                                                          borderRadius:
                                                              const BorderRadius
                                                                  .all(Radius
                                                                      .circular(
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
                                                            child: profileProvider!
                                                                    .profileDetails!
                                                                    .profilePic!
                                                                    .isEmpty
                                                                ? const CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                )
                                                                : Image.network(
                                                                    profileProvider!
                                                                        .profileDetails!
                                                                        .profilePic!,
                                                                    fit: BoxFit
                                                                        .cover,
                                                                  )),
                                                      ),
                                                    ),
                                              isChecked
                                                  ? Positioned(
                                                      bottom: 0,
                                                      right: -25,
                                                      child: RawMaterialButton(
                                                        onPressed: () {
                                                          setState(() {});
                                                          showOptions(context);
                                                        },
                                                        elevation: 2.0,
                                                        fillColor: Colors.white,
                                                        padding:
                                                            const EdgeInsets
                                                                .all(5.0),
                                                        shape:
                                                            const CircleBorder(),
                                                        child: GestureDetector(
                                                          child: const Icon(
                                                            Icons.camera_alt,
                                                            size: 20,
                                                            color: AppColors
                                                                .blackColor,
                                                          ),
                                                        ),
                                                      ))
                                                  : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(
                                          top: 80.0,
                                          left: 20,
                                          right: 20,
                                          bottom: 0),
                                      child: SingleChildScrollView(
                                        child: SizedBox(
                                          height: 600,
                                          child: Column(
                                            crossAxisAlignment:
                                                CrossAxisAlignment.start,
                                            children: [
                                              GestureDetector(
                                                onTap: () {},
                                                child: Text(
                                                  AppStrings.firstName,
                                                  style: greyTitle,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 4.0),
                                                child: SizedBox(
                                                  height: 45,
                                                  child: TextFormField(
                                                    enabled: isChecked
                                                        ? true
                                                        : false,
                                                    style: blackTitle,
                                                    controller:
                                                        firstNameController,
                                                    textInputAction:
                                                        TextInputAction.next,
                                                    cursorColor:
                                                        AppColors.greyColor,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      disabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  width: 1)),
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 3.0,
                                                              horizontal: 10.0),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  width: 1)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  width: 1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Text(
                                                AppStrings.lastName,
                                                style: greyTitle,
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Padding(
                                                padding: const EdgeInsets.only(
                                                    left: 4.0, right: 4.0),
                                                child: SizedBox(
                                                  height: 45,
                                                  child: TextFormField(
                                                    enabled: isChecked
                                                        ? true
                                                        : false,
                                                    style: blackTitle,
                                                    controller:
                                                        lastNameController,
                                                    textInputAction:
                                                        TextInputAction.done,
                                                    cursorColor:
                                                        AppColors.greyColor,
                                                    keyboardType:
                                                        TextInputType.name,
                                                    decoration: InputDecoration(
                                                      contentPadding:
                                                          const EdgeInsets
                                                              .symmetric(
                                                              vertical: 3.0,
                                                              horizontal: 10.0),
                                                      disabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  width: 1)),
                                                      enabledBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  width: 1)),
                                                      focusedBorder: OutlineInputBorder(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          borderSide:
                                                              const BorderSide(
                                                                  color: AppColors
                                                                      .greyColor,
                                                                  width: 1)),
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppStrings.email,
                                                    style: greyTitle,
                                                  ),
                                                  isChecked
                                                      ? InkWell(
                                                          onTap: () {
                                                            Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                    builder:
                                                                        (context) =>
                                                                            EditEmailID(
                                                                              oldEmail: profileProvider!.profileDetails!.email.toString(),
                                                                            )));
                                                          },
                                                          child: Text(
                                                              AppStrings.changeEmail,
                                                              style: redTitle),
                                                        )
                                                      : const SizedBox()
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Container(
                                                height: 50,
                                                margin: const EdgeInsets.only(
                                                    bottom: 10),
                                                padding: const EdgeInsets.only(
                                                    left: 10),
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            10),
                                                    border: Border.all(
                                                        color:
                                                            AppColors.greyColor,
                                                        width: 1)),
                                                child: Row(
                                                  children: [
                                                    Text(
                                                      profileProvider!
                                                          .profileDetails!.email
                                                          .toString(),
                                                      style: blackTitle,
                                                    ),
                                                  ],
                                                ),
                                              ),
                                              Text(
                                                AppStrings.useEmailToRecieveMessages,
                                                style: smallGrey,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Row(
                                                mainAxisAlignment:
                                                    MainAxisAlignment
                                                        .spaceBetween,
                                                children: [
                                                  Text(
                                                    AppStrings.code,
                                                    style: greyTitle,
                                                  ),
                                                  Text(
                                                    AppStrings.phonenumber,
                                                    style: greyTitle,
                                                  ),
                                                  const Icon(
                                                    Icons.lock,
                                                    color: AppColors.greyColor,
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              Row(
                                                children: [
                                                  Expanded(
                                                    flex: 2,
                                                    child: Container(
                                                      height: 50,
                                                      decoration: BoxDecoration(
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(10),
                                                          border: Border.all(
                                                              color: AppColors
                                                                  .greyColor,
                                                              width: 1)),
                                                      child: CountryCodePicker(
                                                          enabled: false,
                                                          padding:
                                                              EdgeInsets.zero,
                                                          showDropDownButton:
                                                              true,
                                                          onChanged: (code) {
                                                            setState(() {
                                                              countryCode = code
                                                                  .dialCode
                                                                  .toString();
                                                            });
                                                          },
                                                          textStyle: blackTitle,
                                                          initialSelection:
                                                              profileProvider!
                                                                  .profileDetails!
                                                                  .countryCode,
                                                          favorite: const [
                                                            '+1',
                                                            'US'
                                                          ],
                                                          showCountryOnly: true,
                                                          showFlag: true,
                                                          alignLeft: false,
                                                          flagWidth: 20,
                                                          showFlagDialog: true,
                                                          comparator: (a, b) =>
                                                              b.name!.compareTo(
                                                                  a.name!),
                                                          onInit: (code) {
                                                            countryCode =
                                                                profileProvider!
                                                                    .profileDetails!
                                                                    .countryCode!;
                                                          }),
                                                    ),
                                                  ),
                                                  const SizedBox(
                                                    width: 10,
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: TextFormField(
                                                      controller: phoneNumberc,
                                                      enabled: false,
                                                      textInputAction:
                                                          TextInputAction.done,
                                                      keyboardType:
                                                          TextInputType.number,
                                                      style: blackTitle,
                                                      onChanged: (value) {
                                                        if (showIcon) {
                                                          setState(() {
                                                            showIcon = false;
                                                          });
                                                        }
                                                      },
                                                      onEditingComplete: () {
                                                        setState(() {
                                                          showIcon = true;
                                                        });
                                                      },
                                                      decoration:
                                                          InputDecoration(
                                                        contentPadding:
                                                            const EdgeInsets
                                                                .symmetric(
                                                                vertical: 3.0,
                                                                horizontal:
                                                                    10.0),
                                                        disabledBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppColors
                                                                        .greyColor,
                                                                    width: 1)),
                                                        focusedBorder: OutlineInputBorder(
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        10),
                                                            borderSide:
                                                                const BorderSide(
                                                                    color: AppColors
                                                                        .greyColor,
                                                                    width: 1)),
                                                        suffixIcon: showIcon
                                                            ? const Icon(
                                                                Icons
                                                                    .check_circle_outline,
                                                                color: AppColors
                                                                    .blackColor)
                                                            : const Icon(
                                                                Icons
                                                                    .check_circle_outline,
                                                                color: Colors
                                                                    .transparent),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const SizedBox(
                                                height: 10,
                                              ),
                                              Text(
                                                AppStrings.usePhoneToRecieveNotifications,
                                                style: smallGrey,
                                              ),
                                              const SizedBox(
                                                height: 20,
                                              ),
                                              Expanded(
                                                flex: 1,
                                                child: Column(
                                                  mainAxisAlignment:
                                                      MainAxisAlignment.center,
                                                  crossAxisAlignment:
                                                      CrossAxisAlignment.center,
                                                  children: [
                                                    isChecked
                                                        ? ButtonWidget(
                                                            text:
                                                                AppStrings.savechanges,
                                                            onPressed: () {
                                                              profileProvider!
                                                                  .editProfileWithoutImage(
                                                                userID,
                                                                firstNameController
                                                                    .text,
                                                                lastNameController
                                                                    .text,
                                                                context,
                                                              );
                                                            },
                                                            color: AppColors
                                                                .primaryBlueStart,
                                                          )
                                                        : const SizedBox()
                                                  ],
                                                ),
                                              ),
                                            ],
                                          ),
                                        ),
                                      ),
                                    )
                                  ],
                                ),
                        ),
                      ),
                    ],
                  ),
                );
              } else {
                return const NetworkAlertBar();
              }
            }));
  }

  Future showOptions(BuildContext context) async {
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

  Future<void> pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        imageFiles.add(File(pickedFile.path));
        imageFilesPath.add(pickedFile.path);

        imagePath = File(pickedFile.path);

        profileProvider!.editProfile(userID, firstNameController.text,
            lastNameController.text, context, imageFilesPath);
      }
    });
  }
}
