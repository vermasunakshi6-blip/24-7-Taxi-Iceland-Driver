
import '../../../apppackages.dart';

// ignore: must_be_immutable
class AboutUsDriver extends StatefulWidget {
  String type;

  AboutUsDriver({super.key, required this.type});
  @override
  State<AboutUsDriver> createState() => AboutUsDriverState();
}

class AboutUsDriverState extends State<AboutUsDriver> {
  bool obscureText = true;
  bool isChecked = false;
  TextEditingController passwordController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      key: scaffoldKey,
      drawer: const NavDrawerDriver(),
      body: Container(
        decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/curvebg.png'),
            ),
            color: Colors.white),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding: const EdgeInsets.only(
                    left: 5.0, right: 40.0, top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                      onTap: () {
                        scaffoldKey.currentState!.openDrawer();
                      },
                      child: const Padding(
                        padding: EdgeInsets.only(left: 20.0, right: 20.0),
                        child: Image(
                          image: AssetImage('assets/images/menu.png'),
                          width: 25,
                        ),
                      ),
                    ),
                    if (widget.type == AppStrings.aboutus) ...{
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          AppStrings.aboutus.toUpperCase(),
                          style:greyHeading,
                        ),
                      ),
                    } else if (widget.type == AppStrings.terms) ...{
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          AppStrings.terms.toUpperCase(),
                          style:greyHeading,
                        ),
                      ),
                    } else ...{
                      Padding(
                        padding: const EdgeInsets.only(left: 15.0),
                        child: Text(
                          AppStrings.privacy.toUpperCase(),
                          style: greyHeading,
                        ),
                      ),
                    },
                    const Icon(
                      Icons.arrow_back,
                      color: Colors.transparent,
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: Container(
                height: 100,
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:AppColors.greyColor,
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset: Offset(2.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      const Image(
                          image: AssetImage('assets/images/aboutimage.png')),
                      Padding(
                        padding: const EdgeInsets.all(20.0),
                        child: Text(
                            style:greyBodyNormal,
                            """Lorem Ipsum is simply dummy text of the printing and typesetting industry. Lorem Ipsum has been the industry's standard dummy text ever since the 1500s,when an unknown printer took a galley of type and scrambled it to make a type specimen book. It has survived not only five centuries, but also the leap into electronic typesetting,  Lorem Ipsum."""),
                      )
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
