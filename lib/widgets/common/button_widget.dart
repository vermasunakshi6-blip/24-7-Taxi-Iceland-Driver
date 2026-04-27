import '../../apppackages.dart';

class ButtonWidget extends StatelessWidget {
  final String text;
  final Color color;
  final Gradient? gradient;
  final IconData? icon;
  final VoidCallback onPressed;

  const ButtonWidget({
    super.key,
    required this.text,
    required this.color,
    required this.onPressed, this.icon,
    this.gradient,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      height: 60,
      decoration: BoxDecoration(
    borderRadius: BorderRadius.circular(30),
    boxShadow: [
      BoxShadow(
                color: (gradient == null ? color : Colors.black)
                    .withOpacity(0.18),
                blurRadius: 18,
                offset: const Offset(0, 8),
              ),
            ],
  ),
      child: ElevatedButton(
        onPressed: onPressed,
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.transparent,
          shadowColor: Colors.transparent,
          elevation: 0,
          padding: EdgeInsets.zero,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(30),
          ),
        ),
        child: Ink(
          decoration: BoxDecoration(
            gradient: gradient,
            color: gradient == null ? color : null,
            borderRadius: BorderRadius.circular(30),
            // boxShadow: [
            //   BoxShadow(
            //     color: (gradient == null ? color : Colors.black)
            //         .withOpacity(0.18),
            //     blurRadius: 18,
            //     offset: const Offset(0, 8),
            //   ),
            // ],
          ),
          child: SizedBox.expand(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const Icon(
                  Icons.arrow_back,
                  color: Colors.transparent,
                ),
                Padding(
                  padding: const EdgeInsets.only(left: 15.0),
                  child: Text(text, style: whiteHeading),
                ),
                Container(
                    width: 60,
                    height: 45,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: const Color.fromRGBO(255, 255, 255, 1)
                          .withOpacity(0.15),
                    ),
                    child: Padding(
                      padding: icon != null
                          ? const EdgeInsets.symmetric(horizontal: 20.0)
                          : const EdgeInsets.all(15),
                      child: icon != null
                          ? Icon(
                              icon,
                              color: Colors.white,
                              size: 20,
                            )
                          : Image.asset('assets/images/rightarrow.png'),
                    ))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
