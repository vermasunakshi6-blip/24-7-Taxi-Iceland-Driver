import '../../apppackages.dart';

class CommonTextField extends StatelessWidget {
  final TextEditingController controller;

  const CommonTextField({
    super.key,
    required this.controller,
  });

  @override
  Widget build(BuildContext context) {
    return TextFormField(
      controller: controller,
      keyboardType: TextInputType.name,
      textInputAction: TextInputAction.next,
      style: blackHeading,
      cursorColor: AppColors.greyColor,
      decoration: InputDecoration(
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
      ),
    );
  }
}
