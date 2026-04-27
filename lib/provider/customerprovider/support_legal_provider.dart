// ignore_for_file: use_build_context_synchronously

import 'package:taxi_driver_24_7/apppackages.dart';
import 'package:taxi_driver_24_7/model/faq_model.dart';
import 'package:taxi_driver_24_7/model/get_contact_support_model.dart';
import 'package:taxi_driver_24_7/model/get_faq_titles_model.dart';
import 'package:taxi_driver_24_7/model/legal_data_model.dart';
import 'package:taxi_driver_24_7/model/notification_status_model.dart';
import 'package:taxi_driver_24_7/screen/shared/account_screens/emergency_assistance.dart';

class SupportLegalProvider extends ChangeNotifier {
  CustomerApiCall apiCall = CustomerApiCall();
  bool isLoading = true;
  bool legalisLoading = true;
  List<FaqTitleData> faqTitles = [];
  List<FaqData> faqData = [];
  List<FaqData> filteredData = [];
  String faqId = '';

  List<ContactData>? contactData;

  List<LegalData>? legalData;
  NotificationData allnotifications = NotificationData(
    pushNotification: 0,
    rideAlerts: 0,
    bookingConfirmation: 0,
    rideStatusUpdate: 0,
    pickUpDropOff: 0,
    ratintRequests: 0,
    rideCompletion: 0,
    paymentConfirmation: 0,
    driverDetail: 0,
    eventNotifications: 0,
    inAppEvents: 0,
    eventReminder: 0,
    eventCancellations: 0,
    liveEventsUpdate: 0,
    specialOffersRelatedEvents: 0,
    promotionsAndOffers: 0,
    discountsAndCoupons: 0,
    featureUpdate: 0,
    holidaySeasonalPromotions: 0,
    mandatoryUpdate: 0,
    partnerOffers: 0,
    performanceImprovements: 0,
    referralProgramOffers: 0,
    securityUpdate: 0,
    subscriptionBasedOffers: 0,
    syatemUpdate: 0,
  );

  Future<void> getFaqTitles(BuildContext context) async {
    isLoading = true;
    notifyListeners();
    final res = await apiCall.getFaqTitles(context);
    isLoading = false;
    notifyListeners();
    if (res.status == 1) {
      faqTitles = res.data ?? [];

      selectFaqTitle(context, faqTitles.first.sId!);
      notifyListeners();
    } else {
      faqTitles = [];
      notifyListeners();
      CSnackBar.showSnackBarError('Something went wrong!', context);
    }
  }

  void selectFaqTitle(BuildContext context, String faqid) {
    faqId = faqid;
    getFaqs(context, faqId);
  }

  Future<void> getFaqs(BuildContext context, String faqId) async {
    isLoading = true;
    notifyListeners();
    final res = await apiCall.getFaqs(context, faqId);
    isLoading = false;
    notifyListeners();
    if (res.status == 1) {
      faqData = res.data ?? [];
      filteredData = faqData;
      notifyListeners();
    } else {
      faqData = [];
      notifyListeners();
      CSnackBar.showSnackBarError('Something went wrong!', context);
    }
  }

  void searchUsers(String query) {
    filteredData = faqData
        .where((user) =>
            user.question!.toLowerCase().contains(query.toLowerCase()))
        .toList();
   
    notifyListeners();
  }

  Future<void> sendsupportemail(BuildContext context, String userid,
      String subject, String message) async {
    ProgressDialog.show(context);
    notifyListeners();
    final res =
        await apiCall.sendemailsupport(context, userid, subject, message);
    isLoading = false;
    notifyListeners();
    if (res.status == 1) {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBar(res.message!, context);
      Navigator.pop(context);
      notifyListeners();
    } else {
      ProgressDialog.hide(context);
      notifyListeners();
      CSnackBar.showSnackBarError('Something went wrong!', context);
    }
  }

  Future<void> reportproblem(BuildContext context, String userid, String issue,
      String description, List<String>? path) async {
    ProgressDialog.show(context);
    notifyListeners();
    final response =
        await apiCall.reportproblem(context, userid, issue, description, path!);

    notifyListeners();

    if (response.status == 1) {
      ProgressDialog.hide(context);
      CSnackBar.showSnackBar(response.message!, context);
      Navigator.pop(context);
      notifyListeners();
    } else {
      ProgressDialog.hide(context);
      notifyListeners();
      CSnackBar.showSnackBarError('Something went wrong!', context);
    }
  }

  Future<void> addcontact(
      BuildContext context, String userid, String name, String number) async {
    ProgressDialog.show(context);
    notifyListeners();
    final res = await apiCall.addContact(context, userid, name, number);
    isLoading = false;
    notifyListeners();
    if (res.status == 1) {
      ProgressDialog.hide(context);

      Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => const EmergencyAssistance(),
          ));
      notifyListeners();
    } else {
      ProgressDialog.hide(context);
      notifyListeners();
      CSnackBar.showSnackBarError('Something went wrong!', context);
    }
  }

  Future<void> getContacts(BuildContext context, String userid) async {
    isLoading = true;
    notifyListeners();
    final res = await apiCall.getEmergencyContacts(context, userid);
    isLoading = false;
    notifyListeners();
    if (res.status == 1) {
      contactData = res.data ?? [];

      notifyListeners();
    } else {
      contactData = [];
      notifyListeners();
      CSnackBar.showSnackBarError('Something went wrong!', context);
    }
  }

  Future<void> getLegalData(BuildContext context, String userid) async {
    legalisLoading = true;
    notifyListeners();
    final res = await apiCall.getlegaldata(context, userid);
    legalisLoading = false;
    notifyListeners();
    if (res.status == 1) {
      legalData = res.data ?? [];
      // CSnackBar.showSnackBar(res.message!, context);
    } else {
      legalData = [];
      CSnackBar.showSnackBarError('Something went wrong!', context);
      notifyListeners();
    }
  }

  Future<void> allNotificationSettings(BuildContext context, String userId,
      String type, int pushNotification) async {
    ProgressDialog.show(context);
    notifyListeners();
    final res = await apiCall.allNotificationSettings(
        context, userId, type, pushNotification);
    if (res.status == 1) {
      ProgressDialog.hide(context);
      notifyListeners();
      await getNotificationStatus(context, userId);
    } else {
      ProgressDialog.hide(context);
      notifyListeners();
      CSnackBar.showSnackBarError(res.message!, context);
    }
  }

  Future<void> singleNotificationSettings(
      BuildContext context, String userId, String fieldName, int value) async {
    ProgressDialog.show(context);
    notifyListeners();
    final res = await apiCall.singleNotificationSettings(
        context, userId, fieldName, value);
    if (res.status == 1) {
      ProgressDialog.hide(context);
      notifyListeners();
      await getNotificationStatus(context, userId);
    } else {
      ProgressDialog.hide(context);
      notifyListeners();
      CSnackBar.showSnackBarError(res.message!, context);
    }
  }

  Future<void> getNotificationStatus(
    BuildContext context,
    String userId,
  ) async {
    ProgressDialog.show(context);
    notifyListeners();
    final res = await apiCall.getNotificationStatus(
      context,
      userId,
    );
    if (res.status == 1) {
      ProgressDialog.hide(context);
      allnotifications = res.data!;
      notifyListeners();
    } else {
      ProgressDialog.hide(context);
      notifyListeners();
      CSnackBar.showSnackBarError(res.message!, context);
    }
  }
}
