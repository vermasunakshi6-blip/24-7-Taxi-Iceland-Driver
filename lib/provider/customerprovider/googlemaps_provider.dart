import 'package:flutter_contacts/flutter_contacts.dart';
import 'package:geocoding/geocoding.dart';
import 'package:flutter_polyline_points/flutter_polyline_points.dart';
import 'package:google_maps_flutter/google_maps_flutter.dart';
import '../../apppackages.dart';

class GoogleMapsProvider extends ChangeNotifier {
  final TextEditingController current = TextEditingController();
  final TextEditingController destination = TextEditingController();
  final TextEditingController currentStop = TextEditingController();
  final TextEditingController firstStop = TextEditingController();
  final TextEditingController secondStop = TextEditingController();
  final TextEditingController thirdStop = TextEditingController();
  final CustomerApiCall api = CustomerApiCall();
  bool isloading = false;
  bool isdestination = false;
  bool isfirstStop = false;
  bool iscurrentStop = false;
  bool isSecondStop = false;
  bool isThirdStop = false;
  List<Results>? result;
  List<CryptoData> cryptoRateList = [];
  List<Results>? get resultDataList => result;
  double? autoCurrentLat;
  double? autoCurrentLang;
  double? currentLat;
  double? currentLang;
  double? currentStopLat;
  double? currentStopLang;
  double? firstStopLat;
  double? firstStopLang;
  double? secondStopLat;
  double? secondStopLang;
  double? thirdStopLat;
  double? thirdStopLang;
  double? destiLat;
  double? destiLang;
  String currentAddresss = "";
  String currentStopAddresss = "";
  String? destinationAddress;
  String firstStopAddress = '';
  String secondStopAddress = '';
  String thirdStopAddress = '';
  String? selectedValue;
  LatLng? location;
  String? totalDistance;
  String? totalTime;

  String? totalDistanceCF;
  String? totalDistanceFS;
  String? totalTimeCF;
  String? totalTimeFS;

  String? totalDistanceST;
  String? totalTimeST;

  double? totalFare;
  String priceForApi = "";
  String coinSymbol = "";
  String stopDistance = "";
  String stopDuration = "";
  String totalStopdistance = "";
  String totalStopduration = "";
  List<String> totalRidePriceWithSymboList = [];
  List<String> totalPriceWithoutFormatterList = [];
  List<Polyline> polylines = [];
  double get autoCurrentLatitude => autoCurrentLat ?? 0.0;
  double get autoCurrentLangitute => autoCurrentLang ?? 0.0;
  double get currentLatitude => currentLat ?? 0.0;
  double get currentLangitute => currentLang ?? 0.0;
  double get destinationLatitute => destiLat ?? 0.0;
  double get destinationLangitute => destiLang ?? 0.0;
  double get currentStopLatitude => currentStopLat ?? 0.0;
  double get currentStopLangitute => currentStopLang ?? 0.0;
  double get firstStopLatitude => firstStopLat ?? 0.0;
  double get firstStopLangitute => firstStopLang ?? 0.0;
  double get secondStopLatitude => secondStopLat ?? 0.0;
  double get secondStopLangitute => secondStopLang ?? 0.0;
  double get thirdStopLatitude => thirdStopLat ?? 0.0;
  double get thirdStopLangitute => thirdStopLang ?? 0.0;
  String address = '';
  final String apiKey = Environment.gApiKey;
  BitmapDescriptor sourceIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor destinationIcon = BitmapDescriptor.defaultMarker;
  BitmapDescriptor driverIcon = BitmapDescriptor.defaultMarker;
  List<Contact> contacts = [];
  List<Contact> filteredContacts = [];
  String searchQuery = '';
  List<Contact> pickUpSelectedContactsList = [];
  Set<Contact> selectedContacts = <Contact>{};

  void setAutoCurrentLat(double newValue) {
    autoCurrentLat = newValue;
    notifyListeners();
  }

  void setAutoCurrentLang(double newValue) {
    autoCurrentLang = newValue;
    notifyListeners();
  }

  void setCurrentLat(double newValue) {
    currentLat = newValue;
    notifyListeners();
  }

  void setCurrentLang(double newValue) {
    currentLang = newValue;
    notifyListeners();
  }

  void setCurrentStopLat(double newValue) {
    currentStopLat = newValue;
    notifyListeners();
  }

  void setCurrentStopLang(double newValue) {
    currentStopLang = newValue;
    notifyListeners();
  }

  void setdestinationLang(double newValue) {
    destiLang = newValue;
    notifyListeners();
  }

  void setdestinationLat(double newValue) {
    destiLat = newValue;
    notifyListeners();
  }

  void setfirstLat(double newValue) {
    firstStopLat = newValue;
    notifyListeners();
  }

  void setfirstLang(double newValue) {
    firstStopLang = newValue;
    notifyListeners();
  }

  void setSecondLat(double newValue) {
    secondStopLat = newValue;
    notifyListeners();
  }

  void setSecondLang(double newValue) {
    secondStopLang = newValue;
    notifyListeners();
  }

