import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

class RecoveryMethods extends StatelessWidget {
  const RecoveryMethods({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.only(left: 15.0, right: 15.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 0.0, right: 0.0, top: 80.0),
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
                        AppStrings.recoverymethod.toUpperCase(),
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
              height: 50,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recovery Contacts',
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
                      'Add Phone',
                      style: redBody,
                    )
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1,
              color: AppColors.creamColor,
            ),
            const SizedBox(
              height: 15,
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 6,
              child: ListView.separated(
                itemCount: 3,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                    height: 1,
                    color: AppColors.creamColor,
                  ),
                ),
                itemBuilder: (context, index) => Padding(
                  padding: const EdgeInsets.all(5.0),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        '+91-1234561234',
                        style: greyTitle,
                      ),
                      Row(
                        children: [
                          index==0?
                          Container(
                            width: MediaQuery.of(context).size.width / 6,
                            padding: const EdgeInsets.symmetric(vertical: 5,horizontal: 10),
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
                              child: Text('Primary', style: greenBody),
                            ),
                          ):const SizedBox(),
                          const Icon(
                            CupertinoIcons.ellipsis_vertical,
                            size: 15,
                          ),
                        ],
                      )
                    ],
                  ),
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  'Recovery Key',
                  style: blackTitle,
                ),
                Row(
                  children: [
                    Text(
                      'leurbwtxbqg1r4l0ywoshn37',
                      style: greyBody,
                    ),
                    const SizedBox(
                      width: 5,
                    ),
                    Transform.flip(
                      flipX: true,
                      child: const Icon(
                        CupertinoIcons.square_fill_on_square_fill,
                        color: AppColors.redColor,
                        size: 20,
                      ),
                    ),
                  ],
                )
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Divider(
              height: 1,
              color: AppColors.creamColor,
            ),
            const SizedBox(
              height: 15,
            ),
            Text(
              'Your 28-character Recovery Key helps you regain access if you lose your passcode, passkeys, or trusted number. Keep it safe!',
              style:
                  smallGrey,
            ),
          ],
        ),
      ),
    );
  }
}
