import 'dart:math';

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:intl/intl.dart';

class TransactionHistory extends StatefulWidget {
  const TransactionHistory({
    super.key,
  });
  @override
  State<TransactionHistory> createState() => _TransactionHistoryState();
}

class _TransactionHistoryState extends State<TransactionHistory> {
  List<HistoryModel> filterlist = [];
  var date1 = DateTime.now();
  var date2 = DateTime.now().add(const Duration(days: 7));
  List<HistoryModel> newHistories = [];
  String filter = '';
  int index = 0;

  String formatdate(bool format, DateTime date) {
    return format
        ? DateFormat.MMMd().format(date)
        : DateFormat.yMMMd().format(date);
  }

  List<String> tabs = ['All', 'Earnings', 'Rewards', 'WithDrawals'];
  List<HistoryModel> histories = [
    HistoryModel(
        price: 142,
        time: '7:30 PM',
        date: DateTime.parse('2024-11-09'),
        earnings: 134,
        rewards: 8,
        status: 'Trip Completed',
        btc: 0.0072,
        from: 'Central Station',
        to: 'Circular Quay'),
    HistoryModel(
        price: 29,
        time: '2:17 PM',
        date: DateTime.parse('2024-11-09'),
        status: 'Funds Withdrawal',
        btc: 0.0028),
    HistoryModel(
        price: 63,
        time: '8:47 PM',
        date: DateTime.parse('2024-10-30'),
        earnings: 60,
        rewards: 3,
        status: 'Trip Completed',
        btc: 0.0041,
        from: 'China Town',
        to: 'Bondi Beach'),
    HistoryModel(
        price: 29,
        time: '1:57 AM',
        date: DateTime.parse('2024-11-07'),
        status: 'Funds Withdrawal',
        btc: 0.0028),
    HistoryModel(
        price: 63,
        time: '4:47 PM',
        date: DateTime.parse('2024-10-28'),
        earnings: 225,
        rewards: 22,
        status: 'Trip Completed',
        btc: 0.0118,
        from: 'Pearl Harbour',
        to: 'Marina Sands'),
  ];

  @override
  void initState() {
    fetchHistoriesWithinDateRange();
    super.initState();
  }

  void updateDateRange(bool next) {
    int daysToAdd = next ? 8 : -8;
    date1 = date1.add(Duration(days: daysToAdd));
    date2 = date1.add(const Duration(days: 7));
    setState(() {
      fetchHistoriesWithinDateRange();
      filterData(index == 3 ? 'Funds Withdrawal' : 'Trip Completed');
    });
  }

  void fetchHistoriesWithinDateRange() {
    setState(() {
      newHistories = histories
          .where((history) =>
              ((history.date.isAfter(date1)) && (history.date.isBefore(date2))))
          .toList();
      filterlist = newHistories;
    });
  }

