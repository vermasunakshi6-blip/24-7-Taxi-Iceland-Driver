import '../../apppackages.dart';

class Register extends StatefulWidget {
  const Register({
    super.key,
  });

  @override
  State<Register> createState() => _RegisterState();
}

class _RegisterState extends State<Register> {
  CountryData countryData = CountryData();
  List<Country> countries = [];
  List<String> states = [];
  List<String> cities = [];
  final TextEditingController referCodeController = TextEditingController();
  String? userType;
  Country? selectedCountry;
  late String selectedState;
  late String selectedCity;
  SharedPreferences? sharedprefprovider;
  RegisterProvider? registerprovider;

  void initCountries() {
    final allCountries = countryData.getCountries();
    countries = allCountries
        .where((c) => c.id == 'IN' || c.id == 'IS')
        .toList()
      ..sort((a, b) => (a.id == 'IN' ? 0 : 1).compareTo(b.id == 'IN' ? 0 : 1));
    if (countries.isEmpty) countries = allCountries;
    selectedCountry = countries.first;
    Provider.of<RegisterProvider>(context, listen: false)
        .setCountryValue(selectedCountry!.name);
    initCountryStates();
  }

  @override
  initState() {
    getReferCode();
    super.initState();
    initCountries();
  }
void syncLocationSelectionToProvider() {
    final p = Provider.of<RegisterProvider>(context, listen: false);
    p.setStateValue(
        selectedState == 'Other Provinces' ? 'No State' : selectedState);
    p.setCityValue(
        selectedCity == 'Other Provinces' ? 'No State' : selectedCity);
  }
  void selectCountry({required String countryId}) {
    selectedCountry = countryData.getCountryById(countryId: countryId);
    if (selectedCountry != null) {
      initCountryStates();
    }
  }

  void initCountryStates() {
    states = countryData.getStates(countryId: selectedCountry!.id);
    if (states.isEmpty) states = [selectedCountry!.name];
    selectedState = states[0];
    setState(() {});
    initCities();
  }

  void selectState({required String state}) {
    selectedState = state;
    initCities();
    setState(() {});
  }

  void initCities() {
    cities = countryData.getCities(
        countryId: selectedCountry!.id, state: selectedState);
    if (cities.isEmpty) cities = [selectedState];
    selectedCity = cities[0];
   syncLocationSelectionToProvider();
    setState(() {});
  }

  void selectCity({required String city}) {
    selectedCity = city;
    setState(() {});
  }

  Future<void> getReferCode() async {
    sharedprefprovider = await SharedPreferences.getInstance();
    userType = sharedprefprovider!.getString(PrefConstant.userType).toString();
    referCodeController.text =
        sharedprefprovider!.getString(PrefConstant.refcode) ?? "";
  }

