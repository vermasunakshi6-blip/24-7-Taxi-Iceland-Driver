import 'package:taxi_driver_24_7/provider/authprovider/login_provider.dart';
import '../../apppackages.dart';

class LogoutDialog extends StatefulWidget {
  final String? userid, deviceToken;

  const LogoutDialog({
    super.key,
    this.userid,
    this.deviceToken,
  });

  @override
  State<LogoutDialog> createState() => _LogoutDialogState();
}

class _LogoutDialogState extends State<LogoutDialog> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final loginProvider = Provider.of<LoginProvider>(context);
    return AlertDialog(
      insetPadding: const EdgeInsets.all(15),
      backgroundColor: Colors.white,
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Padding(
            padding: const EdgeInsets.only(
                left: 5.0, right: 5.0, top: 10, bottom: 10),
            child: SizedBox(
              width: MediaQuery.of(context).size.width,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Text(
                    '${AppStrings.logout}?',
                    style: blackHeading,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    AppStrings.suretologout,
                    style: greyTitle,
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      SizedBox(
                        height: 40,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () {
                            Navigator.of(context).pop();
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            padding: EdgeInsets.zero,
                            side: const BorderSide(
                              width: 1,
                              color: AppColors.greyColor,
                            ),
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), 
                            ),
                          ),
                          child: Text(
                            AppStrings.cancel,
                            style: blackHeading,
                          ),
                        ),
                      ),
                      SizedBox(
                        height: 40,
                        width: 140,
                        child: ElevatedButton(
                          onPressed: () async {
                            setState(() {
                              loginProvider.isLoading=true;
                            });
                            await loginProvider.logout(
                                context, widget.userid, widget.deviceToken);
                                setState(() {
                              loginProvider.isLoading=false;
                            });
                          },
                          style: ElevatedButton.styleFrom(
                            backgroundColor: AppColors.primaryBlueStart,
                            padding: EdgeInsets.zero,
                            shape: RoundedRectangleBorder(
                              borderRadius:
                                  BorderRadius.circular(30), 
                            ),
                          ),
                          child: Text(
                            AppStrings.logout.toLowerCase(),
                            style: whiteHeading,
                          ),
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}
