import '../../apppackages.dart';

class CSCPickers extends StatelessWidget {
  const CSCPickers({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    final registerprovider = Provider.of<RegisterProvider>(context);
    return CSCPicker(
      layout: Layout.vertical,
      showStates: true,
      showCities: true,
      flagState: CountryFlag.DISABLE,
      dropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          border: Border.all(color: AppColors.blackColor, width: 1)),
      disabledDropdownDecoration: BoxDecoration(
          borderRadius: const BorderRadius.all(Radius.circular(10)),
          color: Colors.transparent,
          border: Border.all(color: AppColors.redColor, width: 1)),
      countrySearchPlaceholder: "Country",
      stateSearchPlaceholder: "State",
      citySearchPlaceholder: "City",
      countryDropdownLabel: "Country",
      stateDropdownLabel: "State",
      cityDropdownLabel: "City",
      selectedItemStyle:
         blackTitle,
      dropdownHeadingStyle:
          blackHeading,
      dropdownItemStyle:
          blackBody,
      dropdownDialogRadius: 10.0,
      searchBarRadius: 10.0,
      onCountryChanged: (value) {
        registerprovider.setCountryValue(value);
        registerprovider.readJson();
      },
      onStateChanged: (value) {
        registerprovider.setStateValue(value);
        if (value == null) {}
      },
      onCityChanged: (value) {
        registerprovider.setCityValue(value);
      },
    );
  }
}
