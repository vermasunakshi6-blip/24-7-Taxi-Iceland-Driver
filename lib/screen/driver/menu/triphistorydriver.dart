// ignore_for_file: use_build_context_synchronously
import 'dart:developer';
import 'package:taxi_driver_24_7/widgets/specialized/trips_filter.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';
import '../../../apppackages.dart';

class TripHistoryDriver extends StatefulWidget {
  final bool isTab;
  const TripHistoryDriver({super.key, required this.isTab});

  @override
  State<TripHistoryDriver> createState() => TripHistoryDriverState();
}

class TripHistoryDriverState extends State<TripHistoryDriver> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  final ScrollController scrollController = ScrollController();
  SharedPreferences? prefs;
  MyTripProvider? mytripProvider;
  bool isfilterApplied = false;

  Future showbottomsheet() {
    return showModalBottomSheet(
        context: context,
        shape: const RoundedRectangleBorder(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(28), topRight: Radius.circular(28))),
        isScrollControlled: true,
        builder: (context) => const FractionallySizedBox(
              heightFactor: 0.7,
              child: TripsFilterDriver(),
            ));
  }

  @override
  void initState() {
    super.initState();
    main(0);
    scrollController.addListener(() {
      if (scrollController.position.pixels ==
          scrollController.position.maxScrollExtent) {
        main(null);
      }
    });
  }

  @override
  void dispose() {
    mytripProvider!.disposeOffset();
    super.dispose();
  }

  void main(int? offset) async {
    prefs = await SharedPreferences.getInstance();
    final userId = prefs!.getString(PrefConstant.userid);
    if (userId == null || userId.isEmpty) return;
    if (!mounted) return;
    await Provider.of<MyTripProvider>(context, listen: false)
        .getRideHistory(context, userId, offset);
  }

  @override
  Widget build(BuildContext context) {
    mytripProvider = Provider.of<MyTripProvider>(context);
    return Scaffold(
        key: scaffoldKey,
        backgroundColor: Colors.white,
        body: Column(children: [
          Padding(
            padding: const EdgeInsets.only(
              top: 60,
              bottom: 0,
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
                        child: Padding(
                          padding: const EdgeInsets.only(
                              right: 30, top: 0, bottom: 0),
                          child: Image(
                            height: 20,
                            image: const AssetImage(
                              AppImages.arrowback,
                            ),
                            color: widget.isTab ? Colors.transparent : null,
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Expanded(
                  flex: 2,
                  child: Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Center(
                      child: Text(
                        AppStrings.myTrips.toUpperCase(),
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
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  AppStrings.recentTrips,
                  style: blackHeading,
                ),
                InkWell(
                  onTap: () {
                    showbottomsheet();
                  },
                  child: Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.white,
                      border: Border.all(
                        color: mytripProvider!.isFilterAppliedDriver
                            ? AppColors.redColor
                            : AppColors.greyColor,
                        width: 1,
                      ),
                      borderRadius: BorderRadius.circular(28),
                    ),
                    child: Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          AppStrings.filters,
                          style: mytripProvider!.isFilterAppliedDriver
                              ? redBody
                              : greyBody,
                          overflow: TextOverflow.ellipsis,
                        ),
                        const SizedBox(
                          width: 5,
                        ),
                        Icon(
                          CupertinoIcons.slider_horizontal_3,
                          size: 16,
                          color: mytripProvider!.isFilterAppliedDriver
                              ? AppColors.redColor
                              : AppColors.greyColor,
                        ),
                      ],
                    ),
                  ),
                )
              ],
            ),
          ),
          Container(
            height: widget.isTab
                ? MediaQuery.of(context).size.height / 1.5
                : MediaQuery.of(context).size.height / 1.3,
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: mytripProvider!.isloading &&
                    mytripProvider!.rideHistoryData.isEmpty
                ? buildShimmerList()
                : (mytripProvider!.isFilterAppliedDriver
                        ? mytripProvider!.filterRideHistory.isEmpty
                        : mytripProvider!.rideHistoryData.isEmpty)
                    ? Center(
                        child: Text(
                          AppStrings.thereIsNoRecordOfPreviousTrips,
                          style: blackTitle,
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.zero,
                        controller: scrollController,
                        physics: const AlwaysScrollableScrollPhysics(),
                        shrinkWrap: true,
                        itemCount: mytripProvider!.isFilterAppliedDriver
                            ? mytripProvider!.filterRideHistory.length
                            : mytripProvider!.rideHistoryData.length,
                        itemBuilder: (context, index) {
                          final data = mytripProvider!.isFilterAppliedDriver
                              ? mytripProvider!.filterRideHistory[index]
                              : mytripProvider!.rideHistoryData[index];
                          final dateStr = data.updatedAt ?? data.createdAt ?? '';
                          DateTime endDateTime = DateTime.now();
                          try {
                            if (dateStr.isNotEmpty) {
                              endDateTime = DateTime.parse(dateStr).toLocal();
                            }
                          } catch (_) {}
                          DateFormat formatter =
                              DateFormat('MMMM, d - hh:mm a');
                          String endDateOrTime =
                              formatter.format(endDateTime);
                          // final listLen = mytripProvider!.isFilterAppliedDriver
                          //     ? mytripProvider!.filterRideHistory.length
                          //     : mytripProvider!.rideHistoryData.length;
                          // if (index == listLen - 1 && mytripProvider!.hasMore) {
                          //   return const Padding(
                          //     padding: EdgeInsets.only(bottom: 10.0),
                          //     child: Center(
                          //       child: CupertinoActivityIndicator(
                          //         radius: 15,
                          //       ),
                          //     ),
                          //   );
                          // }
                          return Container(
                            margin: const EdgeInsets.only(bottom: 12),
                            padding: const EdgeInsets.all(16.0),
                            decoration: BoxDecoration(
                                border: Border.all(
                                    color: AppColors.creamColor, width: 1),
                                borderRadius: BorderRadius.circular(20),
                                color: Colors.white),
                            child: Column(
                              children: [
                                Row(
                                  children: [
                                    Column(
                                      children: [
                                        (data.vehicleImage != null && data.vehicleImage!.isNotEmpty)
                                            ? Container(
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  border: Border.all(
                                                      color:
                                                          AppColors.creamColor,
                                                      width: 1),
                                                ),
                                                child: ClipRRect(
                                                  borderRadius:
                                                      BorderRadius.circular(12),
                                                  child: Image.network(
                                                    data.vehicleImage!,
                                                    width: 70,
                                                    height: 70,
                                                    fit: BoxFit.cover,
                                                    errorBuilder: (context,
                                                        error, stackTrace) {
                                                      return Image.asset(
                                                        'assets/images/car.jpeg',
                                                        width: 70,
                                                        height: 70,
                                                        fit: BoxFit.cover,
                                                      );
                                                    },
                                                  ),
                                                ),
                                              )
                                            : const SizedBox(),
                                        Text(
                                          data.vehicleType ?? '—',
                                          style: smallGrey,
                                        )
                                      ],
                                    ),
                                    const SizedBox(width: 16.0),
                                    Expanded(
                                      child: InkWell(
                                        onTap: () {
                                          Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                  builder: (context) =>
                                                      TripDetailsDriver(
                                                        data: data,
                                                      )));
                                        },
                                        child: Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              data.toAddress ?? '—',
                                              maxLines: 1,
                                              style: blackTitle,
                                            ),
                                            const SizedBox(height: 2.0),
                                            Row(
                                              children: [
                                                data.status == 4
                                                    ? const Icon(
                                                        Icons.check_circle,
                                                        color: AppColors
                                                            .greenColor,
                                                        size: 16,
                                                      )
                                                    : const Icon(
                                                        Icons.cancel_rounded,
                                                        color:
                                                            AppColors.redColor,
                                                        size: 16,
                                                      ),
                                                const SizedBox(
                                                  width: 5,
                                                ),
                                                Text(
                                                  data.status == 4
                                                      ? AppStrings.completed
                                                      : AppStrings.cancelled,
                                                  maxLines: 1,
                                                  style: data.status == 4
                                                      ? greenBody
                                                      : redBody,
                                                ),
                                              ],
                                            ),
                                            const SizedBox(height: 2.0),
                                            Text(endDateOrTime,
                                                style: greyBodyNormal),
                                            const SizedBox(height: 4.0),
                                            Row(
                                              children: <Widget>[
                                                Text("${data.tripRating}★",
                                                    style: blackBody),
                                                const SizedBox(width: 8.0),
                                                Text(
                                                    "${double.parse(data.price!).toStringAsFixed(0)} ${data.currencySymbol!}",
                                                    style: greyBody),
                                              ],
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ],
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                // InkWell(
                                //   onTap: () {
                                //     log('from address :' +
                                //         data.fromAddress.toString() +
                                //         '--->>>' +
                                //         data.fromLocation!.coordinates
                                //             .toString());
                                //     log('to address :' +
                                //         data.toAddress.toString() +
                                //         '--->>>' +
                                //         data.toLocation!.coordinates
                                //             .toString());
                                //   },
                                //   child: Container(
                                //     padding: const EdgeInsets.all(8),
                                //     decoration: BoxDecoration(
                                //       color: AppColors.redColor,
                                //       borderRadius: BorderRadius.circular(48),
                                //     ),
                                //     child: Row(
                                //       mainAxisAlignment:
                                //           MainAxisAlignment.center,
                                //       children: [
                                //         Image.asset(
                                //           'assets/images/gethelp.png',
                                //           width: 15,
                                //           height: 15,
                                //         ),
                                //         const SizedBox(
                                //           width: 8,
                                //         ),
                                //         Text("Get Help (Coming soon)",
                                //             style: whiteTitle),
                                //       ],
                                //     ),
                                //   ),
                                // ),
                              ],
                            ),
                          );
                        },
                      ),
          )
        ]));
  }

  Widget buildShimmerList() {
    return ListView.builder(
      itemCount: 6,
      physics: const AlwaysScrollableScrollPhysics(),
      shrinkWrap: true,
      padding: EdgeInsets.zero,
      itemBuilder: (context, _) => Padding(
        padding: const EdgeInsets.all(5.0),
        child: Shimmer.fromColors(
          baseColor: Colors.grey[300]!,
          highlightColor: Colors.grey[100]!,
          child: Container(
            height: 150,
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(8),
            ),
          ),
        ),
      ),
    );
  }
}
