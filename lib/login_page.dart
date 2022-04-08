import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mband_app/custom_input_field.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/registration_page.dart';
import 'package:mband_app/service.dart';

import 'main_page.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => LoginPageState();
}

class LoginPageState extends State<LoginPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
      body: Container(
          constraints: const BoxConstraints.expand(),
          color: const Color.fromRGBO(255, 182, 41, 1),

          child: Row(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Container(
                width: MediaQuery.of(context).size.width,
                height: MediaQuery.of(context).size.height * 0.8,
                decoration: const BoxDecoration(
                    boxShadow: [
                      BoxShadow(
                          color: Colors.white,
                          offset: Offset(-4, -4),
                          blurRadius: 15,
                          spreadRadius: 1)
                    ],
                    borderRadius:
                        BorderRadius.vertical(top: Radius.circular(15)),
                    gradient: LinearGradient(
                        begin: Alignment.topLeft,
                        end: Alignment.bottomRight,
                        colors: <Color>[
                          Color.fromRGBO(255, 255, 255, 1),
                          Color.fromRGBO(228, 228, 228, 1),
                        ])),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                        padding: const EdgeInsets.fromLTRB(26, 27, 0, 0),
                        child: Text(
                          "Добро пожаловать",
                          style: GoogleFonts.manrope(
                              fontSize: 18,
                              color: const Color.fromRGBO(0, 0, 0, 0.70)),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                        child: Text(
                          "Войдите чтобы продолжить",
                          style: GoogleFonts.manrope(
                              fontSize: 13,
                              color: const Color.fromRGBO(0, 0, 0, 0.45)),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(26, 41, 26, 0),
                        child: CustomInputField(
                            hintText: "Имя пользователя",
                            obscureText: false,
                            controller: usernameController,
                            width: MediaQuery.of(context).size.width * 0.86)),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(26, 27, 26, 0),
                        child: CustomInputField(
                          hintText: "Пароль",
                          obscureText: true,
                          controller: passwordController,
                          width: MediaQuery.of(context).size.width * 0.86,
                        )),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          NeumorphicButton(
                            onPressed: () {
                              Service().login(
                                  usernameController.text.toLowerCase(),
                                  passwordController.text,
                                  context);
                            },
                            style: NeumorphicStyle(
                                depth: 3,
                                color: const Color.fromRGBO(244, 244, 244, 1),
                                boxShape: NeumorphicBoxShape.roundRect(
                                    BorderRadius.circular(15)),
                                shape: NeumorphicShape.concave,
                                lightSource: LightSource.topLeft),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Center(
                                child: Text("Войти",
                                    style: GoogleFonts.manrope(
                                        fontSize: 15,
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.45))),
                              ),
                            ),
                          ),
                          NeumorphicButton(
                            onPressed: () {
                              Navigator.push(
                                context,
                                MaterialPageRoute(
                                    builder: (context) =>
                                        const RegistrationPage()),
                              );
                            },
                            style: NeumorphicStyle(
                              depth: 3,
                              color: const Color.fromRGBO(244, 244, 244, 1),
                              boxShape: NeumorphicBoxShape.roundRect(
                                  BorderRadius.circular(15)),
                              shape: NeumorphicShape.concave,
                              lightSource: LightSource.topLeft,
                            ),
                            child: SizedBox(
                              width: MediaQuery.of(context).size.width * 0.3,
                              height: MediaQuery.of(context).size.height * 0.06,
                              child: Center(
                                child: Text("Регистрация",
                                    style: GoogleFonts.manrope(
                                        fontSize: 15,
                                        color: const Color.fromRGBO(
                                            0, 0, 0, 0.45))),
                              ),
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
