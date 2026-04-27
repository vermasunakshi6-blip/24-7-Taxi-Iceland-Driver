import 'dart:math';

import 'package:intl/intl.dart';
import 'package:taxi_driver_24_7/model/driver_offer_by_driver_model.dart';

/// Client-side filtering: nearby, active flags, calendar date range, weekday, time-of-day.
class OfferFilters {
  OfferFilters._();

  /// Max distance from user to offer location (km). Offers without location info are kept if API may have pre-filtered.
  static const double defaultMaxDistanceKm = 80;

  static List<Offers> apply(
    List<Offers> offers, {
    required double userLat,
    required double userLng,
    double maxDistanceKm = defaultMaxDistanceKm,
  }) {
    final now = DateTime.now();
    return offers.where((o) {
      if (!_isActiveOffer(o)) return false;
      if (!_inDateRange(o, now)) return false;
      if (!_matchesValidDay(o, now)) return false;
      if (!_inTimeWindow(o, now)) return false;
      if (!_isNearby(o, userLat, userLng, maxDistanceKm)) return false;
      return true;
    }).toList();
  }

  static bool _isActiveOffer(Offers o) {
    if (o.isActive != null && o.isActive == 0) return false;
    if (o.status != null && o.status == 0) return false;
    return true;
  }

  static bool _inDateRange(Offers o, DateTime now) {
    final d = DateTime(now.year, now.month, now.day);
    try {
      if (o.startDate != null && o.startDate!.trim().isNotEmpty) {
        final s = DateTime.parse(o.startDate!.trim());
        final sd = DateTime(s.year, s.month, s.day);
        if (d.isBefore(sd)) return false;
      }
      if (o.endDate != null && o.endDate!.trim().isNotEmpty) {
        final e = DateTime.parse(o.endDate!.trim());
        final ed = DateTime(e.year, e.month, e.day);
        if (d.isAfter(ed)) return false;
      }
    } catch (_) {
      /* ignore parse errors; don’t hide offers */
    }
    return true;
  }

  static bool _matchesValidDay(Offers o, DateTime now) {
    final days = o.validDays;
    if (days == null || days.isEmpty) return true;
    final short = DateFormat('EEE', 'en_US').format(now).toLowerCase();
    final full = DateFormat('EEEE', 'en_US').format(now).toLowerCase();
    final weekday = now.weekday;
    for (final raw in days) {
      final n = raw.trim().toLowerCase();
      if (n.isEmpty) continue;
      final asNum = int.tryParse(n);
      if (asNum != null && asNum >= 1 && asNum <= 7 && asNum == weekday) {
        return true;
      }
      if (n == short || n == full) return true;
      if (full.startsWith(n) || short.startsWith(n)) return true;
      if (n.length >= 3 && (full.contains(n) || short.contains(n))) {
        return true;
      }
    }
    return false;
  }

  static bool _inTimeWindow(Offers o, DateTime now) {
    final start = o.startTime;
    final end = o.endTime;
    if (start == null ||
        end == null ||
        start.trim().isEmpty ||
        end.trim().isEmpty) {
      return true;
    }
    final s = _minutesSinceMidnight(start.trim());
    final e = _minutesSinceMidnight(end.trim());
    if (s == null || e == null) return true;
    final cur = now.hour * 60 + now.minute;
    if (e >= s) {
      return cur >= s && cur <= e;
    }
    return cur >= s || cur <= e;
  }

  static int? _minutesSinceMidnight(String t) {
    try {
      final s = t.trim();
      if (s.contains('T') || s.length > 12) {
        final dt = DateTime.tryParse(s);
        if (dt != null) return dt.hour * 60 + dt.minute;
      }
      final parts = s.split(':');
      if (parts.isEmpty) return null;
      final h = int.parse(parts[0].trim());
      final sec = parts.length > 1 ? parts[1].trim() : '0';
      final mPart = sec.split(RegExp(r'[^0-9]')).first;
      final m = int.tryParse(mPart) ?? 0;
      return h * 60 + m;
    } catch (_) {
      return null;
    }
  }

  static bool _isNearby(
    Offers o,
    double userLat,
    double userLng,
    double maxKm,
  ) {
    double? km = _distanceToKm(o.distanceInKm ?? o.distance);
    if (km != null && km >= 0) {
      return km <= maxKm;
    }
    final coords = o.fromAreaLocation?.coordinates;
    if (coords != null && coords.length >= 2) {
      final offerLng = coords[0];
      final offerLat = coords[1];
      km = _haversineKm(userLat, userLng, offerLat, offerLng);
      return km <= maxKm;
    }
    return true;
  }

  static double _haversineKm(double lat1, double lon1, double lat2, double lon2) {
    const p = pi / 180;
    final a = 0.5 -
        cos((lat2 - lat1) * p) / 2 +
        cos(lat1 * p) * cos(lat2 * p) * (1 - cos((lon2 - lon1) * p)) / 2;
    return 12742 * asin(sqrt(a));
  }

  /// Treat very large values as meters (e.g. 8500 → 8.5 km).
  static double? _distanceToKm(double? raw) {
    if (raw == null || raw < 0) return null;
    if (raw > 200) return raw / 1000;
    return raw;
  }
}
