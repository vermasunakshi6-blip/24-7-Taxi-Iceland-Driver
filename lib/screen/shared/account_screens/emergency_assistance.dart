// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/add_contact_screen.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/support_and_legal.dart';
import 'package:flutter/cupertino.dart';
import 'package:url_launcher/url_launcher.dart';

class EmergencyAssistance extends StatefulWidget {
  const EmergencyAssistance({super.key});

  @override
  State<EmergencyAssistance> createState() => _EmergencyAssistanceState();
}

class _EmergencyAssistanceState extends State<EmergencyAssistance> {

 @override
  void initState() {
    super.initState();
    getData();
  }

  void getData() async {
    SharedPreferences? prefs =
                    await SharedPreferences.getInstance();
               
                String? userId = prefs.getString(PrefConstant.userid);
    await Provider.of<SupportLegalProvider>(context, listen: false)
        .getContacts(context,userId!);
  }


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
                              Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => const SupportAndLegal(),));
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
                        AppStrings.emergencyassistance.toUpperCase(),
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
              'Emergency Services',
              style: blackHeading,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 10),
              margin: const EdgeInsets.only(bottom: 30, top: 10),
              decoration: BoxDecoration(
                  color:  AppColors.creamColor.withOpacity(0.5),
                  border: Border.all(color:  AppColors.creamColor, width: 1),
                  borderRadius: BorderRadius.circular(12)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text('National Emergency Number',
                          style: blackTitle.copyWith(fontSize: 18)),
                      Text('911',
                          style: greyTitle),
                    ],
                  ),
                  GestureDetector(
                    onTap: () {
                      launchDialPad('911');
                    },
                    child: const CircleAvatar(
                      radius: 28,
                      backgroundColor: AppColors.creamColor,
                      child: Icon(
                        CupertinoIcons.phone_fill,
                        color: AppColors.redColor,
                        size: 20,
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Emergency Contacts',
                  style: blackHeading,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.add_circle,
                      color: AppColors.redColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const AddContactScreen(),
                            ));
                      },
                      child: Text(
                        'Add Contact',
                        style: redBody,
                      ),
                    )
                  ],
                ),
              ],
            ),
         supportProvider.contactData!.isNotEmpty?    SizedBox(
              height: MediaQuery.of(context).size.height / 2,
              child: ListView.builder(
                padding: const EdgeInsets.only(top: 10),
                itemCount: supportProvider.contactData!.length,
                itemBuilder: (context, index) {
                  
                  
                  return Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 12, vertical: 10),
                    margin: const EdgeInsets.only(bottom: 20),
                    decoration: BoxDecoration(
                        color:  AppColors.creamColor.withOpacity(0.5),
                        border: Border.all(
                            color:  AppColors.creamColor, width: 1),
                        borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(supportProvider.contactData![index].name!,
                                style: blackTitle.copyWith(fontSize: 18)),
                            Text(supportProvider.contactData![index].phone!,
                                style: greyTitle),
                          ],
                        ),
                        GestureDetector(
                          onTap: (){
                             launchDialPad(supportProvider.contactData![index].phone! );
                          },
                          child: const CircleAvatar(
                            radius: 28,
                            backgroundColor: AppColors.creamColor,
                            child: Icon(
                              CupertinoIcons.phone_fill,
                              color: AppColors.redColor,
                              size: 20,
                            ),
                          ),
                        ),
                      ],
                    ),
                  );
                },
              ),
            ): const SizedBox()
          ],
        ),
      ),
    );
  }

  Future<void> launchDialPad(String number) async {
    final Uri dialUri = Uri.parse("tel:$number");
    if (await canLaunchUrl(dialUri)) {
      await launchUrl(dialUri);
    } else {
      throw "Could not launch $dialUri";
    }
  }
}
