import 'package:taxi_driver_24_7/screen/shared/account_screens/add_card.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/add_digital_wallet.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/appimages.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';

class PaymentPreferences extends StatefulWidget {
  const PaymentPreferences({super.key});

  @override
  State<PaymentPreferences> createState() => _PaymentPreferencesState();
}

class _PaymentPreferencesState extends State<PaymentPreferences> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Expanded(
                    child: InkWell(
                      onTap: () {
                        Navigator.pop(context);
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(right: 30, top: 0, bottom: 0),
                        child: Image(
                            height: 25,
                            image: AssetImage(
                              AppImages.arrowback,
                            )),
                      ),
                    ),
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 0.0),
                    child: Center(
                      child: Text(
                        AppStrings.paymentsprefs.toUpperCase(),
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
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Digital Wallets',
                  style: blackHeading,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddDigitalWallet(),
                        ));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: AppColors.redColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text(
                        'Add Wallet',
                        style: redBody,
                      )
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/applepay.png',
                            width: 78,
                            height: 18,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.greenColor.withOpacity(0.1),
                                    AppColors.greenColor.withOpacity(0.04),
                                  ],
                                )),
                            child: Center(
                              child: Text('Connected', style: smallGreen),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Cards',
                  style: blackHeading,
                ),
                InkWell(
                  onTap: () {
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddCard(),
                        ));
                  },
                  child: Row(
                    children: [
                      const Icon(
                        Icons.add_circle,
                        color: AppColors.redColor,
                        size: 20,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Text('Add Card', style: redBody)
                    ],
                  ),
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/mastercard.png',
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 20,
                          ),
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text(
                                '●●●● ●●●● ●●●● 8502',
                                style: smallBlack,
                              ),
                              Text(
                                'expires 10/25',
                                style: smallGrey,
                              ),
                            ],
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                color: AppColors.greyColor.withOpacity(0.15)),
                            child: Center(
                              child: Text('Edit', style: blackBody),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Crypto Wallets',
                  style: blackTitle,
                ),
                Row(
                  children: [
                    const Icon(
                      Icons.add_circle,
                      color: AppColors.redColor,
                      size: 20,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Text(
                      'Add Wallet',
                      style: redBody,
                    )
                  ],
                ),
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 5,
              child: ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const SizedBox(
                  height: 10,
                ),
                itemBuilder: (context, index) => Container(
                  padding: const EdgeInsets.all(10),
                  decoration: BoxDecoration(
                      border: Border.all(
                          color: AppColors.greyColor.withOpacity(0.3)),
                      borderRadius: BorderRadius.circular(8)),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          Image.asset(
                            'assets/images/metamask.png',
                            width: 25,
                            height: 25,
                          ),
                          const SizedBox(
                            width: 15,
                          ),
                          Text(
                            'MetaMask',
                            style: blackTitle,
                          ),
                        ],
                      ),
                      Row(
                        children: [
                          Container(
                            padding: const EdgeInsets.symmetric(
                                vertical: 5, horizontal: 10),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(40),
                                gradient: LinearGradient(
                                  begin: Alignment.centerLeft,
                                  end: Alignment.centerRight,
                                  colors: [
                                    AppColors.greenColor.withOpacity(0.1),
                                    AppColors.greenColor.withOpacity(0.04),
                                  ],
                                )),
                            child: Center(
                              child: Text('Connected', style: smallGreen),
                            ),
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
