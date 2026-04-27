import 'package:taxi_driver_24_7/apppackages.dart';

class BarChartSample1 extends StatefulWidget {
 const BarChartSample1({super.key});

  final Color barBackgroundColor =
      Colors.white;
  final Color barColor = AppColors.greenColor;
  final Color touchedBarColor = AppColors.greenColor;

  @override
  State<BarChartSample1> createState() => BarChartSample1State();
}

class BarChartSample1State extends State<BarChartSample1> {
  final Duration animDuration = const Duration(milliseconds: 0);

  int touchedIndex = -1;

  bool isPlaying = false;

  @override
  Widget build(BuildContext context) {
    final walletProvider = Provider.of<WalletScreenProvider>(context);
    walletProvider.weakDate =
        walletProvider.formatter.format(walletProvider.weekDate);
    walletProvider.todaydate =
        walletProvider.formatter.format(walletProvider.todayDate);
    walletProvider.startDate =
        walletProvider.formatterForApi.format(walletProvider.weekDate);
    walletProvider.endDate =
        walletProvider.formatterForApi.format(walletProvider.todayDate);
    return Container(
      color: Colors.white,
      child: AspectRatio(
        aspectRatio: 1,
        child: Stack(
          children: [
            Padding(
              padding: const EdgeInsets.all(16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    "${walletProvider.weakDate} - ${walletProvider.todaydate}",
                    style: blackHeading
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  Text(
                    "${walletProvider.totalWeeklyPrice} ${walletProvider.currencySymbol}",
                    style:blackTitle
                  ),
                  const SizedBox(
                    height: 38,
                  ),
                  Expanded(
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      child: BarChart(
                        mainBarData(walletProvider.weekData,
                            walletProvider.currencySymbol),
                        swapAnimationDuration: animDuration,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 12,
                  ),
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topRight,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_forward,
                    color: AppColors.blackColor,
                  ),
                  onPressed: () {
                    setState(() {
                      walletProvider.weekDate =
                          walletProvider.weekDate.add(const Duration(days: 7));
                      walletProvider.todayDate =
                          walletProvider.todayDate.add(const Duration(days: 7));
                    });
                  },
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(8),
              child: Align(
                alignment: Alignment.topLeft,
                child: IconButton(
                  icon: const Icon(
                    Icons.arrow_back,
                    color: AppColors.blackColor,
                  ),
                  onPressed: () {
                    setState(() {
                      walletProvider.weekDate = walletProvider.weekDate
                          .subtract(const Duration(days: 7));
                      walletProvider.todayDate = walletProvider.todayDate
                          .subtract(const Duration(days: 7));
                    });
                  },
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  BarChartGroupData makeGroupData(
    int x,
    double y, {
    bool isTouched = false,
    Color? barColor,
    double width = 22,
    List<int> showTooltips = const [],
  }) {
    barColor ??= widget.barColor;
    return BarChartGroupData(
      x: x,
      barRods: [
        BarChartRodData(
          toY: isTouched ? y + 1 : y,
          color: isTouched ? widget.touchedBarColor : barColor,
          width: width,
          borderSide: isTouched
              ? BorderSide(color: widget.touchedBarColor.darken(80))
              : const BorderSide(color: Colors.white, width: 0),
          backDrawRodData: BackgroundBarChartRodData(
            show: true,
            toY: 0,
            color: widget.barBackgroundColor,
          ),
        ),
      ],
      showingTooltipIndicators: showTooltips,
    );
  }

  List<BarChartGroupData> showingGroups(WeekData weekData) =>
      List.generate(7, (i) {
        double mon = double.parse(weekData.mon!.totalPrice!.toStringAsFixed(4));
        double tue = double.parse(weekData.tue!.totalPrice.toString());
        double wed = double.parse(weekData.wed!.totalPrice.toString());
        double thu = double.parse(weekData.thu!.totalPrice.toString());
        double fri = double.parse(weekData.fri!.totalPrice!.toStringAsFixed(4));

        double sat = double.parse(weekData.sat!.totalPrice.toString());
        double sun = double.parse(weekData.sun!.totalPrice.toString());
        switch (i) {
          case 0:
            return makeGroupData(0, mon, isTouched: i == touchedIndex);
          case 1:
            return makeGroupData(1, tue, isTouched: i == touchedIndex);
          case 2:
            return makeGroupData(2, wed, isTouched: i == touchedIndex);
          case 3:
            return makeGroupData(3, thu, isTouched: i == touchedIndex);
          case 4:
            return makeGroupData(4, fri, isTouched: i == touchedIndex);
          case 5:
            return makeGroupData(5, sat, isTouched: i == touchedIndex);
          case 6:
            return makeGroupData(6, sun, isTouched: i == touchedIndex);
          default:
            return throw Error();
        }
      });

  BarChartData mainBarData(WeekData? weekData, String? currencySymbol) {
    return BarChartData(
      barTouchData: BarTouchData(
        touchTooltipData: BarTouchTooltipData(
          getTooltipColor: (_) => const Color.fromRGBO(246, 249, 197, 1),
          tooltipHorizontalAlignment: FLHorizontalAlignment.right,
          tooltipMargin: -10,
          getTooltipItem: (group, groupIndex, rod, rodIndex) {
            String weekDay;
            String mon = weekData!.mon!.date.toString();
            String tue = weekData.tue!.date.toString();
            String wed = weekData.wed!.date.toString();
            String thu = weekData.thu!.date.toString();
            String fri = weekData.fri!.date.toString();
            String sat = weekData.sat!.date.toString();
            String sun = weekData.sun!.date.toString();

            switch (group.x) {
              case 0:
                weekDay = mon;
                break;
              case 1:
                weekDay = tue;
                break;
              case 2:
                weekDay = wed;
                break;
              case 3:
                weekDay = thu;
                break;
              case 4:
                weekDay = fri;
                break;
              case 5:
                weekDay = sat;
                break;
              case 6:
                weekDay = sun;
                break;
              default:
                throw Error();
            }
            return BarTooltipItem(
              '$weekDay\n',
               blackTitle,
              children: <TextSpan>[
                TextSpan(
                  text: "${rod.toY - 1} $currencySymbol",
                  style:blackTitle
                ),
              ],
            );
          },
        ),
        touchCallback: (FlTouchEvent event, barTouchResponse) {
          setState(() {
            if (!event.isInterestedForInteractions ||
                barTouchResponse == null ||
                barTouchResponse.spot == null) {
              touchedIndex = -1;
              return;
            }
            touchedIndex = barTouchResponse.spot!.touchedBarGroupIndex;
          });
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            getTitlesWidget: getTitles,
            reservedSize: 38,
          ),
        ),
        leftTitles: const AxisTitles(
          sideTitles: SideTitles(
            showTitles: false,
          ),
        ),
      ),
      borderData: FlBorderData(
        show: false,
      ),
      barGroups: showingGroups(weekData!),
      gridData: const FlGridData(show: false),
    );
  }

  Widget getTitles(double value, TitleMeta meta) {
    Widget text;
    switch (value.toInt()) {
      case 0:
        text =  Text('M', style: blackBody);
        break;
      case 1:
        text =  Text('T', style: blackBody);
        break;
      case 2:
        text =  Text('W', style: blackBody);
        break;
      case 3:
        text =  Text('T', style: blackBody);
        break;
      case 4:
        text =  Text('F', style: blackBody);
        break;
      case 5:
        text =  Text('S', style: blackBody);
        break;
      case 6:
        text =  Text('S', style: blackBody);
        break;
      default:
        text =  Text('', style: blackBody);
        break;
    }
    return Title(color: AppColors.blackColor, child: text);
  }
}
