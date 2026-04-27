import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:flutter/material.dart';

class CustomTextField extends StatelessWidget {
  final String label;
  final TextInputType keyboardType;
  final IconData? icon;
  final TextEditingController? controller;
  final VoidCallback? onTap;
  final Function(String)? onFieldSubmitted;

  const CustomTextField({
     super.key,
    required this.label,
    required this.keyboardType,
    this.controller,
    this.onTap,
    this.onFieldSubmitted,
    this.icon,
  }) ;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            label,
            style:  greyBody
          ),
          const SizedBox(height: 4),
          SizedBox(
            height: 50,
            child: TextFormField(
              controller: controller,
              keyboardType: keyboardType,
              onTap: onTap,
              validator: (value) {
                if (value == null || value.isEmpty) {
                  return "$label is required";
                }
                return null;
              },
              
              textInputAction: TextInputAction.done,
              style:  blackTitle,
              cursorColor: AppColors.blackColor,
              onFieldSubmitted: onFieldSubmitted,
              decoration: InputDecoration(
                contentPadding:
                    const EdgeInsets.symmetric(vertical: 3.0, horizontal: 10.0),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: AppColors.greyColor, width: 1)),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(10),
                    borderSide: const BorderSide(
                        color: AppColors.greyColor, width: 1)),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
