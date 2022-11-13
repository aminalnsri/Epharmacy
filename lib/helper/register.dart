import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';

import '../constant/constant.dart';
import '../firebase_options.dart';
import '../widgets/custom_text.dart';

class RegisterVeiw extends StatefulWidget {
  const RegisterVeiw({Key? key}) : super(key: key);

  @override
  State<RegisterVeiw> createState() => _RegisterVeiwState();
}

class _RegisterVeiwState extends State<RegisterVeiw> {
  late final TextEditingController _email;
  late final TextEditingController _password;

  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Sign up'),
        elevation: 0.0,
        backgroundColor: Colors.white,
      ),
      body: FutureBuilder(
        future: Firebase.initializeApp(
          options: DefaultFirebaseOptions.currentPlatform,
        ),
        builder: (context,snapshot){
          switch (snapshot.connectionState){


            case ConnectionState.done:
              return Padding(
                padding: const EdgeInsets.only(
                  top: 16,
                  right: 20,
                  left: 20,
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomText(
                          text: "welcome",
                          fontSize: 30,
                        ),
                        CustomText(
                          text: "sign up",
                          color: primaryColor,
                          fontSize: 18,
                        )
                      ],
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: "sign in to continue ",
                      fontSize: 14,
                      color: Colors.grey,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Column(
                      children: [
                        CustomText(
                          text: 'email',
                          fontSize: 14,
                          color: Colors.grey.shade900,
                        ),
                        TextFormField(
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _email,
                          keyboardType: TextInputType.emailAddress,
                          decoration: InputDecoration(
                            hintText: 'YOUREMAIL@gmail.com',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                          ),
                        )
                      ],
                    ), //email
                    SizedBox(height: 40),
                    Column(
                      children: [
                        CustomText(
                          text: 'password',
                          fontSize: 14,
                          color: Colors.grey.shade900,
                        ),
                        TextFormField(
                          obscureText: true,
                          enableSuggestions: false,
                          autocorrect: false,
                          controller: _password,
                          decoration: InputDecoration(
                            hintText: '*********',
                            hintStyle: TextStyle(
                              color: Colors.black,
                            ),
                            fillColor: Colors.white,
                          ),
                        )
                      ],
                    ),
                    //password,
                    SizedBox(height: 20),
                    CustomText(
                      text: 'Forget password?',
                      color: Colors.black,
                      fontSize: 14,
                      alignment: Alignment.topRight,
                    ),
                    SizedBox(height: 20),
                    FlatButton(
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10)),
                      padding: EdgeInsets.all(18),
                      onPressed: () async {

                        final email = _email.text;
                        final password = _password.text;
                       try{
                         final userCredentail = await FirebaseAuth.instance.createUserWithEmailAndPassword(
                           email: email,
                           password: password,
                         );
                         print (userCredentail);
                       }on FirebaseAuthException catch (e){
                         if (e.code == 'weak-password'){
                           print('weak password');
                         }else  if (e.code == 'email-already-in-use'){
                           print('email already un use');
                         }else  if (e.code == 'invalid-email'){
                           print('invalid email');
                         }

                       }

                      },
                      color: primaryColor,
                      child: CustomText(
                        text: 'sign up',
                        color: Colors.white,
                        alignment: Alignment.center,
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    CustomText(
                      text: '-OR-',
                      alignment: Alignment.center,
                    ),
                    SizedBox(
                      height: 30,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade100,
                      ),
                      child: FlatButton(
                          onPressed: () {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/facebook.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              CustomText(
                                text: 'sign in with facebook',
                              )
                            ],
                          )),
                    ),
                    SizedBox(
                      height: 40,
                    ),
                    Container(
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: Colors.grey.shade100,
                      ),
                      child: FlatButton(
                          onPressed: () async {},
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(10)),
                          child: Row(
                            children: [
                              Image.asset(
                                'assets/images/google.png',
                                height: 20,
                                width: 20,
                              ),
                              SizedBox(
                                width: 70,
                              ),
                              CustomText(
                                text: 'sign in with Google',
                              )
                            ],
                          )),
                    ),
                  ],
                ),
              );
            default:
              return const Text('Loadin ....');
          }

        },

      ),
    );
  }
}
