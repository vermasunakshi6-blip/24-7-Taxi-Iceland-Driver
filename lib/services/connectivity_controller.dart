import '../apppackages.dart';

class ConnectivityController {
  ValueNotifier<bool> isConnected = ValueNotifier(false);

  Future<void> init() async {
    List<ConnectivityResult> result = await Connectivity().checkConnectivity();
    isInternetConnected(result);
    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      isInternetConnected(result);
    });
  }

  bool isInternetConnected(List<ConnectivityResult>? result) {
    if (result == null || result.isEmpty) {
      isConnected.value = false;
      return false;
    }
    final connected = result.contains(ConnectivityResult.mobile) ||
        result.contains(ConnectivityResult.wifi);
    isConnected.value = connected;
    return connected;
  }
}
