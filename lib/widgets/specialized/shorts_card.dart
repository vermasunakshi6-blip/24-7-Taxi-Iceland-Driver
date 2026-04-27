import 'package:taxi_driver_24_7/provider/customerprovider/watchtoearnprovider.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:taxi_driver_24_7/model/watch_to_earn_model.dart';
import 'package:shared_preferences/shared_preferences.dart';

class ShortsCard extends StatefulWidget {
  final Data shortsData;
  const ShortsCard({
    super.key,
    required this.shortsData,
  });

  @override
  State<ShortsCard> createState() => _ShortsCardState();
}

class _ShortsCardState extends State<ShortsCard> {
  WatchtoEarnprovider? watchtoEarnprovider;
  SharedPreferences? prefs;
  String userId = '';

  @override
  void initState() {
    getdata();
    super.initState();
  }
  void getdata() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    userId = prefs!.getString(PrefConstant.userid).toString();
  }

  @override
  Widget build(BuildContext context) {
    watchtoEarnprovider =
        Provider.of<WatchtoEarnprovider>(context, listen: true);
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          height: 220,
          padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 5),
          decoration: BoxDecoration(
            color: AppColors.redColor,
            borderRadius: const BorderRadius.all(Radius.circular(8)),
            image: DecorationImage(
                image: NetworkImage(widget.shortsData.thumbnailUrl!,),
                fit: BoxFit.cover),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const CircleAvatar(
                  radius: 12,
                  backgroundColor: AppColors.blackColor,
                  child: Icon(
                    Icons.share,
                    size: 16,
                    color: Colors.white,
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  const SizedBox(),
                  Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 2),
                      decoration: BoxDecoration(
                          color: AppColors.blackColor,
                          borderRadius: BorderRadius.circular(4)),
                      child: Text(
                        widget.shortsData.duration.toString(),
                        style:whiteBody,
                      )),
                ],
              ),
            ],
          ),
        ),
        Padding(
          padding:
              const EdgeInsets.only(top: 8, bottom: 12, left: 4, right: 4),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                widget.shortsData.title.toString(),
                style: blackBody,
              ),
              Row(
                children: [
                  Text(
                  '${widget.shortsData.reward![0].currency.toString()} ',
                    style: greyBody,
                  ),
                  Text(widget.shortsData.reward![0].amount.toString(),
                      style:blackBody),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }
}
