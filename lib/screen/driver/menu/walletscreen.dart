// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/screen/driver/menu/transaction_history.dart';
import 'package:geekyants_flutter_gauges/geekyants_flutter_gauges.dart';
import 'package:intl/intl.dart';

import '../../../apppackages.dart';

class WalletScreen extends StatefulWidget {
  const WalletScreen({super.key});
  @override
  State<WalletScreen> createState() => WalletScreenState();
}

class WalletScreenState extends State<WalletScreen>
    with SingleTickerProviderStateMixin {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isToggled = false;
  String driverId = "";
  bool showEarnings = true;
  String selectedType = 'Daily';
  final List<double> weeklyData = [4, 5, 3, 7, 6, 8, 5];
  final List<double> rewardData = [5, 5, 4, 2, 2, 1, 2];
  final List<double> tipsData = [1, 0, 3, 1, 2, 1, 3];
  int? touchedIndex;
  DateTime _focusedDay = DateTime.now();
  DateTime? _selectedDay;
  PageController scrollController = PageController();
  int pageIndex = 0;
  Animation<double>? _animation;
  AnimationController? _animationController;
  SharedPreferences? prefs;

  String selectedItem = 'Current Month';
  var date1 = DateTime.now();
  var date2 = DateTime.now().add(const Duration(days: 7));

  @override
  void initState() {
    super.initState();
    main();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _animationController = AnimationController(
        vsync: this,
        duration: const Duration(seconds: 2),
      );

      _animation = Tween<double>(begin: 0, end: 1.0).animate(
        CurvedAnimation(
          parent: _animationController!,
          curve: Curves.easeInOut,
        ),
      );

      _animationController!.forward();
    });
  }

  void main() async {
    prefs = await SharedPreferences.getInstance();
    driverId = prefs!.getString(PrefConstant.userid) ?? "";
    Provider.of<WalletScreenProvider>(context, listen: false)
        .main(context, driverId);
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletScreenProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: SingleChildScrollView(
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.only(top: 60.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {},
                      child: const Image(
                          height: 25,
                          color: Colors.transparent,
                          image: AssetImage(AppImages.arrowback)),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(right: 50.0),
                      child: Center(
                        child: Text(
                          AppStrings.wallet.toUpperCase(),
                          style: greyHeading,
                        ),
                      ),
                    ),
                    const SizedBox()
                    // Container(
                    //   padding: const EdgeInsets.only(left: 20),
                    //   width: 90,
                    //   height: 28,
                    //   decoration: BoxDecoration(
                    //       border:
                    //           Border.all(color: AppColors.blackColor, width: 2),
                    //       borderRadius: BorderRadius.circular(28)),
                    //   child: DropdownButton<String>(
                    //     underline: const SizedBox(),
                    //     value: walletProvider.selectedItem,
                    //     onChanged: (String? newValue) {
                    //       setState(() {
                    //         walletProvider.selectedItem = newValue!;
                    //         walletProvider.main(context, driverId);
                    //       });
                    //     },
                    //     items: walletProvider.cryptocurrency.map((value) {
                    //       return DropdownMenuItem<String>(
                    //         value: value,
                    //         child: Text(
                    //           value,
                    //           style: smallBlack,
                    //         ),
                    //       );
                    //     }).toList(),
                    //   ),
                    // ),
                  ],
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                children: [
                  Text(
                    "Wallet Summary",
                    style: blackHeading,
                  ),
                ],
              ),
              const SizedBox(
                height: 10,
              ),
              SizedBox(
                height: MediaQuery.of(context).size.height / 4.5,
                child: PageView.builder(
                  itemCount: 4,
                  onPageChanged: (value) {
                    setState(() {
                      pageIndex = value;
                    });
                  },
                  controller: scrollController,
                  scrollDirection: Axis.horizontal,
                  itemBuilder: (context, index) => Padding(
                    padding: const EdgeInsets.only(right: 8.0),
                    child: Container(
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
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                            "George Jacob",
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
              ),
              const SizedBox(
                height: 15,
              ),
              SizedBox(
                height: 5,
                width: double.infinity,
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    4,
                    (index) => Padding(
                      padding: const EdgeInsets.only(right: 10),
                      child: Container(
                        width: pageIndex == index ? 28 : 5,
                        height: 5,
                        decoration: BoxDecoration(
                          color: pageIndex == index
                              ? AppColors.blackColor
                              : AppColors.greyColor.withOpacity(0.3),
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 25,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Earning Summary",
                    style: blackHeading,
                  ),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showEarnings = true;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      decoration: BoxDecoration(
                          color: showEarnings
                              ? AppColors.redColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: showEarnings
                                  ? AppColors.redColor
                                  : AppColors.greyColor)),
                      child: Text('Earnings',
                          style: showEarnings
                              ? whiteBody
                              : blackBody),
                    ),
                  ),
                  const SizedBox(width: 5),
                  GestureDetector(
                    onTap: () {
                      setState(() {
                        showEarnings = false;
                      });
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          vertical: 10, horizontal: 40),
                      decoration: BoxDecoration(
                          color: !showEarnings
                              ? AppColors.redColor
                              : Colors.white,
                          borderRadius: BorderRadius.circular(30),
                          border: Border.all(
                              color: !showEarnings
                                  ? AppColors.redColor
                                  : AppColors.greyColor)),
                      child: Text('Rewards',
                          style: !showEarnings
                              ? whiteBody
                              : blackBody),
                    ),
                  ),
                ],
              ),
              showEarnings
                  ? const SizedBox()
                  :
                  // mytripProvider!.ridesLength == 0 ||
                  //                   _animation == null ||
                  //                   _animation!.value.isNaN
                  //               ? const SizedBox()
                  //               :
                  Padding(
                      padding: const EdgeInsets.only(top: 10.0),
                      child: Container(
                        padding: 2 < 5
                            //  _animation!.value < 5
                            ? const EdgeInsets.only(
                                left: 20, right: 10, top: 10, bottom: 10)
                            : const EdgeInsets.symmetric(
                                vertical: 10, horizontal: 15),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(
                                color: AppColors.blackColor.withOpacity(0.1))),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            Text("🎉 You’re on your way to rewards!",
                                style: blackTitle),
                            const SizedBox(height: 20),
                            AnimatedBuilder(
                              animation: _animation!,
                              builder: (context, child) {
                                return LinearGauge(
                                  start: 0,
                                  end: 200,
                                  steps: 100,
                                  rulers: RulerStyle(
                                      rulerPosition: RulerPosition.bottom,
                                      showPrimaryRulers: false,
                                      showSecondaryRulers: false,
                                      primaryRulerColor: AppColors.blackColor,
                                      secondaryRulerColor: AppColors.greyColor,
                                      textStyle: smallGrey),
                                  customLabels: const [
                                    CustomRulerLabel(text: "", value: 0),
                                    CustomRulerLabel(
                                      text: '20 of 100',
                                      // '${_animation!.value.toInt()} of 100',
                                      value: 20,
                                      // value: _animation!.value,
                                    ),
                                    CustomRulerLabel(
                                        text: "100\nRides", value: 100),
                                    CustomRulerLabel(
                                        text: "200\nRides", value: 200),
                                  ],
                                  rangeLinearGauge: [
                                    RangeLinearGauge(
                                      start: 0,
                                      end: 20,
                                      // end: _animation!.value,
                                      color: AppColors.redColor,
                                      edgeStyle: LinearEdgeStyle.bothCurve,
                                    ),
                                  ],
                                  pointers: const [
                                    Pointer(
                                      value: 0,
                                      shape: PointerShape.circle,
                                      isInteractive: false,
                                      color: AppColors.redColor,
                                      showLabel: true,
                                      width: 15,
                                      height: 15,
                                    ),
                                    Pointer(
                                      value: 20,
                                      // value: _animation!.value,
                                      shape: PointerShape.circle,
                                      isInteractive: false,
                                      color: AppColors.redColor,
                                      showLabel: true,
                                    ),
                                    Pointer(
                                      value: 100,
                                      width: 15,
                                      height: 15,
                                      shape: PointerShape.circle,
                                      color: 20 < 100
                                          // color: _animation!.value < 100
                                          ? AppColors.greyColor
                                          : AppColors.redColor,
                                      showLabel: true,
                                    ),
                                    Pointer(
                                      value: 200,
                                      width: 15,
                                      height: 15,
                                      shape: PointerShape.circle,
                                      color: 20 < 200
                                          // color: _animation!.value < 200
                                          ? AppColors.greyColor
                                          : AppColors.redColor,
                                      showLabel: true,
                                    ),
                                  ],
                                  enableGaugeAnimation: true,
                                  animationType: Curves.decelerate,
                                  gaugeOrientation: GaugeOrientation.horizontal,
                                  linearGaugeBoxDecoration:
                                      const LinearGaugeBoxDecoration(
                                    backgroundColor: AppColors.greyColor,
                                  ),
                                );
                              },
                            ),
                            const SizedBox(height: 20),
                          ],
                        ),
                      ),
                    ),
              const SizedBox(height: 20),
              Container(
                height: MediaQuery.of(context).size.height / 3,
                padding:
                    const EdgeInsets.symmetric(horizontal: 15, vertical: 24),
                width: double.infinity,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.creamColor.withOpacity(0.15),
                    border: Border.all(
                        color: AppColors.blackColor.withOpacity(0.1)),
                    boxShadow: [
                      BoxShadow(
                          color: AppColors.blackColor.withOpacity(0.12),
                          offset: const Offset(0, 0),
                          blurRadius: 20,
                          blurStyle: BlurStyle.outer)
                    ]),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              showEarnings ? "Total Earnings" : 'Total Rewards',
                              style: blackBody,
                            ),
                            SizedBox(
                              height: 20,
                              child: DropdownButton<String>(
                                underline: const SizedBox(),
                                iconSize: 20,
                                iconEnabledColor: AppColors.redColor,
                                value: selectedItem,
                                onChanged: (String? newValue) {
                                  setState(() {
                                    selectedItem = newValue!;
                                    walletProvider.main(context, driverId);
                                  });
                                },
                                items: ['Current Month', 'Next Month']
                                    .map((value) {
                                  return DropdownMenuItem<String>(
                                    value: value,
                                    child: Text(
                                      value,
                                      style: smallBlack,
                                    ),
                                  );
                                }).toList(),
                              ),
                            ),
                          ],
                        ),
                        RichText(
                            text: TextSpan(
                                text: '0.0058 BTC',
                                style: blackHeading,
                                children: [
                              TextSpan(
                                  text: ' (\$123)', style: blackHeading)
                            ])),
                      ],
                    ),
                    Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                showEarnings
                                    ? "Available Earnings"
                                    : "Available Rewards",
                                style: greyBody),
                            RichText(
                                text: TextSpan(
                                    text: '0.0058 BTC',
                                    style: greyBody,
                                    children: [
                                  TextSpan(
                                      text: ' (\$123)',
                                      style: blackBody)
                                ])),
                          ],
                        ),
                        const Divider(),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                                showEarnings
                                    ? "Pending Earnings"
                                    : "Pending Rewards",
                                style: greyBody),
                            RichText(
                                text: TextSpan(
                                    text: '0.0058 BTC',
                                    style: greyBody,
                                    children: [
                                  TextSpan(
                                      text: ' (\$123)',
                                      style: blackBody)
                                ])),
                          ],
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: AppColors.redColor,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Withdraw Funds',
                                  style: whiteTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 8,
                        ),
                        SizedBox(
                          height: 50,
                          child: ElevatedButton(
                            onPressed: () {},
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors.white,
                              padding: EdgeInsets.zero,
                              shape: RoundedRectangleBorder(
                                side: const BorderSide(
                                    color: AppColors.redColor, width: 1),
                                borderRadius: BorderRadius.circular(30),
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'Convert to Crypto',
                                  style: redTitle,
                                ),
                              ],
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 20),
              Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    3,
                    (index) {
                      final text = ['Daily', 'Weekly', 'Monthly'];
                      bool selected = selectedType == text[index];
                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            selectedType = text[index];
                          });
                        },
                        child: Padding(
                          padding: const EdgeInsets.only(right: 5.0),
                          child: Container(
                            padding: EdgeInsets.symmetric(
                                vertical: 10, horizontal: index == 0 ? 20 : 12),
                            decoration: BoxDecoration(
                              color: selected
                                  ? AppColors.redColor
                                  : Colors.white,
                              borderRadius: BorderRadius.circular(30),
                              border: Border.all(
                                color: selected
                                  ? AppColors.redColor
                                  : AppColors.greyColor.withOpacity(0.3),
                              )
                            ),
                            child: Text(text[index],
                                style: selected
                                    ? whiteBody
                                    : greyBody),
                          ),
                        ),
                      );
                    },
                  )),
              const SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: TableCalendar(
                  focusedDay: _focusedDay,
                  startingDayOfWeek: StartingDayOfWeek.monday,
                  daysOfWeekStyle: DaysOfWeekStyle(
                    dowTextFormatter: (date, locale) =>
                        DateFormat.E(locale).format(date).substring(0, 2),
                  ),
                  firstDay: DateTime.utc(2020, 1, 1),
                  lastDay: DateTime.utc(2030, 12, 31),
                  selectedDayPredicate: (day) {
                    return isSameDay(_selectedDay, day);
                  },
                  onDaySelected: (selectedDay, focusedDay) {
                    setState(() {
                      _selectedDay = selectedDay;
                      _focusedDay = focusedDay;
                    });
                  },
                  calendarStyle: CalendarStyle(
                      isTodayHighlighted: false,
                      selectedTextStyle: whiteTitle,
                      selectedDecoration: const BoxDecoration(
                        color: AppColors.redColor,
                        shape: BoxShape.circle,
                      ),
                      outsideDaysVisible: false,
                      defaultTextStyle: blackTitle,
                      weekendTextStyle: blackTitle),
                  headerStyle: HeaderStyle(
                    formatButtonVisible: false,
                    titleCentered: true,
                    leftChevronIcon: const Icon(Icons.chevron_left,
                        color: AppColors.greyColor),
                    rightChevronIcon: const Icon(Icons.chevron_right,
                        color: AppColors.greyColor),
                    headerPadding: const EdgeInsets.symmetric(vertical: 8),
                    titleTextStyle: blackHeading,
                    titleTextFormatter: (date, locale) {
                      return DateFormat('MMMM yyyy').format(date) +
                          '\n 0.001 BTC';
                    },
                  ),
                  calendarFormat: CalendarFormat.week,
                ),
              ),
              Container(
                padding: const EdgeInsets.all(20.0),
                width: double.infinity,
                height: 300,
                decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(20),
                    color: AppColors.creamColor.withOpacity(0.15)),
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: 10,
                    barTouchData: BarTouchData(
                      touchTooltipData: BarTouchTooltipData(
                          fitInsideHorizontally: true,
                          fitInsideVertically: false,
                          getTooltipColor: (group) => Colors.white,
                          tooltipBorder:  BorderSide(
                            color: AppColors.greyColor.withOpacity(0.3),
                          ),
                          getTooltipItem: (BarChartGroupData group,
                              int groupIndex,
                              BarChartRodData rod,
                              int rodIndex) {
                            return showEarnings
                                ? BarTooltipItem(
                                    '${DateFormat('EEEE, dd MMM, yyyy').format(_focusedDay)}\n',
                                    smallGrey,
                                    textAlign: TextAlign.left,
                                    children: [
                                        TextSpan(
                                            text: 'Rides:',
                                            style: smallRed),
                                        TextSpan(
                                            text:
                                                '${weeklyData[groupIndex]} BTC',
                                            style: smallGrey),
                                        TextSpan(
                                            text: ' (\$11.4)\n',
                                            style: smallGrey),
                                        TextSpan(
                                            text:
                                                'Tips: ${tipsData[groupIndex]} BTC',
                                            style: smallWhite.copyWith(
                                                color:AppColors.skyBlue,)),
                                        TextSpan(
                                            text: ' (\$11.4)\n',
                                            style: smallGrey),
                                        TextSpan(
                                            text:
                                                'Rewards: ${rewardData[groupIndex]} BTC',
                                            style: smallGrey.copyWith(
                                                color: AppColors
                                                    .orangeColor,)),
                                        TextSpan(
                                            text: ' (\$11.4)\n',
                                            style: smallGrey),
                                      ])
                                : BarTooltipItem(
                                    '${DateFormat('EEEE, dd MMM, yyyy').format(_focusedDay)}\n',
                                    smallGrey,
                                    textAlign: TextAlign.center,
                                    children: [
                                        TextSpan(
                                          text:
                                              'Rewards: ${rewardData[groupIndex]}',
                                          style: smallRed.copyWith(
                                              color:
                                                  AppColors.orangeColor,
                                             ),
                                        )
                                      ]);
                          }),
                      touchCallback: (FlTouchEvent event, barTouchResponse) {
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
                          getTitlesWidget: (double value, TitleMeta meta) {
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
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),
                      rightTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text(value.toInt().toString());
                          },
                        ),
                      ),
                      topTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: false,
                          getTitlesWidget: (double value, TitleMeta meta) {
                            return Text('Value:' + value.toInt().toString());
                          },
                        ),
                      ),
                    ),
                    borderData: FlBorderData(
                        show: true,
                        border: const Border(
                            bottom: BorderSide(
                                color: Colors.white, width: 2))),
                    barGroups: showEarnings
                        ? weeklyData.asMap().entries.map((entry) {
                            int index = entry.key;
                            double value = entry.value;
                            double rewards = rewardData[index];
                            double tips = tipsData[index];
                            bool isTouched = index == touchedIndex;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                    toY: showEarnings
                                        ? value + rewards + tips
                                        : rewards,
                                    color: isTouched
                                        ? AppColors.blackColor
                                        : AppColors.greyColor.withOpacity(0.5),
                                    width: 16,
                                    borderRadius: BorderRadius.circular(4),
                                    backDrawRodData: BackgroundBarChartRodData(
                                      show: true,
                                      toY: showEarnings
                                          ? value + rewards + tips
                                          : rewards,
                                      color:
                                          AppColors.greyColor.withOpacity(0.5),
                                    ),
                                    rodStackItems: [
                                      BarChartRodStackItem(
                                        0,
                                        value,
                                        isTouched
                                            ? AppColors.redColor
                                            : AppColors.greyColor.lighten(),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      BarChartRodStackItem(
                                        value,
                                        value + tips,
                                        isTouched
                                            ? AppColors.skyBlue
                                            : AppColors.greyColor.lighten(),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                      ),
                                      BarChartRodStackItem(
                                        value + tips,
                                        value + tips + rewards,
                                        isTouched
                                            ? AppColors.orangeColor
                                            : AppColors.greyColor
                                                .withOpacity(0.5),
                                        borderSide: const BorderSide(
                                            color: Colors.transparent),
                                      ),
                                    ]),
                              ],
                            );
                          }).toList()
                        : rewardData.asMap().entries.map((entry) {
                            int index = entry.key;
                            double value = entry.value;
                            bool isTouched = index == touchedIndex;
                            return BarChartGroupData(
                              x: index,
                              barRods: [
                                BarChartRodData(
                                  toY: value,
                                  color: isTouched
                                      ? AppColors.orangeColor
                                      : Colors.white,
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
              const SizedBox(
                height: 20,
              ),
              showEarnings
                  ? Padding(
                      padding: const EdgeInsets.only(bottom: 20.0),
                      child: InkWell(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) =>
                                    const TransactionHistory(),
                              ));
                        },
                        child: Text(
                          "See Transaction History",
                          style: redTitle,
                        ),
                      ),
                    )
                  : const SizedBox(),
            ],
          ),
        ),
      ),
    );
  }
}
