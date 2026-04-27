import '../../apppackages.dart';

class NavDrawerDriver extends StatefulWidget {
  const NavDrawerDriver({super.key});
  @override
  State<NavDrawerDriver> createState() => NavDrawerDriverState();
}

class NavDrawerDriverState extends State<NavDrawerDriver> {
  SharedPreferences? prefs;
  String? userID, deviceToken;
  @override
  void initState() {
    super.initState();
    getData();
  }

  Future<void> getData() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    userID = prefs!.getString(PrefConstant.userid);
    deviceToken = prefs!.getString(PrefConstant.token);
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);

    return Drawer(
      backgroundColor: Colors.white,
      child: Column(
        children: [
          DrawerHeader(
            child: Row(
              children: [
                const SizedBox(
                  width: 10,
                ),
                InkWell(
                  onTap: () {},
                  child: Container(
                    width: 90.0,
                    height: 90.0,
                    decoration: BoxDecoration(
                      color: AppColors.greyColor.withOpacity(0.3),
                      image: const DecorationImage(
                        image: AssetImage('assets/images/roundgrey.png'),
                        fit: BoxFit.cover,
                      ),
                      borderRadius:
                          const BorderRadius.all(Radius.circular(50.0)),
                      border: Border.all(
                        color: AppColors.blackColor,
                        width: 3.0,
                      ),
                    ),
                    child: ClipRRect(
                        borderRadius: BorderRadius.circular(60),
                        child: profileProvider
                                .profileDetails!.profilePic!.isEmpty
                            ? const CircularProgressIndicator(
                                  color: AppColors.blackColor,
                                )
                            : Image.network(
                                profileProvider.profileDetails!.profilePic!)),
                  ),
                ),
                const SizedBox(
                  width: 10,
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "${profileProvider.profileDetailss!.firstName!}${profileProvider.profileDetailss!.lastName!}",
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    RatingBarIndicator(
                        rating: 5,
                        itemCount: 5,
                        itemSize: 20.0,
                        itemBuilder: (context, _) => const Icon(
                              Icons.star,
                              color:AppColors.yellow,
                            ))
                  ],
                ),
              ],
            ),
          ),
          Expanded(
            child: ListView(
              padding: EdgeInsets.zero,
              children: <Widget>[
                ListTile(
                  leading: const Image(
                      width: 30, image: AssetImage('assets/images/mytrip.png')),
                  title: Text(
                    AppStrings.home,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const DriverHome()));
                  },
                ),
                ListTile(
                  leading: const Image(
                      width: 30, image: AssetImage('assets/images/mytrip.png')),
                  title: Text(
                    AppStrings.myTrips,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const TripHistoryDriver(isTab: false,)));
                  },
                ),
                ListTile(
                  leading: const Image(
                      width: 30,
                      image: AssetImage('assets/images/paymenticon.png')),
                  title: Text(
                    AppStrings.manageyourvehicle,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const ManageVehicle()));
                  },
                ),
                ListTile(
                  leading: const Image(
                      width: 30,
                      image: AssetImage('assets/images/paymenticon.png')),
                  title: Text(
                    AppStrings.wallet,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const WalletScreen()));
                  },
                ),
                ListTile(
                  leading: const Image(
                      width: 25,
                      image: AssetImage('assets/images/aboutusicon.png')),
                  title: Text(
                    AppStrings.aboutus,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AboutUsDriver(type: AppStrings.aboutus)));
                  },
                ),
                ListTile(
                  leading: const Image(
                      width: 23,
                      image: AssetImage('assets/images/termsicon.png')),
                  title: Text(
                    AppStrings.terms,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();

                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AboutUsDriver(type: AppStrings.terms)));
                  },
                ),
                ListTile(
                  leading: const Image(
                      width: 23,
                      image: AssetImage('assets/images/privacypolicy.png')),
                  title: Text(
                    AppStrings.privacy,
                    style:blackTitle,
                  ),
                  trailing: const Image(
                      width: 12,
                      image: AssetImage('assets/images/arrowforward.png')),
                  onTap: () {
                    Navigator.of(context).pop();
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                            builder: (context) =>
                                AboutUsDriver(type: AppStrings.privacy)));
                  },
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(15.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Text(
                  AppStrings.useappas,
                  style: Theme.of(context).textTheme.bodyLarge,
                ),
                const SizedBox(
                  width: 10,
                ),
              ],
            ),
          ),
          Container(
            color: AppColors.blackColor,
            width: double.infinity,
            height: 0.1,
          ),
          SizedBox(
            height: 100,
            child: Padding(
              padding: const EdgeInsets.only(top: 10),
              child: ListTile(
                leading: const Image(
                    width: 23,
                    image: AssetImage('assets/images/logouticon.png')),
                title: Text(
                  AppStrings.logout,
                  style:blackTitle,
                ),
                trailing: const Image(
                    width: 12,
                    image: AssetImage('assets/images/arrowforward.png')),
                onTap: () {
                  Navigator.of(context).pop();

                  showDialog(
                    context: context,
                    builder: (_) =>
                        LogoutDialog(userid: userID, deviceToken: deviceToken),
                  );
                },
              ),
            ),
          ),
        ],
      ),
    );
  }
}
