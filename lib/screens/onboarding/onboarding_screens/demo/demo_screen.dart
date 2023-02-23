import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/onboarding/onboarding_screens/picture/pictures_screen.dart';
import 'package:layover/screens/onboarding/widgets/cbutton.dart';
import 'package:layover/screens/onboarding/widgets/custom_checkbox.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_field.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

import '../../../../cubits/signup/signup_cubit.dart';
import '../../../../model/model.dart';

class Demography extends StatelessWidget {
  Demography({Key? key}) : super(key: key);

  static final formKey2 = GlobalKey<FormState>();
  static const String routeName = '/demo';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => Demography(),
    );
  }

  @override
  Widget build(BuildContext context) {
    final controller = TextEditingController();
    bool isLoading = false;

    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
      body: BlocBuilder<OnboardingBloc, OnboardingState>(
          builder: (context, state) {
        if (state is OnboardingLoading) {
          return Padding(
            padding: EdgeInsets.only(
                top: (Get.context!.height / (Get.context!.height / 15))),
            child: Center(
              child: CircularProgressIndicator(),
            ),
          );
        }
        if (state is OnboardingLoaded) {
          return Padding(
            padding:
                const EdgeInsets.only(left: 30.0, right: 30.0, bottom: 50.0),
            child: Form(
              key: formKey2,
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        const CustomTextHeader(
                          text: "What's Your Name?",
                        ),
                        CustomTextField(
                          hint: 'Enter Your Name...',
                          controller: controller,
                          padding: EdgeInsets.only(
                              top: (Get.context!.height /
                                  (Get.context!.height / 20))),
                          validate: validateName,
                          onChanged: (value) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(name: value)));
                          },
                        ),
                        SizedBox(
                            height: (Get.context!.height /
                                (Get.context!.height / 40))),
                        const CustomTextHeader(
                          text: "What's Your Gender?",
                        ),
                        SizedBox(
                            height: (Get.context!.height /
                                (Get.context!.height / 20))),
                        CustomCheckbox(
                          text: 'MALE',
                          value: state.user.gender == 'Male',
                          onChanged: ((bool? newValue) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(gender: 'Male')));
                          }),
                        ),
                        CustomCheckbox(
                          text: 'FEMALE',
                          value: state.user.gender == 'Female',
                          onChanged: ((bool? newValue) {
                            context.read<OnboardingBloc>().add(UpdateUser(
                                user: state.user.copyWith(gender: 'Female')));
                          }),
                        ),
                        SizedBox(
                            height: (Get.context!.height /
                                (Get.context!.height / 40))),
                        const CustomTextHeader(
                          text: "What's Your Age?",
                        ),
                        Padding(
                            padding: const EdgeInsets.only(top: 5.0),
                            child: CustomTextField(
                              controller: controller,
                              format: [FilteringTextInputFormatter.digitsOnly],
                              keyboardType: TextInputType.number,
                              padding: const EdgeInsets.only(top: 20),
                              validate: validateAge,
                              hint: 'Enter Your Age',
                              onChanged: (value) {
                                context.read<OnboardingBloc>().add(
                                      UpdateUser(
                                          user: state.user.copyWith(
                                        age: int.parse(value),
                                      )),
                                    );
                              },
                            ))
                      ],
                    ),
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 3,
                          selectedColor: theme().primaryColor,
                          unselectedColor: theme().backgroundColor,
                        ),
                        SizedBox(
                          height: (Get.context!.height /
                              (Get.context!.height / 30)),
                        ),
                        (formKey2.currentState != null)
                            ? Cbutton(
                                onpressed: (() {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Pictures.routeName,
                                      ModalRoute.withName('/picture'));
                                }),
                                text: 'NEXT STEP')
                            : Cbutton(
                                onpressed: (() {
                                  if (formKey2.currentState != null) {
                                    if (formKey2.currentState!.validate()) {}
                                  }
                                }),
                                text: 'NEXT STEP'),
                      ],
                    ),
                  ]),
            ),
          );
        } else {
          return const Text('Something went wrong...');
        }
      }),
    );
  }
}

String? validateName(String? value) {
  if (value!.length < 3)
    return 'Name must be more than 2 charater';
  else
    return null;
}

String? validateAge(String? value) {
  if (value!.length < 2) return 'Age must not be less than 18yrs';
  if (value == '1' ||
      value == '2' ||
      value == '3' ||
      value == '4' ||
      value == '5' ||
      value == '6' ||
      value == '7' ||
      value == '8' ||
      value == '9' ||
      value == '10' ||
      value == '11' ||
      value == '12' ||
      value == '13' ||
      value == '14' ||
      value == '15' ||
      value == '16' ||
      value == '17') {
    return 'Age must not be less than 18yrs';
  } else
    return null;
}
