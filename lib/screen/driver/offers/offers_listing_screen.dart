// ignore_for_file: use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:location/location.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:taxi_driver_24_7/model/driver_offer_by_driver_model.dart';
import 'package:taxi_driver_24_7/services/driver_apicall.dart';
import 'package:taxi_driver_24_7/utils/app_colors.dart';
import 'package:taxi_driver_24_7/utils/app_strings.dart';
import 'package:taxi_driver_24_7/utils/offers_validity.dart';
import 'package:taxi_driver_24_7/utils/prefconstant.dart';
import 'package:taxi_driver_24_7/utils/styles.dart';
import 'package:taxi_driver_24_7/widgets/common/snackbar.dart';

class OffersListingScreen extends StatefulWidget {
  const OffersListingScreen({super.key});

  @override
  State<OffersListingScreen> createState() => _OffersListingScreenState();
}

class _OffersListingScreenState extends State<OffersListingScreen> {
  final DriverApiCall _api = DriverApiCall();
  List<Offers> _items = [];
  bool _loading = true;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) => _load());
  }

  Future<void> _load() async {
    if (!mounted) return;
    setState(() => _loading = true);
    final prefs = await SharedPreferences.getInstance();
    final userId = prefs.getString(PrefConstant.userid);
    if (userId == null || userId.isEmpty) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final loc = Location();
    LocationData? data;
    try {
      data = await loc.getLocation();
    } catch (_) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    if (data.latitude == null || data.longitude == null) {
      if (mounted) setState(() => _loading = false);
      return;
    }
    final lat = data.latitude!;
    final lng = data.longitude!;
    final res = await _api.getOfferByDriver(context, userId, lat, lng);
    if (!mounted) return;
    final raw = List<Offers>.from(res?.offers ?? []);
    var filtered = OfferFilters.apply(raw, userLat: lat, userLng: lng);
    if (filtered.isEmpty && raw.isNotEmpty) {
      filtered = raw;
    }
    double sortKey(Offers o) {
      final rawD = o.distanceInKm ?? o.distance;
      if (rawD == null) return double.maxFinite;
      return rawD > 200 ? rawD / 1000 : rawD;
    }

    filtered.sort((a, b) => sortKey(a).compareTo(sortKey(b)));
    setState(() {
      _items = filtered;
      _loading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        iconTheme: const IconThemeData(color: AppColors.blackColor),
        title: Text(
          AppStrings.offers,
          style: blackTitle,
        ),
        centerTitle: true,
      ),
      body: RefreshIndicator(
        color: AppColors.redColor,
        onRefresh: _load,
        child: _loading
            ? ListView(
                physics: const AlwaysScrollableScrollPhysics(),
                children: const [
                  SizedBox(height: 120),
                  Center(child: CircularProgressIndicator(color: AppColors.redColor)),
                ],
              )
            : _items.isEmpty
                ? ListView(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.all(24),
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height * 0.25,
                      ),
                      Icon(Icons.local_offer_outlined,
                          size: 56, color: AppColors.greyColor),
                      const SizedBox(height: 16),
                      Text(
                        AppStrings.noOffersMatch,
                        textAlign: TextAlign.center,
                        style: greyTitleNormal,
                      ),
                    ],
                  )
                : ListView.separated(
                    physics: const AlwaysScrollableScrollPhysics(),
                    padding: const EdgeInsets.fromLTRB(16, 8, 16, 24),
                    itemCount: _items.length,
                    separatorBuilder: (_, __) => const SizedBox(height: 12),
                    itemBuilder: (context, index) {
                      return TweenAnimationBuilder<double>(
                        tween: Tween(begin: 0, end: 1),
                        duration: Duration(milliseconds: 350 + (index * 70)),
                        curve: Curves.easeOutCubic,
                        builder: (context, value, child) {
                          return Opacity(
                            opacity: value,
                            child: Transform.translate(
                              offset: Offset(0, 18 * (1 - value)),
                              child: child,
                            ),
                          );
                        },
                        child: _OfferCard(
                          offer: _items[index],
                          accentIndex: index,
                          onRedeem: () {
                            CSnackBar.showSnackBar(
                              AppStrings.redeemRequestPlaced,
                              context,
                            );
                          },
                        ),
                      );
                    },
                  ),
      ),
    );
  }
}

class _OfferCard extends StatelessWidget {
  const _OfferCard({
    required this.offer,
    required this.onRedeem,
    required this.accentIndex,
  });

  final Offers offer;
  final VoidCallback onRedeem;
  final int accentIndex;

