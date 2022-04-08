import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mband_app/main.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/service.dart';
import 'package:mband_app/skill.dart';

import 'genre.dart';

class MorePage extends StatefulWidget {
  const MorePage({Key? key, required this.profile}) : super(key: key);

  final Profile profile;

  @override
  State<StatefulWidget> createState() => MorePageState(profile);
}

class MorePageState extends State<MorePage> {
  MorePageState(this.profile);

  Profile profile;

  String genresAndSkills(List<Genre>? genres, List<Skill>? skills) {
    String genresAndSkills = "";
    if (genres!.isNotEmpty) {
      for (var e in genres) {
        genresAndSkills = genresAndSkills + " " + e.title.toString();
      }
    }
    if (skills!.isNotEmpty) {
      for (var e in skills) {
        genresAndSkills = genresAndSkills + " " + e.title.toString();
      }
    }
    if (genresAndSkills.isEmpty) {
      genresAndSkills = "Не указаны";
    }
    return genresAndSkills;
  }

  bool subState = false;
  String btnText = "Подписаться";

  @override
  initState() {
    super.initState();
    subCheck();
  }

  subCheck() async {
    List<dynamic> list = await Service().checkSub(profile.id!.toInt());
    if (list.isNotEmpty) {
      setState(() {
        btnText = "Отписаться";
        subState = list.isNotEmpty;
      });
    } else {
      setState(() {
        btnText = "Подписаться";
        subState = list.isNotEmpty;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
          leading: IconButton(
            icon: const Icon(Icons.arrow_back_ios),
            color: const Color.fromRGBO(0, 0, 0, 1),
            onPressed: () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (context) => SplashPage()));
            },
          ),
          title: Padding(
            padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
            child: Text(
              profile.username.toString(),
              style: GoogleFonts.manrope(
                  fontSize: 20, color: const Color.fromRGBO(0, 0, 0, 1)),
            ),
          ),
        ),
        body: Container(
          constraints: const BoxConstraints.expand(),
          decoration: const BoxDecoration(
              gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: <Color>[
                Color.fromRGBO(255, 255, 255, 1),
                Color.fromRGBO(228, 228, 228, 1),
              ])),
          child: Column(
            children: [
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 0, 0),
                child: Row(
                  children: [
                    Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Container(
                            height: 111,
                            width: 111,
                            decoration: const BoxDecoration(
                                shape: BoxShape.circle, color: Colors.black45),
                            child: const Icon(
                              Icons.photo_camera_outlined,
                              color: Colors.white24,
                              size: 50,
                            ))
                      ],
                    ),
                    Padding(
                      padding: const EdgeInsets.only(left: 8),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          //имя фамилия
                          Text(
                              (profile.firstName.toString() +
                                  " " +
                                  profile.lastName.toString()),
                              style: GoogleFonts.manrope(
                                fontSize: 25,
                                color: const Color.fromRGBO(0, 0, 0, 0.65),
                              )),
                          //статус
                          Padding(
                            padding: const EdgeInsets.only(top: 3),
                            child: Row(
                              children: [
                                const Icon(
                                  Icons.sensors,
                                  color: Color.fromRGBO(70, 221, 32, 1),
                                ),
                                Padding(
                                  padding: const EdgeInsets.only(left: 5),
                                  child: Text(
                                    profile.status.toString(),
                                    style: GoogleFonts.manrope(
                                        fontSize: 18,
                                        color: const Color.fromRGBO(
                                            70, 221, 32, 1)),
                                  ),
                                )
                              ],
                            ),
                          ),
                          //линка
                          Padding(
                            padding: const EdgeInsets.only(top: 5),
                            child: Text(
                              profile.linkVK.toString(),
                              style: GoogleFonts.manrope(
                                fontSize: 15,
                                color: const Color.fromRGBO(0, 0, 0, 0.45),
                              ),
                            ),
                          ),
                          //кнопка
                          Padding(
                            padding: const EdgeInsets.only(top: 10),
                            child: NeumorphicButton(
                              onPressed: () {
                                if (subState) {
                                  Service()
                                      .deleteSubscription(profile.id!.toInt());
                                } else {
                                  Service()
                                      .createSubscription(profile.id!.toInt());
                                }
                                setState(() {
                                  subState = !subState;
                                });
                                if (btnText == "Подписаться") {
                                  setState(() {
                                    btnText = "Отписаться";
                                  });
                                } else {
                                  setState(() {
                                    btnText = "Подписаться";
                                  });
                                }
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
                                width: 110,
                                height: 20,
                                child: Center(
                                    child: Text(
                                  btnText,
                                  style: GoogleFonts.manrope(
                                    fontSize: 15,
                                    color: const Color.fromRGBO(0, 0, 0, 0.45),
                                  ),
                                )),
                              ),
                            ),
                          )
                        ],
                      ),
                    )
                  ],
                ),
              ),
              Padding(
                padding: const EdgeInsets.fromLTRB(20, 20, 20, 0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    //локация
                    Row(
                      children: [
                        const Icon(
                          Icons.location_on_outlined,
                          color: Color.fromRGBO(0, 0, 0, 0.45),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 5),
                          child: Text(
                            profile.city.toString() +
                                ", " +
                                profile.district.toString(),
                            style: GoogleFonts.manrope(
                              fontSize: 20,
                              color: const Color.fromRGBO(0, 0, 0, 0.45),
                            ),
                          ),
                        )
                      ],
                    ),

                    //жанры и инструменты
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.music_note_outlined,
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              genresAndSkills(profile.genres, profile.skills),
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                                color: const Color.fromRGBO(0, 0, 0, 0.45),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                    //др
                    Padding(
                      padding: const EdgeInsets.only(top: 10),
                      child: Row(
                        children: [
                          const Icon(
                            Icons.calendar_today_outlined,
                            color: Color.fromRGBO(0, 0, 0, 0.45),
                          ),
                          Padding(
                            padding: const EdgeInsets.only(left: 5),
                            child: Text(
                              profile.birthday.toString().split(' ')[0],
                              style: GoogleFonts.manrope(
                                fontSize: 20,
                                color: const Color.fromRGBO(0, 0, 0, 0.45),
                              ),
                            ),
                          )
                        ],
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ));
  }
}
