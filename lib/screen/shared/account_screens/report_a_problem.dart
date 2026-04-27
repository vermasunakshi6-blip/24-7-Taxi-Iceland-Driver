// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';

class ReportaProblem extends StatefulWidget {
  const ReportaProblem({super.key});

  @override
  State<ReportaProblem> createState() => _ReportaProblemState();
}

class _ReportaProblemState extends State<ReportaProblem> {
  TextEditingController descriptionController = TextEditingController();
  File? imagePath;
  List<File> imageFiles = [];
  List<String> imageFilesPath = [];

  String? selectedValue = "select one";
  @override
  Widget build(BuildContext context) {
    final supportProvider =
        Provider.of<SupportLegalProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Expanded(
              flex: 1,
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                          left: 0.0, right: 0.0, top: 80.0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Expanded(
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                InkWell(
                                  onTap: () {
                                    Navigator.pop(context);
                                  },
                                  child: const Padding(
                                    padding: EdgeInsets.only(
                                        right: 30, top: 0, bottom: 0),
                                    child: Image(
                                        height: 25,
                                        image: AssetImage(
                                          AppImages.arrowback,
                                        )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 0.0),
                            child: Center(
                              child: Text(
                                AppStrings.reportproblm.toUpperCase(),
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
                    const SizedBox(
                      height: 30,
                    ),
                    Text(
                      'Report a Problem',
                      style: blackHeading,
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 8.0, top: 30),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Choose Issue',
                            style:blackBody
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 50,
                            child: DropdownButtonFormField<dynamic>(
                                value: selectedValue,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  contentPadding: const EdgeInsets.symmetric(
                                      vertical: 3.0, horizontal: 10.0),
                                  enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1),
                                  ),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1),
                                  ),
                                ),
                                items: ['select one', 'App Performance Issues', 'Log in and Account Issues', 'Payment and Billing Problems','Feature Function Bugs','Content or Display Errors','Security and Privacy Concerns','Other']
                                    .map((item) => DropdownMenuItem<dynamic>(
                                          value: item,
                                          child: Text(
                                            item,
                                            overflow: TextOverflow.ellipsis,
                                            style:item=='select one'?greyTitle: blackTitle,
                                          ),
                                        ))
                                    .toList(),
                                onChanged: (v) {
                                  setState(() {
                                    selectedValue = v;
                                  });
                                }),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(bottom: 20.0, top: 8),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                           Text(
                            'Description',
                            style:blackBody
                          ),
                          const SizedBox(
                            height: 4,
                          ),
                          SizedBox(
                            height: 100,
                            child: TextFormField(
                              controller: descriptionController,
                              keyboardType: TextInputType.text,
                              textInputAction: TextInputAction.next,
                              style: blackTitle,
                              cursorColor: AppColors.blackColor,
                              onFieldSubmitted: (v) {},
                              maxLines: 5,
                              decoration: InputDecoration(
                                hintText: 'Describe your Issue',
                                hintStyle: greyBodyNormal,
                                border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1),
                                  ),
                                contentPadding: const EdgeInsets.symmetric(
                                    vertical: 3.0, horizontal: 10.0),
                                enabledBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1)),
                                focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(10),
                                    borderSide: const BorderSide(
                                        color: AppColors.greyColor,
                                        width: 1)),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                    DottedBorder(
                      options: RoundedRectDottedBorderOptions(
                        radius: const Radius.circular(20),
                      ),
                      child: InkWell(
                        onTap: () {
                          pickImage(ImageSource.gallery);
                        },
                        child: Container(
                          height: 200,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                          ),
                          child: imagePath == null
                              ?  Column(
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                   const Icon(
                                      Icons.cloud_upload,
                                      color: AppColors.redColor,
                                      size: 40,
                                    ),
                                    Text(
                                      'Upload Images/Videos',
                                      style: greyHeading
                                    ),
                                  ],
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(20),
                                  child: Image.file(
                                    File(imagePath!.path),
                                    fit: BoxFit.fitWidth,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
            ),
            if (MediaQuery.of(context).viewInsets.bottom == 0)
              Expanded(
                flex: 0,
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 10.0),
                  child: ButtonWidget(
                    text: 'Report Issue',
                    color: AppColors.blackColor,
                    onPressed: () async {
                      if (selectedValue == 'select one') {
                        CSnackBar.showSnackBarError(
                            "Please select issue", context);
                      } else if (descriptionController.text.isEmpty) {
                        CSnackBar.showSnackBarError(
                            "Please enter description", context);
                      } else if (imagePath == null) {
                        CSnackBar.showSnackBarError(
                            "Please upload image", context);
                      } else {
                        SharedPreferences? prefs =
                            await SharedPreferences.getInstance();

                        String? userId = prefs.getString(PrefConstant.userid);

                        supportProvider.reportproblem(
                            context,
                            userId!,
                            selectedValue!,
                            descriptionController.text,
                            imageFilesPath);
                      }
                    },
                    icon: CupertinoIcons.check_mark_circled_solid,
                  ),
                ),
              )
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

        imagePath = File(pickedFile.path);
      }
    });
  }
}
