import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

class TripsFilter extends StatefulWidget {
  const TripsFilter({super.key});

  @override
  State<TripsFilter> createState() => _TripsFilterState();
}

class _TripsFilterState extends State<TripsFilter> {
  MyTripProvider? myTripProvider;
  String userId = '';
  List<String> months = [
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December'
  ];
   DateTime now = DateTime.now();


void getData()async{
SharedPreferences prefs =await SharedPreferences.getInstance();
userId = prefs.getString(PrefConstant.userid).toString();
}
 
@override
void initState(){
  super.initState();
  getData();
}


  @override
  Widget build(BuildContext context) {
    myTripProvider = Provider.of<MyTripProvider>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.clear_circled,
                  color: AppColors.greyColor,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                         CircleAvatar(
                          backgroundColor:
                              AppColors.redColor.withOpacity(0.1),
                          radius: 20,
                          child:const ImageIcon(
                            AssetImage('assets/images/sort.png'),
                            color: AppColors.redColor,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                         Text(
                          'Search Filters',
                          style: blackHeading,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  'Month',
                  style: blackTitle,
                ),
                const SizedBox(
                  height: 10,
                ),
                const SizedBox(
                  height: 10,
                ),
                Wrap(
                  children: months.map((month) {
                    int monthIndex = months.indexOf(month) + 1;
                    bool isSelected =
                        myTripProvider!.selectedMonths.contains(monthIndex);
                    return InkWell(
                      onTap: myTripProvider!.onMonthselection(monthIndex),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 22,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        margin: const EdgeInsets.only(right: 8.0, bottom: 10),
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
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Text(
                              month,
                              style: isSelected
                                    ?redBody:greyBody ,
                              overflow: TextOverflow.ellipsis,
                            ),
                            isSelected? const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Icon(Icons.cancel_outlined,color: AppColors.redColor,size: 15,),
                            ):
                            const SizedBox()
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 15,
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["Clear All", "Confirm"].map((element) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: element == 'Clear All'
                              ? () {
                                  myTripProvider!.removeUserFilter(context);
                                }
                              : () {
                                   myTripProvider!.filterPastTrips(context,userId,myTripProvider!.selectedMonths,now.year );
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            decoration: BoxDecoration(
                              color: element == 'Clear All'
                                  ? Colors.white
                                  : AppColors.redColor,
                              border: Border.all(
                                color: AppColors.redColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  element,
                                  style: element == 'Clear All'
                                      ? redTitle
                                      : whiteTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ));
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}

class TripsFilterDriver extends StatefulWidget {
  const TripsFilterDriver({super.key});

  @override
  State<TripsFilterDriver> createState() => _TripsFilterDriverState();
}

class _TripsFilterDriverState extends State<TripsFilterDriver> {
  MyTripProvider? myTripProvider;
  List<String> status = [
    'All',
    'Completed',
    'Cancelled',
    'No Show',
  ];
  List<String> distance = [
    'Short (<5mi)',
    'Medium (5-20 mi)',
    'Long (20+mi)',
  ];
  List<String> tripTypes = ['All', 'Personal', 'Shared Trip', 'Leggoo Bites','Event Rides'];
  List<String> timeRange = ['All', '24h', '7d', '30d'];
  String driverId='';

  void getData()async{
SharedPreferences prefs =await SharedPreferences.getInstance();
driverId = prefs.getString(PrefConstant.userid).toString();
}
 
@override
void initState(){
  super.initState();
  getData();
}
  @override
  Widget build(BuildContext context) {
    myTripProvider = Provider.of<MyTripProvider>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      padding: const EdgeInsets.only(left: 20),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(28), topRight: Radius.circular(28))),
      child: SingleChildScrollView(
        child: Stack(
          alignment: Alignment.topRight,
          children: [
            IconButton(
                onPressed: () {
                  Navigator.pop(context);
                },
                icon: const Icon(
                  CupertinoIcons.clear_circled,
                  color: AppColors.greyColor,
                )),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Column(
                      children: [
                         CircleAvatar(
                          backgroundColor:
                              AppColors.redColor.withOpacity(0.1),
                          radius: 20,
                          child:const ImageIcon(
                            AssetImage('assets/images/sort.png'),
                            color: AppColors.redColor,
                            size: 18,
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                         Text(
                          AppStrings.searchFilters,
                          style:blackHeading,
                        ),
                      ],
                    ),
                  ],
                ),
                const SizedBox(
                  height: 15,
                ),
                 Text(
                  AppStrings.timeRange,
                  style: blackTitle
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: timeRange.map((option) {
                    bool isSelected = (myTripProvider!.selectedtime == option);
                    return InkWell(
                      onTap: myTripProvider!.onTimeSelection(option),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 22,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 30, vertical: 6),
                        margin: const EdgeInsets.only(right: 8.0, bottom: 10),
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
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Text(
                              option,
                              style:isSelected
                                    ?redBody:greyBody ,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  AppStrings.distance,
                  style: blackTitle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: distance.map((distance) {
                    bool isSelected =
                        myTripProvider!.selectedDistance==distance;
                    return InkWell(
                      onTap: myTripProvider!.onDistanceSelection(distance),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 22,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        margin: const EdgeInsets.only(right: 8.0, bottom: 10),
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
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Text(
                              distance,
                              style: isSelected
                                    ?redBody:greyBody ,
                              overflow: TextOverflow.ellipsis,
                            ),
                            isSelected? const Padding(
                              padding: EdgeInsets.only(left: 5.0),
                              child: Icon(Icons.cancel_outlined,color: AppColors.redColor,size: 15,),
                            ):
                            const SizedBox()
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                ),
                 Text(
                  AppStrings.rideStatus,
                  style: blackTitle,
                ),
                const SizedBox(
                  height: 5,
                ),
                Wrap(
                  children: status.map((locoption) {
                    bool isSelected =
                        myTripProvider!.selectedStatus == locoption;
                    return InkWell(
                      onTap: myTripProvider!.onStatusTypeSelection(locoption),
                      child: Container(
                        height: MediaQuery.of(context).size.height / 22,
                        padding: const EdgeInsets.symmetric(
                            horizontal: 20, vertical: 6),
                        margin: const EdgeInsets.only(right: 8.0, bottom: 10),
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
                        child: Wrap(
                          crossAxisAlignment: WrapCrossAlignment.center,
                          runAlignment: WrapAlignment.center,
                          children: [
                            Text(
                              locoption,
                              style: isSelected
                                    ?redBody:greyBody ,
                              overflow: TextOverflow.ellipsis,
                            ),
                          ],
                        ),
                      ),
                    );
                  }).toList(),
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: ["Clear All", "Confirm"].map((element) {
                    return Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: element == 'Clear All'
                              ? () {
                                  myTripProvider!.removeDriverFilter(context);
                                }
                              : () {
                                myTripProvider!.filterPastTripsDriver(context,driverId,myTripProvider!.selectedStatus,myTripProvider!.selectedDistanceType,myTripProvider!.selectedtime,0);
                                },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            decoration: BoxDecoration(
                              color: element == 'Clear All'
                                  ? Colors.white
                                  : AppColors.redColor,
                              border: Border.all(
                                color: AppColors.redColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  element,
                                  style: element == 'Clear All'
                                      ? redTitle
                                      : whiteTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ));
                  }).toList(),
                ),
                const SizedBox(
                  height: 10,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
