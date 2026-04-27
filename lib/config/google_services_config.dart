/// Models the structure of Android's google-services.json (Firebase config).
/// The actual file is consumed by the Gradle Google Services plugin at build time.
/// Use [DefaultFirebaseOptions] for runtime Firebase initialization in Dart.
class GoogleServicesConfig {
  GoogleServicesConfig({
    required this.projectInfo,
    required this.clients,
  });

  factory GoogleServicesConfig.fromJson(Map<String, dynamic> json) {
    return GoogleServicesConfig(
      projectInfo: ProjectInfo.fromJson(
        json['project_info'] as Map<String, dynamic>,
      ),
      clients: (json['client'] as List<dynamic>)
          .map((e) => ClientEntry.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  final ProjectInfo projectInfo;
  final List<ClientEntry> clients;

  /// Find the client entry for the given Android package name.
  ClientEntry? clientForPackage(String packageName) {
    try {
      return clients.firstWhere(
        (c) =>
            c.clientInfo.androidClientInfo?.packageName == packageName,
      );
    } catch (_) {
      return null;
    }
  }
}

class ProjectInfo {
  ProjectInfo({
    required this.projectId,
    required this.projectNumber,
    this.storageBucket,
    this.firebaseUrl,
  });

  factory ProjectInfo.fromJson(Map<String, dynamic> json) {
    return ProjectInfo(
      projectId: json['project_id'] as String,
      projectNumber: json['project_number'] as String,
      storageBucket: json['storage_bucket'] as String?,
      firebaseUrl: json['firebase_url'] as String?,
    );
  }

  final String projectId;
  final String projectNumber;
  final String? storageBucket;
  final String? firebaseUrl;
}

class ClientEntry {
  ClientEntry({
    required this.clientInfo,
    this.apiKey,
    this.oauthClients = const [],
  });

  factory ClientEntry.fromJson(Map<String, dynamic> json) {
    final apiKeyList = json['api_key'] as List<dynamic>?;
    final currentKey = apiKeyList?.isNotEmpty == true
        ? (apiKeyList!.first as Map<String, dynamic>)['current_key'] as String?
        : null;
    return ClientEntry(
      clientInfo: ClientInfo.fromJson(
        json['client_info'] as Map<String, dynamic>,
      ),
      apiKey: currentKey,
      oauthClients: (json['oauth_client'] as List<dynamic>?)
              ?.map((e) => e as Map<String, dynamic>)
              .toList() ??
          [],
    );
  }

  final ClientInfo clientInfo;
  final String? apiKey;
  final List<Map<String, dynamic>> oauthClients;
}

class ClientInfo {
  ClientInfo({
    required this.mobilesdkAppId,
    this.androidClientInfo,
  });

  factory ClientInfo.fromJson(Map<String, dynamic> json) {
    final android = json['android_client_info'] as Map<String, dynamic>?;
    return ClientInfo(
      mobilesdkAppId: json['mobilesdk_app_id'] as String,
      androidClientInfo: android != null
          ? AndroidClientInfo.fromJson(android)
          : null,
    );
  }

  final String mobilesdkAppId;
  final AndroidClientInfo? androidClientInfo;
}

class AndroidClientInfo {
  AndroidClientInfo({required this.packageName});

  factory AndroidClientInfo.fromJson(Map<String, dynamic> json) {
    return AndroidClientInfo(
      packageName: json['package_name'] as String,
    );
  }

  final String packageName;
}
