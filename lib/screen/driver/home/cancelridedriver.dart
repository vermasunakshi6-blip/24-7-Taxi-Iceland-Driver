import 'dart:developer';
import 'package:socket_io_client/socket_io_client.dart';
import '../../../apppackages.dart';

class Cancelridedriver extends StatefulWidget {
  final String rideId;
  const Cancelridedriver({super.key, required this.rideId});
  @override
  State<Cancelridedriver> createState() => CancelridedriverState();
}

class CancelridedriverState extends State<Cancelridedriver> {
  Socket? socket;
  bool obscureText = true;
  bool isChecked = false;
  String userId = '';
  TextEditingController passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
    getData();
    socket = io('https://taxi-api.testdrivesite.com', <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });
    socket!.connect();

    socket!.onConnect((_) {
      log('Connected to Server');
    });

    socket!.onDisconnect((_) {
      log('Disconnected from server');
    });
  }

  void getData() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    userId = prefs.getString(PrefConstant.userid).toString();
  }

  @override
  Widget build(BuildContext context) {
    final googleMapsProvider =
        Provider.of<DriveSideGoogleMapsProvider>(context);
    return Scaffold(
      body: Container(
        color: Colors.white,
        child: Padding(
          padding: const EdgeInsets.only(
              left: 30.0, right: 30.0, top: 70, bottom: 5),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Image(
                          width: 25,
                          image: AssetImage('assets/images/backarrow.png')),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 15.0),
                      child: Text(
                        AppStrings.cancelride.toUpperCase(),
                        style: Theme.of(context).textTheme.displayLarge,
                      ),
                    ),
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                 Align(
                    alignment: Alignment.center,
                    child: CircleAvatar(
                      backgroundColor: AppColors.redColor.withOpacity(0.1),
                      radius: 35,
                      child:const Icon(
                        Icons.close,
                        color: AppColors.redColor,
                        size: 50,
                      ),
                    )),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  AppStrings.pleaseselectreason,
                  style: blackHeading,
                ),
                Text(
                  AppStrings.cancellingTheRide,
                  style: blackHeading,
                ),
                const SizedBox(
                  height: 40,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.4,
                  child: ListView.separated(
                    separatorBuilder: (context, index) => const SizedBox(
                      height: 10,
                    ),
                    itemCount: googleMapsProvider.cancelResons.length,
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    physics: const NeverScrollableScrollPhysics(),
                    itemBuilder: (context, index) {
                      return InkWell(
                        onTap: () {
                          googleMapsProvider.selectCancelReason(
                              googleMapsProvider.cancelResons[index]);
                        },
                        child: Container(
                          width: double.infinity,
                          height: 40,
                          decoration: BoxDecoration(
                              color: googleMapsProvider.reason ==
                                      googleMapsProvider.cancelResons[index]
                                  ? AppColors.primaryBlueStart
                                  :AppColors.greyColor.withOpacity(0.1),
                              border: Border.all(
                                  color: AppColors.greyColor.withOpacity(0.3), width: 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Center(
                              child: Text(
                            googleMapsProvider.cancelResons[index],
                            style:googleMapsProvider.reason ==
                                        googleMapsProvider.cancelResons[index]
                                    ? whiteBody:blackBody,
                          )),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 0,
                ),
                ButtonWidget(
                  text: AppStrings.done,
                  onPressed: () {
                    log('rideId && Userid --->>${widget.rideId} $userId');
                    socket!.disconnect();
                    googleMapsProvider.driverCancelRide(widget.rideId, userId,
                        googleMapsProvider.reason!, context);
                  },
                  color: AppColors.primaryBlueStart,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
