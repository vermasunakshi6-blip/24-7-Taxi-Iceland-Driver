// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';

class AddContactScreen extends StatefulWidget {
  const AddContactScreen({super.key});

  @override
  State<AddContactScreen> createState() => AddContactScreenState();
}

class AddContactScreenState extends State<AddContactScreen> {
  TextEditingController nameController = TextEditingController();
  TextEditingController contactController = TextEditingController();


 


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
                       'Add Emergency Contact'.toUpperCase(),
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
            
            Padding(
              padding: const EdgeInsets.only(bottom: 8.0, top: 30),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Name',
                    style: blackBody
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: nameController,
                      keyboardType: TextInputType.text,
                      textInputAction: TextInputAction.next,
                      style: blackTitle,
                      cursorColor: AppColors.greyColor,
                      onFieldSubmitted: (v) {},
                     
                      decoration: InputDecoration(
                        hintText: 'Your Name',
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
            Padding(
              padding: const EdgeInsets.only(bottom: 40.0, top: 8),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                   Text(
                    'Contact',
                    style:blackBody
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 50,
                    child: TextFormField(
                      controller: contactController,
                      keyboardType: TextInputType.phone,
                      textInputAction: TextInputAction.next,
                      style: blackTitle,
                      cursorColor: AppColors.greyColor,
                      onFieldSubmitted: (v) {},
                     
                      decoration: InputDecoration(
                        hintText: 'Your Contact',
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
              text: 'Add Contact',
              color: AppColors.blackColor,
              onPressed: () async {
                SharedPreferences? prefs =
                    await SharedPreferences.getInstance();
                prefs = await SharedPreferences.getInstance();
                String? userId = prefs.getString(PrefConstant.userid);
                if (nameController.text.isEmpty) {
                  CSnackBar.showSnackBarError("Please enter name", context);
                } else if (contactController.text.isEmpty) {
                  CSnackBar.showSnackBarError("Please enter contact", context);
                } else {
                 supportProvider.addcontact(context, userId!,
                     nameController.text, contactController.text);
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
