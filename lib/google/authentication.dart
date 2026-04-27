// ignore_for_file: use_build_context_synchronously

import '../apppackages.dart';

class Authentication {
  static Future<FirebaseApp> initializeFirebase({
    required BuildContext context,
  }) async {
    FirebaseApp firebaseApp;
    try {
      if (Firebase.apps.isEmpty) {
        firebaseApp = await Firebase.initializeApp();
      } else {
        firebaseApp = Firebase.app();
      }
    } catch (e) {
      // Firebase might already be initialized, ignore duplicate app error
      final errorString = e.toString().toLowerCase();
      if (errorString.contains('duplicate-app') || 
          errorString.contains('already exists') ||
          errorString.contains('[default]')) {
        firebaseApp = Firebase.app();
      } else {
        rethrow;
      }
    }

    User? user = FirebaseAuth.instance.currentUser;

    if (user != null) {
      Navigator.of(context).pushReplacement(
        MaterialPageRoute(
          builder: (context) => UserInfoScreen(
            user: user,
          ),
        ),
      );
    }
    return firebaseApp;
  }

  static Future<User?> signInWithGoogle({required BuildContext context}) async {
    FirebaseAuth auth = FirebaseAuth.instance;
    User? user;

    if (kIsWeb) {
      GoogleAuthProvider authProvider = GoogleAuthProvider();

      try {
        final UserCredential userCredential =
            await auth.signInWithPopup(authProvider);

        user = userCredential.user;
      } catch (e) {
        // print(e);
      }
    } else {
      final GoogleSignIn googleSignIn = GoogleSignIn.instance;
      await googleSignIn.initialize();

      GoogleSignInAccount? googleSignInAccount;
      try {
        googleSignInAccount = await googleSignIn.authenticate();
      } catch (_) {
        // User cancelled or error
        googleSignInAccount = null;
      }

      if (googleSignInAccount != null) {
        final GoogleSignInAuthentication googleSignInAuthentication =
            googleSignInAccount.authentication;

        final AuthCredential credential = GoogleAuthProvider.credential(
          idToken: googleSignInAuthentication.idToken,
        );

        try {
          final UserCredential userCredential =
              await auth.signInWithCredential(credential);

          user = userCredential.user;
        } on FirebaseAuthException catch (e) {
          if (e.code == 'account-exists-with-different-credential') {
            CSnackBar.showSnackBar(
                "The account already exists with a different credential",
                context);
          } else if (e.code == 'invalid-credential') {
            CSnackBar.showSnackBar(
                "Error occurred while accessing credentials. Try again.",
                context);
          }
        } catch (e) {
          CSnackBar.showSnackBar(
              "Error occurred using Google Sign In. Try again.", context);
        }
      }
    }

    return user;
  }

  static Future<void> signOut({required BuildContext context}) async {
    final GoogleSignIn googleSignIn = GoogleSignIn.instance;

    try {
      if (!kIsWeb) {
        await googleSignIn.signOut();
      }
      await FirebaseAuth.instance.signOut();
    } catch (e) {
      CSnackBar.showSnackBar("Error signing out. Try again.", context);
    }
  }
}
