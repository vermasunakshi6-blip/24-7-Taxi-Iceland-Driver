import '../apppackages.dart';

class DefaultFirebaseOptions {
  static FirebaseOptions get currentPlatform {
    switch (defaultTargetPlatform) {
      case TargetPlatform.android:
        return android;
      case TargetPlatform.iOS:
        return ios;

      case TargetPlatform.windows:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for windows - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      case TargetPlatform.linux:
        throw UnsupportedError(
          'DefaultFirebaseOptions have not been configured for linux - '
          'you can reconfigure this by running the FlutterFire CLI again.',
        );
      default:
        throw UnsupportedError(
          'DefaultFirebaseOptions are not supported for this platform.',
        );
    }
  }

  static const FirebaseOptions android = FirebaseOptions(
    apiKey: 'AIzaSyD180swgk5opmNM0a53aBsnc2qeUJRcVVE',
    appId: '1:991361992929:android:fe4c6fd1b67ff7c4558fa0',
    messagingSenderId: '991361992929',
    projectId: 'leggoo-4779a',
  );

  static const FirebaseOptions ios = FirebaseOptions(
    apiKey: 'AIzaSyB181iysHomu0wJhO9Pt4Hn3x_tGA9rxCI',
    appId: '1:976004896608:ios:261a5f2810df5da21db005',
    messagingSenderId: '976004896608',
    projectId: 'taxi-b3256',
    storageBucket: 'taxi-b3256.firebasestorage.app',
    iosBundleId: 'com.twentyfourseven.driver',
  );
}


 
  