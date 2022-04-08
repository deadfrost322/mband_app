import 'dart:convert';
import 'dart:developer';
import 'package:http/http.dart' as http;
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mband_app/custom_input_field.dart';
import 'package:mband_app/login_page.dart';
import 'package:mband_app/service.dart';

class RegistrationPage extends StatefulWidget {
  const RegistrationPage({Key? key}) : super(key: key);

  @override
  State<StatefulWidget> createState() => RegistrationPageState();
}

class RegistrationPageState extends State<RegistrationPage> {
  final usernameController = TextEditingController();
  final passwordController = TextEditingController();
  final emailController = TextEditingController();

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
                          "Создайте аккаунт",
                          style: GoogleFonts.manrope(
                              fontSize: 18,
                              color: const Color.fromRGBO(0, 0, 0, 0.70)),
                        )),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(26, 0, 0, 0),
                        child: Text(
                          "Влейтесь в музыкальное комюнити",
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
                            hintText: "Электронная почта",
                            obscureText: false,
                            controller: emailController,
                            width: MediaQuery.of(context).size.width * 0.86)),
                    Padding(
                        padding: const EdgeInsets.fromLTRB(26, 27, 26, 0),
                        child: CustomInputField(
                            hintText: "Пароль",
                            obscureText: true,
                            controller: passwordController,
                            width: MediaQuery.of(context).size.width * 0.86)),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(26, 33, 26, 0),
                      child: NeumorphicButton(
                        onPressed: () {
                          Service().registration(usernameController.text.toLowerCase(), emailController.text, passwordController.text, context);
                        },
                        style: NeumorphicStyle(
                            depth: 5,
                            color: const Color.fromRGBO(244, 244, 244, 1),
                            boxShape: NeumorphicBoxShape.roundRect(
                                BorderRadius.circular(15)),
                            shape: NeumorphicShape.concave,
                            lightSource: LightSource.topLeft),
                        child: SizedBox(
                          width: MediaQuery.of(context).size.width * 0.856,
                          height: MediaQuery.of(context).size.height * 0.06,
                          child: Center(
                            child: Text("Регистрация",
                                style: GoogleFonts.manrope(
                                    fontSize: 15,
                                    color:
                                        const Color.fromRGBO(0, 0, 0, 0.45))),
                          ),
                        ),
                      ),
                    ),
                    Padding(
                      padding: const EdgeInsets.fromLTRB(26, 26, 26, 0),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          TextButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                      builder: (context) => const LoginPage()),
                                );
                              },
                              child: Text("Уже есть аккаунт?",
                                  style: GoogleFonts.manrope(
                                    fontSize: 13,
                                    color: const Color.fromRGBO(0, 133, 255, 1),
                                  ))),
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
