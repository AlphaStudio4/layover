import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layover/screens/onboarding/widgets/custom_text_container.dart';
import 'package:layover/screens/premium/premium_screen.dart';
import 'package:layover/widgets/custom_button.dart';
import 'package:layover/widgets/user_image.dart';

import '../../blocs/onboarding/onboarding_bloc.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../config/theme.dart';
import '../../model/user_model.dart';

class UsersScreen extends StatelessWidget {
  static const String routeName = '/user';

  static Route route({required User user}) {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => UsersScreen(user: user),
    );
  }

  final User user;

  const UsersScreen({Key? key, required this.user}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
        ),
        extendBodyBehindAppBar: true,
        body: BlocBuilder<ProfileBloc, ProfileState>(builder: (context, state) {
          if (state is ProfileLoading) {
            return const Padding(
              padding: EdgeInsets.only(top: 85.0),
              child: Center(
                child: CircularProgressIndicator(),
              ),
            );
          }
          if (state is ProfileLoaded) {
            return SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Stack(
                    children: [
                      SizedBox(
                        height: MediaQuery.of(context).size.height / 1.67,
                        child: Stack(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(bottom: 85.0),
                              child: Container(
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(20.0),
                                    image: DecorationImage(
                                        image: NetworkImage(user.imageUrls[0]),
                                        fit: BoxFit.cover)),
                              ),
                            ),
                            Align(
                              alignment: Alignment.bottomCenter,
                              child: Padding(
                                padding: const EdgeInsets.only(top: 348.0),
                                child: Column(
                                  children: [
                                    Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 60),
                                      child: Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: [
                                          InkWell(
                                            onTap: (() {
                                              Navigator.pushNamed(
                                                context,
                                                '/',
                                              );
                                            }),
                                            child: ChoiceButton(
                                                width: 60,
                                                height: 60,
                                                size: 25,
                                                color: theme()
                                                    .secondaryHeaderColor,
                                                hasGradient: false,
                                                icon: Icons.clear_rounded),
                                          ),
                                          InkWell(
                                            onTap: (() {
                                              FirebaseFirestore.instance
                                                  .collection('users')
                                                  .doc(user.id)
                                                  .update({
                                                'likes':
                                                    FieldValue.increment(1),
                                              });
                                            }),
                                            child: const ChoiceButton(
                                                width: 75,
                                                height: 75,
                                                size: 30,
                                                hasGradient: true,
                                                color: Colors.white,
                                                icon: Icons.favorite),
                                          ),
                                          InkWell(
                                            onTap: (() async {
                                              final QuerySnapshot qSnap =
                                                  await FirebaseFirestore
                                                      .instance
                                                      .collection('users')
                                                      .doc(state.user.id)
                                                      .collection('messages')
                                                      .get();
                                              print('object');
                                              final int documents =
                                                  qSnap.docs.length;
                                              if (state.user.status ==
                                                  'Out of Boundary') {
                                                print('lee ${documents}');
                                                if (documents < 1) {
                                                  Navigator.push(
                                                      context,
                                                      MaterialPageRoute(
                                                          builder: (context) =>
                                                              PremiumScreen()));
                                                } else {
                                                  Navigator.pushNamed(
                                                      context, '/chat',
                                                      arguments: user);
                                                }
                                              } else {
                                                Navigator.pushNamed(
                                                    context, '/chat',
                                                    arguments: user);
                                              }
                                            }),
                                            child: ChoiceButton(
                                                width: 60,
                                                height: 60,
                                                size: 25,
                                                onpressed: () {},
                                                hasGradient: false,
                                                color: theme()
                                                    .secondaryHeaderColor,
                                                icon: Icons.message_outlined),
                                          )
                                        ],
                                      ),
                                    ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        '${user.likes} likes',
                                        style: Theme.of(context)
                                            .textTheme
                                            .headline2
                                            ?.copyWith(fontSize: 18),
                                      ),
                                    ),
                                  ],
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 20, vertical: 10),
                    child: SingleChildScrollView(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            '${user.name}, ${user.age}',
                            style: Theme.of(context)
                                .textTheme
                                .headline2
                                ?.copyWith(fontSize: 35),
                          ),
                          Text(
                            user.jobTitle,
                            style: Theme.of(context)
                                .textTheme
                                .headline3!
                                .copyWith(
                                    fontWeight: FontWeight.normal, height: 1.3),
                          ),
                          const SizedBox(
                            height: 18,
                          ),
                          Text(
                            'About',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 21),
                          ),
                          Text(
                            user.bio,
                            style: Theme.of(context)
                                .textTheme
                                .bodyText1!
                                .copyWith(
                                    fontWeight: FontWeight.normal,
                                    height: 2,
                                    fontSize: 13),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          Text(
                            'Pictures',
                            style: Theme.of(context)
                                .textTheme
                                .headline3
                                ?.copyWith(fontSize: 21),
                          ),
                          SizedBox(
                            height: 125,
                            child: ListView.builder(
                              shrinkWrap: true,
                              scrollDirection: Axis.horizontal,
                              itemCount: user.imageUrls.length,
                              itemBuilder: ((context, index) {
                                return Padding(
                                  padding: const EdgeInsets.only(
                                      top: 10, bottom: 10, right: 8.0),
                                  child: UserImage.small(
                                    width: 100,
                                    url: user.imageUrls[index],
                                    border: Border.all(
                                        color: theme().secondaryHeaderColor),
                                  ),
                                );
                              }),
                            ),
                          ),
                          const SizedBox(
                            height: 24,
                          ),
                          (user.interest.length > 0)
                              ? Column(
                                  children: [
                                    Text(
                                      'Interests',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          ?.copyWith(fontSize: 21),
                                    ),
                                    SizedBox(
                                      height: 72,
                                      child: ListView.builder(
                                        shrinkWrap: true,
                                        scrollDirection: Axis.horizontal,
                                        itemCount: user.interest.length,
                                        itemBuilder: ((context, index) {
                                          return Padding(
                                            padding: const EdgeInsets.only(
                                                bottom: 10, right: 8.0),
                                            child: CustomTextContainer(
                                                text: user.interest[0]),
                                          );
                                        }),
                                      ),
                                    )
                                  ],
                                )
                              : Column(
                                  children: [
                                    Text(
                                      'Interests',
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline3
                                          ?.copyWith(fontSize: 21),
                                    ),
                                    SizedBox(
                                      height: 72,
                                      child: Text('No interest'),
                                    )
                                  ],
                                ),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            );
          } else {
            return const Text('data');
          }
        }));
  }
}
