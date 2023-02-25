import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get/get.dart';
import 'package:layover/blocs/profile/profile_bloc.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/onboarding/onboarding_screens/screens.dart';
import 'package:layover/screens/onboarding/widgets/cbutton.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_field.dart';
import 'package:layover/screens/profile/image_cont.dart';
import 'package:layover/widgets/custom_text_container.dart';
import 'package:firebase_auth/firebase_auth.dart' hide User;
import 'package:layover/widgets/user_image.dart';

import '../../blocs/auth/auth_bloc.dart';

class ProfileScreen extends StatefulWidget {
  static const String routeName = '/profile';

  ProfileScreen({Key? key}) : super(key: key);

  static Route route() {
    return MaterialPageRoute(
        settings: const RouteSettings(name: routeName),
        builder: (context) {
          print(BlocProvider.of<AuthBloc>(context).state);

          return BlocProvider.of<AuthBloc>(context).state.status ==
                  AuthStatus.unauthenticated
              ? const Start()
              : ProfileScreen();
        });
  }

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final jobController = TextEditingController();
  final bioController = TextEditingController();
  final key1 = GlobalKey<FormState>();
  final key2 = GlobalKey<FormState>();
  final key3 = GlobalKey<FormState>();
  bool shouldShowJobText = false;
  bool shouldShowBioText = false;

  @override
  void dispose() {
    jobController.dispose();
    super.dispose();
  }

