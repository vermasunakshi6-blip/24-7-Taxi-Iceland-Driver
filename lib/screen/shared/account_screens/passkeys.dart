import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

class Passkeys extends StatefulWidget {
  const Passkeys({super.key});

  @override
  State<Passkeys> createState() => _PasskeysState();
}

class _PasskeysState extends State<Passkeys> {
  bool isTouchToggled = false;
  bool isfaceToggled = false;
  bool isPasscodeToggled = false;
  bool isTfaToggled = false;
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
                        AppStrings.passkeys.toUpperCase(),
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
            toggleButton('Touch Id', () {
                        setState(() {
                          isTouchToggled = !isTouchToggled;
                        });
                      },isTouchToggled),
            toggleButton('Face Id', () {
                        setState(() {
                          isfaceToggled = !isfaceToggled;
                        });
                      },isfaceToggled),
            toggleButton('Passcode', () {
                        setState(() {
                          isPasscodeToggled = !isPasscodeToggled;
                        });
                      },isPasscodeToggled),
            toggleButton('2- Factor Authentication', () {
                        setState(() {
                          isTfaToggled = !isTfaToggled;
                        });
                      },isTfaToggled),
                      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      'Trusted Phone Numbers',
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
              height: MediaQuery.of(context).size.height / 3,
              child: ListView.separated(
                itemCount: 4,
                padding: EdgeInsets.zero,
                separatorBuilder: (context, index) => const Padding(
                  padding: EdgeInsets.symmetric(vertical: 8.0),
                  child: Divider(
                                height: 1,
                                color: AppColors.creamColor,
                              ),
                ),
                itemBuilder: (context, index) => 
                 Row(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      '+91-1234561234',
                      style:
                          greyTitle,
                    ),
                    Row(
                      children: [
                        index==0?
                        Container(
                          width: MediaQuery.of(context).size.width / 6,
                          padding: const EdgeInsets.symmetric(vertical: 4,horizontal: 10),
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
                            child: Text('Primary', style: smallGreen),
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
            
          ],
        ),
      ),
    );
  }
  Widget toggleButton(String text, Function()? onTap,bool toggle){
  return Column(
    children: [
      Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      text,
                      style: blackTitle,
                    ),
                    GestureDetector(
                      onTap: onTap,
                      child: Container(
                        width: 52,
                        height: 28,
                          padding:  const EdgeInsets.all(5.0),
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(24.0),
                            color:toggle? AppColors.redColor: AppColors.blackColor.withOpacity(0.2),
                          ),
                          child:!toggle? const Row(
                            mainAxisSize: MainAxisSize.min,
                            children: [
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                              ),
                               SizedBox(width: 8.0),
                            ],
                          ): 
                          const Row(
                            mainAxisSize: MainAxisSize.min,
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                               SizedBox(width: 8.0),
                              CircleAvatar(
                                radius: 10,
                                backgroundColor: Colors.white,
                              ),
                              
                            ],
                          )
                          )
                          
                    ),
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
    ],
  );
            
}
}

