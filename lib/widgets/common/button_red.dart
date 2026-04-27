import '../../apppackages.dart';

class ButtonRed extends StatelessWidget {
  final String text;
  final Color color;
  final VoidCallback onPressed;
  final bool? showIcon;
  final bool? smallText;

  const ButtonRed({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed, this.showIcon, this.smallText,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 60,
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: color,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30), 
          ),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            const SizedBox(),
            Text(
              text,
              style:smallText==true?whiteTitle: whiteHeading,
            ),
            showIcon==null||showIcon==true?
            Container(
                width: 56,
                height: 45,
                decoration: BoxDecoration(
                  shape: BoxShape.circle,
                  color: Colors.white.withOpacity(0.1),
                ),
                child: Padding(
                  padding: const EdgeInsets.all(15.0),
                  child: Image.asset('assets/images/rightarrow.png'),
                )):const SizedBox(),
          ],
        ),
      ),
    );
  }
}
