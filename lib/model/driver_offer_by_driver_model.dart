class DriverOfferByDriverModel {
  int? status;
  String? message;
  List<Offers>? offers;

  DriverOfferByDriverModel({this.status, this.message, this.offers});

  DriverOfferByDriverModel.fromJson(Map<String, dynamic> json) {
    status = _parseIntLoose(json['status']);
    message = json['message']?.toString();
    offers = <Offers>[];
    final rawList = _rawOffersList(json);
    for (final v in rawList) {
      try {
        if (v is Map<String, dynamic>) {
          offers!.add(Offers.fromJson(v));
        } else if (v is Map) {
          offers!.add(Offers.fromJson(Map<String, dynamic>.from(v)));
        }
      } catch (_) {
        /* skip malformed row */
      }
    }
  }

  static List<dynamic> _rawOffersList(Map<String, dynamic> json) {
    dynamic a =
        json['offers'] ?? json['data'] ?? json['result'] ?? json['offerList'];
    if (a is Map) {
      final inner = a['offers'] ?? a['data'] ?? a['list'] ?? a['items'];
      if (inner is List) return inner;
      if (a.containsKey('_id') || a.containsKey('title')) return [a];
    }
    if (a is List) return a;
    final single = json['offer'];
    if (single is Map) return [single];
    return const [];
  }

  static int? _parseIntLoose(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is bool) return v ? 1 : 0;
    return int.tryParse(v.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['status'] = this.status;
    data['message'] = this.message;
    if (this.offers != null) {
      data['offers'] = this.offers!.map((v) => v.toJson()).toList();
    }
    return data;
  }

  List<Offers> get displayableOffers {
    if (offers == null) return const [];
    return offers!
        .where((o) =>
            o.offerImage != null && o.offerImage!.trim().isNotEmpty)
        .toList();
  }

  Offers? get firstDisplayableOffer {
    final list = displayableOffers;
    return list.isEmpty ? null : list.first;
  }
}

class Offers {
  String? sId;
  String? businessId;
  /// Display name when API sends it (or nested business).
  String? businessName;
  /// Short label e.g. "2F1".
  String? tag;
  String? title;
  String? description;
  String? offerType;
  String? offerImage;
  String? startDate;
  String? endDate;
  String? startTime;
  String? endTime;
  List<String>? validDays;
  int? usageLimitPerUser;
  String? usageType;
  FromAreaLocation? fromAreaLocation;
  String? address;
  int? isActive;
  int? status;
  String? createdAt;
  String? updatedAt;
  int? iV;
  double? distance;
  String? startDateTime;
  String? endDateTime;
  String? endDateTimeAdjusted;
  double? distanceInKm;

  Offers(
      {this.sId,
      this.businessId,
      this.businessName,
      this.tag,
      this.title,
      this.description,
      this.offerType,
      this.offerImage,
      this.startDate,
      this.endDate,
      this.startTime,
      this.endTime,
      this.validDays,
      this.usageLimitPerUser,
      this.usageType,
      this.fromAreaLocation,
      this.address,
      this.isActive,
      this.status,
      this.createdAt,
      this.updatedAt,
      this.iV,
      this.distance,
      this.startDateTime,
      this.endDateTime,
      this.endDateTimeAdjusted,
      this.distanceInKm});

  Offers.fromJson(Map<String, dynamic> json) {
    sId = json['_id']?.toString();
    businessId = json['businessId']?.toString();
    businessName = json['businessName']?.toString() ??
        json['business_name']?.toString();
    if (businessName == null || businessName!.trim().isEmpty) {
      final b = json['business'];
      if (b is Map) {
        businessName = b['name']?.toString() ?? b['businessName']?.toString();
      }
    }
    tag = json['tag']?.toString() ??
        json['offerTag']?.toString() ??
        json['shortCode']?.toString();
    title = json['title'];
    description = json['description'];
    offerType = json['offerType']?.toString();
    offerImage = json['offerImage']?.toString() ??
        json['image']?.toString() ??
        json['bannerPic']?.toString() ??
        json['offer_image']?.toString();
    startDate = json['startDate']?.toString();
    endDate = json['endDate']?.toString();
    startTime = json['startTime']?.toString();
    endTime = json['endTime']?.toString();
    if (json['validDays'] != null) {
      validDays =
          (json['validDays'] as List).map((e) => e.toString()).toList();
    }
    usageLimitPerUser = json['usageLimitPerUser'];
    usageType = json['usageType'];
    final geo = json['from_area_location'] ?? json['fromAreaLocation'];
    fromAreaLocation = geo is Map
        ? FromAreaLocation.fromJson(Map<String, dynamic>.from(geo))
        : null;
    address = json['address']?.toString();
    isActive = _parseIntLoose(json['isActive']);
    status = _parseIntLoose(json['status']);
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    iV = json['__v'];
    distance = _parseDoubleLoose(json['distance']);
    startDateTime = json['startDateTime'];
    endDateTime = json['endDateTime'];
    endDateTimeAdjusted = json['endDateTimeAdjusted'];
    distanceInKm = _parseDoubleLoose(
        json['distanceInKm'] ?? json['distance_in_km']);
  }

  static int? _parseIntLoose(dynamic v) {
    if (v == null) return null;
    if (v is int) return v;
    if (v is double) return v.toInt();
    if (v is bool) return v ? 1 : 0;
    return int.tryParse(v.toString());
  }

