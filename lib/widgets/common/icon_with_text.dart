

import '../../apppackages.dart';

class IconWithText extends StatelessWidget {
  final String text;
  final bool? color;
  final String? imageIcon;
  final IconData icon;
  final bool small;
  const IconWithText(
      {super.key,
      required this.text,
      required this.icon,
      required this.small,
      this.color,
      this.imageIcon});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        imageIcon!=null?
        ImageIcon(
          AssetImage(imageIcon.toString(),
          ),
          size: small ? 14 : 18,
          color: small
              ? AppColors.greyColor
              : color == null
                  ? AppColors.greyColor
                  : AppColors.blackColor,
        ):
        Icon(
          icon,
          size: small ? 14 : 18,
          color: small
              ? AppColors.greyColor
              : color == null
                  ? AppColors.greyColor
                  : AppColors.blackColor,
        ),
        SizedBox(
          width: small ? 5 : 8,
        ),
        SizedBox(
          width:color==true? MediaQuery.of(context).size.width/1.2 :icon==Icons.location_pin? MediaQuery.of(context).size.width/2.7:null,
          child: Text(
            text,
            overflow: TextOverflow.fade,
            maxLines: 1,
            style: small
                ? smallGrey
                : color == null
                    ? smallGrey
                    : blackBody,
          ),
        )
      ],
    );
  }
}