  void setthirdLat(double newValue) {
    thirdStopLat = newValue;
    notifyListeners();
  }

  void setthirdLang(double newValue) {
    thirdStopLang = newValue;
    notifyListeners();
  }


  Future<void> getAddressFromLatLng(double latitude, double longitude) async {
    setAutoCurrentLat(latitude);
    setAutoCurrentLang(longitude);
    try {
      List<Placemark> placemarks =
          await placemarkFromCoordinates(latitude, longitude);
      if (placemarks.isNotEmpty) {
        Placemark place = placemarks[0];
        address =
            '${place.street}, ${place.locality}, ${place.administrativeArea}, ${place.country}';
        current.text = address;
        currentStop.text = address;
        notifyListeners();
      } else {
        address = 'No results found';
        notifyListeners();
      }
    } catch (e) {
      address = 'Failed to fetch address: $e';
      notifyListeners();
    }
  }

  void setCustomMarkerIcon() {
    BitmapDescriptor.asset(
            ImageConfiguration.empty, 'assets/images/CurrentLocation.png')
        .then((icon) {
      sourceIcon = icon;
    });
    BitmapDescriptor.asset(
            ImageConfiguration.empty, 'assets/images/destination.png',)
        .then((icon) {
      destinationIcon = icon;
    });

    BitmapDescriptor.asset(
            ImageConfiguration.empty, 'assets/images/destination.png')
        .then((icon) {
      destinationIcon = icon;
    });

    BitmapDescriptor.asset(
            ImageConfiguration.empty, 'assets/images/drivercar.png')
        .then((icon) {
      driverIcon = icon;
    });
  }


  void getPolyPoints() async {
    PolylinePoints polylinePoints = PolylinePoints(apiKey: apiKey);
    List<List<PointLatLng>> autoRoutesCoordinates = [
      [
        PointLatLng(autoCurrentLatitude, autoCurrentLangitute),
        PointLatLng(destinationLatitute, destinationLangitute),
      ],
    ];

    List<List<PointLatLng>> routesCoordinates = [
      [
        PointLatLng(currentLatitude, currentLangitute),
        PointLatLng(destinationLatitute, destinationLangitute),
      ],
    ];

    for (var routeCoordinates in currentAddresss.isEmpty
        ? autoRoutesCoordinates
        : routesCoordinates) {
      PolylineResult result = await polylinePoints.getRouteBetweenCoordinates(
        request: PolylineRequest(
          origin: routeCoordinates[0],
          destination: routeCoordinates[1],
          mode: TravelMode.driving,
        ),
      );
      if (result.points.isNotEmpty) {
        List<LatLng> polylineCoordinates = [];
        for (var point in result.points) {
          polylineCoordinates.add(
            LatLng(point.latitude, point.longitude),
          );
        }
        polylines.add(
          Polyline(
            polylineId: PolylineId(
                'route_${routesCoordinates.indexOf(routeCoordinates)}'),
            color:AppColors.blackColor,
            points: polylineCoordinates,
            width: 5,
          ),
        );
        notifyListeners();
      }
    }
  }
 


  


  

  Future<void> priceCalculation(double totalFarePrice) async {
    for (var item in cryptoRateList) {
      
      if (selectedValue == item.symbol) {
        final totalRidePrice = (totalFarePrice / item.quote!.uSD!.price!);
        var formattedNumber = totalRidePrice.toStringAsFixed(6);

        var totalRidePriceWithSymbol = "$formattedNumber ${item.symbol}";
        var totalPriceWithoutFormatter = "$totalRidePrice";

        totalPriceWithoutFormatterList.add(totalPriceWithoutFormatter);
        totalRidePriceWithSymboList.add(totalRidePriceWithSymbol);
        coinSymbol = item.symbol!;
        notifyListeners();
      }
    }
  }

  Future<void> loadContacts() async {
    Iterable<Contact> contactsFromDevice = await FlutterContacts.getContacts();
    contacts = contactsFromDevice.toList();
    filteredContacts = contacts;
    notifyListeners();
  }

  void updateSearchQuery(String query) {
    searchQuery = query;
    filteredContacts = contacts
        .where((contact) =>
            ((contact.displayName ?? '').toLowerCase()).contains(query.toLowerCase()))
        .toList();
    notifyListeners();
  }

  void toggleSelection(Contact contact) {
    if (pickUpSelectedContactsList.contains(contact)) {
      pickUpSelectedContactsList.remove(contact);
    } else {
      pickUpSelectedContactsList.add(contact);
    }
    notifyListeners();
  }

  void selectContact(Contact contact) {
    selectedContacts.add(contact);
    notifyListeners();
  }

  void clearList() {
    notifyListeners();
    resultDataList!.clear();
    
    notifyListeners();
  }

  @override
  void dispose() {
    current.clear();
    destination.clear();
    currentStop.clear();
    firstStop.clear();
    secondStop.clear();
    thirdStop.clear();
    result!.clear();
    resultDataList!.clear();
    super.dispose();
  }
}
