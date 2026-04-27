import '../../apppackages.dart';

class NetworkAlertBar extends StatelessWidget {
  const NetworkAlertBar({super.key});

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.signal_cellular_connected_no_internet_4_bar_rounded,
            size: 100,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(AppStrings.nointernet,
              style:blackHeading),
          Text(AppStrings.checkyourconnection,
              style:blackHeading),
        ],
      ),
    );
  }
}
