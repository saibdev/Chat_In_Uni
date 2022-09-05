// ignore_for_file: sort_child_properties_last

import 'package:chatinunii/models/ChatMessage.dart';
import 'package:chatinunii/screens/chats/chats_screen.dart';
import 'package:chatinunii/screens/messages/components/message.dart';
import 'package:chatinunii/screens/messages/messages_screen.dart';
import 'package:chatinunii/screens/profile.dart';
import 'package:chatinunii/screens/settings/setlanguage.dart';
import 'package:chatinunii/screens/splashscreen.dart';
import 'package:flutter/material.dart';
import 'package:socket_io_client/socket_io_client.dart' as IO;
import '../../authScreens/login.dart';
import '../../constants.dart';
import '../../core/apis.dart';
import '../SiginInOrSignUp/signin_or_signup_screen.dart';
import 'components/body.dart';
import 'components/chatInput_field.dart';

class TranslatedMessagesScreen extends StatefulWidget {
  final username;
  var data;
  int index;
  TranslatedMessagesScreen({
    Key? key,
    required this.username,
    required this.data,
    required this.index,
  }) : super(key: key);

  @override
  State<TranslatedMessagesScreen> createState() => _MessagesScreenState();
}

bool? transFlag;

class _MessagesScreenState extends State<TranslatedMessagesScreen> {
  IO.Socket socket = IO.io('https://test-api.chatinuni.com', <String, dynamic>{
    "transports": ["websocket"]
  });
  var msgList;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print("trans1 $trans");

    countscreen += 1;
    print('chat translated ${widget.data['IsChatTranslated']}');

    setState(() {
      transFlag = true;
      trans = 'Show Original';
    });

    print("trans4 $trans flag $transFlag");

    print(socket.connected);
    socket.on('CreateChat', (data) {
      setState(() {
        msgList = data;
      });
      print(msgList);
      print('done');
    });
  }

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  bool _flag = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: WillPopScope(
        onWillPop: () {
          Navigator.pushAndRemoveUntil(
              context,
              MaterialPageRoute(builder: (context) => ChatsScreen()),
              (route) => false);
          return Future.value(false);
        },
        child: Column(
          children: [
            Body(
              username: widget.username,
              data: widget.data,
              index: widget.index,
              transFlag: true,
            )

            // Expanded(
            //   child: Padding(
            //     padding: const EdgeInsets.symmetric(
            //       horizontal: kDefaultPadding,
            //     ),
            //     child: StreamBuilder<List>(
            //       stream: transFlag == true
            //           ? Apis().getTranslatedChat(widget.data['ChatId'],
            //               langCode == null ? lang : langCode, token!)
            //           : Apis().getGetChat(widget.username),
            //       builder: (context, snapshot) {
            //         if (snapshot.connectionState != ConnectionState.active) {
            //           return const Center(child: CircularProgressIndicator());
            //         } else if (!snapshot.hasData) {
            //           return const Center(
            //             child: Text('Empty Chat'),
            //           );
            //         } else {
            //           print('Trans flag ${transFlag}');
            //           return SingleChildScrollView(
            //               reverse: true,
            //               child: ListView.builder(
            //                   physics: NeverScrollableScrollPhysics(),
            //                   shrinkWrap: true,
            //                   itemCount: snapshot.data!.length,
            //                   itemBuilder: (context, index) {
            //                     // readmsg();
            //                     return Message(
            //                       message: ChatMessage(
            //                           text: snapshot.data![index]['Message'],
            //                           messageType: ChatMessageType.text,
            //                           messageStatus: MessageStatus.viewed,
            //                           isSender: snapshot.data![index]
            //                                       ['ToUserName'] ==
            //                                   widget.username
            //                               ? true
            //                               : false),
            //                       image: widget.data['ProfilePhotos'] == null
            //                           ? 'https://chatinuni.com/assets/image/profile-place-holder.jpg'
            //                           : widget.data['ProfilePhotos'][0]
            //                               ['FileURL'],
            //                     );
            //                   }));
            //         }
            //       },
            //     ),
            //   ),
            // ),
            ,
            ChatInputField(
              username: widget.username,
              chatId: widget.data['ChatId'],
            ),
          ],
        ),
      ),
    );
  }

  String? trans;

  AppBar buildAppBar() {
    return AppBar(
      backgroundColor: kPrimaryColor,
      automaticallyImplyLeading: false,
      title: Row(
        children: [
          BackButton(
            onPressed: () {
              Navigator.pushAndRemoveUntil(
                  context,
                  MaterialPageRoute(builder: (context) => ChatsScreen()),
                  (route) => false);
            },
          ),
          CircleAvatar(
            backgroundImage: NetworkImage(widget.data['ProfilePhotos'] == null
                ? 'https://chatinuni.com/assets/image/profile-place-holder.jpg'
                : widget.data['ProfilePhotos'][0]['FileURL']),
          ),
          const SizedBox(
            width: kDefaultPadding * 0.35,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  widget.username,
                  style: TextStyle(fontSize: 16),
                ),
              ],
            ),
          ),
        ],
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: InkWell(
                child: Text("Set Language"),
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => const SetLanguage()));
                },
              ),
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(
          width: kDefaultPadding * 0.15,
        ),
        Container(
          margin: const EdgeInsets.only(
            top: 15,
            bottom: 15,
          ),
          child: Center(
            child: Padding(
              padding: const EdgeInsets.only(
                left: 5,
                right: 5,
              ),
              child: InkWell(
                child: Text(trans!),
                onTap: () {
                  // if (trans == 'Show Original') {
                  // setState(() {
                  // trans = 'Translate Chat';
                  // });
                  // }
                  //else {
                  //   setState(() {
                  //     transFlag = true;
                  //     trans = 'Show Original';
                  //   });
                  // }
                  print("count $countscreen");
                  if (countscreen == 1) {
                    transFlag = false;
                    countscreen = 0;
                    Navigator.push(
                        context,
                        MaterialPageRoute(
                            builder: (context) => MessagesScreen(
                                username: widget.username,
                                data: widget.data,
                                index: widget.index)));
                  } else {
                    transFlag = false;
                    Navigator.pop(context);
                  }
                },
              ),
            ),
          ),
          decoration: BoxDecoration(
              border: Border.all(
                color: Colors.white,
              ),
              borderRadius: BorderRadius.circular(10)),
        ),
        const SizedBox(
          width: kDefaultPadding * 0.15,
        ),
        // IconButton(onPressed: () {}, icon: Icon(Icons.square_outlined)),
      ],
    );
  }
}
