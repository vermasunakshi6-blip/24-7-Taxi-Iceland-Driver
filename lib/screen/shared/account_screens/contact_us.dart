import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/email_support.dart';
import 'package:flutter_svg/svg.dart';
import 'package:url_launcher/url_launcher.dart';

class ContactUs extends StatelessWidget {
  const ContactUs({super.key});

  @override
  Widget build(BuildContext context) {
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
                        AppStrings.contactus.toUpperCase(),
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
              'Contact Us',
              style: blackHeading,
            ),
            const SizedBox(
              height: 8,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.5,
              child: ListView.separated(
                separatorBuilder: (context, index) =>const SizedBox(
                  height: 20,
                ) ,
                padding: EdgeInsets.zero,
                itemCount: 2,
                itemBuilder: (context, index) {
                  final contactus = ['Email Support', 'Call us'];

                  final images = [
                    'assets/images/emailAddress.svg',
                    'assets/images/phoneNumber.svg'
                  ];

                  return InkWell(
                    onTap: index == 0
                        ? () {
                            Navigator.push(
                                context,
                                MaterialPageRoute(
                                  builder: (context) => const EmailSupport(),
                                ));
                          }
                        : () {
                            launchDialPad('191');
                          },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 12, vertical: 10),
                      decoration: BoxDecoration(
                          color:  AppColors.creamColor.withOpacity(0.15),
                          border: Border.all(
                              color: AppColors.creamColor, width: 1),
                          borderRadius: BorderRadius.circular(12)),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            children: [
                              SvgPicture.asset(
                                images[index],
                                width: 24,
                                height: 24,
                                color: AppColors.redColor,
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Text(contactus[index],
                                  style: blackHeading),
                            ],
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
           )
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
