import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:flutter/cupertino.dart';

// ignore: must_be_immutable
class AddVehicle extends StatefulWidget {
  AddVehicle({super.key, required this.isNewVehicel});
  bool isNewVehicel = false;
  @override
  State<AddVehicle> createState() => AddVehicleState();
}

class AddVehicleState extends State<AddVehicle> {
  bool obscureText = true;
  bool isChecked = false;
  TextEditingController passwordController = TextEditingController();
  var scaffoldKey = GlobalKey<ScaffoldState>();

  String? vehicleTypeValue;
  String? vehicleYearValue;
  SharedPreferences? prefs;
  String? vehicleId, vehiclename;

  List<File> imageFiles = [];
  List<String> imageFilesPath = [];

  @override
  void initState() {
    super.initState();
    main();
  }

  Future<void> main() async {
    WidgetsFlutterBinding.ensureInitialized();
    prefs = await SharedPreferences.getInstance();
    Future.delayed(Duration.zero).then((value) {
      if (prefs?.getString(PrefConstant.userid) != null) {
        // ignore: use_build_context_synchronously
        Provider.of<VehicleTypeProvider>(context, listen: false).getVehicleTypeData(context,prefs!.getString(PrefConstant.userid)!);
      }
    });
  }

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile =
        await ImagePicker().pickImage(source: source, imageQuality: 50);
    setState(() {
      if (pickedFile != null) {
        imageFiles.add(File(pickedFile.path));
        imageFilesPath.add(pickedFile.path);
      }
    });
  }

  void _removeImage(int index) {
    setState(() {
      imageFiles.removeAt(index);
      imageFilesPath.removeAt(index);
    });
  }

  @override
  Widget build(BuildContext context) {
    final vehicleTypeProvider = Provider.of<VehicleTypeProvider>(context);
    final vehicleProvider = Provider.of<VehicleProvider>(context);
    int currentYear = DateTime.now().year;
    int startingYear = 1900;
    List yearList = List.generate(
        (currentYear - startingYear) + 1, (index) => currentYear - index);

    return Scaffold(
      resizeToAvoidBottomInset: true,
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
                padding: const EdgeInsets.only(
                    left: 5.0, right: 5.0, top: 0, bottom: 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    InkWell(
                            onTap: () {
                              Navigator.push(context,MaterialPageRoute(builder: (context) => const DriverHomeNew(),));
                            },
                            child: const Padding(
                              padding: EdgeInsets.only(left: 20.0, right: 20.0),
                              child: Image(
                                image:
                                    AssetImage('assets/images/backarrow.png'),
                                height: 25,
                              ),
                            ),
                          ),
                        
                    Text(
                      prefs?.getString(PrefConstant.firstName) == 'null'
                          ? AppStrings.welcomeDriver
                          : '${AppStrings.welcome.toUpperCase()} ${prefs?.getString(PrefConstant.firstName)!.toUpperCase()}',
                      style: greyHeading,
                    ),
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
                width: MediaQuery.of(context).size.width,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    boxShadow: [
                      BoxShadow(
                        color:AppColors.greyColor,
                        blurRadius: 10.0,
                        spreadRadius: 0.0,
                        offset:
                            Offset(2.0, 2.0),
                      )
                    ],
                    borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(40),
                      topRight: Radius.circular(40),
                    )),
                child: Padding(
                  padding: const EdgeInsets.only(
                      left: 25.0, right: 25.0, top: 40, bottom: 40),
                  child: SingleChildScrollView(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          AppStrings.fillvehicledetail,
                          style: blackHeading,
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.chooseVehicleType,
                          style: blackTitle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        vehicleTypeProvider.vehicletypeData != null
                            ? DropdownButtonFormField<String>(
                                hint: Text(
                                  AppStrings.select,
                                  style: greyTitle,
                                ),
                                value: vehicleTypeValue,
                                onChanged: (String? newValue) {
                                  vehicleTypeValue = newValue;

                                  int idx = vehicleTypeValue!.indexOf("-");
                                  List parts = [
                                    vehicleTypeValue!.substring(0, idx).trim(),
                                    vehicleTypeValue!.substring(idx + 1).trim()
                                  ];
                                  vehicleId = parts[0].trim();
                                  vehiclename = parts[1].trim();
                                },
                                icon: const Icon(
                                  Icons.keyboard_arrow_down_rounded,
                                  size: 30,
                                ),
                                items:
                                    vehicleTypeProvider.vehicletypeData!.map((item) {
                                  return DropdownMenuItem(
                                    value: '${item.sId}-${item.vehicleName}',
                                    child: Text(
                                      item.vehicleName.toString(),
                                      style: blackTitle,
                                    ),
                                  );
                                }).toList(),
                              )
                            : const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryBlueStart,
                                )),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          AppStrings.enterVehicleMake,
                          style: blackTitle,
                        ),
                        SizedBox(
                          height: 42,
                          child: TextFormField(
                            style: blackTitle,
                            textInputAction: TextInputAction.next,
                            controller: vehicleProvider.vehiclemakeController,
                            cursorColor: AppColors.redColor,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                              hintText: AppStrings.make,
                              hintStyle: greyTitle,
                                contentPadding: const EdgeInsets.only(bottom: 2)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          AppStrings.enterVehicleModel,
                          style: blackTitle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        SizedBox(
                          height: 42,
                          child: TextFormField(
                            style: blackTitle,
                            textInputAction: TextInputAction.next,
                            controller: vehicleProvider.vehicleModelController,
                            cursorColor: AppColors.redColor,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                               hintText: AppStrings.model,
                              hintStyle: greyTitle,
                                contentPadding: const EdgeInsets.only(bottom: 2)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          AppStrings.vehicleYear,
                          style: blackTitle,
                        ),
                        const SizedBox(
                          height: 5,
                        ),
                        DropdownButtonFormField<String>(
                          menuMaxHeight: 300,
                          hint: Text(
                            AppStrings.select,
                            style: greyTitle,
                          ),
                          value: vehicleYearValue,
                          onChanged: (String? newValue) {
                            setState(() {
                              vehicleYearValue = newValue!;
                            });
                          },
                          icon: const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 30,
                          ),
                          items: yearList.map((item) {
                            return DropdownMenuItem(
                              value: item.toString(),
                              child: Text(
                                item.toString(),
                                style: blackTitle,
                              ),
                            );
                          }).toList(),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.enterRegistrationNumber,
                          style: blackTitle,
                        ),
                        SizedBox(
                          height: 42,
                          child: TextFormField(
                            style: blackTitle,
                            textInputAction: TextInputAction.next,
                            controller:
                                vehicleProvider.registrationNumberController,
                            cursorColor: AppColors.redColor,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                               hintText: AppStrings.number,
                              hintStyle: greyTitle,
                                contentPadding:const EdgeInsets.only(bottom: 2)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          AppStrings.enterVehicleColour,
                          style: blackTitle,
                        ),
                        SizedBox(
                          height: 42,
                          child: TextFormField(
                            style: blackTitle,
                            textInputAction: TextInputAction.next,
                            controller: vehicleProvider.vehicleColorController,
                            cursorColor: AppColors.redColor,
                            keyboardType: TextInputType.name,
                            decoration:  InputDecoration(
                               hintText: AppStrings.color,
                              hintStyle: greyTitle,
                                contentPadding:const EdgeInsets.only(bottom: 2)),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Container(
                          width: double.infinity,
                          decoration: BoxDecoration(
                            border:
                                Border.all(color:AppColors.greyColor),
                            borderRadius: BorderRadius.circular(20.0),
                            color: Colors.white,
                          ),
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.start,
                            children: <Widget>[
                              imageFiles.isNotEmpty
                                  ? Column(
                                      children: [
                                        const SizedBox(
                                          height: 30,
                                        ),
                                        SizedBox(
                                          height: MediaQuery.of(context)
                                                  .size
                                                  .height *
                                              0.13,
                                          child: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: ListView.builder(
                                              scrollDirection: Axis.horizontal,
                                              itemCount: imageFiles.length,
                                              itemBuilder: (context, index) {
                                                return SizedBox(
                                                  width: 140,
                                                  child: ListTile(
                                                    title: Stack(
                                                      clipBehavior: Clip.none,
                                                      fit: StackFit.expand,
                                                      children: [
                                                        imageFiles.isEmpty
                                                            ? const Image(
                                                                width: 10,
                                                                image: AssetImage(
                                                                    'assets/images/greybg.png'))
                                                            : Image.file(
                                                                imageFiles[
                                                                    index],
                                                                fit: BoxFit
                                                                    .cover,
                                                              ),
                                                        Positioned(
                                                            right: -10,
                                                            top: -8,
                                                            child:
                                                                GestureDetector(
                                                              onTap: () {
                                                                _removeImage(
                                                                    index);
                                                              },
                                                              child: const Image(
                                                                  width: 28,
                                                                  image: AssetImage('assets/images/cross.png')),
                                                            )),
                                                      ],
                                                    ),
                                                  ),
                                                );
                                              },
                                            ),
                                          ),
                                        ),
                                      ],
                                    )
                                  : Container(),
                              const SizedBox(
                                height: 30,
                              ),
                              GestureDetector(
                                onTap: () {
                                  showOptions();
                                },
                                child: const Image(
                                    width: 130,
                                    image: AssetImage(
                                      'assets/images/addimage.png',
                                    )),
                              ),
                              const SizedBox(
                                height: 5,
                              ),
                              Text(
                                AppStrings.addvehicleimage,
                                style: blackTitle,
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                            ],
                          ),
                        ),
                        const SizedBox(
                          height: 30,
                        ),
                        vehicleProvider.isloading
                            ? const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.primaryBlueStart,
                                  strokeWidth: 1,
                                ),
                              )
                            : ButtonWidget(
                                text: AppStrings.next,
                                onPressed: () {
                                  vehicleProvider.validation(
                                      context,
                                      prefs!
                                          .getString(PrefConstant.userid)
                                          .toString(),
                                      vehicleId,
                                      vehiclename,
                                      vehicleYearValue,
                                      imageFilesPath,
                                      widget.isNewVehicel);
                                },
                                color: AppColors.primaryBlueStart,
                              ),
                      ],
                    ),
                  ),
                ),
              ),
            )
          ],
        ),
      ),
    );
  }

  Future showOptions() async {
    showCupertinoModalPopup(
      context: context,
      builder: (context) => CupertinoActionSheet(
        actions: [
          CupertinoActionSheetAction(
            child: Text(
              AppStrings.photoGallery,
              style: blackTitle,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.gallery);
            },
          ),
          CupertinoActionSheetAction(
            child: Text(
             AppStrings.camera,
              style: blackTitle,
            ),
            onPressed: () {
              Navigator.of(context).pop();
              _pickImage(ImageSource.camera);
            },
          ),
        ],
      ),
    );
  }
}
