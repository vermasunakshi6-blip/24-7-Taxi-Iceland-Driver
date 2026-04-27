import '../../apppackages.dart';

class ChooseRole extends StatefulWidget {
    const ChooseRole({super.key, });

  @override
  State<ChooseRole> createState() => _ChooseRoleState();
}

class _ChooseRoleState extends State<ChooseRole> {

  SharedPreferences? sharedprefprovider;
String? authType;

  @override
  void initState() {
    super.initState();
    getData();
    }

    Future<void> getData() async {
        sharedprefprovider = await SharedPreferences.getInstance();
      authType = sharedprefprovider!.getString(PrefConstant.authType).toString();
       
    }
  
  @override
  Widget build(BuildContext context) {
    
    return Scaffold(
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                flex: 1,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.max,
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Padding(
                      padding: const EdgeInsets.only(
                        left: 30.0,
                        right: 30.0,
                      ),
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
                                    padding: EdgeInsets.only(
                                        right: 30, top: 0, bottom: 0),
                                    child: Image(
                                        height: 25,
                                        image: AssetImage(AppImages.arrowback)),
                                  ),
                                ),
                              ],
                            ),
                          ),
                          Expanded(
                            child: Padding(
                              padding: const EdgeInsets.only(left: 0.0),
                              child: Center(
                                child: Text(
                                  AppStrings.register.toUpperCase(),
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
                    const SizedBox(
                      height: 30,
                    ),
                  ],
                ),
              ),
              Expanded(
                flex: 6,
                child: Container(
                  decoration: const BoxDecoration(
                      image: DecorationImage(
                        image: AssetImage(
                            'assets/images/curvebg.png'),
                        fit: BoxFit.fill,
                      ),
                      color: Colors.transparent),
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 5, bottom: 5),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.end,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        authType == AppStrings.login
                            ? Text(
                                '${AppStrings.login} as',
                                style: blackHeading,
                              )
                            : Text(
                                '${AppStrings.register} as',
                                style:blackHeading,
                              ),
                        const SizedBox(
                          height: 20,
                        ),
                        SizedBox(
                          width: double.infinity,
                          height: 60,
                          child: ElevatedButton(
                            onPressed: () {
                              sharedprefprovider!.setString(PrefConstant.userType,
                                  UserType.driver.name.toString());
                              Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => authType ==
                                            AppStrings.login
                                        ? const Login()
                                        : const Register(),
                                  ));
                            },
                            style: ElevatedButton.styleFrom(
                              elevation: 0,
                              backgroundColor: AppColors.blackColor,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius:
                                    BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.arrow_back,
                                  color: Colors.transparent,
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 15.0),
                                  child: Text(
                                    AppStrings.drivercap,
                                    style: whiteHeading,
                                  ),
                                ),
                                Container(
                                    width: 56,
                                    height: 45,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: AppColors.blackColor,
                                    ),
                                    child: Padding(
                                      padding: const EdgeInsets.all(10.0),
                                      child:
                                          Image.asset('assets/images/steering.png',color: Colors.white,),
                                    ))
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 40,
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(top: 150.0),
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
