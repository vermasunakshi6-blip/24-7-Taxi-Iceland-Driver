// ignore_for_file: use_build_context_synchronously, deprecated_member_use

import 'dart:ui';

import 'package:taxi_driver_24_7/provider/driverprovider/driverside_googlemaps_provider.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import 'package:taxi_driver_24_7/model/current_ride_driver_model.dart';
import 'dart:math';
import 'package:provider/provider.dart';

class AddStopsDialog extends StatefulWidget {
  final String rideId;
  final Data rideData;
  const AddStopsDialog(
      {super.key, required this.rideId, required this.rideData});

  @override
  State<AddStopsDialog> createState() => _AddStopsDialogState();
}

class _AddStopsDialogState extends State<AddStopsDialog> {
  bool seeDetails = false;
  GoogleMapController? mapController;
  BitmapDescriptor? customIcon;
  BitmapDescriptor? customIcon1;
  BitmapDescriptor? stopIcon;
  LatLng newStop = const LatLng(30.6987547, 76.7168628);

  @override
  void initState() {
    super.initState();
    getData();
    loadCustomMarker();
  }
  double calculateDistance(double lat1, double lon1, double lat2, double lon2) {
    const double earthRadiusMiles = 3959; 

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

  void getData() {
    Provider.of<DriveSideGoogleMapsProvider>(context, listen: false)
        .getStopsOngoing(widget.rideId, context);
  }

  @override
  Widget build(BuildContext context) {
    final googlemapsProvider =
        Provider.of<DriveSideGoogleMapsProvider>(context, listen: true);
    return Container(
      width: MediaQuery.of(context).size.width,
      height: seeDetails
          ? (googlemapsProvider.stopsList.length==1?
          MediaQuery.of(context).size.height /1.5:MediaQuery.of(context).size.height /1.2)
          : MediaQuery.of(context).size.height * 0.3,
      padding: const EdgeInsets.all(15),
      decoration: const BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(20), topRight: Radius.circular(20))),
      child: seeDetails
          ? Column(
              children: [
                 CircleAvatar(
                  backgroundColor: AppColors.redColor.withOpacity(0.1),
                  radius: 20,
                  child:const Icon(
                    Icons.add_location,
                    color: AppColors.redColor,
                    size: 18,
                  ),
                ),
                Text(
                  'New Stop Requested',
                  style: blackHeading,
                ),
                Text(
                  '${widget.rideData.userName} has requested a new stop for this trip.',
                  textAlign: TextAlign.center,
                  style: greyBody,
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: AppColors.redColor,
                            child: Text(
                              '1',
                              style: smallWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              googlemapsProvider.stopsList[0].stopAddress
                                  .toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: blackBody,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage('assets/images/locationEvent.png'),
                          color: AppColors.greyColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          calculateDistance(
                                  widget.rideData.toLocation!.coordinates![1],
                                  widget.rideData.toLocation!.coordinates![0],
                                  googlemapsProvider.stopsList[0].stopLatitude!,
                                  googlemapsProvider.stopsList[0].stopLongitude!,
                                  )
                              .toStringAsFixed(2)+' mi',
                          style: greyBody,
                        )
                      ],
                    ),
                    Row(
                      children: [
                        const ImageIcon(
                          AssetImage('assets/images/clockfill.png'),
                          color: AppColors.greyColor,
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '15 minutes', // TODO change to dynamic
                          style: greyBody,
                        )
                      ],
                    )
                  ],
                ),
                googlemapsProvider.stopsList.length==2?
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    SizedBox(
                      width: 200,
                      child: Row(
                        children: [
                          CircleAvatar(
                            radius: 8,
                            backgroundColor: AppColors.redColor,
                            child: Text(
                              '2',
                              style: smallWhite,
                            ),
                          ),
                          const SizedBox(
                            width: 8,
                          ),
                          Expanded(
                            child: Text(
                              googlemapsProvider.stopsList[1].stopAddress
                                  .toString(),
                              maxLines: 3,
                              overflow: TextOverflow.ellipsis,
                              style: blackBody,
                            ),
                          )
                        ],
                      ),
                    ),
                    Row(
                      children: [
                          ImageIcon(
                        const AssetImage('assets/images/locationEvent.png'),
                          color: AppColors.greyColor.withOpacity(0.3),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          calculateDistance(
                                  googlemapsProvider.stopsList[0].stopLatitude!,
                                  googlemapsProvider.stopsList[0].stopLongitude!,
                                  googlemapsProvider.stopsList[1].stopLatitude!,
                                  googlemapsProvider.stopsList[1].stopLongitude!)
                              .toStringAsFixed(2)+' mi',
                          style: greyBody,
                        )
                      ],
                    ),
                    Row(
                      children: [
                          ImageIcon(
                        const AssetImage('assets/images/clockfill.png'),
                          color: AppColors.greyColor.withOpacity(0.3),
                          size: 20,
                        ),
                        const SizedBox(
                          width: 4,
                        ),
                        Text(
                          '15 minutes', // TODO change to dynamic
                          style: greyBody,
                        )
                      ],
                    )
                  ],
                ):const SizedBox(),
                const SizedBox(
                  height: 10,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 5,
                  width: MediaQuery.of(context).size.width,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: GoogleMap(
                        onMapCreated: (GoogleMapController controller) {
                          mapController = controller;
                        },
                        initialCameraPosition: CameraPosition(
                            target: LatLng(
                                widget.rideData.fromLocation!.coordinates![1],
                                widget.rideData.fromLocation!.coordinates![0]),
                            zoom: 12),
                        myLocationEnabled: false,
                        scrollGesturesEnabled: true,
                        zoomGesturesEnabled: true,
                        zoomControlsEnabled: true,
                        markers: {
                          Marker(
                            markerId: const MarkerId("source"),
                            icon: customIcon ??
                                BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueRed),
                            position: LatLng(
                                widget.rideData.fromLocation!.coordinates![1],
                                widget.rideData.fromLocation!.coordinates![0]),
                          ),
                          Marker(
                            markerId: const MarkerId("desti"),
                            icon: customIcon1 ??
                                BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueGreen),
                            position: LatLng(
                                widget.rideData.toLocation!.coordinates![1],
                                widget.rideData.toLocation!.coordinates![0]),
                          ),
                          Marker(
                            markerId: const MarkerId("Stop1"),
                            icon: stopIcon ??
                                BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueGreen),
                            position: LatLng(
                                googlemapsProvider.stopsList[0].stopLatitude!,
                                googlemapsProvider.stopsList[0].stopLongitude!),
                          ),
                          googlemapsProvider.stopsList.length==2?
                          Marker(
                            markerId: const MarkerId("Stop1"),
                            icon: stopIcon ??
                                BitmapDescriptor.defaultMarkerWithHue(
                                    BitmapDescriptor.hueGreen),
                            position: LatLng(
                                googlemapsProvider.stopsList[1].stopLatitude!,
                                googlemapsProvider.stopsList[1].stopLongitude!),
                          ):const Marker(markerId: MarkerId('Empty Marker')),

                        }),
                  ),
                ),
                const SizedBox(
                  height: 15,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Arrival Time',
                      style: blackTitle,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Text(
                          '4:48 PM',
                          style: blackTitle,
                        ),
                        Text(
                          '+18 Mins',
                          style: greyBody,
                        ),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 5,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Fare',
                      style: blackTitle,
                    ),
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        RichText(
                            text: TextSpan(
                                text: widget.rideData.price.toString()+ ' '+widget.rideData.currencySymbol.toString(),
                                style: blackTitle,
                                children: [
                              TextSpan(
                                  text: '(\$${widget.rideData.priceInUSD.toString()})',
                                  style: greyBody)
                            ])),
                      ],
                    )
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () async{
                           await googlemapsProvider.driverAcceptStops(
                                widget.rideId, 0, context);
                                Navigator.pop(context);
                                googlemapsProvider.currentRideDetails(context,widget.rideData.driverId.toString());
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              border: Border.all(
                                color: AppColors.redColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text('Decline',
                                    style: redTitle),
                              ],
                            ),
                          ),
                        )),
                    Padding(
                        padding: const EdgeInsets.only(right: 20.0),
                        child: InkWell(
                          onTap: () async{
                          await  googlemapsProvider.driverAcceptStops(
                                widget.rideId, 1, context);
                          },
                          child: Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 50, vertical: 10),
                            decoration: BoxDecoration(
                              color: AppColors.redColor,
                              border: Border.all(
                                color: AppColors.redColor,
                                width: 1,
                              ),
                              borderRadius: BorderRadius.circular(20),
                            ),
                            child:  Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Accept',
                                  style: whiteTitle,
                                  overflow: TextOverflow.ellipsis,
                                ),
                              ],
                            ),
                          ),
                        ))
                  ],
                ),
              ],
            )
          : Column(
              children: [
                 CircleAvatar(
                  backgroundColor: AppColors.redColor.withOpacity(0.1),
                  radius: 20,
                  child:const ImageIcon(
                    AssetImage('assets/images/screw.png'),
                    color: AppColors.redColor,
                    size: 18,
                  ),
                ),
                const SizedBox(
                  height: 20,
                ),
                Text(
                  'Ride Changes Requested',
                  style: blackHeading,
                ),
                Text(
                  '${widget.rideData.userName} has requested a new stop for this trip.',
                  textAlign: TextAlign.center,
                  style: greyBody,
                ),
                const SizedBox(
                  height: 20,
                ),
                InkWell(
                  onTap: () {
                    setState(() {
                      seeDetails = true;
                    });
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 24, vertical: 10),
                    decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(24)),
                    child: Text(
                      'See Details',
                      style:
                          whiteHeading,
                    ),
                  ),
                )
              ],
            ),
    );
  }

  Future<void> loadCustomMarker() async {
    customIcon = await _resizeMarker('assets/images/caricons.png', 100, 100);

    customIcon1 =
        await _resizeMarker('assets/images/destination.png', 100, 100);
    stopIcon =
        await _resizeMarker('assets/images/newStop.png', 50, 50);
  }

  Future<BitmapDescriptor> _resizeMarker(
      String assetPath, int width, int height) async {
    ByteData data = await rootBundle.load(assetPath);
    Codec codec = await instantiateImageCodec(
      data.buffer.asUint8List(),
      targetWidth: width, 
      targetHeight: height, 
    );
    FrameInfo fi = await codec.getNextFrame();
    ByteData? byteData =
        await fi.image.toByteData(format:ImageByteFormat.png);
    return BitmapDescriptor.fromBytes(byteData!.buffer.asUint8List());
  }
}
