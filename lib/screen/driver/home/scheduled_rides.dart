import 'dart:math';

import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:location/location.dart';
import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/screen/driver/home/cancelridedriver.dart';
import 'package:taxi_driver_24_7/widgets/common/shimmer_loader.dart';

class ScheduleRides extends StatefulWidget {
  const ScheduleRides({
    super.key,
  });

  @override
  State<ScheduleRides> createState() => _ScheduleRidesState();
}

class _ScheduleRidesState extends State<ScheduleRides> {
  LocationData? currentLocation;
  SharedPreferences? prefs;
  String? userId;
  String? usertype;
  // CustomerVehicleTypeProvider? vehicleTypeProvider;
  DateTime? dateTime;

  DateTime? dateTimenew;
  @override
  void initState() {
    dateTime = getInitialDateTime();
    super.initState();
    getdata();
  }

  void getdata() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs!.getString(PrefConstant.userid);
    usertype = prefs!.getString(PrefConstant.currentType);
    await Provider.of<GetNearByRidesProvider>(context, listen: false)
        .getScheduleRidesDriver(context, userId!);
  }

  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusMiles = 3959; // Earth radius in miles

    double dLat = _toRadians(lat2 - lat1);
    double dLon = _toRadians(lon2 - lon1);

    double a = sin(dLat / 2) * sin(dLat / 2) +
        cos(_toRadians(lat1)) *
            cos(_toRadians(lat2)) *
            sin(dLon / 2) *
            sin(dLon / 2);

    double c = 2 * atan2(sqrt(a), sqrt(1 - a));

    return earthRadiusMiles * c;
  }

  double _toRadians(double degree) {
    return degree * pi / 180;
  }

  @override
  Widget build(BuildContext context) {
    final scheduleRidesDriver = Provider.of<GetNearByRidesProvider>(context);

    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Padding(
            padding: const EdgeInsets.only(left: 30.0, right: 30.0, top: 80.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.pop(
                          context,
                        );
                      },
                      child: const Image(
                          height: 25, image: AssetImage(AppImages.arrowback)),
                    ),
                  ],
                ),
                Expanded(
                  child: Center(
                    child: Text(
                      AppStrings.scheduledride.toUpperCase(),
                      style: greyHeading,
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const Image(
                  height: 25,
                  image: AssetImage(AppImages.arrowback),
                  color: Colors.transparent,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 30),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.only(left: 30.0),
                  child: Text(
                    AppStrings.scheduledride.toUpperCase(),
                    style: blackHeading,
                  ),
                ),
                SizedBox(
                    height: MediaQuery.of(context).size.height / 1.3,
                    child: scheduleRidesDriver.isloading
                        ? Padding(
                            padding:
                                const EdgeInsets.symmetric(horizontal: 16.0),
                            child: ShimmerLoader(
                                count: 2,
                                height:
                                    MediaQuery.of(context).size.height / 2.6),
                          )
                        : driverView(scheduleRidesDriver))
              ],
            ),
          )
        ],
      ),
    );
  }

  Widget driverView(GetNearByRidesProvider scheduleRidesProvider) {
    return scheduleRidesProvider.scheduleRidesList == null ||
            scheduleRidesProvider.scheduleRidesList!.isEmpty
        ? Center(
            child: Text(
              AppStrings.noRidesAvailable,
              style: redTitle,
            ),
          )
        : ListView.separated(
            padding: EdgeInsets.zero,
            separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
            itemCount: scheduleRidesProvider.scheduleRidesList!.length,
            itemBuilder: (context, index) {
              final data = scheduleRidesProvider.scheduleRidesList![index];
              final formattedDate = DateFormat('dd MMMM, yyyy')
                  .format(DateTime.parse(data.ridebookingDate ?? ''));

              final distance = calculateDistance(
                  data.fromLocation!.coordinates![1],
                  data.fromLocation!.coordinates![0],
                  data.toLocation!.coordinates![1],
                  data.toLocation!.coordinates![0]);
              return ListTile(
                title: Card(
                  color: Colors.white,
                  elevation: 0.5,
                  shadowColor: Colors.white,
                  shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(20),
                      side: BorderSide(
                          color: AppColors.greyColor.withOpacity(0.3),
                          width: 1)),
                  child: Padding(
                    padding: const EdgeInsets.symmetric(
                        vertical: 20, horizontal: 16),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(formattedDate, style: blackHeading),
                            Text(
                              data.ridebookingTime ?? '',
                              style: blackHeading,
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.route, style: blackHeading),
                            // Text('${distance.toStringAsFixed(3)} mi',
                            //     style: blackHeading),
                          ],
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Expanded(
                              flex: 4,
                              child: Text(
                                maxLines: 2,
                                data.fromAddress!,
                                style: greyBody,
                              ),
                            ),
                            const Expanded(
                              flex: 1,
                              child: Icon(
                                Icons.arrow_forward,
                                size: 12,
                              ),
                            ),
                            Expanded(
                              flex: 4,
                              child: Text(
                                maxLines: 2,
                                data.toAddress!,
                                style: greyBody,
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(AppStrings.totalFare, style: blackHeading),
                            Row(
                              children: [
                                Text('${data.price} ${data.currencySymbol}',
                                    style: blackHeading),
                              ],
                            ),
                          ],
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 0, top: 20),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Row(
                                  mainAxisAlignment: MainAxisAlignment.start,
                                  children: [
                                    CircleAvatar(
                                      radius: 24,
                                      backgroundColor: Colors.white,
                                      backgroundImage: NetworkImage(
                                          data.userPhoto.toString()),
                                      child: data.userPhoto != ''
                                          ? const SizedBox()
                                          : const Icon(
                                              Icons.person,
                                              color: AppColors.redColor,
                                            ),
                                    ),
                                    const SizedBox(
                                      width: 10,
                                    ),
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.start,
                                      children: [
                                        Text(
                                          data.userName.toString(),
                                          style: blackTitle,
                                        ),
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.start,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            const Icon(
                                              Icons.star,
                                              color: AppColors.redColor,
                                              size: 18,
                                            ),
                                            Text(
                                              data.userRating.toString(),
                                              style: blackTitle,
                                            ),
                                          ],
                                        ),
                                        Text(
                                          data.vehicleType.toString(),
                                          style: blackTitle,
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                                InkWell(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) => ChatScreen(
                                                  isScheduleRide: true,
                                                  rideid: data.sId,
                                                  senderid: data.userId,
                                                  reciverid: data.driverId,
                                                  receieverImage:
                                                      data.userPhoto.toString(),
                                                  recieverName:
                                                      data.userName.toString(),
                                                  source: data.fromAddress,
                                                  destination: data.toAddress,
                                                  fare: data.price! +
                                                      data.currencySymbol!,
                                                  usd: data.priceInUSD,
                                                )));
                                  },
                                  child: CircleAvatar(
                                    radius: 20,
                                    backgroundColor:
                                        AppColors.redColor.withOpacity(0.1),
                                    child: const Icon(
                                      CupertinoIcons.ellipses_bubble_fill,
                                      size: 18,
                                      color: AppColors.redColor,
                                    ),
                                  ),
                                )
                              ],
                            )),
                        const SizedBox(
                          height: 16,
                        ),
                        SizedBox(
                          height: 45,
                          child: Row(
                            children: [
                              Expanded(
                                flex: 1,
                                child: ElevatedButton(
                                  onPressed: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                Cancelridedriver(
                                                  rideId: data.sId.toString(),
                                                )));
                                  },
                                  style: ElevatedButton.styleFrom(
                                    backgroundColor: Colors.transparent,
                                    elevation: 0,
                                    padding: EdgeInsets.zero,
                                    side: const BorderSide(
                                      width: 1,
                                      color: AppColors.redColor,
                                    ),
                                    shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(30),
                                    ),
                                  ),
                                  child: Text(
                                    AppStrings.cancelride,
                                    style: redHeading,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                onTap: () {},
              );
            });
  }

