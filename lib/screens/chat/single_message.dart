import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/src/foundation/key.dart';
import 'package:flutter/src/widgets/container.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:layover/config/theme.dart';

class SingleMessage extends StatelessWidget {
  final String messages;
  final bool isMe;
  final String image;
  final String time;
  final bool isImage;
  const SingleMessage(
      {Key? key,
      required this.messages,
      required this.isMe,
      required this.image,
      required this.time,
      required this.isImage})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: isMe ? MainAxisAlignment.end : MainAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(right: 15.0, bottom: 7.0, top: 3.0),
          child: Row(
            children: [
              !isMe
                  ? !isImage
                      ? Row(
                          children: [
                            Container(
                              width: 100,
                            ),
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 12.0,
                                    bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                  color: isMe
                                      ? theme().backgroundColor
                                      : theme().primaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (messages.length > 17)
                                        ? Container(
                                            width: 200,
                                            child: Text(
                                              messages,
                                              style: theme()
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: isMe
                                                          ? Color.fromARGB(
                                                              255, 3, 0, 0)
                                                          : Colors.white,
                                                      fontSize: 17),
                                            ),
                                          )
                                        : Text(
                                            messages,
                                            style: theme()
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: isMe
                                                        ? Color.fromARGB(
                                                            255, 3, 0, 0)
                                                        : Colors.white,
                                                    fontSize: 17),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        time,
                                        style: theme()
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: isMe
                                                    ? Color.fromARGB(
                                                        255, 3, 0, 0)
                                                    : Colors.white,
                                                fontSize: 10),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      : Container(
                          width: 200,
                          height: 300,
                          padding: const EdgeInsets.only(
                              left: 16.0, right: 16.0, top: 12.0, bottom: 8),
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                              image: DecorationImage(
                                  fit: BoxFit.cover,
                                  image: NetworkImage(messages))),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Padding(
                                padding: const EdgeInsets.only(top: 268.0),
                                child: Text(
                                  time,
                                  style: theme().textTheme.headline6!.copyWith(
                                      color: Colors.white, fontSize: 10),
                                ),
                              ),
                            ],
                          ))
                  : !isImage
                      ? Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Container(
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 12.0,
                                    bottom: 8),
                                decoration: BoxDecoration(
                                  borderRadius: const BorderRadius.all(
                                    Radius.circular(7.0),
                                  ),
                                  color: isMe
                                      ? theme().backgroundColor
                                      : theme().primaryColor,
                                ),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    (messages.length > 17)
                                        ? Container(
                                            width: 200,
                                            child: Text(
                                              messages,
                                              style: theme()
                                                  .textTheme
                                                  .headline6!
                                                  .copyWith(
                                                      color: isMe
                                                          ? Color.fromARGB(
                                                              255, 3, 0, 0)
                                                          : Colors.white,
                                                      fontSize: 17),
                                            ),
                                          )
                                        : Text(
                                            messages,
                                            style: theme()
                                                .textTheme
                                                .headline6!
                                                .copyWith(
                                                    color: isMe
                                                        ? Color.fromARGB(
                                                            255, 3, 0, 0)
                                                        : Colors.white,
                                                    fontSize: 17),
                                          ),
                                    Padding(
                                      padding: const EdgeInsets.only(top: 8.0),
                                      child: Text(
                                        time,
                                        style: theme()
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: isMe
                                                    ? Color.fromARGB(
                                                        255, 3, 0, 0)
                                                    : Colors.white,
                                                fontSize: 10),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )
                      : Row(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            Container(
                                width: 200,
                                height: 300,
                                padding: const EdgeInsets.only(
                                    left: 16.0,
                                    right: 16.0,
                                    top: 12.0,
                                    bottom: 8),
                                decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(10),
                                    image: DecorationImage(
                                        fit: BoxFit.cover,
                                        image: NetworkImage(messages))),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Padding(
                                      padding:
                                          const EdgeInsets.only(top: 268.0),
                                      child: Text(
                                        time,
                                        style: theme()
                                            .textTheme
                                            .headline6!
                                            .copyWith(
                                                color: Colors.white,
                                                fontSize: 10),
                                      ),
                                    ),
                                  ],
                                )),
                          ],
                        )

              // !isImage
              //     ? Row(
              //         children: [
              //           Container(
              //             width: 100,
              //           ),
              //           Container(
              //               padding: const EdgeInsets.only(
              //                   left: 16.0, right: 16.0, top: 12.0, bottom: 8),
              //               decoration: BoxDecoration(
              //                 borderRadius: const BorderRadius.all(
              //                   Radius.circular(7.0),
              //                 ),
              //                 color: isMe
              //                     ? theme().backgroundColor
              //                     : theme().primaryColor,
              //               ),
              //               child: Column(
              //                 crossAxisAlignment: CrossAxisAlignment.start,
              //                 children: [
              //                   (messages.length > 17)
              //                       ? Container(
              //                           width: 200,
              //                           child: Text(
              //                             messages,
              //                             style: theme()
              //                                 .textTheme
              //                                 .headline6!
              //                                 .copyWith(
              //                                     color: isMe
              //                                         ? Color.fromARGB(
              //                                             255, 3, 0, 0)
              //                                         : Colors.white,
              //                                     fontSize: 17),
              //                           ),
              //                         )
              //                       : Text(
              //                           messages,
              //                           style: theme()
              //                               .textTheme
              //                               .headline6!
              //                               .copyWith(
              //                                   color: isMe
              //                                       ? Color.fromARGB(
              //                                           255, 3, 0, 0)
              //                                       : Colors.white,
              //                                   fontSize: 17),
              //                         ),
              //                   Padding(
              //                     padding: const EdgeInsets.only(top: 8.0),
              //                     child: Text(
              //                       time,
              //                       style: theme()
              //                           .textTheme
              //                           .headline6!
              //                           .copyWith(
              //                               color: isMe
              //                                   ? Color.fromARGB(255, 3, 0, 0)
              //                                   : Colors.white,
              //                               fontSize: 10),
              //                     ),
              //                   ),
              //                 ],
              //               )),
              //         ],
              //       )
              //     :
            ],
          ),
        )
      ],
    );
  }
}



//  Padding(
//   padding: const EdgeInsets.only(right: 5.0),
//   child: CircleAvatar(
//     radius: 15,
//     backgroundImage: NetworkImage(image),
//   ))