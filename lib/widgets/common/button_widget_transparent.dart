import '../../apppackages.dart';

class ButtonWidgetTransparent extends StatelessWidget {
  final String text;
  final Color color;
  /// If set, button uses white background with this color for border and text (outlined style).
  final Color? borderAndTextColor;
  final VoidCallback onPressed;
  final bool? smallText;

  const ButtonWidgetTransparent({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed,
    this.borderAndTextColor,
    this.smallText,
  });

  @override
  Widget build(BuildContext context) {
    final useOutlinedStyle = borderAndTextColor != null;
    final borderColor = borderAndTextColor ?? AppColors.greyColor;
    final backgroundColor = useOutlinedStyle ? Colors.white : color;
    final textColor = useOutlinedStyle ? borderAndTextColor! : Colors.white;
    final textStyle = (smallText == true ? whiteTitle : whiteHeading).copyWith(color: textColor);

    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          elevation: useOutlinedStyle ? 2 : 0,
          shadowColor: useOutlinedStyle ? Colors.black.withOpacity(0.08) : null,
          backgroundColor: backgroundColor,
          side: BorderSide(width: 1.5, color: borderColor),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Center(
          child: Text(text, style: textStyle),
        ),
      ),
    );
  }
}
