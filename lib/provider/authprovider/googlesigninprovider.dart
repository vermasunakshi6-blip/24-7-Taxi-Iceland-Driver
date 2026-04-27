
import '../../apppackages.dart';
// ignore_for_file: use_build_context_synchronously

class GoogleSignInProvider extends ChangeNotifier {
  Future<void> googleSignIn(BuildContext context) async {
    notifyListeners();
    User? user = await Authentication.signInWithGoogle(context: context);
    if (user != null) {
      await Navigator.push(
          context, MaterialPageRoute(builder: (context) =>  const Register()));
    }
    notifyListeners();
  }
}
