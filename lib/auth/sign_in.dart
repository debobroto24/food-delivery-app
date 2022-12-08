import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_signin_button/button_view.dart';
import 'package:flutter_signin_button/flutter_signin_button.dart';
import 'package:food_app/config/colors.dart';
import 'package:food_app/providers/user_provider.dart';
import 'package:food_app/screens/home/home_screen.dart';
import 'package:food_app/widgets/auth_text_field.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:provider/provider.dart';

class SignIn extends StatefulWidget {
  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  UserProvider userProvider;
  Future<void> _googleSignUp() async {
    try {
      final GoogleSignIn _googleSignIn = GoogleSignIn(
        scopes: ['email'],
      );
      final FirebaseAuth _auth = FirebaseAuth.instance;

      final GoogleSignInAccount googleUser = await _googleSignIn.signIn();
      final GoogleSignInAuthentication googleAuth =
          await googleUser.authentication;

      final AuthCredential credential = GoogleAuthProvider.credential(
        accessToken: googleAuth.accessToken,
        idToken: googleAuth.idToken,
      );

      final User user = (await _auth.signInWithCredential(credential)).user;
      // print("signed in " + user.displayName);
      userProvider.addUserData(
        currentUser: user,
        userEmail: user.email,
        userImage: user.photoURL,
        userName: user.displayName,
      );

      return user;
    } catch (e) {
      print(e.message);
    }
  }

  @override
  Widget build(BuildContext context) {
    userProvider = Provider.of<UserProvider>(context);

    TextEditingController emailController = TextEditingController();
    TextEditingController passwordController = TextEditingController();
    return Scaffold(
      body: Stack(
        children: [
          Container(
            height: double.infinity,
            width: double.infinity,
            decoration: BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.cover, image: AssetImage('assets/background.png')),
            ),
            child: Center(
              child: SingleChildScrollView(
                
                child: Container(
                  
                  // color: Colors.red,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                       Text('Vegi',
                          style:
                              TextStyle(fontSize: 50, color: Colors.white, shadows: [
                            BoxShadow(
                              blurRadius: 5,
                              color: Colors.green.shade900,
                              offset: Offset(3, 3),
                            )
                          ]),
                        ),
                        SizedBox(height: 20,), 
                        
                        AuthTextField(controller: emailController,hinText: "Email", isObscure: false, icon:Icons.email_outlined), 
                        SizedBox(height: 10),
                        AuthTextField(controller: emailController,hinText: "password", isObscure: true, icon:Icons.password_outlined), 
                        SizedBox(height:30), 
                        Container(
                          width: 80, 
                          height:30, 
                          // padding: EdgeInsets.only(left:10,right:10,), 
                          decoration: BoxDecoration(  
                            color: primaryColor, 
                            borderRadius: BorderRadius.circular(4), 
                          ),
                          child: TextButton(
                            onPressed: (){}, 
                            child: Text("Login" , style: TextStyle(color:Colors.white, fontSize: 18, fontWeight: FontWeight.bold))
                            ,)
                          ),
                        
                        
                     
                      // SignInButton(
                          //   Buttons.Apple,
                          //   text: "Sign in with Apple",
                          //   onPressed: () {},
                          // ),
                          SignInButton(
                            Buttons.Google,
                            text: "Sign in with Google",
                            onPressed: () async {
                              await _googleSignUp().then(
                                (value) => Navigator.of(context).pushReplacement(
                                  MaterialPageRoute(
                                    builder: (context) => HomeScreen(),
                                  ),
                                ),
                              );
                            },
                          ),
                          Column(
                            children: [
                              Text(
                                'By signing in you are agreeing to our',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                              Text(
                                'Terms and Pricacy Policy',
                                style: TextStyle(
                                  color: Colors.grey[800],
                                ),
                              ),
                            ],
                          ),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
