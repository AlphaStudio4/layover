import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/screens/onboarding/widgets/cbutton.dart';
import 'package:layover/screens/onboarding/widgets/custom_image_container.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_header.dart';
import 'package:step_progress_indicator/step_progress_indicator.dart';

class Pictures extends StatelessWidget {
  const Pictures({Key? key}) : super(key: key);

  static const String routeName = '/picture';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => const Pictures(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
      ),
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
          var images = state.user.imageUrls;
          var imagesCount = images.length;
          return Padding(
              padding: EdgeInsets.only(
                  left: (Get.context!.width / (Get.context!.width / 30)),
                  right: (Get.context!.width / (Get.context!.width / 30)),
                  bottom: (Get.context!.height / (Get.context!.height / 50))),
              child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        CustomTextHeader(text: 'Add 2 or More Pictures'),
                        SizedBox(
                          height: (Get.context!.height /
                              (Get.context!.height / 400)),
                          child: GridView.builder(
                              gridDelegate:
                                  const SliverGridDelegateWithFixedCrossAxisCount(
                                      crossAxisCount: 3,
                                      childAspectRatio: 0.55),
                              itemCount: 6,
                              itemBuilder: (BuildContext context, int index) {
                                return (imagesCount > index)
                                    ? CustomImageContainer(
                                        imageUrl: images[index])
                                    : const CustomImageContainer();
                              }),
                        ),
                      ],
                    ),
                    Column(
                      children: [
                        StepProgressIndicator(
                          totalSteps: 5,
                          currentStep: 4,
                          selectedColor: theme().primaryColor,
                          unselectedColor: theme().backgroundColor,
                        ),
                        SizedBox(
                          height: (Get.context!.height /
                              (Get.context!.height / 30)),
                        ),
                        (imagesCount < 2)
                            ? Cbutton(text: 'NEXT STEP')
                            : Cbutton(
                                text: 'NEXT STEP',
                                onpressed: () {
                                  Navigator.of(context).pushNamedAndRemoveUntil(
                                      Biography.routeName,
                                      ModalRoute.withName('/bio'));
                                },
                              )
                      ],
                    ),
                  ]));
        } else {
          return const Text('Something went wrong');
        }
      }),
    );
  }
}
