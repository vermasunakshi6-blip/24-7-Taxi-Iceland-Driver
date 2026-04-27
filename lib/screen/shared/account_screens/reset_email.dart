import 'package:taxi_driver_24_7/apppackages.dart';

// ignore: must_be_immutable
class EditEmailID extends StatefulWidget {
  EditEmailID({super.key, required this.oldEmail});
  String oldEmail;

  @override
  State<EditEmailID> createState() => _EditEmailIDState();
}

class _EditEmailIDState extends State<EditEmailID> {
  final TextEditingController newEmailController = TextEditingController();
  ConnectivityController connectivityController = ConnectivityController();

  @override
  void initState() {
    connectivityController.init();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final profileProvider = Provider.of<ProfileProvider>(context);
    return Scaffold(
        body: ValueListenableBuilder(
            valueListenable: connectivityController.isConnected,
            builder: (context, value, child) {
              if (value) {
                return Padding(
                  padding: const EdgeInsets.only(left: 16, right: 16),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Padding(
                        padding: const EdgeInsets.only(
                            left: 0.0, right: 0.0, top: 80, bottom: 0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          crossAxisAlignment: CrossAxisAlignment.center,
                          children: [
                            InkWell(
                              onTap: () {
                                Navigator.pop(context, true);
                              },
                              child: const Padding(
                                padding: EdgeInsets.only(
                                    right: 30, top: 0, bottom: 0),
                                child: Image(
                                    height: 25,
                                    image: AssetImage(AppImages.arrowback)),
                              ),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 15.0),
                              child: Text(
                                AppStrings.emailupdate.toUpperCase(),
                                style: greyHeading,
                              ),
                            ),
                            GestureDetector(
                              onTap: () {},
                              child: const Icon(
                                Icons.edit,
                                color: Colors.transparent,
                              ),
                            ),
                          ],
                        ),
                      ),
                      const SizedBox(
                        height: 60,
                      ),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller:
                              TextEditingController(text: widget.oldEmail),
                          readOnly: true,
                          style: blackTitle,
                          cursorColor: AppColors.greenColor,
                          keyboardType: TextInputType.name,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                          ),
                        ),
                      ),
                      const Divider(
                        color: AppColors.greyColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      SizedBox(
                        height: 45,
                        child: TextFormField(
                          controller: newEmailController,
                          style: blackTitle,
                          textInputAction: TextInputAction.done,
                          cursorColor: AppColors.redColor,
                          keyboardType: TextInputType.emailAddress,
                          decoration: const InputDecoration(
                            border: InputBorder.none,
                            enabledBorder: InputBorder.none,
                            focusedBorder: InputBorder.none,
                            hintText: 'Enter New Email',
                          ),
                        ),
                      ),
                      const Divider(
                        color: AppColors.greyColor,
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      profileProvider.isVerfify == false
                          ? ButtonWidget(
                              text: "Send otp",
                              color: AppColors.primaryBlueStart,
                              onPressed: () {
                                if (newEmailController.text.isEmpty) {
                                  CSnackBar.showSnackBarError(
                                      "Please enter new Email Address",
                                      context);
                                } else {
                                  setState(() {
                                    profileProvider.setValue(true);
                                  });
                                  profileProvider.resetEmail(widget.oldEmail,
                                      newEmailController.text, "", context);
                                }
                              })
                          : Column(
                              mainAxisAlignment: MainAxisAlignment.start,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  'Verify your email!',
                                  style: blackTitle,
                                ),
                                OTPTextField(
                                  length: 6,
                                  width: MediaQuery.of(context).size.width,
                                  textFieldAlignment:
                                      MainAxisAlignment.spaceAround,
                                  fieldWidth: 45,
                                  style: blackHeading,
                                  fieldStyle: FieldStyle.underline,
                                  outlineBorderRadius: 2.0,
                                  onCompleted: (pin) {
                                    profileProvider.setOtpValue(pin);
                                  },
                                ),
                                const SizedBox(
                                  height: 50,
                                ),
                                ButtonWidget(
                                    text: "Verify otp",
                                    color: AppColors.primaryBlueStart,
                                    onPressed: () {
                                      profileProvider.setValue(false);
                                      profileProvider.resetEmail(
                                          widget.oldEmail,
                                          newEmailController.text,
                                          profileProvider.otpValue!,
                                          context);
                                    })
                              ],
                            )
                    ],
                  ),
                );
              } else {
                return const NetworkAlertBar();
              }
            }));
  }
}
