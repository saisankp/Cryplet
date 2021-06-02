import 'package:cryplet_app/net/flutterfire.dart';
import 'package:cryplet_app/ui/register.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/cupertino.dart';

import 'home_view.dart';

class Authentication extends StatefulWidget {
  Authentication({Key? key}) : super(key: key);

  @override
  _AuthenticationState createState() => _AuthenticationState();
}

class _AuthenticationState extends State<Authentication> {
  TextEditingController _emailField = TextEditingController();
  TextEditingController _passwordField = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: "Cryplet Login",
      home: Scaffold(
        body: SingleChildScrollView(
          child: Container(
            padding: EdgeInsets.symmetric(horizontal: 40),
            color: Color(0xFFfafafa),
            width: double.infinity,
            child: Column(
              children: [
                _logo(),
                _logoText(),
                _emailBox(
                    Icon(Icons.person_outline,
                        size: 30, color: Color(0xffA6B0BD)),
                    "email@gmail.com",
                    _emailField),
                _passwordBox(
                    Icon(Icons.lock_outline,
                        size: 30, color: Color(0xffA6B0BD)),
                    "password",
                    _passwordField),
                _loginBtn(_emailField, _passwordField, context),
                _dontHaveAcnt(),
                _signUp(context),
                _terms(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

Widget _terms() {
  return Container(
    //padding: EdgeInsets.only(top: 0, bottom:),
    child: TextButton(
      onPressed: () => {print("Terms pressed.")},
      child: Text(
        "Terms & Conditions",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            color: Color(0xffA6B0BD),
            fontWeight: FontWeight.w400,
            fontSize: 12,
          ),
        ),
      ),
    ),
  );
}

Widget _signUp(context) {
  return TextButton(
    onPressed: () => {
      Navigator.push(
        context,
        MaterialPageRoute(
          builder: (context) => Register(),
        ),
      )
    },
    child: Text(
      "Register with us today.",
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          color: Color(0xFF008FFF),
          fontWeight: FontWeight.w800,
          fontSize: 16,
        ),
      ),
    ),
  );
}

Widget _dontHaveAcnt() {
  return Text(
    "Don't have an account yet?",
    style: GoogleFonts.montserrat(
      textStyle: TextStyle(
        color: Color(0xffA6B0BD),
        fontWeight: FontWeight.w400,
        fontSize: 18,
      ),
    ),
  );
}

Widget _loginBtn(
    TextEditingController email, TextEditingController password, context) {
  return Container(
    width: double.infinity,
    margin: EdgeInsets.only(top: 20, bottom: 20),
    decoration: BoxDecoration(
        color: Color(0xff008FFF),
        borderRadius: BorderRadius.all(Radius.circular(50)),
        boxShadow: [
          BoxShadow(
            color: Color(0x60008FFF),
            blurRadius: 10,
            offset: Offset(0, 5),
            spreadRadius: 0,
          ),
        ]),
    child: TextButton(
      onPressed: () async {
        bool shouldNavigate = await signIn(email.text, password.text, context);
        if (shouldNavigate) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => HomeView(),
            ),
          );
        } else {
          print("An error occured");
        }
      },
      //padding: EdgeInsets.symmetric(vertical: 25),
      child: Text(
        "Log In",
        style: GoogleFonts.montserrat(
          textStyle: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w800,
            color: Colors.white,
            letterSpacing: 3,
          ),
        ),
      ),
    ),
  );
}

Widget _emailBox(
    Icon prefixIcon, String hintText, TextEditingController email) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 25,
          offset: Offset(0, 5),
          spreadRadius: -25,
        ),
      ],
    ),
    margin: EdgeInsets.only(bottom: 20),
    child: TextFormField(
      controller: email,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xff000912),
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffA6B0BD),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: 75,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget _passwordBox(
    Icon prefixIcon, String hintText, TextEditingController password) {
  return Container(
    decoration: BoxDecoration(
      borderRadius: BorderRadius.all(
        Radius.circular(50),
      ),
      boxShadow: [
        BoxShadow(
          color: Colors.black,
          blurRadius: 25,
          offset: Offset(0, 5),
          spreadRadius: -25,
        ),
      ],
    ),
    margin: EdgeInsets.only(bottom: 20),
    child: TextFormField(
      obscureText: true,
      controller: password,
      style: GoogleFonts.montserrat(
        textStyle: TextStyle(
          fontSize: 20,
          fontWeight: FontWeight.w400,
          color: Color(0xff000912),
        ),
      ),
      decoration: InputDecoration(
        contentPadding: EdgeInsets.symmetric(vertical: 25),
        hintText: hintText,
        hintStyle: TextStyle(
          color: Color(0xffA6B0BD),
        ),
        fillColor: Colors.white,
        filled: true,
        prefixIcon: prefixIcon,
        prefixIconConstraints: BoxConstraints(
          minWidth: 75,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: BorderRadius.all(
            Radius.circular(50),
          ),
          borderSide: BorderSide(color: Colors.white),
        ),
      ),
    ),
  );
}

Widget _logoText() {
  return Container(
      margin: EdgeInsets.only(bottom: 50),
      child: Text(
        "Cryplet",
        style: GoogleFonts.nunito(
          textStyle: TextStyle(
            fontSize: 54,
            fontWeight: FontWeight.w800,
            color: Color(0xff000912),
            letterSpacing: 5,
          ),
        ),
      ));
}

Widget _logo() {
  return Container(
      margin: EdgeInsets.only(top: 100),
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          Positioned(
            left: -8,
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Color(0xff00bfdb),
              size: 100.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          Positioned(
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Color(0xff008FFF),
              size: 100.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
          Positioned(
            left: 8,
            child: Icon(
              Icons.account_balance_wallet_outlined,
              color: Color(0xff00227E),
              size: 100.0,
              semanticLabel: 'Text to announce in accessibility modes',
            ),
          ),
        ],
      ));
}
