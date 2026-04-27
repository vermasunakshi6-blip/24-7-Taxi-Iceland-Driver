
import Flutter
import UIKit
import FirebaseCore
import FirebaseAuth
import FirebaseMessaging
import UserNotifications
import GoogleMaps

@main
@objc class AppDelegate: FlutterAppDelegate, MessagingDelegate {

  override func application(
    _ application: UIApplication,
    didFinishLaunchingWithOptions launchOptions: [UIApplication.LaunchOptionsKey: Any]?
  ) -> Bool {

    // Initialize Google Maps SDK once (required for map to render on iOS).
    // Must be called only here to avoid "Multiple instances of CCTClearcutUploader" / battery impact.
    GMSServices.provideAPIKey("AIzaSyAM465_XcJsUsGli-7_-pBnkILFVpy6LOs")

    // Initialize Firebase
    FirebaseApp.configure()

    // Register Flutter plugins
    GeneratedPluginRegistrant.register(with: self)

    // Notification permission
    if #available(iOS 10.0, *) {
      UNUserNotificationCenter.current().delegate = self

      let authOptions: UNAuthorizationOptions = [.alert, .badge, .sound]
      UNUserNotificationCenter.current().requestAuthorization(
        options: authOptions,
        completionHandler: { _, _ in }
      )
    }

    application.registerForRemoteNotifications()

    // FCM delegate
    Messaging.messaging().delegate = self

    return super.application(application, didFinishLaunchingWithOptions: launchOptions)
  }

  // MARK: Custom URL (Firebase Phone Auth reCAPTCHA callback)
  override func application(
    _ application: UIApplication,
    open url: URL,
    options: [UIApplication.OpenURLOptionsKey: Any] = [:]
  ) -> Bool {
    if Auth.auth().canHandle(url) {
      return true
    }
    return super.application(application, open: url, options: options)
  }

  // MARK: APNs Token
  override func application(
    _ application: UIApplication,
    didRegisterForRemoteNotificationsWithDeviceToken deviceToken: Data
  ) {
    Messaging.messaging().apnsToken = deviceToken
  }

  // MARK: APNs Error
  override func application(
    _ application: UIApplication,
    didFailToRegisterForRemoteNotificationsWithError error: Error
  ) {
    print("Failed to register for remote notifications: \(error.localizedDescription)")
  }

  // MARK: Background Notification
  // Call completionHandler exactly once. Super forwards it to Flutter/Firebase, which will invoke it.
  override func application(
    _ application: UIApplication,
    didReceiveRemoteNotification userInfo: [AnyHashable : Any],
    fetchCompletionHandler completionHandler: @escaping (UIBackgroundFetchResult) -> Void
  ) {
    Messaging.messaging().appDidReceiveMessage(userInfo)
    super.application(application,
                      didReceiveRemoteNotification: userInfo,
                      fetchCompletionHandler: completionHandler)
  }

  // MARK: FCM Token
  func messaging(_ messaging: Messaging, didReceiveRegistrationToken fcmToken: String?) {
      print("FCM Token: \(fcmToken ?? "")")
  }

  // MARK: Foreground Notification (iOS 10+)
  @available(iOS 10.0, *)
  override func userNotificationCenter(
      _ center: UNUserNotificationCenter,
      willPresent notification: UNNotification,
      withCompletionHandler completionHandler:
      @escaping (UNNotificationPresentationOptions) -> Void) {

      completionHandler([.alert, .sound, .badge])
  }
}