  static double? _parseDoubleLoose(dynamic v) {
    if (v == null) return null;
    if (v is double) return v;
    if (v is int) return v.toDouble();
    return double.tryParse(v.toString());
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['_id'] = this.sId;
    data['businessId'] = this.businessId;
    data['businessName'] = this.businessName;
    data['tag'] = this.tag;
    data['title'] = this.title;
    data['description'] = this.description;
    data['offerType'] = this.offerType;
    data['offerImage'] = this.offerImage;
    data['startDate'] = this.startDate;
    data['endDate'] = this.endDate;
    data['startTime'] = this.startTime;
    data['endTime'] = this.endTime;
    data['validDays'] = this.validDays;
    data['usageLimitPerUser'] = this.usageLimitPerUser;
    data['usageType'] = this.usageType;
    if (this.fromAreaLocation != null) {
      data['from_area_location'] = this.fromAreaLocation!.toJson();
    }
    data['address'] = this.address;
    data['isActive'] = this.isActive;
    data['status'] = this.status;
    data['createdAt'] = this.createdAt;
    data['updatedAt'] = this.updatedAt;
    data['__v'] = this.iV;
    data['distance'] = this.distance;
    data['startDateTime'] = this.startDateTime;
    data['endDateTime'] = this.endDateTime;
    data['endDateTimeAdjusted'] = this.endDateTimeAdjusted;
    data['distanceInKm'] = this.distanceInKm;
    return data;
  }

  String get displayBusinessName {
    final n = businessName?.trim();
    if (n != null && n.isNotEmpty) return n;
    final id = businessId?.trim();
    if (id != null && id.isNotEmpty) return id;
    return '';
  }

  String get displayTagLabel {
    final t = tag?.trim();
    if (t != null && t.isNotEmpty) return t.toUpperCase();
    final ot = offerType?.trim();
    if (ot != null && ot.isNotEmpty) {
      final cleaned =
          ot.replaceAll(RegExp(r'[^a-zA-Z0-9]'), '').toUpperCase();
      if (cleaned.length >= 2) {
        return cleaned.length > 8 ? cleaned.substring(0, 8) : cleaned;
      }
    }
    return 'OFFER';
  }

  String get timeSlotLabel {
    final a = startTime?.trim();
    final b = endTime?.trim();
    if (a == null || a.isEmpty || b == null || b.isEmpty) return '';
    return '${_shortClock(a)} – ${_shortClock(b)}';
  }

  /// Human-readable remaining validity from date+time.
  /// Examples: "2d 4h", "3h 20m", "45m", "Expired".
  String get validForLabel {
    final now = DateTime.now();
    final end = _resolveEndDateTime();
    if (end == null) return '';
    final diff = end.difference(now);
    if (diff.inSeconds <= 0) return 'Expired';
    return _formatDuration(diff);
  }

  DateTime? _resolveEndDateTime() {
    // Prefer explicit API combined fields.
    final explicit = _tryParseDateTime(
      endDateTimeAdjusted?.trim().isNotEmpty == true
          ? endDateTimeAdjusted!
          : endDateTime,
    );
    if (explicit != null) return explicit;
    if (endDate == null || endDate!.trim().isEmpty) return null;
    final date = _tryParseDateTime(endDate!);
    if (date == null) return null;
    final endMinutes = _toMinutes(endTime);
    if (endMinutes == null) {
      return DateTime(date.year, date.month, date.day, 23, 59, 59);
    }
    return DateTime(
      date.year,
      date.month,
      date.day,
      endMinutes ~/ 60,
      endMinutes % 60,
    );
  }

  static DateTime? _tryParseDateTime(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    return DateTime.tryParse(raw.trim());
  }

  static int? _toMinutes(String? raw) {
    if (raw == null || raw.trim().isEmpty) return null;
    try {
      final parts = raw.trim().split(':');
      if (parts.isEmpty) return null;
      final h = int.parse(parts[0].trim());
      final m = parts.length > 1 ? int.parse(parts[1].trim()) : 0;
      return h * 60 + m;
    } catch (_) {
      return null;
    }
  }

  static String _formatDuration(Duration d) {
    final days = d.inDays;
    final hours = d.inHours % 24;
    final mins = d.inMinutes % 60;
    if (days > 0) {
      return hours > 0 ? '${days}d ${hours}h' : '${days}d';
    }
    if (d.inHours > 0) {
      return mins > 0 ? '${d.inHours}h ${mins}m' : '${d.inHours}h';
    }
    return '${d.inMinutes}m';
  }

  static String _shortClock(String raw) {
    final parts = raw.split(':');
    if (parts.length >= 2) {
      return '${parts[0]}:${parts[1].padLeft(2, '0')}';
    }
    return raw;
  }
}

class FromAreaLocation {
  String? type;
  List<double>? coordinates;

  FromAreaLocation({this.type, this.coordinates});

  FromAreaLocation.fromJson(Map<String, dynamic> json) {
    type = json['type']?.toString();
    if (json['coordinates'] != null) {
      coordinates = (json['coordinates'] as List)
          .map((e) => (e as num).toDouble())
          .toList();
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['type'] = this.type;
    data['coordinates'] = this.coordinates;
    return data;
  }
}