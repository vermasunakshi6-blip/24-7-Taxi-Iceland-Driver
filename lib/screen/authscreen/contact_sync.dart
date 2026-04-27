// ignore_for_file: use_build_context_synchronously
import 'package:flutter/cupertino.dart';

import '../../apppackages.dart';
import 'package:taxi_driver_24_7/screen/driver/home/driver_home_new.dart';

class ContactSync extends StatefulWidget {
  const ContactSync({super.key});
  @override
  ContactSyncState createState() => ContactSyncState();
}

class ContactSyncState extends State<ContactSync> {
  bool _completed = false;

  @override
  void initState() {
    super.initState();
    Future<void>.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() => _completed = true);
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const DriverHomeNew()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Container(
      decoration: const BoxDecoration(
        image: DecorationImage(
          image: AssetImage(AppImages.splashbg),
          fit: BoxFit.cover,
        ),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Center(
                  child: const AppLogo()),
              const SizedBox(
                height: 20,
              ),
              Text(
                "Your Profile is setting up",
                style: greyTitle,
                textAlign: TextAlign.center,
              ),
              _completed
                  ? const Text(' Profile Setup Completed')
                  : const CupertinoActivityIndicator(radius: 20)
            ],
          ),
        ],
      ),
    ));
  }

}
