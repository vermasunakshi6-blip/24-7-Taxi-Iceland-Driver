import 'dart:developer';

import 'package:taxi_driver_24_7/model/driverridehistory_model.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:intl/intl.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';

class TripDetailsDriver extends StatefulWidget {
  const TripDetailsDriver({super.key, required this.data});
  final RideHistory data;
  @override
  State<TripDetailsDriver> createState() => _TripDetailsDriverState();
}

class _TripDetailsDriverState extends State<TripDetailsDriver> {
  GoogleMapController? mapController;
  String parcelType = '';
  String deliveryType = '';

  @override
  Widget build(BuildContext context) {
    DateTime dateTime = DateTime.parse(widget.data.createdAt!);
    DateTime endDateTime = DateTime.parse(widget.data.updatedAt!);
    DateFormat formatter = DateFormat('MMMM, d - hh:mm a');
    DateFormat formatter2 = DateFormat('hh:mm a');
    String startTime = formatter2.format(dateTime.toLocal());
    String endDateOrTime = formatter.format(endDateTime.toLocal());
    String endTime = formatter2.format(endDateTime.toLocal());
    // switch (widget.data.packageType) {
    //   case 0:
    //     parcelType = "Documents";
    //     break;
    //   case 1:
    //     parcelType = "Small Package";
    //     break;
    //   case 2:
    //     parcelType = "Big Package";
    //     break;
    //   case 3:
    //     parcelType = "Fragile Items";
    //     break;
    //   default:
    //     parcelType = "Documents";
    // }
    // switch (widget.data.deliveryType) {
    //   case 0:
    //     deliveryType = "Express Delivery";
    //     break;
    //   case 1:
    //     deliveryType = "Standard Delivery";
    //     break;

    //   default:
    //     deliveryType = 'Standard Delivery';
    // }
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Padding(
              padding: EdgeInsets.only(top: 50, left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(
                left: 30.0,
                right: 30.0,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  InkWell(
                    onTap: () {
                      Navigator.pop(context);
                    },
                    child: const Image(
                        height: 20, image: AssetImage(AppImages.arrowback)),
                  ),
                  Center(
                    child: Text(
                      AppStrings.tripDetails.toUpperCase(),
                      style: greyHeading,
                    ),
                  ),
                  const SizedBox(),
                ],
              ),
            ),
            const SizedBox(height: 40.0),
            widget.data.fromLocation == null
                ? const SizedBox()
                : Container(
                    height: MediaQuery.of(context).size.height / 4,
                    width: MediaQuery.of(context).size.width,
                    margin: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    child: widget.data.fromLocation!.coordinates!.isEmpty
                        ? const Center(
                            child: CircularProgressIndicator(
                              color: AppColors.blackColor,
                            ),
                          )
                        : ClipRRect(
                            borderRadius: BorderRadius.circular(30),
                            child: GoogleMap(
                                onMapCreated: (GoogleMapController controller) {
                                  mapController = controller;
                                  log(widget.data.fromLocation!.coordinates!
                                      .toString());
                                },
                                initialCameraPosition: CameraPosition(
                                    target: LatLng(
                                        widget
                                            .data.fromLocation!.coordinates![1],
                                        widget.data.fromLocation!
                                            .coordinates![0]),
                                    zoom: 12),
                                myLocationEnabled: false,
                                zoomGesturesEnabled: true,
                                scrollGesturesEnabled: true,
                                zoomControlsEnabled: true,
                                markers: {
                                  Marker(
                                    markerId: const MarkerId("source"),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueGreen),
                                    position: LatLng(
                                        widget
                                            .data.fromLocation!.coordinates![1],
                                        widget.data.fromLocation!
                                            .coordinates![0]),
                                  ),
                                  Marker(
                                    markerId: const MarkerId("desti"),
                                    icon: BitmapDescriptor.defaultMarkerWithHue(
                                        BitmapDescriptor.hueRed),
                                    position: LatLng(
                                        widget.data.toLocation!.coordinates![1],
                                        widget
                                            .data.toLocation!.coordinates![0]),
                                  ),
                                  widget.data.stops!.isNotEmpty &&
                                          widget.data.stops![0].stopAddress !=
                                              widget.data.toAddress
                                      ? Marker(
                                          markerId: const MarkerId("stop1"),
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                                  BitmapDescriptor.hueRed),
                                          position: LatLng(
                                            double.parse(widget
                                                .data.stops![0].stopLatitude!),
                                            double.parse(widget
                                                .data.stops![0].stopLongitude!),
                                          ),
                                        )
                                      : const Marker(
                                          markerId: MarkerId('empty')),
                                  widget.data.stops!.length >= 2
                                      ? Marker(
                                          markerId: const MarkerId("stop1"),
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                                  BitmapDescriptor.hueRed),
                                          position: widget.data.stops![0]
                                                      .stopAddress !=
                                                  widget.data.toAddress
                                              ? LatLng(
                                                  double.parse(widget.data
                                                      .stops![0].stopLatitude!),
                                                  double.parse(widget
                                                      .data
                                                      .stops![0]
                                                      .stopLongitude!),
                                                )
                                              : LatLng(
                                                  double.parse(widget.data
                                                      .stops![1].stopLatitude!),
                                                  double.parse(widget
                                                      .data
                                                      .stops![1]
                                                      .stopLongitude!),
                                                ),
                                        )
                                      : const Marker(
                                          markerId: MarkerId('empty')),
                                  widget.data.stops!.length == 3
                                      ? Marker(
                                          markerId: const MarkerId("stop1"),
                                          icon: BitmapDescriptor
                                              .defaultMarkerWithHue(
                                                  BitmapDescriptor.hueRed),
                                          position: LatLng(
                                            double.parse(widget
                                                .data.stops![2].stopLatitude!),
                                            double.parse(widget
                                                .data.stops![2].stopLongitude!),
                                          ),
                                        )
                                      : const Marker(
                                          markerId: MarkerId('empty')),
                                }),
                          ),
                  ),
            Padding(
              padding: const EdgeInsets.only(left: 20, right: 20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  const SizedBox(height: 16.0),
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(AppStrings.tripDetails, style: blackHeading),
                          Text(endDateOrTime, style: blackBody),
                          Row(
                            children: [
                              widget.data.status == 4
                                  ? const Icon(
                                      Icons.check_circle,
                                      color: AppColors.greenColor,
                                      size: 16,
                                    )
                                  : const Icon(
                                      Icons.close,
                                      color: AppColors.redColor,
                                      size: 16,
                                    ),
                              const SizedBox(
                                width: 5,
                              ),
                              Text(
                                  widget.data.status == 4
                                      ? AppStrings.completed
                                      : AppStrings.cancelled,
                                  style: blackBody),
                            ],
                          ),
                        ],
                      ),
                      Column(
                        children: [
                          Container(
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(14),
                              border: Border.all(
                                  color: AppColors.creamColor, width: 1),
                            ),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(14),
                              child: Image.network(
                                widget.data.vehicleImage!,
                                width: 85,
                                height: 85,
                                fit: BoxFit.cover,
                                errorBuilder: (context, error, stackTrace) {
                                  return Image.asset(
                                    'assets/images/car.jpeg',
                                    width: 85,
                                    height: 85,
                                    fit: BoxFit.cover,
                                  );
                                },
                              ),
                            ),
                          ),
                          Text(
                            widget.data.vehicleType!,
                            style: smallGrey,
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Divider(
                      height: 1, color: AppColors.greyColor.withOpacity(0.3)),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 10.0),
                        child: Text(AppStrings.route, style: blackHeading),
                      ),
                      Row(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset("assets/images/circlegreen.png"),
                              const SizedBox(
                                height: 70,
                                child: VerticalDivider(
                                  color: AppColors.blackColor,
                                  thickness: 0.5,
                                ),
                              ),
                              widget.data.stops!.isNotEmpty &&
                                      widget.data.stops![0].stopAddress !=
                                          widget.data.toAddress
                                  ? Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/location.png"),
                                        const SizedBox(
                                          height: 70,
                                          child: VerticalDivider(
                                            color: AppColors.blackColor,
                                            thickness: 0.5,
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              widget.data.stops!.length >= 2
                                  ? Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/location.png"),
                                        const SizedBox(
                                          height: 70,
                                          child: VerticalDivider(
                                            color: AppColors.blackColor,
                                            thickness: 0.5,
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              widget.data.stops!.length == 3
                                  ? Column(
                                      children: [
                                        Image.asset(
                                            "assets/images/location.png"),
                                        const SizedBox(
                                          height: 70,
                                          child: VerticalDivider(
                                            color: AppColors.blackColor,
                                            thickness: 0.5,
                                          ),
                                        )
                                      ],
                                    )
                                  : const SizedBox(),
                              Image.asset("assets/images/location.png"),
                            ],
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: Text(
                                  widget.data.fromAddress!,
                                  maxLines: 2,
                                  style: blackBody,
                                ),
                              ),
                              Text(startTime, style: greyBodyNormal),
                              widget.data.stops!.isNotEmpty &&
                                      widget.data.stops![0].stopAddress !=
                                          widget.data.toAddress
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: Text(
                                              widget
                                                  .data.stops![0].stopAddress!,
                                              maxLines: 2,
                                              style: blackBody),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              widget.data.stops!.length >= 2
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: Text(
                                              widget.data.stops![0]
                                                          .stopAddress !=
                                                      widget.data.toAddress
                                                  ? widget.data.stops![0]
                                                      .stopAddress!
                                                  : widget.data.stops![1]
                                                      .stopAddress!,
                                              maxLines: 2,
                                              style: blackBody),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              widget.data.stops!.length == 3
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 20,
                                        ),
                                        SizedBox(
                                          width: MediaQuery.of(context)
                                                  .size
                                                  .width /
                                              1.3,
                                          child: Text(
                                              widget
                                                  .data.stops![2].stopAddress!,
                                              maxLines: 2,
                                              style: blackBody),
                                        ),
                                      ],
                                    )
                                  : const SizedBox(),
                              const SizedBox(
                                height: 20,
                              ),
                              SizedBox(
                                width: MediaQuery.of(context).size.width / 1.3,
                                child: Text(widget.data.toAddress!,
                                    overflow: TextOverflow.ellipsis,
                                    maxLines: 2,
                                    style: blackTitle),
                              ),
                              Text(endTime, style: greyBodyNormal),
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Divider(
                      height: 1, color: AppColors.greyColor.withOpacity(0.3)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(AppStrings.paymentInfo, style: blackHeading),
                      
                    ],
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                        AppStrings.totalAmount,
                        style: blackBody,
                      ),
                      Text(
                          '${double.parse(widget.data.price!).toStringAsFixed(0)} ${widget.data.currencySymbol!}',
                          style: blackBody),
                    ],
                  ),
                  const SizedBox(height: 8.0),
                  Divider(
                      height: 1, color: AppColors.greyColor.withOpacity(0.3)),
                  const SizedBox(height: 16.0),
                  Text(
                    AppStrings.billDetails,
                    style: blackTitle,
                  ),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Text(
                       AppStrings.subtotal,
                        style: greyBodyNormal,
                      ),
                      Text(
                          "${double.parse(widget.data.price!).toStringAsFixed(0)} ${widget.data.currencySymbol!}",
                          style: blackBody),
                    ],
                  ),
                  const SizedBox(height: 12.0),
               
                  const SizedBox(height: 12.0),
                  Divider(
                      height: 1, color: AppColors.greyColor.withOpacity(0.3)),
                  const SizedBox(height: 6.0),
                  
                  const SizedBox(height: 12.0),
                 
                  const SizedBox(height: 6.0),
                  Text(AppStrings.riderInfo, style: blackHeading),
                  const SizedBox(height: 4.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Row(
                        children: [
                          widget.data.profilePicUser!.isNotEmpty
                              ? CircleAvatar(
                                  radius: 21,
                                  onBackgroundImageError:
                                      (exception, stackTrace) => const Icon(
                                    Icons.person,
                                    color: AppColors.redColor,
                                  ),
                                  backgroundImage: NetworkImage(
                                      widget.data.profilePicUser.toString(),
                                      scale: 1.0),
                                )
                              : const CircleAvatar(
                                  radius: 21,
                                  child: Icon(
                                    Icons.person,
                                    color: AppColors.redColor,
                                  ),
                                ),
                          const SizedBox(width: 8.0),
                          Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(widget.data.userId!.firstName!,
                                  style: blackBody),
                              Row(
                                children: [
                                  const Icon(
                                    Icons.star,
                                    color: AppColors.redColor,
                                    size: 16,
                                  ),
                                  Text('${widget.data.userRating}',
                                      style: blackBody),
                                ],
                              )
                            ],
                          ),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 12.0),
                  Divider(
                      height: 1, color: AppColors.greyColor.withOpacity(0.3)),
                  const SizedBox(height: 8.0),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        AppStrings.feedback,
                        style: blackHeading,
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          RatingBarIndicator(
                              rating: double.parse(
                                  widget.data.tripRating.toString()),
                              itemCount: 5,
                              unratedColor:
                                  AppColors.greyColor.withOpacity(0.3),
                              itemSize: 25.0,
                              itemBuilder: (context, _) => const Icon(
                                    Icons.star,
                                    color: Colors.amber,
                                  )),
                          Text(
                              'You rated ${widget.data.userId!.firstName} ${double.parse(widget.data.tripRating.toString()).round()}-Star',
                              style: blackBody),
                        ],
                      ),
                    ],
                  ),
                  const SizedBox(height: 6.0),


                  // widget.data.bookingRideStatus == 1
                  //     ? Text(AppStrings.packageInfo, style: blackHeading)
                  //     : const SizedBox(),




                  widget.data.bookingRideStatus == 1
                      ? const SizedBox(
                          height: 8,
                        )
                      : const SizedBox(),
                  widget.data.bookingRideStatus == 1
                      ? Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                // Image.asset(
                                //   'assets/images/parcel.png',
                                //   width: 32,
                                //   height: 32,
                                // ),
                                // const SizedBox(
                                //   width: 10,
                                // ),
                                // Expanded(
                                //   child: Column(
                                //     crossAxisAlignment:
                                //         CrossAxisAlignment.start,
                                //     children: [
                                //       Text(parcelType.toString(),
                                //           style: blackBody),
                                //       // Row(
                                //       //   children: [
                                //       //     Text(
                                //       //         widget.data.packageWeight
                                //       //             .toString(),
                                //       //         style: greyBody),
                                //       //     const SizedBox(
                                //       //       width: 5,
                                //       //     ),
                                //       //     Text(deliveryType.toString(),
                                //       //         style: greyBody),
                                //       //   ],
                                //       // ),
                                //     ],
                                //   ),
                                // ),
                              ],
                            ),
                            // Row(
                            //   children: [
                            //     const Icon(
                            //       Icons.call,
                            //       size: 25,
                            //       color: AppColors.blackColor,
                            //     ),
                            //     const SizedBox(
                            //       width: 10,
                            //     ),
                            //     // Expanded(
                            //     //   child: Column(
                            //     //     crossAxisAlignment:
                            //     //         CrossAxisAlignment.start,
                            //     //     children: [
                            //     //       Text(
                            //     //           widget.data.recipientsName.toString(),
                            //     //           style: blackBody),
                            //     //       Row(
                            //     //         children: [
                            //     //           Text(
                            //     //               widget.data.recipientsNumber
                            //     //                   .toString(),
                            //     //               style: blackBody),
                            //     //         ],
                            //     //       ),
                            //     //     ],
                            //     //   ),
                            //     // ),
                            //   ],
                            // )
                          ],
                        )
                      : const SizedBox(),
                  const SizedBox(height: 16.0),
                  const SizedBox(height: 16.0),
                  
               
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
