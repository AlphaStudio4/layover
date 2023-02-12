import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/home/home_screen.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/screens/onboarding/widgets/cbutton.dart';

class Start extends StatelessWidget {
  const Start({
    Key? key,
  }) : super(key: key);
  static const String routeName = '/start';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const Start(),
    );
  }

  @override
  Widget build(BuildContext context) {
    User? user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      // wrong call in wrong place!
      Navigator.of(context).pushReplacement(
          MaterialPageRoute(builder: (context) => HomeScreen()));
    }
    return Scaffold(
      body: Stack(children: [
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(10),
              image: DecorationImage(
                  fit: BoxFit.cover,
                  image: AssetImage('assets/images/relation.jpg'))),
        ),
        Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          color: Color.fromARGB(181, 73, 54, 54),
        ),
        Container(
          child: Padding(
              padding: const EdgeInsets.only(
                  left: 30.0, right: 30.0, top: 150, bottom: 50),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Container(
                          height: 170,
                          width: 170,
                          child: Image.asset(
                            'assets/images/icon.png',
                            color: Color.fromARGB(235, 11, 80, 177),
                          ),
                        ),
                        const SizedBox(height: 50),
                        Text('Welcome to Layover',
                            style: Theme.of(context)
                                .textTheme
                                .headline2!
                                .copyWith(color: Colors.white, fontFamily: '')),
                        const SizedBox(height: 20),
                        Text(
                          'Dating in layover can be fun, and you should have the best time possible with your match. With layover dating app, you can browse other profiles and find matches that are within you in airport!',
                          style: Theme.of(context)
                              .textTheme
                              .headline6!
                              .copyWith(
                                  height: 1.3,
                                  fontSize: 18,
                                  color: Colors.white,
                                  fontFamily: ''),
                          textAlign: TextAlign.center,
                        ),
                      ],
                    ),
                    const SizedBox(height: 30),
                    Padding(
                      padding: const EdgeInsets.only(top: 36.0),
                      child: Cbutton(
                        onpressed: () {
                          Navigator.pushNamed(context, '/email');
                        },
                        text: 'START',
                      ),
                    ),
                    const SizedBox(height: 5),
                    DecoratedBox(
                      decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(25),
                          border: Border.all(color: Colors.white)),
                      child: ElevatedButton(
                        style: ElevatedButton.styleFrom(
                            elevation: 0, primary: Colors.transparent),
                        onPressed: () {
                          Navigator.pushNamed(
                            context,
                            '/login',
                          );
                        },
                        child: SizedBox(
                            width: double.infinity,
                            child: Center(
                                child: Text(
                              'Login',
                              style: theme()
                                  .textTheme
                                  .headline4!
                                  .copyWith(color: Colors.white),
                            ))),
                      ),
                    ),
                  ])),
        ),
      ]),
    );
  }
}
