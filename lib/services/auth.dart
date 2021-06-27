import 'package:ddd/Model/user.dart';
import 'package:ddd/services/db.dart';
import 'package:firebase_auth/firebase_auth.dart';

class AuthService {
  FirebaseAuth auth = FirebaseAuth.instance;

  Future signinAnonimous() async {
    try {
      final result = await auth.signInAnonymously();
      return result.user;
    } catch (e) {
      print(e);
      return null;
    }
  }

  Future<User> get user async {
    final user = FirebaseAuth.instance.currentUser;
    return user;
  }

  Future<bool> signup(String email, pass, String username) async {
    try {
      final result = await auth.createUserWithEmailAndPassword(
          email: email, password: pass);
      if (result.user != null) {
        await dbService().saveUser(
            UsersM(id: result.user.uid, email: email, username: username));
        return true;
      }
      ;
      return false;
    } catch (e) {}
  }

  Future<bool> signin(String email, String pass) async {
    try {
      final result =
          await auth.signInWithEmailAndPassword(email: email, password: pass);
      if (result.user != null) return true;
      return false;
    } catch (e) {}
  }

  Future sigOut() async {
    try {
      return auth.signOut();
    } catch (e) {
      return null;
    }
  }
}