  @override
  Widget build(BuildContext context) {
    final img = offer.offerImage?.trim();
    final title = offer.title?.trim().isNotEmpty == true
        ? offer.title!.trim()
        : AppStrings.offers;
    final business = offer.displayBusinessName;
    final slot = offer.timeSlotLabel;
    final tag = offer.displayTagLabel;
    final usageType = offer.usageType?.trim();
    final validFor = offer.validForLabel;

    final accent = _accentGradient(accentIndex);

    return AnimatedContainer(
      duration: const Duration(milliseconds: 220),
      curve: Curves.easeOut,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(16),
        gradient: accent,
        boxShadow: [
          BoxShadow(
            color: AppColors.primaryBlueStart.withOpacity(0.16),
            blurRadius: 16,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      padding: const EdgeInsets.all(1.2),
      child: Material(
        elevation: 0,
        borderRadius: BorderRadius.circular(15),
        color: Colors.white,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Stack(
                children: [
                  SizedBox(
                    height: 156,
                    child: img != null && img.isNotEmpty
                        ? Image.network(
                            img,
                            fit: BoxFit.cover,
                            width: double.infinity,
                            errorBuilder: (_, __, ___) => _imagePlaceholder(),
                          )
                        : _imagePlaceholder(),
                  ),
                  Positioned.fill(
                    child: DecoratedBox(
                      decoration: BoxDecoration(
                        gradient: LinearGradient(
                          begin: Alignment.topCenter,
                          end: Alignment.bottomCenter,
                          colors: [
                            Colors.transparent,
                            Colors.black.withOpacity(0.18),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(14, 12, 14, 14),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Expanded(
                        child: Text(
                          title,
                          style: blackTitle,
                          maxLines: 2,
                          overflow: TextOverflow.ellipsis,
                        ),
                      ),
                      const SizedBox(width: 8),
                      AnimatedContainer(
                        duration: const Duration(milliseconds: 250),
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 4),
                        decoration: BoxDecoration(
                          gradient: accent,
                          borderRadius: BorderRadius.circular(8),
                        ),
                        child: Text(
                          tag,
                          style: whiteTitle.copyWith(
                            fontSize: 12,
                            fontWeight: FontWeight.w700,
                            letterSpacing: 0.5,
                          ),
                        ),
                      ),
                    ],
                  ),
                  if (business.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.storefront_outlined,
                            size: 18, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            business,
                            style: greyTitleNormal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (slot.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.schedule_outlined,
                            size: 18, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Text(slot, style: blackTitleNormal),
                      ],
                    ),
                  ],
                  if (usageType != null && usageType.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.category_outlined,
                            size: 18, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${AppStrings.usageType}: $usageType',
                            style: blackTitleNormal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  if (validFor.isNotEmpty) ...[
                    const SizedBox(height: 8),
                    Row(
                      children: [
                        Icon(Icons.hourglass_bottom_outlined,
                            size: 18, color: AppColors.greyColor),
                        const SizedBox(width: 6),
                        Expanded(
                          child: Text(
                            '${AppStrings.validFor}: $validFor',
                            style: blackTitleNormal,
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                        ),
                      ],
                    ),
                  ],
                  const SizedBox(height: 12),
                  SizedBox(
                    width: double.infinity,
                    child: TweenAnimationBuilder<double>(
                      tween: Tween(begin: 0.98, end: 1),
                      duration: const Duration(milliseconds: 450),
                      curve: Curves.easeOutBack,
                      builder: (context, value, child) {
                        return Transform.scale(
                          scale: value,
                          child: child,
                        );
                      },
                      child: ElevatedButton.icon(
                        onPressed: onRedeem,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: AppColors.primaryBlueStart,
                          foregroundColor: Colors.white,
                          elevation: 0,
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(10),
                          ),
                          padding: const EdgeInsets.symmetric(vertical: 12),
                        ),
                        icon: const Icon(Icons.redeem_rounded, size: 18),
                        label: Text(
                          AppStrings.redeem,
                          style: whiteTitle.copyWith(fontSize: 14),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
      ),
    );
  }

  Widget _imagePlaceholder() {
    return Container(
      decoration: BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [
            AppColors.primaryBlueStart.withOpacity(0.15),
            AppColors.primaryBlueEnd.withOpacity(0.08),
          ],
        ),
      ),
      alignment: Alignment.center,
      child: Icon(
        Icons.local_offer_rounded,
        size: 48,
        color: AppColors.primaryBlueStart.withOpacity(0.6),
      ),
    );
  }

  LinearGradient _accentGradient(int index) {
    const combos = [
      [Color(0xFF1E5EFF), Color(0xFF3D7CFF)],
      [Color(0xFF7048E8), Color(0xFF9A6BFF)],
      [Color(0xFF0EA5E9), Color(0xFF22D3EE)],
      [Color(0xFF06B6D4), Color(0xFF3B82F6)],
    ];
    final c = combos[index % combos.length];
    return LinearGradient(
      begin: Alignment.topLeft,
      end: Alignment.bottomRight,
      colors: c,
    );
  }
}