  @override
  Widget build(BuildContext context) {
    registerprovider = Provider.of<RegisterProvider>(context);
    return Scaffold(
        backgroundColor: Colors.white,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Padding(
                padding:
                    const EdgeInsets.only(left: 30.0, right: 30.0, top: 60),
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
                            },
                            child: const Padding(
                              padding:
                                  EdgeInsets.only(right: 30, top: 0, bottom: 0),
                              child: Image(
                                  height: 20,
                                  image: AssetImage(AppImages.arrowback)),
                            ),
                          ),
                        ],
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 0.0),
                      child: Center(
                        child: Text(
                          '${AppStrings.register.toUpperCase()} AS DRIVER',
                          style: greyHeading,
                        ),
                      ),
                    ),
                    const Expanded(
                      child: SizedBox(),
                    ),
                  ],
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              Center(
                  child: const AppLogo()),
            ],
          ),
          Expanded(
              flex: 4,
              child: Container(
                
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.only(
                        left: 30.0, right: 30.0, top: 0, bottom: 5),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(
                          AppStrings.enteryourdetails,
                          style:blackHeading,
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'First Name',
                              style: greyBody,
                              children: [
                                TextSpan(text: '*', style: redBody)
                              ]),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: registerprovider!.firstNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            style: blackTitle,
                            cursorColor: AppColors.blackColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor, width: 1)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Last Name',
                              style: greyBody,
                              children: [
                                TextSpan(text: '*', style: redBody)
                              ]),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: registerprovider!.lastNameController,
                            keyboardType: TextInputType.name,
                            textInputAction: TextInputAction.next,
                            style: blackTitle,
                            cursorColor: AppColors.blackColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor, width: 1)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        RichText(
                          text: TextSpan(
                              text: 'Email Address',
                              style: greyBody,
                              children: [
                                TextSpan(text: '*', style: redBody)
                              ]),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        SizedBox(
                          height: 40,
                          child: TextFormField(
                            controller: registerprovider!.emailController,
                            keyboardType: TextInputType.emailAddress,
                            textInputAction: TextInputAction.next,
                            style: blackTitle,
                            cursorColor: AppColors.blackColor,
                            decoration: InputDecoration(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 3.0, horizontal: 10.0),
                              enabledBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor, width: 1)),
                              focusedBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(10),
                                  borderSide: const BorderSide(
                                      color: AppColors.blackColor, width: 1)),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5.0),
                          child: RichText(
                            text: TextSpan(
                                text: 'Country',
                                style: greyBody,
                                children: [
                                  TextSpan(text: '*', style: redBody)
                                ]),
                          ),
                        ),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 36,
                          width: double.infinity,
                          padding: const EdgeInsets.symmetric(
                              horizontal: 10.0, vertical: 0.0),
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.blackColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Center(
                            child: CountryCodePicker(
                              countryList: countries.map((country) {
                                return {
                                  'name': country.name,
                                  'code': country.id,
                                  'dial_code': '+${country.phone}'
                                };
                              }).toList(),
                              padding: EdgeInsets.zero,
                              margin: EdgeInsets.zero,
                              showDropDownButton: true,
                              onChanged: (code) {
                                if (code.code != null) {
                                  selectCountry(countryId: code.code!);

                                  registerprovider!
                                      .setCountryValue(selectedCountry!.name);
                                  registerprovider!.readJson();
                                }
                              },
                              builder: (v) => Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(
                                        v!.name.toString(),
                                        style: blackTitle,
                                      ),
                                      const Icon(Icons.arrow_drop_down)
                                    ],
                                  ),
                              textStyle:blackTitle,
                              initialSelection: selectedCountry!.id,
                              showCountryOnly: true,
                              showFlag: false,
                              showFlagDialog: true,
                              dialogSize: Size(
                                  MediaQuery.of(context).size.width, 280),
                              searchDecoration:  InputDecoration(
                                hintText: 'Search Country',
                                hintStyle: greyBodyNormal,
                              ),
                              comparator: (a, b) => a.name!.compareTo(b.name!),
                              onInit: (code) {}),
                          ),
                        ),
                        // Container(
                        //   height: 40,
                        //   padding: const EdgeInsets.symmetric(
                        //       horizontal: 0.0, vertical: 0.0),
                        //   decoration: BoxDecoration(
                        //     border: Border.all(
                        //         color: AppColors.blackColor, width: 1.0),
                        //     borderRadius: BorderRadius.circular(10.0),
                        //   ),
                        //   child: Padding(
                        //     padding: const EdgeInsets.only(left: 0.0),
                        //     child: DropdownButtonHideUnderline(
                        //       child: DropdownButton<String>(
                        //         isExpanded: true,
                        //         value: selectedCountry!.id,
                        //         items: countries
                        //             .map((country) => DropdownMenuItem<String>(
                        //                   value: country.id,
                        //                   child: Text(
                        //                     '  ${country.name}',
                        //                     overflow: TextOverflow.ellipsis,
                        //                     style: blackTitle,
                        //                   ),
                        //                 ))
                        //             .toList(),
                        //         onChanged: (countryId) {
                        //           if (countryId != null) {
                        //             selectCountry(countryId: countryId);

                        //             registerprovider!
                        //                 .setCountryValue(selectedCountry!.name);
                        //             registerprovider!.readJson();
                        //           }
                        //         },
                        //       ),
                        //     ),
                        //   ),
                        // ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: RichText(
                              text: TextSpan(
                                  text: 'State',
                                  style: greyBody,
                                  children: [
                                    TextSpan(text: '*', style: redBody)
                                  ]),
                            )),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.blackColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: selectedState,
                                  isExpanded: true,
                                  style: blackTitle,
                                  items: states
                                      .map((state) => DropdownMenuItem<String>(
                                            value: state,
                                            child: state == 'Other Provinces'
                                                ? Text(
                                                    'No States Available',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: blackTitle,
                                                  )
                                                : Text(
                                                    state,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: blackTitle,
                                                  ),
                                          ))
                                      .toList(),
                                  onChanged: (state) {
                                    if (state != null) {
                                      selectState(state: state);
                                      if (state == 'Other Provinces') {
                                        registerprovider!
                                            .setStateValue('No State');
                                      } else {
                                        registerprovider!.setStateValue(state);
                                      }
                                    }
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: RichText(
                              text: TextSpan(
                                  text: 'City/Province',
                                  style: greyBody,
                                  children: [
                                    TextSpan(text: '*', style: redBody)
                                  ]),
                            )),
                        const SizedBox(
                          height: 2,
                        ),
                        Container(
                          height: 40,
                          decoration: BoxDecoration(
                            border: Border.all(
                                color: AppColors.blackColor, width: 1.0),
                            borderRadius: BorderRadius.circular(10.0),
                          ),
                          child: Padding(
                            padding: const EdgeInsets.only(left: 5.0),
                            child: DropdownButtonHideUnderline(
                              child: DropdownButton<String>(
                                  value: selectedCity,
                                  isExpanded: true,
                                  style: blackTitle,
                                  items: cities
                                      .map((city) => DropdownMenuItem<String>(
                                            value: city,
                                            child: city == 'Other Provinces'
                                                ? Text(
                                                    'No City Available',
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: blackTitle,
                                                  )
                                                : Text(
                                                    city,
                                                    overflow:
                                                        TextOverflow.ellipsis,
                                                    style: blackTitle,
                                                  ),
                                          ))
                                      .toList(),
                                  onChanged: (city) {
                                    if (city != null) {
                                      selectCity(city: city);

                                      if (city == 'Other Provinces') {
                                        registerprovider!
                                            .setCityValue('No State');
                                      } else {
                                        registerprovider!.setCityValue(city);
                                      }
                                    }
                                  }),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Row(
                          children: [
                            registerprovider!.isCountryCode
                                ? Column(
                                    mainAxisAlignment: MainAxisAlignment.start,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Padding(
                                          padding:
                                              const EdgeInsets.only(left: 0.0),
                                          child: RichText(
                                            text: TextSpan(
                                                text: 'Country Code',
                                                style: greyBody,
                                                children: [
                                                  TextSpan(
                                                      text: '*',
                                                      style: redBody)
                                                ]),
                                          )),
                                      const SizedBox(
                                        height: 2,
                                      ),
                                      Container(
                                          padding: const EdgeInsets.symmetric(
                                              horizontal: 12, vertical: 8),
                                          width: 120,
                                          height: 40,
                                          decoration: BoxDecoration(
                                            border: Border.all(
                                                color: AppColors.blackColor,
                                                width: 1.0),
                                            borderRadius:
                                                BorderRadius.circular(10.0),
                                          ),
                                          child: Center(
                                            child: Text(
                                              registerprovider!.countryCode,
                                              style: blackTitle,
                                              overflow: TextOverflow.visible,
                                            ),
                                          )),
                                    ],
                                  )
                                : const SizedBox(),
                            SizedBox(
                              width: registerprovider!.isCountryCode ? 10 : 0,
                            ),
                            Expanded(
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  RichText(
                                    text: TextSpan(
                                        text: 'Phone number',
                                        style: greyBody,
                                        children: [
                                          TextSpan(
                                              text: '*', style: redBody)
                                        ]),
                                  ),
                                  const SizedBox(
                                    height: 2,
                                  ),
                                  SizedBox(
                                    height: 40,
                                    child: TextFormField(
                                      controller: registerprovider!
                                          .phoneNumberController,
                                      keyboardType: TextInputType.phone,
                                      textInputAction: TextInputAction.next,
                                      style: blackTitle,
                                      cursorColor: AppColors.blackColor,
                                      decoration: InputDecoration(
                                        contentPadding:
                                            const EdgeInsets.symmetric(
                                                vertical: 3.0,
                                                horizontal: 10.0),
                                        enabledBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: AppColors.blackColor,
                                                width: 1)),
                                        focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            borderSide: const BorderSide(
                                                color: AppColors.blackColor,
                                                width: 1)),
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        
                        const SizedBox(
                          height: 2,
                        ),
                       
                        const SizedBox(
                          height: 40,
                        ),
                        Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            InkWell(
                              onTap: () {
                                registerprovider!
                                    .setValue(!registerprovider!.value);
                              },
                              child: Container(
                                decoration: const BoxDecoration(
                                    shape: BoxShape.circle,
                                    color: AppColors.greenColor),
                                child: Padding(
                                  padding: const EdgeInsets.all(3.0),
                                  child: registerprovider!.isChecked
                                      ? const Icon(
                                          Icons.check,
                                          size: 15.0,
                                          color: Colors.white,
                                        )
                                      : const Icon(
                                          Icons.check_box_outline_blank,
                                          size: 15.0,
                                          color: AppColors.greenColor,
                                        ),
                                ),
                              ),
                            ),
                            const SizedBox(
                              width: 10,
                            ),
                            RichText(
                              text: TextSpan(
                                text:
                                    'By continuing , I confirm I have read the\n',
                                style: greyBody,
                                children: <TextSpan>[
                                  TextSpan(
                                    text: 'Terms and conditions',
                                    style: blackBody,
                                  ),
                                  TextSpan(
                                      text: ' and', style: greyBody),
                                  TextSpan(
                                    text: ' Privacy Policy.',
                                    style: blackBody,
                                  )
                                ],
                              ),
                            ),
                          ],
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        ButtonWidget(
                          text: AppStrings.next,
                          onPressed: () {
                            registerprovider!.validation(
                                context, userType!);
                          },
                          color: AppColors.primaryBlueStart,
                          gradient: AppColors.primaryBlueGradient,
                        ),
                      ],
                    ),
                  ),
                ),
              ))
        ],
      ),
    );
  }
}
