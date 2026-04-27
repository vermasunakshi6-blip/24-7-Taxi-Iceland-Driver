import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';
 
class ToggleButton extends StatefulWidget {
final String text;
final Function()? onTap;
final int value;
final bool? small;
final bool? medium;
final bool? large;
  const ToggleButton({super.key, required this.text,required this.onTap, required this.value,  this.small,  this.medium,  this.large});
 
  @override
  State<ToggleButton> createState() => _ToggleButtonState();
}
 
class _ToggleButtonState extends State<ToggleButton> {
  @override
  Widget build(BuildContext context) {
    return Column(
    children: [
      Padding(
        padding:widget.small==true? const EdgeInsets.only(left: 20.0):EdgeInsets.zero,
        child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        widget.text,
                        style: widget.small==true?blackTitle:widget.large==true?blackHeading:blackTitle.copyWith(fontSize: 18)
                      ),
                      GestureDetector(
                        onTap: widget.onTap,
                        child: Container(
                          width: widget.large==true? 52:widget.medium==true?45:38,
                          height: widget.large==true? 28:widget.medium==true?24:20,
                            padding: widget.small==true?const EdgeInsets.all(2.0): const EdgeInsets.all(4.0),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(widget.large==true? 24:widget.medium==true?20:17),
                              color:widget.value==1? AppColors.redColor: AppColors.blackColor.withOpacity(0.2),
                            ),
                            child:widget.value==0?  Row(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                CircleAvatar(
                                  radius: widget.small==true?6: 10,
                                  backgroundColor: Colors.white,
                                ),
                                const SizedBox(width: 8.0),
                              ],
                            ):
                             Row(
                              mainAxisSize: MainAxisSize.min,
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                const SizedBox(width: 8.0),
                                CircleAvatar(
                                  radius:widget.small==true?6: 10,
                                  backgroundColor: Colors.white,
                                ),
                                
                              ],
                            )
                            )
                            
                      ),
                    ],
                  ),
      ),
                const SizedBox(
              height: 10,
            ),
            widget.medium==true?
            const SizedBox():
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
 