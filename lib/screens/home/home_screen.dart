import 'dart:async';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:layover/blocs/swipe/swipe_bloc.dart';
import 'package:geofence_flutter/geofence_flutter.dart';
import 'package:layover/config/theme.dart';
import 'package:layover/screens/home/locations/locations.dart';
import '../../blocs/profile/profile_bloc.dart';
import '../../widgets/custom_appbar.dart';
import '../../widgets/user_card.dart';
import '../onboarding/onboarding_screens/start/start_screen.dart';
import '../onboarding/onboarding_screens/verif/email_verification_screen.dart';
import 'locations/get_locations.dart';

class HomeScreen extends StatefulWidget {
  @override
  State<HomeScreen> createState() => _HomeScreenState();

  static const String routeName = '/';

  static Route route() {
    return MaterialPageRoute(
      settings: const RouteSettings(name: routeName),
      builder: (context) => HomeScreen(),
    );
  }
}

Future reload() async {
  await FirebaseAuth.instance.currentUser!.reload();
}

class _HomeScreenState extends State<HomeScreen> with WidgetsBindingObserver {
  @override
  initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    // FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
    //   'location': 'You Are Out of Boundary',
    // });
  }

  Future reload() async {
    await FirebaseAuth.instance.currentUser!.reload();
  }

  @override
  void disposed() {
    WidgetsBinding.instance.removeObserver(this);

    super.dispose();
  }

  @override
  void didChangeAppLifecycleSTate(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);

    final isBackground = state == AppLifecycleState.paused;

    if (state == AppLifecycleState.inactive ||
        state == AppLifecycleState.detached) {
      FirebaseFirestore.instance.collection('users').doc(user!.uid).update({
        'location': 'You Are Out of Boundary',
      });
    }
  }

  StreamController<GeofenceEvent> controller =
      StreamController<GeofenceEvent>.broadcast();
  StreamSubscription<GeofenceEvent>? geofenceEventStream1;
  StreamSubscription<GeofenceEvented>? geofenceEventStream2;
  StreamSubscription<GeofenceEvented1>? geofenceEventStream3;
  StreamSubscription<GeofenceEvented2>? geofenceEventStream4;
  StreamSubscription<GeofenceEvented3>? geofenceEventStream5;
  StreamSubscription<GeofenceEvented4>? geofenceEventStream6;
  StreamSubscription<GeofenceEvented5>? geofenceEventStream7;
  StreamSubscription<GeofenceEvented6>? geofenceEventStream8;
  StreamSubscription<GeofenceEvented7>? geofenceEventStream9;
  StreamSubscription<GeofenceEvented8>? geofenceEventStream10;
  String geofenceEvent = '';
  bool isRefreshing = false;
  User? user = FirebaseAuth.instance.currentUser;
  Future signOut() async {
    await FirebaseAuth.instance.signOut();
    // ignore: use_build_context_synchronously
    Navigator.pushReplacement(
        context, MaterialPageRoute(builder: (context) => Start()));
  }

  @override
  Widget build(context) {
    if (FirebaseAuth.instance.currentUser != null) {
      if (FirebaseAuth.instance.currentUser!.emailVerified == false) {
        signOut();
      }
    }
    return Scaffold(
      appBar: const CustomAppBar(
        title: 'Layover',
      ),
      body: BlocBuilder<SwipeBloc, SwipeState>(
        builder: (context, state) {
          if (state is SwipeLoading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (state is SwipeLoaded) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              child: Stack(children: [
                SingleChildScrollView(
                  child: Column(
                    children: [
                      Column(
                        children: [
                          Padding(
                              padding:
                                  const EdgeInsets.symmetric(vertical: 10.0),
                              // child: Text(
                              //   'Out of Boundary',
                              // ),
                              // ),
                              child: BlocBuilder<ProfileBloc, ProfileState>(
                                  builder: (context, stated) {
                                if (stated is SwipeLoading) {
                                  return const Center(
                                    child: CircularProgressIndicator(),
                                  );
                                }
                                if (stated is ProfileLoaded) {
                                  void getReload() {
                                    if (stated.user.location !=
                                        'You Are Out of Boundary') {
                                      reload();
                                    }
                                  }

                                  return Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Text(stated.user.location,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline2!
                                              .copyWith(
                                                  fontWeight: FontWeight.normal,
                                                  height: 1.4,
                                                  fontSize: 20,
                                                  wordSpacing: 3,
                                                  color: Color.fromARGB(
                                                      255, 4, 8, 44))),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(top: 8.0),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  right: 8.0),
                                              child: Container(
                                                  height: 6,
                                                  width: 6,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          theme().primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40))),
                                            ),
                                            Container(
                                                height: 6,
                                                width: 70,
                                                decoration: BoxDecoration(
                                                    color: theme().primaryColor,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            40))),
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                  left: 8.0),
                                              child: Container(
                                                  height: 6,
                                                  width: 6,
                                                  decoration: BoxDecoration(
                                                      color:
                                                          theme().primaryColor,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              40))),
                                            ),
                                          ],
                                        ),
                                      )
                                    ],
                                  );
                                } else {
                                  return Text('');
                                }
                              })),
                          BlocBuilder<ProfileBloc, ProfileState>(
                              builder: (context, stated) {
                            if (stated is ProfileLoaded) {
                              return (state.users.length > 1 &&
                                      stated.user.location !=
                                          'You Are Out of Boundary')
                                  ? SizedBox(
                                      height: 230,
                                      child: GridView.builder(
                                          gridDelegate:
                                              const SliverGridDelegateWithFixedCrossAxisCount(
                                                  crossAxisCount: 3,
                                                  childAspectRatio: 0.55),
                                          itemCount: state.users.length,
                                          itemBuilder: (BuildContext context,
                                              int index) {
                                            return InkWell(
                                                onTap: () {
                                                  Navigator.pushNamed(
                                                      context, '/user',
                                                      arguments:
                                                          state.users[0]);
                                                },
                                                child: (state.users[index]
                                                                .location !=
                                                            'You Are Out of Boundary' &&
                                                        state.users[index].id !=
                                                            '${user!.uid}')
                                                    ? (state.users.length < 2)
                                                        ? Row(
                                                            children: [
                                                              UserCard(
                                                                  user: state
                                                                          .users[
                                                                      index]),
                                                            ],
                                                          )
                                                        : UserCard(
                                                            user: state
                                                                .users[index])
                                                    : Text(''));
                                          }),
                                    )
                                  : Padding(
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 18.0, vertical: 60),
                                      child: Container(
                                        decoration: BoxDecoration(
                                            color: theme().backgroundColor,
                                            borderRadius:
                                                BorderRadius.circular(20)),
                                        child: Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          children: [
                                            Padding(
                                              padding: const EdgeInsets.only(
                                                top: 30.0,
                                                bottom: 30.0,
                                              ),
                                              child: Row(
                                                children: [
                                                  Padding(
                                                    padding:
                                                        const EdgeInsets.only(
                                                            right: 8.0),
                                                    child: Icon(
                                                        Icons.info_outline),
                                                  ),
                                                  Center(
                                                      child: const Text(
                                                    'No user is found near you.',
                                                    textAlign: TextAlign.center,
                                                    style:
                                                        TextStyle(fontSize: 20),
                                                  )),
                                                ],
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    );
                            } else {
                              return Text('');
                            }
                          }),
                        ],
                      ),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: Padding(
                    padding: const EdgeInsets.only(bottom: 8.0),
                    child: FloatingActionButton(
                      backgroundColor: theme().primaryColor,
                      onPressed: () {
                        setState(() {
                          isRefreshing = true;
                        });
                        Future getLocation1() async {
                          print("start");
                          double latitude1 = 33.640925;
                          double longitude1 = 84.427643;
                          double radius1 = 1610.0;
                          final String locationName =
                              "Hartsfield- Jackson (ATL)";
                          await Geofence.startGeofenceService(
                              pointedLatitude: latitude1.toString(),
                              pointedLongitude: longitude1.toString(),
                              radiusMeter: radius1.toString(),
                              eventPeriodInSeconds: 10);
                          if (geofenceEventStream1 == null) {
                            geofenceEventStream1 = Geofence.getGeofenceStream()
                                ?.listen((GeofenceEvent event) {
                              print('${event.toString()} 1');
                              setState(() {
                                geofenceEvent = event.toString();
                              });
                              if (event == GeofenceEvent.enter) {
                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .update({
                                  'location': locationName,
                                });
                                setState(() {
                                  isRefreshing = true;
                                });
                              } else if (event == GeofenceEvent.exit) {
                                print('object');

                                FirebaseFirestore.instance
                                    .collection('users')
                                    .doc(user!.uid)
                                    .update({
                                  'location': 'You Are Out of Boundary',
                                });
                                setState(() {
                                  isRefreshing = true;
                                });

                                ////////////////// 2nd Stream ///////////

                                Future getLocation2() async {
                                  print("start");
                                  double latitude2 = 33.941788;
                                  double longitude2 = -118.404343;
                                  double radius1 = 1000.0;
                                  final String locationName =
                                      "Los Angeles International Airport (LAX)";
                                  await Geofence.startGeofenceService(
                                      pointedLatitude: latitude2.toString(),
                                      pointedLongitude: longitude2.toString(),
                                      radiusMeter: radius1.toString(),
                                      eventPeriodInSeconds: 13);
                                  if (geofenceEventStream2 == null) {
                                    geofenceEventStream2 =
                                        Geofenced.getGeofenceStreamed()
                                            ?.listen((GeofenceEvented event) {
                                      print('${event.toString()} 2');
                                      setState(() {
                                        geofenceEvent = event.toString();
                                      });
                                    });
                                  }
                                  if (geofenceEvent == "GeofenceEvent.enter") {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user!.uid)
                                        .update({
                                      'location': locationName,
                                    });
                                    setState(() {
                                      isRefreshing = false;
                                    });
                                  } else if (geofenceEvent ==
                                      "GeofenceEvent.exit") {
                                    FirebaseFirestore.instance
                                        .collection('users')
                                        .doc(user!.uid)
                                        .update({
                                      'location': 'You Are Out of Boundary',
                                    });
                                    setState(() {
                                      isRefreshing = false;
                                    });
                                    //////////// 3rd stream/////////////////
                                    Future getLocation3() async {
                                      print("start");
                                      double latitude3 = 41.977406;
                                      double longitude3 = -87.897584;
                                      double radius1 = 1610.0;
                                      final String locationName =
                                          "O'Hare International Airport (ORD)";
                                      await Geofenced1.startGeofenceService(
                                          pointedLatitude: latitude3.toString(),
                                          pointedLongitude:
                                              longitude3.toString(),
                                          radiusMeter: radius1.toString(),
                                          eventPeriodInSeconds: 10);
                                      if (geofenceEventStream3 == null) {
                                        geofenceEventStream3 =
                                            Geofenced1.getGeofenceStreamed1()
                                                ?.listen(
                                                    (GeofenceEvented1 event) {
                                          print('${event.toString()} 3');
                                          setState(() {
                                            geofenceEvent = event.toString();
                                          });
                                        });
                                      }
                                      if (geofenceEvent ==
                                          "GeofenceEvent.enter") {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.uid)
                                            .update({
                                          'location': locationName,
                                        });
                                        setState(() {
                                          isRefreshing = false;
                                        });
                                      } else if (geofenceEvent ==
                                          "GeofenceEvent.exit") {
                                        FirebaseFirestore.instance
                                            .collection('users')
                                            .doc(user!.uid)
                                            .update({
                                          'location': 'You Are Out of Boundary',
                                        });
                                        setState(() {
                                          isRefreshing = false;
                                        });

                                        /// 4th stream/////
                                        Future getLocation4() async {
                                          print("start");
                                          double latitude4 = 32.897541;
                                          double longitude4 = 97.040629;
                                          double radius1 = 1610;
                                          final String locationName =
                                              "Dallas/Fort Worth Airport (DFW)";
                                          await Geofenced2.startGeofenceService(
                                              pointedLatitude:
                                                  latitude4.toString(),
                                              pointedLongitude:
                                                  longitude4.toString(),
                                              radiusMeter: radius1.toString(),
                                              eventPeriodInSeconds: 10);
                                          if (geofenceEventStream4 == null) {
                                            geofenceEventStream4 = Geofenced2
                                                    .getGeofenceStreamed2()
                                                ?.listen(
                                                    (GeofenceEvented2 event) {
                                              print('${event.toString()} 4');
                                              setState(() {
                                                geofenceEvent =
                                                    event.toString();
                                              });
                                            });
                                          }
                                          if (geofenceEvent ==
                                              "GeofenceEvent.enter") {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user!.uid)
                                                .update({
                                              'location': locationName,
                                            });
                                            setState(() {
                                              isRefreshing = false;
                                            });
                                          } else if (geofenceEvent ==
                                              "GeofenceEvent.exit") {
                                            FirebaseFirestore.instance
                                                .collection('users')
                                                .doc(user!.uid)
                                                .update({
                                              'location':
                                                  'You Are Out of Boundary',
                                            });
                                            setState(() {
                                              isRefreshing = false;
                                            });

                                            /// 5th stream/////
                                            Future getLocation5() async {
                                              print("start");
                                              double latitude5 = 39.858389;
                                              double longitude5 = -104.673575;
                                              double radius1 = 1000;
                                              final String locationName =
                                                  "Denver International Airport (DEN)";
                                              await Geofenced3
                                                  .startGeofenceService(
                                                      pointedLatitude:
                                                          latitude5.toString(),
                                                      pointedLongitude:
                                                          longitude5.toString(),
                                                      radiusMeter:
                                                          radius1.toString(),
                                                      eventPeriodInSeconds: 10);
                                              if (geofenceEventStream5 ==
                                                  null) {
                                                geofenceEventStream5 = Geofenced3
                                                        .getGeofenceStreamed3()
                                                    ?.listen((GeofenceEvented3
                                                        event) {
                                                  print(
                                                      '${event.toString()} 5');
                                                  setState(() {
                                                    geofenceEvent =
                                                        event.toString();
                                                  });
                                                });
                                              }
                                              if (geofenceEvent ==
                                                  "GeofenceEvent.enter") {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user!.uid)
                                                    .update({
                                                  'location': locationName,
                                                });
                                                setState(() {
                                                  isRefreshing = false;
                                                });
                                              } else if (geofenceEvent ==
                                                  "GeofenceEvent.exit") {
                                                FirebaseFirestore.instance
                                                    .collection('users')
                                                    .doc(user!.uid)
                                                    .update({
                                                  'location':
                                                      'You Are Out of Boundary',
                                                });
                                                setState(() {
                                                  isRefreshing = false;
                                                });

                                                /// 6th stream/////
                                                Future getLocation6() async {
                                                  print("start");
                                                  double latitude6 = 40.644987;
                                                  double longitude6 =
                                                      -73.784148;
                                                  double radius1 = 1200;
                                                  final String locationName =
                                                      "John F. Kennedy International Airport (JFK)";
                                                  await Geofenced4
                                                      .startGeofenceService(
                                                          pointedLatitude:
                                                              latitude6
                                                                  .toString(),
                                                          pointedLongitude:
                                                              longitude6
                                                                  .toString(),
                                                          radiusMeter: radius1
                                                              .toString(),
                                                          eventPeriodInSeconds:
                                                              10);
                                                  if (geofenceEventStream6 ==
                                                      null) {
                                                    geofenceEventStream6 = Geofenced4
                                                            .getGeofenceStreamed4()
                                                        ?.listen(
                                                            (GeofenceEvented4
                                                                event) {
                                                      print(
                                                          '${event.toString()} 6');
                                                      setState(() {
                                                        geofenceEvent =
                                                            event.toString();
                                                      });
                                                    });
                                                  }
                                                  if (geofenceEvent ==
                                                      "GeofenceEvent.enter") {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(user!.uid)
                                                        .update({
                                                      'location': locationName,
                                                    });
                                                    setState(() {
                                                      isRefreshing = false;
                                                    });
                                                  } else if (geofenceEvent ==
                                                      "GeofenceEvent.exit") {
                                                    FirebaseFirestore.instance
                                                        .collection('users')
                                                        .doc(user!.uid)
                                                        .update({
                                                      'location':
                                                          'You Are Out of Boundary',
                                                    });
                                                    setState(() {
                                                      isRefreshing = false;
                                                    });

                                                    /// 7th stream/////
                                                    Future
                                                        getLocation7() async {
                                                      print("start");
                                                      double latitude7 =
                                                          37.616010;
                                                      double longitude7 =
                                                          -122.385804;
                                                      double radius1 = 1000;
                                                      final String
                                                          locationName =
                                                          "San Francisco  Airport (SFO)";
                                                      await Geofenced5
                                                          .startGeofenceService(
                                                              pointedLatitude:
                                                                  latitude7
                                                                      .toString(),
                                                              pointedLongitude:
                                                                  longitude7
                                                                      .toString(),
                                                              radiusMeter: radius1
                                                                  .toString(),
                                                              eventPeriodInSeconds:
                                                                  10);
                                                      if (geofenceEventStream7 ==
                                                          null) {
                                                        geofenceEventStream7 =
                                                            Geofenced5
                                                                    .getGeofenceStreamed5()
                                                                ?.listen(
                                                                    (GeofenceEvented5
                                                                        event) {
                                                          print(
                                                              '${event.toString()} 7');
                                                          setState(() {
                                                            geofenceEvent =
                                                                event
                                                                    .toString();
                                                          });
                                                        });
                                                      }
                                                      if (geofenceEvent ==
                                                          "GeofenceEvent.enter") {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(user!.uid)
                                                            .update({
                                                          'location':
                                                              locationName,
                                                        });
                                                        setState(() {
                                                          isRefreshing = false;
                                                        });
                                                      } else if (geofenceEvent ==
                                                          "GeofenceEvent.exit") {
                                                        FirebaseFirestore
                                                            .instance
                                                            .collection('users')
                                                            .doc(user!.uid)
                                                            .update({
                                                          'location':
                                                              'You Are Out of Boundary',
                                                        });
                                                        setState(() {
                                                          isRefreshing = false;
                                                        });

                                                        /// 8th stream/////
                                                        Future
                                                            getLocation8() async {
                                                          print("start");
                                                          double latitude8 =
                                                              47.442986;
                                                          double longitude8 =
                                                              122.304757;
                                                          double radius1 = 800;
                                                          final String
                                                              locationName =
                                                              "Seattle-Tacoma International Airport (SEA)";
                                                          await Geofenced6.startGeofenceService(
                                                              pointedLatitude:
                                                                  latitude8
                                                                      .toString(),
                                                              pointedLongitude:
                                                                  longitude8
                                                                      .toString(),
                                                              radiusMeter: radius1
                                                                  .toString(),
                                                              eventPeriodInSeconds:
                                                                  10);
                                                          if (geofenceEventStream8 ==
                                                              null) {
                                                            geofenceEventStream8 = Geofenced6
                                                                    .getGeofenceStreamed6()
                                                                ?.listen(
                                                                    (GeofenceEvented6
                                                                        event) {
                                                              print(
                                                                  '${event.toString()} 8');
                                                              setState(() {
                                                                geofenceEvent =
                                                                    event
                                                                        .toString();
                                                              });
                                                            });
                                                          }
                                                          if (geofenceEvent ==
                                                              "GeofenceEvent.enter") {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(user!.uid)
                                                                .update({
                                                              'location':
                                                                  locationName,
                                                            });
                                                            setState(() {
                                                              isRefreshing =
                                                                  false;
                                                            });
                                                          } else if (geofenceEvent ==
                                                              "GeofenceEvent.exit") {
                                                            FirebaseFirestore
                                                                .instance
                                                                .collection(
                                                                    'users')
                                                                .doc(user!.uid)
                                                                .update({
                                                              'location':
                                                                  'You Are Out of Boundary',
                                                            });
                                                            setState(() {
                                                              isRefreshing =
                                                                  false;
                                                            });

                                                            /// 9th stream/////
                                                            Future
                                                                getLocation9() async {
                                                              print("start");
                                                              double latitude9 =
                                                                  36.081619;
                                                              double
                                                                  longitude9 =
                                                                  -115.114099;
                                                              double radius1 =
                                                                  1000;
                                                              final String
                                                                  locationName =
                                                                  "Harry Reid International Airport (LAS)";
                                                              await Geofenced7.startGeofenceService(
                                                                  pointedLatitude:
                                                                      latitude9
                                                                          .toString(),
                                                                  pointedLongitude:
                                                                      longitude9
                                                                          .toString(),
                                                                  radiusMeter:
                                                                      radius1
                                                                          .toString(),
                                                                  eventPeriodInSeconds:
                                                                      10);
                                                              if (geofenceEventStream9 ==
                                                                  null) {
                                                                geofenceEventStream9 = Geofenced7
                                                                        .getGeofenceStreamed7()
                                                                    ?.listen(
                                                                        (GeofenceEvented7
                                                                            event) {
                                                                  print(
                                                                      '${event.toString()} 9');
                                                                  setState(() {
                                                                    geofenceEvent =
                                                                        event
                                                                            .toString();
                                                                  });
                                                                });
                                                              }
                                                              if (geofenceEvent ==
                                                                  "GeofenceEvent.enter") {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(user!
                                                                        .uid)
                                                                    .update({
                                                                  'location':
                                                                      locationName,
                                                                });
                                                                setState(() {
                                                                  isRefreshing =
                                                                      false;
                                                                });
                                                              } else if (geofenceEvent ==
                                                                  "GeofenceEvent.exit") {
                                                                FirebaseFirestore
                                                                    .instance
                                                                    .collection(
                                                                        'users')
                                                                    .doc(user!
                                                                        .uid)
                                                                    .update({
                                                                  'location':
                                                                      'You Are Out of Boundary',
                                                                });
                                                                setState(() {
                                                                  isRefreshing =
                                                                      false;
                                                                });

                                                                /// 10th stream/////
                                                                Future
                                                                    getLocation10() async {
                                                                  print(
                                                                      "start");
                                                                  double
                                                                      latitude10 =
                                                                      28.431916;
                                                                  double
                                                                      longitude10 =
                                                                      -81.307909;
                                                                  double
                                                                      radius1 =
                                                                      1000;
                                                                  final String
                                                                      locationName =
                                                                      "Orlando International Airport (MCO)";
                                                                  await Geofenced8.startGeofenceService(
                                                                      pointedLatitude:
                                                                          latitude10
                                                                              .toString(),
                                                                      pointedLongitude:
                                                                          longitude10
                                                                              .toString(),
                                                                      radiusMeter:
                                                                          radius1
                                                                              .toString(),
                                                                      eventPeriodInSeconds:
                                                                          10);
                                                                  if (geofenceEventStream10 ==
                                                                      null) {
                                                                    geofenceEventStream10 = Geofenced8
                                                                            .getGeofenceStreamed8()
                                                                        ?.listen((GeofenceEvented8
                                                                            event) {
                                                                      print(
                                                                          '${event.toString()} 10');
                                                                      setState(
                                                                          () {
                                                                        geofenceEvent =
                                                                            event.toString();
                                                                      });
                                                                    });
                                                                  }
                                                                  if (geofenceEvent ==
                                                                      "GeofenceEvent.enter") {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(user!
                                                                            .uid)
                                                                        .update({
                                                                      'location':
                                                                          locationName,
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      isRefreshing =
                                                                          false;
                                                                    });
                                                                  } else if (geofenceEvent ==
                                                                      "GeofenceEvent.exit") {
                                                                    FirebaseFirestore
                                                                        .instance
                                                                        .collection(
                                                                            'users')
                                                                        .doc(user!
                                                                            .uid)
                                                                        .update({
                                                                      'location':
                                                                          'You Are Out of Boundary',
                                                                    });
                                                                    setState(
                                                                        () {
                                                                      isRefreshing =
                                                                          false;
                                                                    });
                                                                  }
                                                                }

                                                                getLocation10();
                                                              }
                                                            }

                                                            getLocation9();
                                                          }
                                                        }

                                                        getLocation8();
                                                      }
                                                    }

                                                    getLocation7();
                                                  }
                                                }

                                                getLocation6();
                                              }
                                            }

                                            getLocation5();
                                          }
                                        }

                                        getLocation4();
                                      }
                                    }

                                    getLocation3();
                                  }
                                }

                                getLocation2();
                              }
                            });
                          }
                        }

                        getLocation1();
                      },
                      child: isRefreshing
                          ? const Center(
                              child: SizedBox(
                              width: 20,
                              height: 20,
                              child: CircularProgressIndicator(
                                color: Colors.white,
                              ),
                            ))
                          : Icon(Icons.refresh),
                    ),
                  ),
                )
              ]),
            );
          } else {
            return const Text('Something went wrong');
          }
        },
      ),
    );
  }
}
