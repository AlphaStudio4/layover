// import 'dart:async';

// import 'package:firebase_auth/firebase_auth.dart' hide User;
// import 'package:firebase_core/firebase_core.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:layover/blocs/onboarding/onboarding_bloc.dart';
// import 'package:layover/config/theme.dart';
// import 'package:layover/cubits/signup/signup_cubit.dart';
// import 'package:layover/model/model.dart';
// import 'package:layover/screens/login/controllers.dart';

// class CustomButton extends StatefulWidget {
//   final String text;
//   final String? mail;
//   const CustomButton({
//     Key? key,
//     required this.text,
//     this.mail,
//   }) : super(key: key);

//   @override
//   State<CustomButton> createState() => _CustomButtonState();
// }

// class _CustomButtonState extends State<CustomButton> {
//   @override
//   Widget build(BuildContext context) {
//     return DecoratedBox(
//       decoration: BoxDecoration(
//           borderRadius: BorderRadius.circular(25),
//           gradient: LinearGradient(
//               colors: [theme().primaryColor, theme().secondaryHeaderColor])),
//       child: ElevatedButton(
//         style:
//             ElevatedButton.styleFrom(elevation: 0, primary: Colors.transparent),
//         onPressed: () async {
//           // if (tabController.index == 4) {
//           //   tabController.animateTo(tabController.index + 1);
//           // }
//           if (widget.tabController!.index <= 3 &&
//               widget.tabController!.index != 1 &&
//               widget.tabController!.index != 2) {
//             widget.tabController!.animateTo(widget.tabController!.index + 1);
//           } else if (widget.tabController!.index == 2) {
//             User user = User(
//                 id: context.read<SignupCubit>().state.user!.uid,
//                 name: '',
//                 age: 0,
//                 gender: 'Male',
//                 imageUrls: const [],
//                 interest: const [],
//                 bio: '',
//                 jobTitle: '',
//                 likes: 0,
//                 status: 'Out of Boundary');

//             context.read<OnboardingBloc>().add(
//                   StartOnboarding(user: user),
//                 );
//             widget.tabController!.animateTo(widget.tabController!.index + 1);
//           } else if (widget.tabController!.index == 1) {
//             if (formKey.currentState != null) {
//               if (formKey.currentState!.validate()) {
//                 await context.read<SignupCubit>().signUpWithCredentials();

//                 widget.tabController!
//                     .animateTo(widget.tabController!.index + 1);
//               }
//             }
//           } else {
//             Navigator.pushNamed(context, '/');
//           }
//         },
//         child: SizedBox(
//             width: double.infinity,
//             child: Center(
//                 child: Text(
//               widget.text,
//               style: theme().textTheme.headline4!.copyWith(color: Colors.white),
//             ))),
//       ),
//     );
//   }
// }
