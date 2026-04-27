import 'package:interactive_bottom_sheet/interactive_bottom_sheet.dart';

import '../../../apppackages.dart';

class RateCustomer extends StatefulWidget {
  const RateCustomer({super.key});
  @override
  State<RateCustomer> createState() => RateCustomerState();
}

class RateCustomerState extends State<RateCustomer> {
  MediaQueryData? queryData;

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final driverSideGoogleMaps =
        Provider.of<DriveSideGoogleMapsProvider>(context);
    queryData = MediaQuery.of(context);
    return Scaffold(
        bottomSheet: InteractiveBottomSheet(
            options: const InteractiveBottomSheetOptions(
                initialSize: 0.55, maxSize: 0.75),
            draggableAreaOptions:  DraggableAreaOptions(
                topBorderRadius: 20,
                indicatorWidth: 120,
                indicatorColor: AppColors.greyColor.withValues(alpha: 0.5),
                indicatorHeight: 5,shadows: []),
            child: SingleChildScrollView(
              child: Padding(
                  padding: const EdgeInsets.only(top: 0, left: 10, right: 10),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.all(20.0),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  mainAxisAlignment: MainAxisAlignment.center,
                                  children: [
                                                                           driverSideGoogleMaps

                                  .userRideDetail!.userPhoto!.isNotEmpty
                              ? CircleAvatar(
                                  radius: 48,
                                  backgroundImage: NetworkImage(
                                      driverSideGoogleMaps
                                  .userRideDetail!.userPhoto!),
                                )
                              : const Text(''),
                                    Text(
                                      driverSideGoogleMaps
                                          .userRideDetail!.userName!,
                                      textAlign: TextAlign.center,
                                      style:blackHeading,
                                    ),
                                    const SizedBox(
                                      height: 10,
                                    ),
                                    RatingBarIndicator(
                                        rating: 5,
                                        itemCount: 5,
                                        itemSize: 28.0,
                                        itemBuilder: (context, _) => const Icon(
                                              Icons.star,
                                              color: AppColors.redColor,
                                            ))
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                      Text(
                                    AppStrings.howWasTrip,
                                    style:blackHeading,
                                  ),
                                  const SizedBox(height: 20,),
                      Padding(
                        padding: const EdgeInsets.only(
                            top: 0.0, left: 20.0, right: 20.0),
                        child: Column(
                          children: [
                            Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: AppColors.blackColor,
                              ),
                              child: Column(
                                children: [
                                  const SizedBox(
                                    height: 10,
                                  ),
                                  Text(
                                    AppStrings.howWasTrip,
                                    style:whiteTitle,
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                 Center(
                                    child: RatingBar(
                                      initialRating:
                                          driverSideGoogleMaps.rating,
                                      minRating: 0,
                                      direction: Axis.horizontal,
                                      allowHalfRating: false,
                                      itemCount: 5,
                                      itemSize:30.0,
                                      unratedColor: Colors.white,
                                      itemPadding: const EdgeInsets.symmetric(
                                          horizontal: 4.0),
                                      ratingWidget: RatingWidget(
                                          full: const Icon(
                                            Icons.star,
                                            color: Colors.white,
                                          ),
                                          half: const Icon(
                                            Icons.star_half,
                                            color: Colors.white,
                                          ),
                                          empty: const Icon(
                                            Icons.star_border,
                                            color: Colors.white,
                                          )),
                                      onRatingUpdate: (rating) {
                                        setState(() {
                                          driverSideGoogleMaps.rating = rating;
                                        });
                                      },
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 10,
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              height: 30,
                            ),
                            TextField(
                                controller: driverSideGoogleMaps.comments,
                                maxLines: 3,
                                keyboardType: TextInputType.name,
                                cursorColor: AppColors.greyColor,
                                style: blackTitle,
                                decoration:  InputDecoration(
                                    hintText: AppStrings.comment,
                                    hintStyle: smallGrey,
                                    border:  OutlineInputBorder(
                                      borderRadius:const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color: AppColors.greyColor.withOpacity(0.3)),
                                    ),
                                    enabledBorder: OutlineInputBorder(
                                      borderRadius:const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color:  AppColors.greyColor.withOpacity(0.3)),
                                    ),
                                    focusedBorder: OutlineInputBorder(
                                      borderRadius:const BorderRadius.all(
                                          Radius.circular(20.0)),
                                      borderSide: BorderSide(
                                          color:  AppColors.greyColor.withOpacity(0.3)),
                                    ))),
                            const SizedBox(
                              height: 40,
                            ),
                            ButtonWidget(
                              text: AppStrings.send,
                              onPressed: () {
                                driverSideGoogleMaps.sendFeedback(
                                    driverSideGoogleMaps.userRideDetaildata!.sId!,
                                    driverSideGoogleMaps
                                        .userRideDetaildata!.userId!,
                                    driverSideGoogleMaps
                                        .userRideDetaildata!.driverId!,
                                    driverSideGoogleMaps.rating.toString(),
                                    driverSideGoogleMaps.comments.text,
                                    context);
                              },
                              color: AppColors.primaryBlueStart,
                            ),
                          ],
                        ),
                      ),
                    ],
                  )),
            )),
        body: Stack(children: [
          Container(
            decoration: const BoxDecoration(
                image: DecorationImage(
                  image: AssetImage(
                      "assets/images/map.png"),
                  fit: BoxFit.contain,
                ),
                color: Colors.white),
          ),
          Positioned(
              child: Padding(
            padding: const EdgeInsets.only(top: 50, left: 4),
            child: InkWell(
              onTap: () {
                Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DriverHome()));
              },
              child: const Padding(
                padding:
                    EdgeInsets.only(right: 25, top: 25, bottom: 25, left: 25),
                child: Image(
                    width: 25,
                    image: AssetImage(AppImages.arrowback)),
              ),
            ),
          )),
        ]));
  }
}
