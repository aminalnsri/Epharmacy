
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';

class AuthViewModel extends GetxController{
GoogleSignIn _googleSignIn = GoogleSignIn(scopes: ['email']);
FirebaseAuth _auth = FirebaseAuth.instance;

@override
  void onInit() {
//
super.onInit();
  }


@override
  void onReady() {
//
super.onReady();
  }



@override
  void onClose() {
//
super.onClose();
  }
void  googleSignInMethod()async{
  final GoogleSignInAccount? googleUser= await _googleSignIn.signIn();
}
}