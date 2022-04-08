import 'dart:ffi';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mband_app/main.dart';
import 'package:mband_app/profile.dart';

class FilterPage extends StatefulWidget {
  const FilterPage({Key? key, required this.profileList}) : super(key: key);

  final List<Profile> profileList;




  @override
  State<StatefulWidget> createState() => FilterPageState(profileList);
}

class FilterPageState extends State<FilterPage> {
  FilterPageState(this.profileList);

  final List<Profile> profileList;



  bool folkState = false;
  bool rockState = false;
  bool rapState = false;
  bool classicState = false;
  bool metalState = false;

  bool guitarState = false;
  bool synthState = false;
  bool voiceState = false;
  bool violState = false;
  bool drumState = false;

  bool groupState = false;
  bool peopleState = false;
  bool noStatusState = false;


  submitFilter() {
    Navigator.push(
        context,
        MaterialPageRoute(
            builder: (context) => SplashPage()));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(
            Icons.arrow_back_ios,
            color: Color.fromRGBO(0, 0, 0, 1),
          ),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        title: Padding(
          padding: const EdgeInsets.only(left: 67),
          child: Text(
            "Фильтрация",
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
        child: Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "Жанры",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: const Color.fromRGBO(0, 0, 0, 0.45),
                ),
              ),
              Wrap(
                spacing: 5,
                children: [
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        folkState = val;
                      });
                    },
                    label: Text(
                      "Фолк",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: folkState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        rockState = val;
                      });
                    },
                    label: Text(
                      "Рок",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: rockState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        rapState = val;
                      });
                    },
                    label: Text(
                      "Рэп",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: rapState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        classicState = val;
                      });
                    },
                    label: Text(
                      "Классика",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: classicState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        metalState = val;
                      });
                    },
                    label: Text(
                      "Металл",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: metalState,
                  ),
                ],
              ),
              Text(
                "Инструменты",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: const Color.fromRGBO(0, 0, 0, 0.45),
                ),
              ),
              Wrap(
                spacing: 5,
                children: [
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        guitarState = val;
                      });
                    },
                    label: Text(
                      "Гитара",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: guitarState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        synthState = val;
                      });
                    },
                    label: Text(
                      "Синтезатор",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: synthState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        voiceState = val;
                      });
                    },
                    label: Text(
                      "Вокал",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: voiceState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        violState = val;
                      });
                    },
                    label: Text(
                      "Скрипка",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: violState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        drumState = val;
                      });
                    },
                    label: Text(
                      "Барабаны",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: drumState,
                  ),
                ],
              ),
              Text(
                "Статус",
                style: GoogleFonts.manrope(
                  fontSize: 16,
                  color: const Color.fromRGBO(0, 0, 0, 0.45),
                ),
              ),
              Wrap(
                spacing: 5,
                children: [
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        groupState = val;
                      });
                    },
                    label: Text(
                      "В поиске группы",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: groupState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        peopleState = val;
                      });
                    },
                    label: Text(
                      "в поиске людей в группу",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: peopleState,
                  ),
                  ChoiceChip(
                    onSelected: (val) {
                      setState(() {
                        noStatusState = val;
                      });
                    },
                    label: Text(
                      "Нет статуса",
                      style: GoogleFonts.manrope(),
                    ),
                    selected: noStatusState,
                  )
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 40),
                child: Wrap(
                  spacing: 20,
                  children: [
                    NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(
                          depth: 3,
                          color: const Color.fromRGBO(244, 244, 244, 1),
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15)),
                          shape: NeumorphicShape.concave,
                          lightSource: LightSource.topLeft),
                      child: SizedBox(
                        child: Text(
                          "Применить",
                          style: GoogleFonts.manrope(fontSize: 15),
                        ),
                      ),
                    ),
                    NeumorphicButton(
                      onPressed: () {},
                      style: NeumorphicStyle(
                          depth: 3,
                          color: const Color.fromRGBO(244, 244, 244, 1),
                          boxShape: NeumorphicBoxShape.roundRect(
                              BorderRadius.circular(15)),
                          shape: NeumorphicShape.concave,
                          lightSource: LightSource.topLeft),
                      child: SizedBox(
                        child: Text(
                          "Отмена",
                          style: GoogleFonts.manrope(fontSize: 15),
                        ),
                      ),
                    ),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
