import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthService {
  final FirebaseAuth _firebaseAuth = FirebaseAuth.instance;

  // Login with email and password
  Future<String?> loginWithEmail(String email, String password) async {
    try {
      UserCredential userCredential = await _firebaseAuth.signInWithEmailAndPassword(
        email: email,
        password: password,
      );
      return await userCredential.user?.getIdToken();
    } catch (e) {
      print('Login failed: $e');
      return null;
    }
  }

  // Login with Google
  Future<String?> loginWithGoogle() async {
    try {
      final GoogleSignInAccount? googleUser = await GoogleSignIn().signIn();
      final GoogleSignInAuthentication googleAuth = await googleUser!.authentication;

      final credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      UserCredential userCredential = await _firebaseAuth.signInWithCredential(credential);
      return await userCredential.user?.getIdToken();
    } catch (e) {
      print('Google login failed: $e');
      return null;
    }
  }

  // Logout
  Future<void> logout() async {
    await _firebaseAuth.signOut();
  }
}
