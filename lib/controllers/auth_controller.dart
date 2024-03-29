import 'package:brain_storm_mania/firebase_ref/references.dart';
import 'package:brain_storm_mania/screens/home/home_screen.dart';
import 'package:brain_storm_mania/screens/login/login_screen.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

import '../widgets/dialogs/dialog_widget.dart';

class AuthController extends GetxController {
  late FirebaseAuth _auth;
  final _user = Rxn<User>();

  late Stream<User?> _authStateChanges;

  @override
  void onReady() {
    initAuth();
    super.onReady();
  }

  Future<void> initAuth() async {
    await Future.delayed(const Duration(seconds: 2));
    _auth = FirebaseAuth.instance;
    _authStateChanges = _auth.authStateChanges();
    _authStateChanges.listen((User? user) {
      _user.value = user;
    });
    navigateToIntroduction();
  }

  void navigateToIntroduction() {
    Get.offAllNamed("/introduction");
  }

  Future<void> signInWithGoogle() async {
    final GoogleSignIn _googleSignIn = GoogleSignIn();
    try {
      GoogleSignInAccount? account = await _googleSignIn.signIn();
      if (account != null) {
        final _authAccount = await account.authentication;
        final _credential = GoogleAuthProvider.credential(
            idToken: _authAccount.idToken,
            accessToken: _authAccount.accessToken);

        await _auth.signInWithCredential(_credential);
        await _saveUser(account);
        navigateToHomePage();
      }
    } on Exception catch (e) {
      rethrow;
    }
  }

  Future<void> _saveUser(GoogleSignInAccount account) async {
    await userRef.doc(account.email).set({
      'email': account.email,
      'name': account.displayName,
      'avatar': account.photoUrl
    });
  }

  void showLogInAlertDialog() {
    Get.dialog(Dialogs.questionStartDialog(onTap: () {
      Get.back();
      navigateLoginPage();
    }), barrierDismissible: false);
  }

  // returns true if a user is logged in, else false
  bool isLoggedIn() {
    return _auth.currentUser != null;
  }

  // returns current user
  User? getCurrentUser() {
    return _user.value;
  }

  // method to sign out current user
  Future<void> signOut() async {
    try {
      await _auth.signOut();
      navigateToHomePage();
    } on FirebaseAuthException catch (e) {
      print(e.message);
    }
  }

  // navigate To HomePage Screen
  void navigateToHomePage() {
    Get.toNamed(HomeScreen.routeName);
  }

  // navigate To Login Screen
  void navigateLoginPage() {
    Get.toNamed(LogInScreen.routeName);
  }
}
