import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/home/home_screen.dart';
import 'package:layover/screens/onboarding/widgets/cbutton.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_field.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_header.dart';
import 'package:layover/widgets/interest_button.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Biography extends StatefulWidget {
  Biography({Key? key}) : super(key: key);
  static const String routeName = '/bio';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => Biography(),
    );
  }

  @override
  State<Biography> createState() => _BiographyState();
}

class _BiographyState extends State<Biography> {
  static final formKey3 = GlobalKey<FormState>();
  bool isLoading = false;

  bool isMusicPressed = false;
  bool isPoliticsPressed = false;
  bool isTechPressed = false;
  bool isGamingPressed = false;
  bool isSportPressed = false;
  bool isNaturePressed = false;

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
        if (state is OnboardingLoading) {
          return const Padding(
            padding: EdgeInsets.only(top: 15.0),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
              padding: EdgeInsets.only(
                  left: (MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.width / 30)),
                  right: (MediaQuery.of(context).size.width /
                      (MediaQuery.of(context).size.width / 30)),
                  bottom: (MediaQuery.of(context).size.height /
                      (MediaQuery.of(context).size.height / 50)),
                  top: (MediaQuery.of(context).size.height /
                      (MediaQuery.of(context).size.height / 90))),
              child: Form(
                key: formKey3,
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          CustomTextHeader(
                            text: "Describe Yourself a Little Bit. ",
                          ),
                          CustomTextField(
                            hint: 'Enter Your Bio...',
                            maxlength: 750,
                            maxLine: null,
                            padding: const EdgeInsets.only(top: 20),
                            controller: controller,
                            validate: validateBio,
                            onChanged: (value) {
                              context.read<OnboardingBloc>().add(UpdateUser(
                                  user: state.user.copyWith(bio: value)));
                            },
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height /
                                (MediaQuery.of(context).size.height / 40)),
                          ),
                          CustomTextHeader(
                            text: "What's Your Job?",
                          ),
                          CustomTextField(
                            hint: 'Enter Your Job Title...',
                            validate: validateJob,
                            padding: const EdgeInsets.only(top: 20),
                            controller: controller,
                            onChanged: (value) {
                              context.read<OnboardingBloc>().add(UpdateUser(
                                  user: state.user.copyWith(jobTitle: value)));
                            },
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height /
                                (MediaQuery.of(context).size.height / 40)),
                          ),
                          CustomTextHeader(text: "What Are Your Interest? "),
                          Row(
                            children: [
                              InterestButton(
                                text: 'Music',
                                textColor: Colors.white,
                                onpressed: () {
                                  setState(() {
                                    isMusicPressed = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .update({
                                    'interest':
                                        FieldValue.arrayUnion(['Music']),
                                  });
                                },
                                hasBeenPressed: isMusicPressed,
                              ),
                              InterestButton(
                                text: 'Politics',
                                textColor: Colors.white,
                                onpressed: () {
                                  setState(() {
                                    isPoliticsPressed = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .update({
                                    'interest':
                                        FieldValue.arrayUnion(['Politics']),
                                  });
                                },
                                hasBeenPressed: isPoliticsPressed,
                              ),
                              InterestButton(
                                text: 'Nature',
                                textColor: Colors.white,
                                onpressed: () {
                                  setState(() {
                                    isNaturePressed = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .update({
                                    'Nature': FieldValue.arrayUnion(['Nature']),
                                  });
                                },
                                hasBeenPressed: isNaturePressed,
                              ),
                            ],
                          ),
                          Row(
                            children: [
                              InterestButton(
                                text: 'Tech',
                                textColor: Colors.white,
                                onpressed: () {
                                  setState(() {
                                    isTechPressed = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .update({
                                    'interest':
                                        FieldValue.arrayUnion(['Technology']),
                                  });
                                },
                                hasBeenPressed: isTechPressed,
                              ),
                              InterestButton(
                                text: 'Sports',
                                textColor: Colors.white,
                                onpressed: () {
                                  setState(() {
                                    isSportPressed = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .update({
                                    'interest':
                                        FieldValue.arrayUnion(['Sports']),
                                  });
                                },
                                hasBeenPressed: isSportPressed,
                              ),
                              InterestButton(
                                text: 'Gaming',
                                textColor: Colors.white,
                                onpressed: () {
                                  setState(() {
                                    isGamingPressed = true;
                                  });
                                  FirebaseFirestore.instance
                                      .collection('users')
                                      .doc(state.user.id)
                                      .update({
                                    'interest':
                                        FieldValue.arrayUnion(['Gaming']),
                                  });
                                },
                                hasBeenPressed: isGamingPressed,
                              ),
                            ],
                          )
                        ],
                      ),
                      Column(
                        children: [
                          StepProgressIndicator(
                            totalSteps: 5,
                            currentStep: 5,
                            selectedColor: theme().primaryColor,
                            unselectedColor: theme().backgroundColor,
                          ),
                          SizedBox(
                            height: (MediaQuery.of(context).size.height /
                                (MediaQuery.of(context).size.height / 30)),
                          ),
                          (formKey3.currentState != null)
                              ? Cbutton(
                                  onpressed: (() {
                                    if (isLoading == true) {
                                      setState(() {
                                        isLoading = false;
                                      });
                                    } else {
                                      isLoading = true;
                                    }
                                    Navigator.of(context)
                                        .pushNamedAndRemoveUntil(
                                            HomeScreen.routeName,
                                            ModalRoute.withName('/'));
                                  }),
                                  text: !isLoading
                                      ? 'NEXT STEP'
                                      : 'Please Wait ...')
                              : Cbutton(
                                  onpressed: (() {
                                    if (formKey3.currentState != null) {
                                      if (formKey3.currentState!.validate()) {}
                                    }
                                  }),
                                  text: isLoading
                                      ? 'NEXT STEP'
                                      : 'Please wait...'),
                        ],
                      ),
                    ]),
              ));
        } else {
          return Text('Something went wrong');
        }
      }),
    );
  }
}

String? validateBio(String? value) {
  if (value!.length < 20)
    return 'Bio must be more than six words';
  else
    return null;
}

String? validateJob(String? value) {
  if (value!.length < 1)
    return 'Job Title can\'t be empty';
  else
    return null;
}
