import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';

class ConnectedSocialMedia extends StatefulWidget {
  const ConnectedSocialMedia({super.key});

  @override
  State<ConnectedSocialMedia> createState() => _ConnectedSocialMediaState();
}

class _ConnectedSocialMediaState extends State<ConnectedSocialMedia> {
  List<String> social = ['Facebook', 'Apple','Google'];
  List<IconData> icons = [Icons.facebook,Icons.apple, Icons.g_mobiledata];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
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
                        AppStrings.connectedsocialmedia.toUpperCase(),
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
              height: 50,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    height: 1,
                    color: AppColors.creamColor,
                  ),
                ),
                itemBuilder: (context, index) => Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                   Row(
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                 Icon(
                  icons[index],
                  size: 25,
                  color: AppColors.blackColor,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(
                  social[index],
                  style: blackTitle,
                ),
              ],
            ),
                    Row(
                      children: [
                        Container(
                          padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(40),
                              gradient: LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  AppColors.greenColor.withOpacity(0.1),
                                  AppColors.greenColor.withOpacity(0.04),
                                ],
                              )),
                          child: Center(
                            child: Text('Connected', style: greenBody),
                          ),
                        ),
                        
                      ],
                    )
                  ],
                ),
              ),
            ),
            
          ],
        ),
      ),
    );
  }
}