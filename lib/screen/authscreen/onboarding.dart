import 'package:lottie/lottie.dart';

import 'package:taxi_driver_24_7/utils/prefconstant.dart';

import '../../apppackages.dart';

class Onboarding extends StatelessWidget {
  const Onboarding({super.key});

  @override
  Widget build(BuildContext context) {
    final sharedPrefProvider = Provider.of<SharedPrefProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Stack(
        children: [
          Column(
            children: [
              const Expanded(flex: 1, child: SizedBox()),
              Expanded(
                flex: 4,
                child: Container(
                    color: Colors.white,
                  padding:
                      const EdgeInsets.symmetric(horizontal: 30.0, vertical: 5),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.end,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      const SizedBox(height: 10),
                      Expanded(
                        flex: 1,
                        child: Lottie.asset('assets/json/welcomelottie.json',
                            fit: BoxFit.fitWidth, width: double.infinity),
                      ),
                      ButtonWidget(
                        text: AppStrings.register,
                        onPressed: () {
                          sharedPrefProvider.setString(
                              PrefConstant.authType, AppStrings.register);
                          sharedPrefProvider.setString(
                              PrefConstant.userType, AppStrings.driver);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Register(),
                            ),
                          );
                        },
                        color: AppColors.primaryBlueStart,
                        gradient: AppColors.primaryBlueGradient,
                      ),
                      const SizedBox(height: 10),
                      ButtonWidgetTransparent(
                        text: AppStrings.login,
                        onPressed: () {
                          sharedPrefProvider.setString(
                              PrefConstant.authType, AppStrings.login);
                          sharedPrefProvider.setString(
                              PrefConstant.userType, AppStrings.driver);
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const Login()),
                          );
                        },
                        color: Colors.white,
                        borderAndTextColor: AppColors.primaryBlueStart,
                      ),
                      const SizedBox(height: 40),
                    ],
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 100.0),
            child: Align(
              alignment: Alignment.topCenter,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const AppLogo(),
                  const SizedBox(height: 10,),
                  Text(
                    "Choose your destination\n and we’ll drive",
                    style: greyHeading,
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