  void filterData([String selectedfilter = '']) async {
    setState(() {
      filter = selectedfilter;
      filterlist =
          newHistories.where((history) => (history.status == filter)).toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final walletProvider =
        Provider.of<WalletScreenProvider>(context, listen: false);
    return DefaultTabController(
      length: 4,
      child: Scaffold(
        backgroundColor: Colors.white,
        body: Padding(
          padding: const EdgeInsets.all(10.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                Padding(
                  padding:
                      const EdgeInsets.only(left: 10.0, right: 10.0, top: 60.0),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
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
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    right: 30, top: 0, bottom: 0),
                                child: Image(
                                    height: 20,
                                    image: AssetImage(AppImages.arrowback)),
                              ),
                            ),
                          ],
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.only(right: 50.0),
                          child: Text(
                            'History'.toUpperCase(),
                            style:greyHeading,
                          ),
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.only(left: 10),
                        width: 80,
                        height: 30,
                        decoration: BoxDecoration(
                            border: Border.all(color: AppColors.blackColor, width: 1.2),
                            borderRadius: BorderRadius.circular(28)),
                        child: DropdownButton<String>(
                          underline: const SizedBox(),
                          isDense: true,
                          isExpanded: true,
                          value: walletProvider.selectedItem,
                          onChanged: (String? newValue) {
                            setState(() {
                              walletProvider.selectedItem = newValue!;
                            });
                          },
                          items: walletProvider.cryptocurrency.map((value) {
                            return DropdownMenuItem<String>(
                              value: value,
                              child: Text(
                                value,
                                style: smallGrey,
                              ),
                            );
                          }).toList(),
                        ),
                      ),
                    ],
                  ),
                ),
                Padding(
                    padding: const EdgeInsets.only(
                      top: 40,
                    ),
                    child: TabBar(
                        indicatorWeight: 2,
                        onTap: (value) {
                          index = value;
                          value == 3
                              ? filterData('Funds Withdrawal')
                              : filterData('Trip Completed');
                          setState(() {});
                        },
                        labelStyle: redTitle,
                        unselectedLabelStyle: greyTitle,
                        tabAlignment: TabAlignment.center,
                        indicatorSize: TabBarIndicatorSize.tab,
                        indicatorColor: AppColors.redColor,
                        tabs: List.generate(
                          tabs.length,
                          (index) => Padding(
                            padding: const EdgeInsets.only(
                              top: 8, bottom: 12),
                            child: Text(
                              tabs[index],
                            ),
                          ),
                        ))),
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
                      Text(
                        '${formatdate(true, date1)}  -  ${formatdate(false, date2)}',
                        style:blackHeading,
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
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.2,
                  child: TabBarView(
                      physics: const NeverScrollableScrollPhysics(),
                      children: [
                        buildHistoryList(newHistories, false),
                        buildHistoryList(filterlist, false),
                        buildHistoryList(filterlist, true),
                        buildHistoryList(filterlist, false),
                      ]),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildHistoryList(List<HistoryModel> list, bool isrewards) {
    return list.isEmpty
        ? Center(
            child: Padding(
              padding: const EdgeInsets.only(bottom: 300.0),
              child: Text('No Transaction Found!',style: blackTitle,)
            ),
          )
        : ListView.builder(
            itemCount: list.length,
            itemBuilder: (context, index) {
              final data = list[index];
              return Padding(
                padding: const EdgeInsets.only(bottom: 6.0),
                child: Card(
                    elevation: 0.5,
                    color: Colors.white,
                    shape: RoundedRectangleBorder(
                        side:   BorderSide(
                          color: AppColors.greyColor.withOpacity(0.3),
                          width: 1,
                        ),
                        borderRadius: BorderRadius.circular(8)),
                    child: Padding(
                      padding: const EdgeInsets.all(16),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Expanded(
                            flex: 1,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  formatdate(false, data.date),
                                  style: blackTitle,
                                ),
                                Text(
                                  data.time,
                                  style:greyTitle,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  data.status,
                                  style:blackBody,
                                ),
                                data.status == 'Trip Completed'
                                    ? Row(
                                        children: [
                                          Text(
                                            data.from.toString(),
                                            style:greyBody,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          const Icon(
                                            Icons.arrow_forward,
                                            size: 12,
                                            color: AppColors.greyColor,
                                          ),
                                          const SizedBox(
                                            width: 2,
                                          ),
                                          Text(
                                            data.to.toString(),
                                            style:greyBody,
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                          SizedBox(
                            width: MediaQuery.of(context).size.width / 3.25,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                Row(
                                  children: [
                                    Transform.rotate(
                                        angle: data.status == 'Trip Completed'
                                            ? pi / 2.9
                                            : pi * 1.7,
                                        child: Icon(
                                          Icons.arrow_forward,
                                          color: data.status == 'Trip Completed'
                                              ? AppColors.greenColor
                                              : AppColors.redColor,
                                          size: 25,
                                        )),
                                    Text('${data.btc} BTC',
                                        style: data.status == 'Trip Completed'
                                            ? redTitle.copyWith(color: AppColors.greenColor)
                                            : redTitle),
                                  ],
                                ),
                                Text(
                                  '(\$${data.price})',
                                  style: greyTitleNormal,
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                data.status == 'Trip Completed' && !isrewards
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            'Earnings',
                                            style:greyBody,
                                          ),
                                          Text(
                                            '\$${data.earnings}',
                                            style: blackBody,
                                          ),
                                        ],
                                      )
                                    : Container(),
                                data.status == 'Trip Completed' && !isrewards
                                    ? Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                           Text(
                                            'Reward',
                                            style:greyBody,
                                          ),
                                          Text(
                                            '\$${data.rewards}',
                                            style:blackBody,
                                          ),
                                        ],
                                      )
                                    : Container(),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
              );
            },
          );
  }
}

class HistoryModel {
  final String time;
  final DateTime date;
  final int? earnings;
  final int? rewards;
  final int price;
  final String status;
  final String? from;
  final String? to;
  final double btc;
  HistoryModel({
    required this.price,
    required this.time,
    required this.date,
    this.earnings,
    this.rewards,
    required this.status,
    this.from,
    this.to,
    required this.btc,
  });
}
