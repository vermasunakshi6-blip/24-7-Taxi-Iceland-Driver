import 'package:taxi_driver_24_7/screen/driver/menu/account_driver.dart';

import '../../../apppackages.dart';
import 'package:socket_io_client/socket_io_client.dart' ;

class DriverHomeNew extends StatefulWidget {
  const DriverHomeNew({super.key});

  @override
  DriverHomeNewState createState() => DriverHomeNewState();
}

class DriverHomeNewState extends State<DriverHomeNew>
    with WidgetsBindingObserver {
  int _currentIndex = 0;
  final List<Widget> _screens = [
    const HomePageDriver(),
    const TripHistoryDriver(isTab: true,),
    const AccountDriver(),
  ];
  Socket? socket;
  void _onTabTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  void initState() {
    super.initState();
    socketConnection();
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      socketConnection();
    } else if (state == AppLifecycleState.paused) {
      socket!.disconnect();
    }
  }

  Future<void> socketConnection() async {
    socket = io('https://taxi-api.testdrivesite.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    socket!.connect();
    socket!.onConnect((_) {
    });
  }

  @override
  Widget build(BuildContext context) {
    return PopScope(
      canPop: false,
      child: Scaffold(
        body: _screens[_currentIndex],
        bottomNavigationBar: SizedBox(
          height: 100,
          child: BottomNavigationBar(
            elevation: 30,
            currentIndex: _currentIndex,
            selectedLabelStyle: redBody,
            unselectedLabelStyle: greyBody,
            selectedItemColor: AppColors.redColor,
            unselectedItemColor: AppColors.greyColor,
            onTap: _onTabTapped,
            type: BottomNavigationBarType.fixed,
            items: [
              BottomNavigationBarItem(
                icon: _currentIndex == 0
                    ? const Image(
                        width: 25,
                        image: AssetImage(
                          'assets/images/home.png',
                        ),
                        color: AppColors.redColor,
                      )
                    : const Image(
                        width: 22,
                        image: AssetImage(
                          'assets/images/home.png',
                        ),
                        color: AppColors.greyColor,
                      ),
                label: AppStrings.home,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 1
                    ? const Image(
                        width: 25,
                        image: AssetImage(
                          'assets/images/steering.png',
                        ),
                        color: AppColors.redColor,
                      )
                    : const Image(
                        width: 22,
                        image: AssetImage(
                          'assets/images/steering.png',
                        ),
                        color: AppColors.greyColor,
                      ),
                label: AppStrings.rides,
              ),
              BottomNavigationBarItem(
                icon: _currentIndex == 2
                    ? const Image(
                        width: 25,
                        image: AssetImage(
                          'assets/images/account.png',
                        ),
                        color: AppColors.redColor,
                      )
                    : const Image(
                        width: 22,
                        image: AssetImage(
                          'assets/images/account.png',
                        ),
                        color: AppColors.greyColor,
                      ),
                label: AppStrings.account,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
