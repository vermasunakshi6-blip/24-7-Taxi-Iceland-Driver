import 'package:taxi_driver_24_7/apppackages.dart';

class AddDigitalWallet extends StatefulWidget {
  const AddDigitalWallet({super.key});

  @override
  State<AddDigitalWallet> createState() => _AddDigitalWalletState();
}

class _AddDigitalWalletState extends State<AddDigitalWallet> {
  TextEditingController cardnoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  List<String> images = ['gpay.png','applepay.png','cashapp.png','dwolla.png','paypal.png','venmo.png','alipay.png','zelle.png','samsungpay.png','amazonpay.png'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
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
                        AppStrings.addigitalwallet.toUpperCase(),
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
                  Text(
                    'Choose your Digital Wallet',
                    style:
                        blackHeading,
                  ),
                  SizedBox(
                    height: MediaQuery.of(context).size.height/1.4,
                    child: GridView.builder(
                      itemCount: 10,
                      gridDelegate:  const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 2,crossAxisSpacing: 12,mainAxisSpacing: 12,
                      childAspectRatio: 2
                      ),
                      itemBuilder: (context, index) {
                        return Container(
                          decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: AppColors.greyColor.withOpacity(0.3)),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Image.asset('assets/images/${images[index]}',fit: BoxFit.contain,width: 70,height: 27,),
                            ],
                          ),
                        );
                      },
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
