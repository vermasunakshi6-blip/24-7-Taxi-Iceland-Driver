// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';

class EmailSupport extends StatefulWidget {
  const EmailSupport({super.key});

  @override
  State<EmailSupport> createState() => _EmailSupportState();
}

class _EmailSupportState extends State<EmailSupport> {
  TextEditingController subjectController = TextEditingController();
  TextEditingController messageController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    final supportProvider =
        Provider.of<SupportLegalProvider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
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
                            padding:
                                EdgeInsets.only(right: 30, top: 0, bottom: 0),
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
                        AppStrings.emailsupport.toUpperCase(),
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
              'Share your Concern',
              style: blackHeading,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Subject',
                    style:blackBody
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: subjectController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: blackTitle,
                      cursorColor: AppColors.blackColor,
                      onFieldSubmitted: (v) {},
                      decoration: InputDecoration(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 3.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.greyColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.greyColor, width: 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Your Message',
                    style: blackBody
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 100,
                    child: TextFormField(
                      controller: messageController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: blackTitle,
                      cursorColor: AppColors.blackColor,
                      onFieldSubmitted: (v) {},
                      maxLines: 5,
                      decoration: InputDecoration(
                        hintText: 'Your Message',
                        hintStyle: greyBodyNormal,
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 12.0, horizontal: 10.0),
                        enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.greyColor, width: 1)),
                        focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.greyColor, width: 1)),
                      ),
                    ),
                  ),
                ],
              ),
            ),
            ButtonWidget(
              text: 'Send Message',
              color: AppColors.blackColor,
              onPressed: () async {
                SharedPreferences? prefs =
                    await SharedPreferences.getInstance();
                prefs = await SharedPreferences.getInstance();
                String? userId = prefs.getString(PrefConstant.userid);
                if (subjectController.text.isEmpty) {
                  CSnackBar.showSnackBarError("Please enter subject", context);
                } else if (messageController.text.isEmpty) {
                  CSnackBar.showSnackBarError("Please enter message", context);
                } else {
                  supportProvider.sendsupportemail(context, userId!,
                      subjectController.text, messageController.text);
                }
              },
              icon: Icons.send,
            )
          ],
        ),
      ),
    );
  }
}
