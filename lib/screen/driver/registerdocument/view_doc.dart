import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:shimmer/shimmer.dart';

class ViewDoc extends StatefulWidget {
  final String vehicleId;
  const ViewDoc({super.key, required this.vehicleId});

  @override
  State<ViewDoc> createState() => ViewDocState();
}

class ViewDocState extends State<ViewDoc> {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  bool isChecked = false;

  @override
  void initState() {
    super.initState();
    main();
  }

  void main() async {
    WidgetsFlutterBinding.ensureInitialized();
    SharedPreferences prefs = await SharedPreferences.getInstance();
    Future.delayed(const Duration(milliseconds: 0)).then((value) {
      setState(() {
        if (prefs.getString(PrefConstant.userid) != null) {
          Provider.of<GetVehicleInfoProvider>(context, listen: false)
              .getVehicleInfo(prefs.getString(PrefConstant.userid)!,
                  widget.vehicleId, context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    final getVehicleInfoProvider = Provider.of<GetVehicleInfoProvider>(context);
    return Scaffold(
      key: scaffoldKey,
      body: Container(
        color: Colors.white,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Expanded(
              flex: 1,
              child: Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 20.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          InkWell(
                            onTap: () {
                              Navigator.pop(context);
                              getVehicleInfoProvider.getVehicleData.clear();
                            },
                            child: const Padding(
                              padding:
                                  EdgeInsets.only(right: 30, top: 0, bottom: 0),
                              child: Image(
                                  height: 25,
                                  image: AssetImage(AppImages.arrowback)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      flex: 3,
                      child: Padding(
                        padding: const EdgeInsets.only(left: 0.0),
                        child: Center(
                          child: Text(
                            AppStrings.vehicledetails.toUpperCase(),
                            style: greyHeading,
                          ),
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
            ),
            Expanded(
              flex: 5,
              child: getVehicleInfoProvider.isloading
                  ? Shimmer.fromColors(
                      baseColor: Colors.grey[300]!,
                      highlightColor: Colors.grey[100]!,
                      child: Container(
                        width: MediaQuery.of(context).size.width,
                        decoration: const BoxDecoration(
                            color: Colors.white,
                            boxShadow: [
                              BoxShadow(
                                color: AppColors.greyColor,
                                blurRadius: 10.0,
                                spreadRadius: 0.0,
                                offset: Offset(2.0, 2.0),
                              )
                            ],
                            borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(40),
                              topRight: Radius.circular(40),
                            )),
                      ),
                    )
                  : Container(
                      width: MediaQuery.of(context).size.width,
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor,
                              blurRadius: 10.0,
                              spreadRadius: 0.0,
                              offset: Offset(2.0, 2.0),
                            )
                          ],
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          )),
                      child: getVehicleInfoProvider.getVehicleData.isEmpty
                          ? Center(
                              child: Text(
                                AppStrings.noDataAvailable,
                                style: blackTitle,
                              ),
                            )
                          : SingleChildScrollView(
                              child: Padding(
                                padding: const EdgeInsets.only(
                                    left: 25.0,
                                    right: 25.0,
                                    top: 40,
                                    bottom: 30),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    getVehicleInfoProvider
                                                .getVehicleData[0].isDefault ==
                                            1
                                        ? Text(
                                            AppStrings.thisIsDefaultVehicle,
                                            style: redTitle,
                                          )
                                        : const SizedBox(),
                                    Text(
                                        getVehicleInfoProvider.getVehicleData[0]
                                                .vehicleModel ??
                                            '',
                                        style: blackHeading),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          mainAxisAlignment:
                                              MainAxisAlignment.spaceBetween,
                                          children: [
                                            Text(
                                                getVehicleInfoProvider
                                                        .getVehicleData[0]
                                                        .vehicleModel ??
                                                    '',
                                                style: blackHeading),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 38),
                                              child: Text(
                                                getVehicleInfoProvider
                                                        .getVehicleData[0]
                                                        .registrationNumber ??
                                                    '',
                                                style: greyTitle,
                                              ),
                                            )
                                          ],
                                        ),
                                        Container(
                                          decoration: BoxDecoration(
                                            color: AppColors.greyColor
                                                .withOpacity(0.3),
                                            border: Border.all(
                                                color: AppColors.blackColor,
                                                width: 2),
                                            shape: BoxShape.circle,
                                          ),
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(60),
                                            child: SizedBox(
                                              height: 80,
                                              width: 80,
                                              child: Image.network(
                                                  fit: BoxFit.cover,
                                                  getVehicleInfoProvider
                                                      .getVehicleData[0]
                                                      .vehicleImages![0]
                                                      .toString()),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 40,
                                    ),
                                    VehicleTextData(
                                        text1: AppStrings.vehicleType,
                                        text2: getVehicleInfoProvider
                                                .getVehicleData[0]
                                                .vehicleType ??
                                            ''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    VehicleTextData(
                                        text1: AppStrings.vehicleMake,
                                        text2: getVehicleInfoProvider
                                                .getVehicleData[0]
                                                .vehicleMake ??
                                            ''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    VehicleTextData(
                                        text1: AppStrings.vehicleModel,
                                        text2: getVehicleInfoProvider
                                                .getVehicleData[0]
                                                .vehicleModel ??
                                            ''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    VehicleTextData(
                                        text1: AppStrings.vehicleYear,
                                        text2: getVehicleInfoProvider
                                                .getVehicleData[0]
                                                .vehicleYear ??
                                            ''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    VehicleTextData(
                                        text1: AppStrings.registrationNumber,
                                        text2: getVehicleInfoProvider
                                                .getVehicleData[0]
                                                .registrationNumber ??
                                            ''),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Text(
                                          AppStrings.vehicleColor,
                                          style: blackTitle,
                                        ),
                                        Text(
                                          getVehicleInfoProvider
                                                  .getVehicleData[0]
                                                  .vehicleColor ??
                                              '',
                                          textAlign: TextAlign.center,
                                          style: blackTitle,
                                        )
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors.redColor)),
                                          child: Image.asset(
                                              'assets/images/imageicon.png'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Text(
                                          AppStrings.vehicleImages,
                                          style: blackTitle,
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenImage(
                                                  imageUrls:
                                                      getVehicleInfoProvider
                                                          .getVehicleData[0]
                                                          .vehicleImages!,
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Row(
                                            children: [
                                              Container(
                                                width: 80,
                                                height: 80,
                                                decoration: BoxDecoration(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    border: Border.all(
                                                        color: AppColors
                                                            .greyColor
                                                            .withOpacity(0.3),
                                                        width: 2)),
                                                child: Hero(
                                                  tag: 'vehicleImage',
                                                  child: ClipRRect(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            20),
                                                    child: Image.network(
                                                      getVehicleInfoProvider
                                                          .getVehicleData[0]
                                                          .vehicleImages![0]
                                                          .toString(),
                                                      fit: BoxFit.cover,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                              const SizedBox(
                                                width: 5,
                                              ),
                                              getVehicleInfoProvider
                                                          .getVehicleData[0]
                                                          .vehicleImages!
                                                          .length >
                                                      1
                                                  ? Text(
                                                      '+${getVehicleInfoProvider.getVehicleData[0].vehicleImages!.length - 1}',
                                                      style: blackTitle,
                                                    )
                                                  : const SizedBox()
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors.redColor)),
                                          child: Image.asset(
                                              'assets/images/insicon.png'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.vehicleInsurance,
                                              style: blackTitle,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenImage(
                                                  imageUrls: [
                                                    getVehicleInfoProvider
                                                        .getVehicleData[0]
                                                        .vehicleInsurance!
                                                  ],
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColors.greyColor
                                                        .withOpacity(0.2),
                                                    width: 2)),
                                            child: Hero(
                                              tag: 'vehicleImage',
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  getVehicleInfoProvider
                                                      .getVehicleData[0]
                                                      .vehicleInsurance
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                    const Padding(
                                      padding: EdgeInsets.only(
                                          top: 10.0, bottom: 10.0),
                                      child: Divider(
                                          height: 1,
                                          color: AppColors.greyColor),
                                    ),
                                    Row(
                                      children: [
                                        Container(
                                          width: 40,
                                          height: 40,
                                          decoration: BoxDecoration(
                                              borderRadius:
                                                  BorderRadius.circular(20),
                                              border: Border.all(
                                                  width: 2,
                                                  color: AppColors.redColor)),
                                          child: Image.asset(
                                              'assets/images/rcicon.png'),
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                        Column(
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              AppStrings.registrationCertificate,
                                              style: blackBody,
                                            ),
                                          ],
                                        ),
                                        const Spacer(),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.push(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    FullScreenImage(
                                                  imageUrls: [
                                                    getVehicleInfoProvider
                                                        .getVehicleData[0]
                                                        .registrationCertificate!
                                                  ],
                                                  index: 0,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            width: 80,
                                            height: 80,
                                            decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                border: Border.all(
                                                    color: AppColors.greyColor
                                                        .withOpacity(0.2),
                                                    width: 2)),
                                            child: Hero(
                                              tag: 'vehicleImage',
                                              child: ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(20),
                                                child: Image.network(
                                                  getVehicleInfoProvider
                                                      .getVehicleData[0]
                                                      .registrationCertificate
                                                      .toString(),
                                                  fit: BoxFit.cover,
                                                ),
                                              ),
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  ],
                                ),
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

class FullScreenImage extends StatefulWidget {
  final List<String> imageUrls;
  final int index;

  const FullScreenImage(
      {super.key, required this.imageUrls, required this.index});

  @override
  FullScreenImageState createState() => FullScreenImageState();
}

class FullScreenImageState extends State<FullScreenImage> {
  late PageController _pageController;
  late int currentIndex;

  @override
  void initState() {
    super.initState();
    currentIndex = widget.index;
    _pageController = PageController(initialPage: currentIndex);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.blackColor,
      body: GestureDetector(
        onTap: () {
          Navigator.pop(context);
        },
        child: widget.imageUrls.length == 1
            ? Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20.0),
                child: Center(
                    child: Hero(
                        tag: 'vehicleImage',
                        child: InteractiveViewer(
                            child: ClipRRect(
                          borderRadius: BorderRadius.circular(20),
                          child: Image.network(widget.imageUrls.first,
                              fit: BoxFit.fill,
                              width: MediaQuery.of(context).size.width,
                              height: MediaQuery.of(context).size.height / 2),
                        )))),
              )
            : PageView.builder(
                controller: _pageController,
                itemCount: widget.imageUrls.length,
                onPageChanged: (index) {
                  setState(() {
                    currentIndex = index;
                  });
                },
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 20.0),
                        child: Hero(
                          tag: 'vehicleImage',
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(20),
                            child: InteractiveViewer(
                              child: Image.network(
                                widget.imageUrls[index],
                                fit: BoxFit.contain,
                                width: MediaQuery.of(context).size.width,
                                height: MediaQuery.of(context).size.height / 2,
                              ),
                            ),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 50,
                        width: double.infinity,
                        child: Row(
                          mainAxisSize: MainAxisSize.min,
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            widget.imageUrls.length,
                            (index) => Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: Container(
                                width: currentIndex == index ? 28 : 5,
                                height: 5,
                                decoration: BoxDecoration(
                                  color: currentIndex == index
                                      ? Colors.white
                                      : AppColors.greyColor.withOpacity(0.3),
                                  borderRadius: BorderRadius.circular(10),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
      ),
    );
  }
}
