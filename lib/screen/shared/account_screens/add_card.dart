import 'package:taxi_driver_24_7/apppackages.dart';

class AddCard extends StatefulWidget {
  const AddCard({super.key});

  @override
  State<AddCard> createState() => _AddCardState();
}

class _AddCardState extends State<AddCard> {
  TextEditingController cardnoController = TextEditingController();
  TextEditingController nameController = TextEditingController();
  TextEditingController cvvController = TextEditingController();
  TextEditingController validController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Expanded(
            flex: 1,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
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
                                  padding: EdgeInsets.only(
                                      right: 30, top: 0, bottom: 0),
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
                              AppStrings.addcard.toUpperCase(),
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
                    child: Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            'Enter Details',
                            style: blackHeading,
                          ),
                          const SizedBox(
                            height: 15,
                          ),
                          textfield(
                              'Card Number',
                              TextInputType.number,
                              cardnoController,
                              () {},
                              '0000 0000 0000 0000',
                              19),
                          textfield('Card Holder Name', TextInputType.name,
                              nameController, () {}, 'David Backhem', null),
                          Row(
                            children: [
                              Expanded(
                                  child: textfield(
                                      'Valid Through(MM/YY)',
                                      TextInputType.text,
                                      validController,
                                      () {},
                                      '03/25',
                                      null)),
                              const SizedBox(
                                width: 10,
                              ),
                              Expanded(
                                  child: textfield('CVV', TextInputType.number,
                                      cvvController, () {}, '011', 3)),
                            ],
                          ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
          Expanded(
              flex: 0,
              child: Padding(
                padding: const EdgeInsets.all(15.0),
                child: ButtonWidget(
                  text: 'Add Card',
                  color: AppColors.blackColor,
                  onPressed: () {},
                  icon: Icons.done,
                ),
              ))
        ],
      ),
    );
  }
}

Widget textfield(
    String label,
    TextInputType keyboardType,
    TextEditingController? controller,
    Function()? onTap,
    String hintText,
    int? maxLength) {
  return Padding(
    padding: const EdgeInsets.only(bottom: 15.0),
    child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: blackBody),
        const SizedBox(
          height: 4,
        ),
        SizedBox(
          height: 50,
          child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              onTap: onTap,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "$label is required";
                } else {
                  return null;
                }
              },
              textInputAction: TextInputAction.next,
              style: blackBody,
              cursorColor: AppColors.blackColor,
              maxLength: maxLength,
              buildCounter: (context,
                      {required currentLength,
                      required isFocused,
                      required maxLength}) =>
                  const SizedBox(),
              onFieldSubmitted: (v) {},
              decoration: InputDecoration(
                hintText: hintText,
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.greyColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide:
                        const BorderSide(color: AppColors.greyColor, width: 1)),
                suffixIcon: label == 'Card Number'
                    ? Padding(
                        padding: const EdgeInsets.only(right: 8.0),
                        child: Image.asset(
                          'assets/images/mastercard.png',
                          width: 24,
                          height: 20,
                        ),
                      )
                    : const SizedBox(),
              )),
        ),
      ],
    ),
  );
}
