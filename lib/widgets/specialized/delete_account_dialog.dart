
import 'package:taxi_driver_24_7/widgets/common/textfield_with_label.dart';

import '../../apppackages.dart';

class DeleteAccountDialog extends StatefulWidget {
  final ProfileProvider profileProvider;
  final String userId;
  const DeleteAccountDialog(
      {super.key, required this.profileProvider, required this.userId});

  @override
  State<DeleteAccountDialog> createState() => _DeleteAccountDialogState();
}

class _DeleteAccountDialogState extends State<DeleteAccountDialog> {
  String selectedItem = '';
  TextEditingController reasonController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(20)),
      insetPadding: selectedItem == 'Other'
          ? const EdgeInsets.all(10)
          : const EdgeInsets.all(20),
      contentPadding: EdgeInsets.zero,
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: MediaQuery.of(context).size.width,
            padding: const EdgeInsets.symmetric(vertical: 10),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(20),
              gradient: const LinearGradient(colors: [
                AppColors.blackColor,
                AppColors.redColor
              ]),
            ),
            child: Column(
              children: [
                CircleAvatar(
                  radius: 32,
                  backgroundColor: AppColors.greyColor.withOpacity(0.3).withOpacity(0.2),
                  child: Text(
                    '😪',
                    style: xLargeWhite,
                  ),
                ),
                Text(
                  'Think of Leaving?',
                  style: whiteHeading,
                ),
                Text(
                  'We’re sad to see you go!',
                  style: whiteTitle,
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(
                left: 28.0, right: 28.0, top: 10, bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    'Tell us why you\'re heading out. Your feedback helps us get better!',
                    style: greyBodyNormal,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                   Text(
                    'Select a Reason ',
                    style: blackBody
                  ),
                  const SizedBox(
                    height: 4,
                  ),
                  SizedBox(
                    height: 50,
                    child: DropdownButtonFormField<dynamic>(
                    style: blackBody,
                        hint:  Text(
                          "Choose One",
                          style: greyBodyNormal,
                        ),
                        value: selectedItem.isNotEmpty? selectedItem:null,
                        isExpanded: true,
                        validator: (value) {
                          if (value == null || value=='') {
                            return "Reason is required";
                          } else {
                            return null;
                          }
                        },
                        decoration: InputDecoration(
                          contentPadding: const EdgeInsets.symmetric(
                              vertical: 3.0, horizontal: 10.0),
                          enabledBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.greyColor, width: 1),
                          ),
                          focusedBorder: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(10),
                            borderSide: const BorderSide(
                                color: AppColors.greyColor, width: 1),
                          ),
                        ),
                        items: [
                          'Switching to another service',
                          'Privacy Concerns ',
                          'Security Issues ',
                          'Dissatisfied with the Service',
                          'High fees/costs',
                          'App Performance Issues',
                          'Driver/Rider Safety Concerns ',
                          'Temporary Deactivation ',
                          'Other',
                        ]
                            .map((item) => DropdownMenuItem<dynamic>(
                                  value: item,
                                  child: Text(
                                    item,
                                    overflow: TextOverflow.ellipsis,
                                    style: blackTitle,
                                  ),
                                ))
                            .toList(),
                        onChanged: (v) {
                          setState(() {
                            selectedItem = v.toString();
                          });
                        }),
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  selectedItem == 'Other'
                      ? CustomTextField(
                          label: 'Please Describe your reason to leave.',
                          keyboardType: TextInputType.text,
                          icon: null,
                          controller: reasonController,
                          onTap: () {},
                          onFieldSubmitted: (v) {},
                        )
                      : const SizedBox(),
                  SizedBox(
                      height: 45,
                      child: ButtonRed(
                        color: AppColors.redColor,
                        text: 'Confirm Delete',
                        showIcon: false,
                        smallText: true,
                        onPressed: () {
                          if (selectedItem!='') {
                          widget.profileProvider.deleteAccount(
                              widget.userId,
                              selectedItem == 'Other'
                                  ? reasonController.text
                                  : selectedItem.toString(),
                              context);
                          }
                          else{
                            CSnackBar.showSnackBarError('Select a Reason First', context);
                          }
                          
                        },
                      )),
                  const SizedBox(
                    height: 15,
                  ),
                  SizedBox(
                      height: 45,
                      child: ButtonWidgetTransparent(
                        color: Colors.white,
                        text: 'Go Back',
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        smallText: true,
                      )),
                  const SizedBox(
                    height: 10,
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
