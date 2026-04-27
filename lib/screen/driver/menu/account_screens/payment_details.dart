// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/watchtoearnprovider.dart';
import 'package:intl/intl.dart';

class PaymentDetails extends StatefulWidget {
  const PaymentDetails({super.key});

  @override
  State<PaymentDetails> createState() => _PaymentDetailsState();
}

class _PaymentDetailsState extends State<PaymentDetails> {
  WatchtoEarnprovider? watchtoEarnprovider;
  String selectedVal = 'Weekly';
  SharedPreferences? prefs;
  String? userId;
  var date1 = DateTime.now();
  var date2 = DateTime.now().add(const Duration(days: 7));
  final List<double> weeklyData = [4, 5, 3, 7, 6, 8, 5];
  int? touchedIndex;
  @override
  void initState() {
    super.initState();
    getdata();
  }

  String formatdate(bool format, DateTime date) {
    return format
        ? DateFormat.MMMd().format(date)
        : DateFormat.yMMMd().format(date);
  }

  void getdata() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    userId = prefs!.getString(PrefConstant.userid).toString();
    await Provider.of<WatchtoEarnprovider>(context, listen: false)
        .getCoinMarkData(context);
  }

  void updateDateRange(bool next) {
    int daysToAdd = next ? 8 : -8;
    date1 = date1.add(Duration(days: daysToAdd));
    date2 = date1.add(const Duration(days: 7));
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    watchtoEarnprovider =
        Provider.of<WatchtoEarnprovider>(context, listen: true);
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.start,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                            },
                            child: const Padding(
                              padding:
                                  EdgeInsets.only(right: 30, top: 0, bottom: 0),
                              child: Image(
                                  height: 25,
                                  image: AssetImage(
                                    AppImages.arrowback,
                                  )),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Center(
                        child: Text(
                          AppStrings.yourearnings.toUpperCase(),
                          style: greyHeading,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.only(top: 30, left: 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Your Payment Methods',
                          style: blackHeading,
                        ),
                        Text(
                          'Manage',
                          style: redTitle,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 8,
                    ),
                    SizedBox(
                      height: MediaQuery.of(context).size.height / 5,
                      child: ListView.separated(
                        itemCount: 4,
                        scrollDirection: Axis.horizontal,
                        separatorBuilder: (context, index) => const SizedBox(
                          width: 10,
                        ),
                        itemBuilder: (context, index) => Container(
                          width: MediaQuery.of(context).size.width / 1.4,
                          padding: const EdgeInsets.all(15),
                          decoration: const BoxDecoration(
                            borderRadius: BorderRadius.all(Radius.circular(20)),
                            gradient: RadialGradient(
                                center: AlignmentDirectional.bottomEnd,
                                radius: 1.2,
                                colors: [
                                  AppColors.usdGreen,
                                  AppColors.usdGreen2,
                                ]),
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    "USD Balance",
                                    style: whiteTitle,
                                  ),
                                  Text(
                                    "\$",
                                    style: whiteHeading,
                                  ),
                                ],
                              ),
                              Text(
                                "George Jacob".toUpperCase(),
                                style: whiteTitle,
                              ),
                              Text(
                                "\$283",
                                style: xLargeWhite,
                              ),
                            ],
                          ),
                        ),
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    Text(
                      'Today\'s Earnings',
                      style: blackHeading,
                    ),
                    Container(
                      height: MediaQuery.of(context).size.height / 4.8,
                      margin: const EdgeInsets.only(top: 10, bottom: 40),
                      padding: const EdgeInsets.symmetric(
                          vertical: 15, horizontal: 10),
                      decoration: BoxDecoration(
                        color: AppColors.redColor,
                        borderRadius: BorderRadius.circular(20),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          watchtoEarnprovider!.cryptocurrency != null ||
                                  watchtoEarnprovider!
                                      .cryptocurrency!.isNotEmpty
                              ? Row(
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.only(left: 20),
                                      height: 28,
                                      decoration: BoxDecoration(
                                          border: Border.all(
                                              color: Colors.white,
                                              width: 2),
                                          borderRadius:
                                              BorderRadius.circular(28)),
                                      child: Row(
                                        children: [
                                          DropdownButton<String>(
                                            iconEnabledColor:
                                                Colors.white,
                                            focusColor: Colors.white,
                                            underline: const SizedBox(),
                                            value: watchtoEarnprovider!
                                                .selectedValue,
                                            style: whiteBody,
                                            onChanged:
                                                (String? newValue) async {
                                              setState(() {
                                                watchtoEarnprovider!
                                                    .setSelectedCoin(newValue!);
                                              });
                                            },
                                            items: watchtoEarnprovider!
                                                .cryptocurrency!
                                                .map((value) {
                                              return DropdownMenuItem<String>(
                                                value: value.symbol,
                                                child: Text(
                                                  value.symbol,
                                                  style: blackBody,
                                                ),
                                              );
                                            }).toList(),
                                            selectedItemBuilder:
                                                (BuildContext context) {
                                              return watchtoEarnprovider!
                                                  .cryptocurrency!
                                                  .map((value) {
                                                return Center(
                                                  child: Text(value.symbol,
                                                      style: whiteBody),
                                                );
                                              }).toList();
                                            },
                                          ),
                                        ],
                                      ),
                                    ),
                                    // InkWell(
                                    //   onTap: () {},
                                    //   child: Text(
                                    //     'View Your Rewards',
                                    //     style: whiteTitle,
                                    //   ),
                                    // )
                                  ],
                                )
                              : const SizedBox(),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(
                                    'Your Earnings',
                                    style: whiteBody,
                                  ),
                                  Text(
                                    'BTC 10',
                                    style: whiteHeading,
                                  ),
                                  RichText(
                                    text: TextSpan(
                                        text: '\$',
                                        style: xLargeWhite,
                                        children: [
                                          TextSpan(
                                            text: '128.45',
                                            style: xLargeWhite,
                                          ),
                                        ]),
                                  ),
                                ],
                              ),
                              Image.asset(
                                'assets/images/coinstack.gif',
                                width: 82,
                                height: 80,
                              ),
                            ],
                          ),
                        ],
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Earning History',
                          style: blackHeading,
                        ),
                        Row(
                          children: [
                            Container(
                              height: 28,
                              decoration: BoxDecoration(
                                  border: Border.all(
                                      color: AppColors.blackColor, width: 2),
                                  borderRadius: BorderRadius.circular(28)),
                              child: Row(
                                children: [
                                  DropdownButton<String>(
                                    alignment: Alignment.center,
                                    iconEnabledColor: AppColors.blackColor,
                                    focusColor: AppColors.blackColor,
                                    underline: const SizedBox(),
                                    isExpanded: false,
                                    value: selectedVal,
                                    style: smallBlack,
                                    onChanged: (String? newValue) async {
                                      setState(() {
                                        selectedVal = newValue!;
                                      });
                                    },
                                    items: ['Daily', 'Weekly', 'Monthly']
                                        .map((value) {
                                      return DropdownMenuItem<String>(
                                          value: value,
                                          child: Text(value,
                                              style: blackBody));
                                    }).toList(),
                                    selectedItemBuilder:
                                        (BuildContext context) {
                                      return ['Daily', 'Weekly', 'Monthly']
                                          .map((value) {
                                        return Center(
                                          child: Text(value,
                                              style: blackTitle),
                                        );
                                      }).toList();
                                    },
                                  ),
                                ],
                              ),
                            ),
                            const SizedBox(
                              width: 8,
                            ),
                            watchtoEarnprovider!.cryptocurrency != null ||
                                    watchtoEarnprovider!
                                        .cryptocurrency!.isNotEmpty
                                ? Container(
                                    height: 28,
                                    decoration: BoxDecoration(
                                        border: Border.all(
                                            color: AppColors.blackColor,
                                            width: 2),
                                        borderRadius:
                                            BorderRadius.circular(28)),
                                    child: Row(
                                      children: [
                                        DropdownButton<String>(
                                          alignment: Alignment.centerRight,
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 0),
                                          iconEnabledColor:
                                              AppColors.blackColor,
                                          focusColor: AppColors.blackColor,
                                          underline: const SizedBox(),
                                          isExpanded: false,
                                          value: watchtoEarnprovider!
                                              .selectedValue,
                                          style: smallBlack,
                                          onChanged: (String? newValue) async {
                                            setState(() {
                                              watchtoEarnprovider!
                                                  .setSelectedCoin(newValue!);
                                            });
                                          },
                                          items: watchtoEarnprovider!
                                              .cryptocurrency!
                                              .map((value) {
                                            return DropdownMenuItem<String>(
                                              value: value.symbol,
                                              child: Text(
                                                value.symbol,
                                                style: blackBody,
                                              ),
                                            );
                                          }).toList(),
                                          selectedItemBuilder:
                                              (BuildContext context) {
                                            return watchtoEarnprovider!
                                                .cryptocurrency!
                                                .map((value) {
                                              return Center(
                                                child: Text(value.symbol,
                                                    style: blackTitle),
                                              );
                                            }).toList();
                                          },
                                        ),
                                      ],
                                    ),
                                  )
                                : const SizedBox(),
                          ],
                        ),
                      ],
                    ),
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 20.0, left: 20, right: 20),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          InkWell(
                            onTap: () {
                              updateDateRange(false);
                            },
                            child:  CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    AppColors.redColor.withOpacity(0.1),
                                child:const Icon(
                                  Icons.arrow_back_ios_new,
                                  size: 12,
                                  color: AppColors.redColor,
                                )),
                          ),
                          Column(
                            children: [
                              Text(
                                '${formatdate(true, date1)}  -  ${formatdate(false, date2)}',
                                style: greyTitle,
                              ),
                              RichText(
                                  text: TextSpan(
                                      text: '1008 BTC',
                                      style: blackHeading,
                                      children: [
                                    TextSpan(
                                      text: ' (\$108)',
                                      style: greyHeading,
                                    )
                                  ])),
                            ],
                          ),
                          InkWell(
                            onTap: () {
                              updateDateRange(true);
                            },
                            child:  CircleAvatar(
                                radius: 15,
                                backgroundColor:
                                    AppColors.redColor.withOpacity(0.1),
                                child:const Icon(
                                  Icons.arrow_forward_ios,
                                  size: 12,
                                  color: AppColors.redColor,
                                )),
                          ),
                        ],
                      ),
                    ),
                    Container(
                      margin: const EdgeInsets.only(top: 30),
                      width: double.infinity,
                      height: 300,
                      child: BarChart(
                        BarChartData(
                          alignment: BarChartAlignment.spaceAround,
                          maxY: 10,
                          barTouchData: BarTouchData(
                            touchCallback:
                                (FlTouchEvent event, barTouchResponse) {
                              setState(() {
                                if (!event.isInterestedForInteractions ||
                                    barTouchResponse == null ||
                                    barTouchResponse.spot == null) {
                                  touchedIndex = -1;
                                  return;
                                }
                                touchedIndex =
                                    barTouchResponse.spot!.touchedBarGroupIndex;
                              });
                            },
                          ),
                          titlesData: FlTitlesData(
                            show: true,
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text('M');
                                    case 1:
                                      return const Text('T');
                                    case 2:
                                      return const Text('W');
                                    case 3:
                                      return const Text('T');
                                    case 4:
                                      return const Text('F');
                                    case 5:
                                      return const Text('S');
                                    case 6:
                                      return const Text('S');
                                  }
                                  return const Text('');
                                },
                              ),
                            ),
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  return Text(value.toInt().toString());
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  return Text(value.toInt().toString());
                                },
                              ),
                            ),
                            topTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: false,
                                getTitlesWidget:
                                    (double value, TitleMeta meta) {
                                  return Text(value.toInt().toString());
                                },
                              ),
                            ),
                          ),
                          borderData: FlBorderData(show: false),
                          barGroups: weeklyData.asMap().entries.map((entry) {
                            int index = entry.key;
                            double value = entry.value;
                            bool isTouched = index == touchedIndex;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: value,
                                  color: isTouched
                                      ? AppColors.blackColor
                                      : AppColors.redColor,
                                  width: 16,
                                  borderRadius: BorderRadius.circular(4),
                                  backDrawRodData: BackgroundBarChartRodData(
                                    show: true,
                                    toY: 10,
                                    color: AppColors.greyColor.withOpacity(0.3).withOpacity(0.4),
                                  ),
                                ),
                              ],
                            );
                          }).toList(),
                          gridData: const FlGridData(
                            show: false,
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
