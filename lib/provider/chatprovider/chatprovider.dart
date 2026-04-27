// ignore_for_file: use_build_context_synchronously

import '../../apppackages.dart';

class ChatProvider extends ChangeNotifier {
  final CustomerApiCall apiProvider = CustomerApiCall();
  bool isloading = false;

  List<Data>? chatDetails;
  List<String> riderMessages = [
    'Hi, I’m at the pick up spot',
    'I see you!',
    'I’ll be there shortly.',
    'Sorry, I’m running late , be there shortly!',
    ' How far away are you?',
    'No worries, take your time',
    'Sorry, I can’t take the ride.',
    ' I need to cancel the ride please.'
  ];
  List<String> driverMessages = [
    'I’ve arrived at the pick up location.',
    'I’m  here',
    'Where exactly are you?',
    'Please hurry up.',
    ' I’m almost there.',
    ' Traffic is a bit tight, be there soon!',
    'Sorry for the delay, I’m almost there!',
    'Been waiting a while, might cancel soon.',
    ' Please cancel the ride in app',
  ];

  //Get Profile >
  Future<void> getChat(String? rideid, BuildContext context) async {
    isloading = true;
    notifyListeners();
    final response = await apiProvider.getChat(context,rideid!);
    isloading = false;
    notifyListeners();
    if (response.status == 1) {
      chatDetails = response.data;
    } else {
      CSnackBar.showSnackBarError(response.message.toString(), context);
    }
  }
}
