import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/cubits/signup/signup_cubit.dart';
import 'package:layover/screens/login/controllers.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_field.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../blocs/onboarding/onboarding_bloc.dart';
import '../../../../model/model.dart';
import '../../widgets/cbutton.dart';

class Email extends StatefulWidget {
  const Email({Key? key}) : super(key: key);

  static const String routeName = '/email';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const Email(),
    );
  }

  @override
  State<Email> createState() => _EmailState();
}

class _EmailState extends State<Email> {
  final TextEditingController mailTrol = TextEditingController();
  final TextEditingController passTrol = TextEditingController();
  bool isLoading = false;
  String email = '';
  String password = '';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<SignupCubit, SignupState>(builder: (context, snapshot) {
        return Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
            child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Form(
                    key: formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextHeader(
                            text: "What's your E-mail Address?"),
                        CustomTextField(
                          hint: 'Enter Your E-mail',
                          keyboardType: TextInputType.emailAddress,
                          controller: mailTrol,
                          validate: validateEmail,
                          padding: const EdgeInsets.only(top: 20),
                          onChanged: (value) {
                            email = value;
                          },
                        ),
                        SizedBox(
                          height: (Get.context!.height /
                              (Get.context!.height / 100)),
                        ),
                        const CustomTextHeader(
                          text: "Choose a Password",
                        ),
                        CustomTextField(
                          hint: 'Enter Your Password',
                          validate: validatePassword,
                          controller: passTrol,
                          maxLine: 1,
                          padding: const EdgeInsets.only(top: 20),
                          onChanged: (value) {
                            password = value;
                          },
                        ),
                      ],
                    ),
                  ),
                  Column(
                    children: [
                      StepProgressIndicator(
                        totalSteps: 5,
                        currentStep: 1,
                        selectedColor: theme().primaryColor,
                        unselectedColor: theme().backgroundColor,
                      ),
                      SizedBox(
                        height:
                            (Get.context!.height / (Get.context!.height / 30)),
                      ),
                      Cbutton(
                          onpressed: (() async {
                            print('pressed');
                            if (formKey.currentState != null) {
                              if (formKey.currentState!.validate()) {
                                print('mjjmjj');
                                if (isLoading == true) {
                                  setState(() {
                                    isLoading = false;
                                  });
                                } else {
                                  setState(() {
                                    isLoading = true;
                                  });
                                }
                                try {
                                  await FirebaseAuth.instance
                                      .createUserWithEmailAndPassword(
                                          email: email, password: password)
                                      .then((value) {
                                    Navigator.pushNamed(
                                      context,
                                      '/verif',
                                    );
                                  });
                                  User user = User(
                                      id: FirebaseAuth
                                          .instance.currentUser!.uid,
                                      name: '',
                                      location: 'You Are Out of Boundary',
                                      age: 18,
                                      gender: 'Male',
                                      imageUrls: const [],
                                      interest: const [],
                                      bio: 'No bio',
                                      jobTitle: '',
                                      likes: 0,
                                      status: 'Out of Boundary');
                                  context.read<OnboardingBloc>().add(
                                        StartOnboarding(
                                          user: user,
                                        ),
                                      );
                                } on FirebaseAuthException catch (error) {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                      SnackBar(content: Text(error.message!)));
                                  setState(() {
                                    isLoading = false;
                                  });
                                }
                              }
                            }
                          }),
                          text: !isLoading ? 'NEXT STEP' : 'Please Wait ...')
                      // : Cbutton(
                      //     onpressed: (() {
                      //       print('object');
                      //       if (formKey.currentState != null) {
                      //         if (formKey.currentState!.validate()) {}
                      //       }
                      //     }),
                      //     text:
                      //         !isLoading ? 'NEXT STEP' : 'Please Wait ...'),
                    ],
                  ),
                ]));
      }),
    );
  }
}

String? validateEmail(String? value) {
  String pattern =
      r'^(([^<>()[\]\\.,;:\s@\"]+(\.[^<>()[\]\\.,;:\s@\"]+)*)|(\".+\"))@((\[[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\.[0-9]{1,3}\])|(([a-zA-Z\-0-9]+\.)+[a-zA-Z]{2,}))$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value!))
    return 'Enter Valid Email';
  else
    return null;
}

String? validatePassword(String? value) {
  if (value == null || value.isEmpty) return 'Password is required';

  String pattern =
      r'^(?=.*?[A-Z])(?=.*?[a-z])(?=.*[0-9])(?=.*?[!@#\$&*~]).{8,}$';
  RegExp regex = RegExp(pattern);
  if (!regex.hasMatch(value)) {
    return '''
  Password must be at least 8 characters,
  include an uppercase letter, number and symbol.
      ''';
  }

  return null;
}
