import 'dart:async';
import 'dart:convert';
import 'package:chatinunii/authScreens/signup.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/screens/chats/chats_screen.dart';
import 'package:chatinunii/screens/messages/messages_screen.dart';
import 'package:flutter/material.dart';
import '../../../authScreens/login.dart';
import '../../../constants.dart';
import '../../../models/ChatMessage.dart';
import '../../splashscreen.dart';
import 'message.dart';

class Body extends StatefulWidget {
  // final messagelist;
  final username;
  var data;
  int index;
  bool transFlag;
  Body(
      {Key? key,
      required this.username,
      required this.data,
      required this.index,
      required this.transFlag})
      : super(key: key);

  @override
  State<Body> createState() => _BodyState();
}

String? langCode;

class _BodyState extends State<Body> {
  @override
  var msgList;

  void initState() {
    // TODO: implement initState
    super.initState();
    print(socket.connected);
    socket.on('Message', (data) {
      print('socket ${data.toString()}');
    });
    print(widget.data['ChatId']);
  }

  @override
  void dispose() {
    super.dispose();
  }

  readmsg() async {
    var readmsg = {
      "ChatId": widget.data['ChatId'],
      "ChatCreatedUserName": widget.username
    };
    socket.emit('ReadChatMessage', readmsg);
  }

  @override
  Widget build(BuildContext context) {
    bool? flag;
    return Expanded(
      child: Padding(
        padding: const EdgeInsets.symmetric(
          horizontal: kDefaultPadding,
        ),
        child: StreamBuilder<List>(
          stream: transFlag == true && countscreen != 0
              ? Apis().getTranslatedChat(widget.data['ChatId'],
                  langCode == null ? lang : langCode, token!)
              : Apis().getGetChat(widget.username, widget.data['ChatId'],
                  token!, langCode == null ? lang : langCode),
          builder: (context, snapshot) {
            if (snapshot.connectionState != ConnectionState.active) {
              return const Center(child: CircularProgressIndicator());
            } else if (!snapshot.hasData) {
              return const Center(
                child: Text('Empty Chat'),
              );
            } else {
              print('Trans flag ${transFlag}');
              return SingleChildScrollView(
                  reverse: true,
                  child: ListView.builder(
                      physics: NeverScrollableScrollPhysics(),
                      shrinkWrap: true,
                      itemCount: snapshot.data!.length,
                      itemBuilder: (context, index) {
                        readmsg();
                        return Message(
                          message: ChatMessage(
                              text: snapshot.data![index]['Message'],
                              messageType: ChatMessageType.text,
                              messageStatus: MessageStatus.viewed,
                              isSender: snapshot.data![index]['ToUserName'] ==
                                      widget.username
                                  ? true
                                  : false),
                          image: widget.data['ProfilePhotos'] == null
                              ? 'https://chatinuni.com/assets/image/profile-place-holder.jpg'
                              : widget.data['ProfilePhotos'][0]['FileURL'],
                        );
                      }));
            }
          },
        ),
      ),
    );
  }
}

// class Body1 extends StatefulWidget {
//   // final messagelist;
//   final username;
//   var data;
//   int index;
//   bool transFlag;
//   Body1(
//       {Key? key,
//       required this.username,
//       required this.data,
//       required this.index,
//       required this.transFlag})
//       : super(key: key);

//   @override
//   State<Body1> createState() => _Body1State();
// }

// // String? langCode;

// class _Body1State extends State<Body1> {
//   @override
//   var msgList;

//   void initState() {
//     // TODO: implement initState
//     super.initState();
//     print(socket.connected);
//     socket.on('Message', (data) {
//       print('socket ${data.toString()}');
//     });
//     print(widget.data['ChatId']);
//     setState(() {});
//   }

//   @override
//   void dispose() {
//     super.dispose();
//   }

//   readmsg() async {
//     var readmsg = {
//       "ChatId": widget.data['ChatId'],
//       "ChatCreatedUserName": widget.username
//     };
//     socket.emit('ReadChatMessage', readmsg);
//   }

//   @override
//   Widget build(BuildContext context) {
//     bool? flag;
//     return Expanded(
//       child: Padding(
//         padding: const EdgeInsets.symmetric(
//           horizontal: kDefaultPadding,
//         ),
//         child: StreamBuilder<List>(
//           stream: Apis().getGetChat(widget.username),
//           builder: (context, snapshot) {
//             if (snapshot.connectionState != ConnectionState.active) {
//               return const Center(child: CircularProgressIndicator());
//             } else if (!snapshot.hasData) {
//               return const Center(
//                 child: Text('Empty Chat'),
//               );
//             } else {
//               print('Trans flag ${transFlag}');
//               return SingleChildScrollView(
//                   reverse: true,
//                   child: ListView.builder(
//                       physics: NeverScrollableScrollPhysics(),
//                       shrinkWrap: true,
//                       itemCount: snapshot.data!.length,
//                       itemBuilder: (context, index) {
//                         readmsg();
//                         return Message(
//                           message: ChatMessage(
//                               text: snapshot.data![index]['Message'],
//                               messageType: ChatMessageType.text,
//                               messageStatus: MessageStatus.viewed,
//                               isSender: snapshot.data![index]['ToUserName'] ==
//                                       widget.username
//                                   ? true
//                                   : false),
//                           image: widget.data['ProfilePhotos'] == null
//                               ? 'https://chatinuni.com/assets/image/profile-place-holder.jpg'
//                               : widget.data['ProfilePhotos'][0]['FileURL'],
//                         );
//                       }));
//             }
//           },
//         ),
//       ),
//     );
//   }
// }
