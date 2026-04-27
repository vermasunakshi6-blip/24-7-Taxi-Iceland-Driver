import '../apppackages.dart';

class AppColors {
  // Primary gradient (requested): #1E5EFF -> #3D7CFF
  static const Color primaryBlueStart = Color(0xFF1E5EFF);
  static const Color primaryBlueEnd = Color(0xFF3D7CFF);
  static const LinearGradient primaryBlueGradient = LinearGradient(
    begin: Alignment.centerLeft,
    end: Alignment.centerRight,
    colors: [primaryBlueStart, primaryBlueEnd],
  );

  static const Color creamColor = Color(0xffEDE5DE);
  static const Color orangeColor = Color(0xFFFF683B);
  // Buttons/accents use primary blue; text stays black
  static const Color greenColor = primaryBlueStart;
  static const Color blackColor = Color(0xff040508);
  static const Color redColor = primaryBlueStart;
  static const Color greyColor = Color(0xff5B5C61);


  //BUY LEGGOO Colors (buttons: primary blue; text: black)
  static const Color red = primaryBlueStart;
  static const Color black = Color(0xff010101);
  static const Color yellow = Color(0xffC79023);
  static const Color brown = Color(0xff170E07);
  static const Color silver = Color(0xffD9C6B3);
  static const Color lightBrown = Color(0xff635447);
  static const Color purple = Color(0xff7E2DDC);
  static const Color purple2 = Color(0xff4E2083);
  static const Color aqua = Color(0xff14F194);
  static const Color lightYellow = Color(0xffE1D091);
  static const Color skin = Color(0xff986B57);
  static const Color skyBlue = Color(0xff3291B4);
  static const Color usdGreen = Color(0xff11795A);
  static const Color usdGreen2 = Color(0xff11272D);
  
  //buy leggo bottom dark colors (darkRed/darkGreen → dark blue)
  static const Color darkRed = Color(0xff1538a3);
  static const Color darkBrown = Color(0xff2C1E0B);
  static const Color darkSilver = Color(0xff67584B);
  static const Color darkPurple = Color(0xff4F2184);
  static const Color darkGreen = Color(0xff1538a3);
}

extension ColorExtension on Color {
  Color darken([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = 1 - percent / 100;
    return Color.fromARGB(
      alpha,
      (red * value).round(),
      (green * value).round(),
      (blue * value).round(),
    );
  }

  Color lighten([int percent = 40]) {
    assert(1 <= percent && percent <= 100);
    final value = percent / 100;
    return Color.fromARGB(
      alpha,
      (red + ((255 - red) * value)).round(),
      (green + ((255 - green) * value)).round(),
      (blue + ((255 - blue) * value)).round(),
    );
  }

  Color avg(Color other) {
    final red = (this.red + other.red) ~/ 2;
    final green = (this.green + other.green) ~/ 2;
    final blue = (this.blue + other.blue) ~/ 2;
    final alpha = (this.alpha + other.alpha) ~/ 2;
    return Color.fromARGB(alpha, red, green, blue);
  }
}
