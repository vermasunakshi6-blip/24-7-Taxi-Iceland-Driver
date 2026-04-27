import 'package:taxi_driver_24_7/apppackages.dart';

class AppPrefs extends StatefulWidget {
  const AppPrefs({super.key});

  @override
  State<AppPrefs> createState() => _AppPrefsState();
}

class _AppPrefsState extends State<AppPrefs> {
  String selectedTheme = '';
  List<String> themes = ['Light', 'Dark', 'Auto'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
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
                        AppStrings.apprefs.toUpperCase(),
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
            Padding(
              padding: const EdgeInsets.only(top: 30, left: 0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  Text(
                    'Theme',
                    style: blackHeading,
                  ),
                  const SizedBox(height: 15,),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: themes.map((theme) {
                      bool isSelected = theme == selectedTheme;
                      return InkWell(
                        onTap: () {
                          setState(() {
                            selectedTheme = theme;
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 8.0),
                          child: Container(
                            width: MediaQuery.of(context).size.width/3.6 ,
                            height: MediaQuery.of(context).size.height / 22,
                            padding: const EdgeInsets.symmetric(
                                horizontal: 20, vertical: 6),
                            decoration: BoxDecoration(
                              color: isSelected
                                  ? AppColors.redColor.withOpacity(0.1)
                                  : Colors.white,
                              border: Border.all(
                                color: isSelected
                                    ? AppColors.redColor
                                    : AppColors.greyColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(28),
                            ),
                            child: Center(
                              child: Text(
                                theme,
                                style: isSelected
                                    ? redBody
                                    : greyBody,
                                overflow: TextOverflow.ellipsis,
                              ),
                            ),
                          ),
                        ),
                      );
                    }).toList(),
                  ),
                  Container(
                    height: MediaQuery.of(context).size.height / 16,
                    margin: const EdgeInsets.only(top: 30),
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: AppColors.greyColor)),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text('Language and Region',
                            style: blackTitle),
                        InkWell(
                          onTap: () {
                          },
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Text('🇺🇸 USA',
                                  style: blackTitle),
                              const SizedBox(
                                width: 8,
                              ),
                              const Icon(
                                Icons.arrow_forward_ios,
                                color: AppColors.blackColor,
                                size: 10,
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
