import 'package:firebase_app_web/pages/HomePage.dart';
import 'package:firebase_app_web/pages/SignInPage.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;


class SignUpPage extends StatefulWidget{
  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  TextEditingController _emailController = TextEditingController();
  TextEditingController _passController = TextEditingController();
  bool circular= false;

  @override
  Widget build(BuildContext context) {
      return Scaffold(
        body: SingleChildScrollView(
          child: Container(
            height: MediaQuery.of(context).size.height,
            width: MediaQuery.of(context).size.width,
            color: Colors.white,
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(
                  "Sign Up",
                  style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold,
                  )
                ),
                SizedBox(
                  height: 20
                ),
                buttonItem("assets/google.svg", "Continue with Google", 25),
                SizedBox(
                  height: 15
                ),
                buttonItem("assets/phone.svg", "Continue with Phone", 30),
                SizedBox(
                  height: 15
                ),
                Text(
                  "Or",
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18
                  )
                ),
                SizedBox(
                  height: 15
                ),
                textItem("Email ...", _emailController, false),
                SizedBox(
                  height: 15
                ),
                textItem("Password ...", _passController, true),
                SizedBox(
                  height:30
                ),
                colorButton(),
                SizedBox(
                  height: 20
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                        Text(
                          "If you already have an account? ",
                          style: TextStyle(
                            color:  Colors.black,
                            fontSize: 18,
                            fontWeight: FontWeight.bold
                          )
                        ),
                      InkWell(
                        onTap: () {
                          Navigator.pushAndRemoveUntil(
                            context,
                            MaterialPageRoute(builder: (builder) => SignInPage()),
                              (route) => false
                          );
                        },
                        child: Text(
                            "Login",
                            style: TextStyle(
                              color:  Colors.black,
                              fontSize: 18,
                              fontWeight: FontWeight.bold
                            )
                          ),
                      )
                    ]
                )
              ]
            )
          )
        )
      ) ;
  }

  Widget colorButton() {
     return InkWell(
       onTap: () async{
         setState(() {
           circular = true;
         });
         try{
           firebase_auth.UserCredential userCredential =
               await firebaseAuth.createUserWithEmailAndPassword(
                 email: _emailController.text, password: _passController.text
               );
           setState(() {
             circular = false;
           });
           Navigator.pushAndRemoveUntil(
              context,
             MaterialPageRoute(builder: (builder) => HomePage()),
               (route) =>false);
         }
         catch(e) {
           final snackBar = SnackBar(content: Text(e.toString()));
           ScaffoldMessenger.of(context).showSnackBar(snackBar);
           setState(() {
             circular = false;
           });
         }
       },

       child: Container(
         width: MediaQuery.of(context).size.width - 90,
         height: 60,
         decoration: BoxDecoration(
           borderRadius: BorderRadius.circular(20),
           gradient: LinearGradient(colors: [
             Color(0xfffd746c),
             Color(0xffff9068),
             Color(0xfffd746c)
           ])
         ),
           child: Center(
           child: circular
             ?
           CircularProgressIndicator()
           : Text(
             "Sign Up",
             style: TextStyle(
               color: Colors.black,
               fontSize: 20
             ),
           )
       )
       ),
     );
  }

  Widget buttonItem(String imagepath, String buttonName, double size){
    return Container(
        width: MediaQuery.of(context).size.width - 60,
        height: 60,
        child: Card(
            color: Colors.black,
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: BorderSide(
                    width: 1,
                    color: Colors.grey
                )
            ),
            child:Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  SvgPicture.asset(
                    imagepath,
                    height: size,
                    width: size,
                  ),
                  SizedBox(width: 15),
                  Text(
                      buttonName,
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 17
                      ))
                ]
            )
        )
    );
  }

  Widget textItem(String labelText, TextEditingController controller, bool obscureText){
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          labelText: labelText,
            labelStyle: TextStyle(
              fontSize: 17,
              color: Colors.black,
            ) ,
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.amber,
            )
          ),
            enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(15),
            borderSide: BorderSide(
              width: 1,
              color: Colors.grey,
            )
          )
        )
      )
    );
  }
}












