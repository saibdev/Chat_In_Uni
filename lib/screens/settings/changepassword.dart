// ignore_for_file: deprecated_member_use, file_names, prefer_const_constructors, unused_label, curly_braces_in_flow_control_structures

import 'dart:convert';
import 'dart:typed_data';
import 'package:chatinunii/components/bottomnavbar.dart';
import 'package:chatinunii/components/toast.dart';
import 'package:chatinunii/constants.dart';
import 'package:chatinunii/core/apis.dart';
import 'package:chatinunii/models/statusmodel.dart';
import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:image_picker/image_picker.dart';
import 'package:translator/translator.dart';

class ChangePassword extends StatefulWidget {
  const ChangePassword();

  @override
  _EditProfileState createState() => _EditProfileState();
}

class _EditProfileState extends State<ChangePassword> {
  final translator = GoogleTranslator();
  var currentpass, save, new_pass, error_update, pass_updated, change_pass;
  String localmage = '';
  TextEditingController oldpass = TextEditingController();
  TextEditingController newpass = TextEditingController();
  // TextEditingController image = TextEditingController();
  bool showPassword = false;
  String? lang;
  StatusModel? status;
  var data;

  @override
  void initState() {
    lang =
        '${Get.deviceLocale.toString().split('_')[0]}-${Get.deviceLocale.toString().split('_')[1]}';
    // TODO: implement initState
    super.initState();
    var l = Get.deviceLocale.toString();
    if (l.contains("uk") || l.contains("ru")) {
      setState(() {
        l = "uk_UA";
      });
    } else if (l.contains("tr")) {
      setState(() {
        l = "tr_Tr";
      });
    } else {
      setState(() {
        l = "en_US";
      });
    }
    print("lang: ${l.toString()}");
    translator
        .translate("Current Password", from: 'en', to: '${l.split('_')[0]}')
        .then((value) {
      setState(() {
        currentpass = value;
      });
    });
    translator
        .translate("New Password", from: 'en', to: '${l.split('_')[0]}')
        .then((value) {
      setState(() {
        new_pass = value;
      });
    });

    translator
        .translate("Error! while Updating password",
            from: 'en', to: '${l.split('_')[0]}')
        .then((value) {
      setState(() {
        error_update = value;
      });
    });
    translator
        .translate("Password has been Updated",
            from: 'en', to: '${l.split('_')[0]}')
        .then((value) {
      setState(() {
        pass_updated = value;
      });
    });
    translator
        .translate("SAVE", from: 'en', to: '${l.split('_')[0]}')
        .then((value) {
      setState(() {
        save = value;
      });
    });
    translator
        .translate("Change Password", from: 'en', to: '${l.split('_')[0]}')
        .then((value) {
      setState(() {
        change_pass = value;
      });
    });
  }

  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: change_pass == null
          ? const Center(child: CircularProgressIndicator())
          : Container(
              padding: EdgeInsets.fromLTRB(20, 20, 0, 0),
              child: ListView(
                children: [
                  SizedBox(
                    height: 25,
                  ),
                  Center(
                    child: Column(
                      children: [
                        SizedBox(
                          height: 45,
                        ),
                        buildTextField(
                            '$currentpass',
                            Icon(
                              Icons.password,
                              size: 30,
                              color: kPrimaryColor,
                            ),
                            oldpass),
                        SizedBox(
                          height: 25,
                        ),
                        buildTextField(
                            '$new_pass',
                            Icon(
                              Icons.password,
                              color: kPrimaryColor,
                            ),
                            newpass),
                        SizedBox(
                          height: 50,
                        ),
                      ],
                    ),
                  ),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        height: 50,
                        child: RaisedButton(
                          onPressed: () {
                            print(oldpass.text);
                            print(newpass.text);
                            Apis()
                                .changePassword(oldpass.text, newpass.text)
                                .then((value) {
                              if (value == 'Bad Request') {
                                showToast('$error_update');
                              } else {
                                if (jsonDecode(value)['IsSuccess'] == true) {
                                  Navigator.pop(context);
                                  showToast('$pass_updated');
                                } else {
                                  showToast(jsonDecode(value)['ErrorMessage']);
                                }
                              }
                            });
                          },
                          color: kPrimaryColor,
                          padding: EdgeInsets.symmetric(horizontal: 50),
                          elevation: 2,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            'save'.tr,
                            style: TextStyle(
                                fontSize: 14,
                                letterSpacing: 2.2,
                                color: Colors.white),
                          ),
                        ),
                      ),
                    ],
                  )
                ],
              ),
            ),
    );
  }

  AppBar buildAppBar() {
    return AppBar(
      leading: IconButton(
          icon: Icon(
            Icons.arrow_back_ios_new,
            color: Colors.white,
          ),
          onPressed: () {
            Navigator.pop(context);
          }),
      automaticallyImplyLeading: false,
      backgroundColor: kPrimaryColor,
      title: Text(
        'change_password'.tr,
      ),
    );
  }

  Widget buildTextField(
      String labelText, Icon icon, TextEditingController ctrl) {
    return Container(
        width: double.infinity,
        height: 70,
        margin: const EdgeInsets.symmetric(horizontal: 20, vertical: 20),
        padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 5),
        decoration: BoxDecoration(
            border: Border.all(color: kPrimaryColor, width: 1),
            color: Colors.white,
            borderRadius: const BorderRadius.all(Radius.circular(20))),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            icon,
            Expanded(
              child: Container(
                margin: const EdgeInsets.only(left: 10),
                child: TextFormField(
                  controller: ctrl,
                  obscureText: true,
                  maxLines: 1,
                  decoration: InputDecoration(
                    label: Text(labelText),
                    border: InputBorder.none,
                  ),
                ),
              ),
            ),
          ],
        ));
  }
}