  //signout function
  signOut() async {
    await auth.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Start()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: SingleChildScrollView(child:
            BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return Padding(
              padding: EdgeInsets.only(
                  top: (MediaQuery.of(context).size.height /
                      (MediaQuery.of(context).size.height / 85))),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is ProfileLoaded) {
            if (state.user.imageUrls.length < 1 &&
                state.user.name == '' &&
                state.user.jobTitle == '') {
              Future signOut() async {
                await FirebaseAuth.instance.signOut();
                // ignore: use_build_context_synchronously
                Navigator.pushReplacement(
                    context, MaterialPageRoute(builder: (context) => Start()));
              }

              signOut();
            }
            return Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                UserImage.medium(
                  url: (state.user.imageUrls.length > 0)
                      ? state.user.imageUrls[0]
                      : 'https://storage.googleapis.com/proudcity/mebanenc/uploads/2021/03/placeholder-image-300x225.png',
                  child: Container(
                    child: Container(
                      margin: const EdgeInsets.only(top: 10),
                      height: MediaQuery.of(context).size.height / 4,
                      decoration: const BoxDecoration(
                        gradient: LinearGradient(
                          colors: [
                            Color.fromARGB(196, 0, 0, 0),
                            Color.fromARGB(0, 0, 0, 0)
                          ],
                          begin: Alignment.bottomCenter,
                          end: Alignment.topCenter,
                        ),
                      ),
                      child: Align(
                        alignment: Alignment.bottomCenter,
                        child: Padding(
                          padding: EdgeInsets.only(
                              bottom: (MediaQuery.of(context).size.height /
                                  (MediaQuery.of(context).size.height / 40))),
                          child: Text(
                            state.user.name,
                            style: theme()
                                .textTheme
                                .headline1!
                                .copyWith(color: Colors.white),
                          ),
                        ),
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.all(20.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const RowWithIcon(title: 'Likes', icon: Icons.favorite),
                      Padding(
                        padding: const EdgeInsets.only(bottom: 12.0),
                        child: Text(
                          '${state.user.likes} likes',
                          style: theme()
                              .textTheme
                              .bodyText1!
                              .copyWith(height: 1.5),
                        ),
                      ),
                      RowWithIcon(
                        title: 'Job Title',
                        icon: Icons.edit,
                        onpressed: () {
                          if (shouldShowJobText == true) {
                            setState(() {
                              shouldShowJobText = false;
                            });
                          } else {
                            setState(() {
                              shouldShowJobText = true;
                            });
                          }
                        },
                      ),
                      (shouldShowJobText == false)
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 1.0),
                              child: Text(state.user.jobTitle,
                                  style: theme().textTheme.bodyText1!),
                            )
                          : Form(
                              key: key1,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    hint: state.user.jobTitle,
                                    validate: validateJob,
                                    controller: jobController,
                                    padding: const EdgeInsets.only(top: 0),
                                    onChanged: (value) {
                                      jobController.text = value;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Cbutton(
                                      text: 'Update',
                                      onpressed: () {
                                        print(jobController.text);
                                        if (jobController.text == '') {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(state.user.id)
                                              .update({
                                            'jobTitle': state.user.jobTitle,
                                          });
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(state.user.id)
                                              .update({
                                            'jobTitle': jobController.text,
                                          });
                                        }

                                        setState(() {
                                          shouldShowJobText = false;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                      const SizedBox(
                        height: 15,
                      ),
                      RowWithIcon(
                        title: 'Biography',
                        icon: Icons.edit,
                        onpressed: () {
                          if (shouldShowBioText == true) {
                            setState(() {
                              shouldShowBioText = false;
                            });
                          } else {
                            setState(() {
                              shouldShowBioText = true;
                            });
                          }
                        },
                      ),
                      (shouldShowBioText == false)
                          ? Padding(
                              padding: const EdgeInsets.only(bottom: 12.0),
                              child: Text(
                                state.user.bio,
                                style: theme()
                                    .textTheme
                                    .bodyText1!
                                    .copyWith(height: 1.5),
                              ),
                            )
                          : Form(
                              key: key2,
                              child: Column(
                                children: [
                                  CustomTextField(
                                    hint: state.user.bio,
                                    validate: validateJob,
                                    maxLine: null,
                                    controller: bioController,
                                    padding: const EdgeInsets.only(top: 0),
                                    onChanged: (value) {
                                      bioController.text = value;
                                    },
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(top: 14.0),
                                    child: Cbutton(
                                      text: 'Update',
                                      onpressed: () {
                                        print(bioController.text);
                                        if (bioController.text == '') {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(state.user.id)
                                              .update({
                                            'bio': state.user.bio,
                                          });
                                        } else {
                                          FirebaseFirestore.instance
                                              .collection('users')
                                              .doc(state.user.id)
                                              .update({
                                            'bio': bioController.text,
                                          });
                                        }

                                        setState(() {
                                          shouldShowBioText = false;
                                        });
                                      },
                                    ),
                                  )
                                ],
                              ),
                            ),
                      SizedBox(
                        height: (MediaQuery.of(context).size.height /
                            (MediaQuery.of(context).size.height / 20)),
                      ),
                      const RowWithIcon(title: 'Pictures'),
                      SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: SizedBox(
                            height: (MediaQuery.of(context).size.height /
                                (MediaQuery.of(context).size.height / 125)),
                            child: Row(children: [
                              (state.user.imageUrls.length > 0)
                                  ? ImageCont(
                                      image: state.user.imageUrls[0],
                                      id: '${state.user.id}')
                                  : Text(''),
                              (state.user.imageUrls.length > 1)
                                  ? ImageCont(
                                      image: state.user.imageUrls[1],
                                      id: '${state.user.id}')
                                  : Text(''),
                              (state.user.imageUrls.length > 2)
                                  ? ImageCont(
                                      image: state.user.imageUrls[2],
                                      id: '${state.user.id}')
                                  : Text(''),
                              (state.user.imageUrls.length > 3)
                                  ? ImageCont(
                                      image: state.user.imageUrls[3],
                                      id: '${state.user.id}')
                                  : Text(''),
                              (state.user.imageUrls.length > 4)
                                  ? ImageCont(
                                      image: state.user.imageUrls[4],
                                      id: '${state.user.id}')
                                  : Text(''),
                              (state.user.imageUrls.length > 5)
                                  ? ImageCont(
                                      image: state.user.imageUrls[5],
                                      id: '${state.user.id}')
                                  : Text(''),
                            ])),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      (state.user.interest.length > 0)
                          ? Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const RowWithIcon(title: 'My Interests'),
                                SizedBox(
                                  height: (MediaQuery.of(context).size.height /
                                      (MediaQuery.of(context).size.height /
                                          92)),
                                  child: ListView.builder(
                                    shrinkWrap: true,
                                    scrollDirection: Axis.horizontal,
                                    itemCount: state.user.interest.length,
                                    itemBuilder: ((context, index) {
                                      return Padding(
                                        padding:
                                            const EdgeInsets.only(right: 8.0),
                                        child: Column(
                                          children: [
                                            Row(
                                              children: [
                                                CustomTextContainer(
                                                    text:
                                                        state.user.interest[0]),
                                                (state.user.interest.length > 1)
                                                    ? CustomTextContainer(
                                                        text: state
                                                            .user.interest[1])
                                                    : const Text(''),
                                                (state.user.interest.length > 2)
                                                    ? CustomTextContainer(
                                                        text: state
                                                            .user.interest[2])
                                                    : const Text(''),
                                                (state.user.interest.length > 3)
                                                    ? CustomTextContainer(
                                                        text: state
                                                            .user.interest[3])
                                                    : const Text(''),
                                              ],
                                            ),
                                            Row(
                                              children: [
                                                (state.user.interest.length > 4)
                                                    ? CustomTextContainer(
                                                        text: state
                                                            .user.interest[4])
                                                    : const Text(''),
                                                (state.user.interest.length > 5)
                                                    ? CustomTextContainer(
                                                        text: state
                                                            .user.interest[5])
                                                    : const Text(''),
                                                (state.user.interest.length > 6)
                                                    ? CustomTextContainer(
                                                        text: state
                                                            .user.interest[6])
                                                    : const Text(''),
                                              ],
                                            )
                                          ],
                                        ),
                                      );
                                    }),
                                  ),
                                ),
                              ],
                            )
                          : const Text(''),
                      const SizedBox(
                        height: 10,
                      ),
                      TextButton(
                        onPressed: () {
                          signOut();
                        },
                        child: Center(
                          child: Container(
                            width: (MediaQuery.of(context).size.width /
                                (MediaQuery.of(context).size.width / 400)),
                            decoration: BoxDecoration(
                                gradient: LinearGradient(colors: [
                                  theme().primaryColor,
                                  theme().secondaryHeaderColor
                                ]),
                                borderRadius: BorderRadius.circular(25)),
                            child: Padding(
                              padding: const EdgeInsets.all(14.0),
                              child: Text(
                                'Sign Out',
                                textAlign: TextAlign.center,
                                style: Theme.of(context)
                                    .textTheme
                                    .headline5!
                                    .copyWith(color: Colors.white),
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                )
              ],
            );
          } else {
            return Text('data');
          }
        })));
  }
}

class RowWithIcon extends StatelessWidget {
  final String title;
  final IconData? icon;
  final Function()? onpressed;
  const RowWithIcon({
    Key? key,
    required this.title,
    this.icon,
    this.onpressed,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
          title,
          style: theme()
              .textTheme
              .headline3!
              .copyWith(fontWeight: FontWeight.w500),
        ),
        IconButton(onPressed: onpressed, icon: Icon(icon))
      ],
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