//   void showDateTimeDialog(BuildContext context, String rideid,
//       CustomerVehicleTypeProvider? vehicleProvider) {
//     showDialog(
//       context: context,
//       builder: (BuildContext context) {
//         return Dialog(
//           child: Container(
//             width: double.infinity,
//             height: 400,
//             padding: const EdgeInsets.all(16),
//             child: Column(
//               children: [
//                 SizedBox(
//                   height: MediaQuery.of(context).size.height / 3,
//                   child: CupertinoDatePicker(
//                     use24hFormat: false,
//                     initialDateTime: getInitialDateTime(),
//                     backgroundColor: Colors.white,
//                     maximumYear: dateTime!.year,
//                     minimumDate: DateTime.now(),
//                     minuteInterval: 15,
//                     showDayOfWeek: true,
//                     mode: CupertinoDatePickerMode.dateAndTime,
//                     onDateTimeChanged: (dateTime) {
//                       setState(() {
//                         dateTimenew = dateTime;
//                       });
//                     },
//                   ),
//                 ),
//                 Center(
//                   child: SizedBox(
//                     width: double.infinity,
//                     child: ElevatedButton(
//                       onPressed: () {
//                         final parts = dateTimenew.toString().split(' ');

//                         final partsnew = parts[1].toString().split(':');

//                         vehicleProvider!.rescheduleRide(rideid, parts[0],
//                             partsnew[0] + ':' + partsnew[1], context);
//                       },
//                       style: ElevatedButton.styleFrom(
//                         backgroundColor: Colors.transparent,
//                         elevation: 0,
//                         padding: EdgeInsets.zero,
//                         side: const BorderSide(
//                           width: 1,
//                           color: AppColors.blackColor,
//                         ),
//                         shape: RoundedRectangleBorder(
//                           borderRadius: BorderRadius.circular(30),
//                         ),
//                       ),
//                       child: Text(
//                         'Update',
//                         style: blackTitle,
//                       ),
//                     ),
//                   ),
//                 ),
//               ],
//             ),
//           ),
//         );
//       },
//     );
//   }
}

DateTime getInitialDateTime() {
  final DateTime now = DateTime.now();
  final int roundedMinutes = (now.minute ~/ 15) * 15;
  final DateTime roundedNow =
      DateTime(now.year, now.month, now.day, now.hour, roundedMinutes);
  return roundedNow.isBefore(now)
      ? roundedNow.add(const Duration(minutes: 15))
      : roundedNow;
}
