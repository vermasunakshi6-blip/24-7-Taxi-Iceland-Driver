import 'package:taxi_driver_24_7/model/legal_data_model.dart';
import 'package:taxi_driver_24_7/provider/customerprovider/support_legal_provider.dart';
import '../../../../apppackages.dart';

class AboutUsStaticDriver extends StatefulWidget {
  const AboutUsStaticDriver({super.key});

  @override
  State<AboutUsStaticDriver> createState() => _AboutUsStaticDriverState();
}

class _AboutUsStaticDriverState extends State<AboutUsStaticDriver> {
  SharedPreferences? prefs;
  String? userId;

  @override
  void initState() {
    super.initState();
    _loadLegalData();
  }

  Future<void> _loadLegalData() async {
    prefs = await SharedPreferences.getInstance();
    userId = prefs!.getString(PrefConstant.userid);
    if (!mounted) return;
    final supportProvider =
        Provider.of<SupportLegalProvider>(context, listen: false);
    if (supportProvider.legalData == null ||
        supportProvider.legalData!.isEmpty) {
      await supportProvider.getLegalData(context, userId ?? '');
    }
  }

  @override
  Widget build(BuildContext context) {
    final supportProvider = Provider.of<SupportLegalProvider>(context);
    final list = supportProvider.legalData ?? [];
    LegalData? aboutItem;
    for (final e in list) {
      final title = (e.title ?? '').toLowerCase();
      if (title.contains('about')) {
        aboutItem = e;
        break;
      }
    }

    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          onPressed: () => Navigator.pop(context),
          icon: const Image(
            height: 22,
            image: AssetImage(AppImages.arrowback),
          ),
        ),
        title: Text(
          AppStrings.aboutus.toUpperCase(),
          style: greyHeading,
        ),
      ),
      body: supportProvider.legalisLoading
          ? const Center(
              child: CircularProgressIndicator(
                color: AppColors.blackColor,
                strokeWidth: 2,
              ),
            )
          : SingleChildScrollView(
              padding: const EdgeInsets.all(16),
              child: Html(
                data: aboutItem?.content ?? '',
              ),
            ),
    );
  }
}

