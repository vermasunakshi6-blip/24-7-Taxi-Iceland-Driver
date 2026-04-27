import '../../apppackages.dart';

class VehicleTextData extends StatelessWidget {
  final String text1;
  final String text2;

  const VehicleTextData({
    super.key,
    required this.text1,
    required this.text2,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            text1,
            style: blackTitle,
          ),
          Text(
            text2,
            textAlign: TextAlign.center,
            style: blackBody,
          )
        ],
      ),
    );
  }
}
