import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:mband_app/custom_input_field.dart';
import 'package:date_field/date_field.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/service.dart';
import 'main.dart';

class EditProfilePage extends StatefulWidget {
  const EditProfilePage({Key? key, required this.profile}) : super(key: key);
  final Profile profile;

  @override
  State<StatefulWidget> createState() => EditProfilePageState(profile);
}

class EditProfilePageState extends State<EditProfilePage> {
  EditProfilePageState(this.profile);


  TextEditingController firstNameController = TextEditingController();
  TextEditingController lastNameController = TextEditingController();
  TextEditingController cityController = TextEditingController();
  TextEditingController districtController = TextEditingController();
  TextEditingController vkController = TextEditingController();

  Profile profile;
  String genreValue = "Рок";
  String skillValue = "Гитара";
  String statusValue = "Нет статуса";
  DateTime birthdayState = DateTime.parse("2002-02-02");
  Profile newProfile = Profile();

  initFieldsState() {
    setState(() {
      firstNameController =
          TextEditingController(text: profile.firstName.toString());
      lastNameController =
          TextEditingController(text: profile.lastName.toString());
      cityController = TextEditingController(text: profile.city.toString());
      districtController =
          TextEditingController(text: profile.district.toString());
      vkController = TextEditingController(text: profile.linkVK.toString());
      statusValue = profile.status.toString();
      birthdayState = DateTime.parse(profile.birthday.toString());
    });
    if (profile.genres!.isNotEmpty) {
      setState(() {
        genreValue = profile.genres![0].title.toString();

      });
    }
    if(profile.skills!.isNotEmpty){
      skillValue = profile.skills![0].title.toString();
    }
  }

  initState() {
    super.initState();
    initFieldsState();
  }

  completeProfile() {
    newProfile = Profile(
        profileId: profile.profileId,
        firstName: firstNameController.text,
        lastName: lastNameController.text,
        district: districtController.text,
        city: cityController.text,
        linkVK: vkController.text,
        birthday: birthdayState,
        status: statusValue);
    if(profile.genres!.isNotEmpty){
      Service().deleteGenre(profile.genres![0].id);
      Service().createGenre(genreValue);
    }
    else{
      Service().createGenre(genreValue);
    }
    if(profile.skills!.isNotEmpty){
      Service().deleteSkill(profile.skills![0].id);
      Service().createSkill(skillValue);
    }
    else{
      Service().createSkill(skillValue);
    }
    Service().updateProfile(newProfile, context);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: AppBar(
        backgroundColor: const Color.fromRGBO(244, 244, 244, 1),
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios),
          color: const Color.fromRGBO(0, 0, 0, 1),
          onPressed: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => SplashPage()));
          },
        ),
        title: Padding(
          padding: const EdgeInsets.fromLTRB(90, 0, 0, 0),
          child: Text(
            "",
            style: GoogleFonts.manrope(
                fontSize: 20, color: const Color.fromRGBO(0, 0, 0, 1)),
          ),
        ),
        actions: [
          IconButton(
            onPressed: () {
              completeProfile();
            },
            icon: const Icon(
              Icons.done,
              size: 30,
            ),
            color: const Color.fromRGBO(0, 0, 0, 1),
          )
        ],
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
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        //имя фамилия
                        CustomInputField(
                            hintText: "Имя",
                            obscureText: false,
                            controller: firstNameController,
                            width: 225),
                        Padding(
                          padding: const EdgeInsets.only(top: 10),
                          child: CustomInputField(
                              hintText: "Фамилия",
                              obscureText: false,
                              controller: lastNameController,
                              width: 225),
                        )
                        //статус

                        //линка
                      ],
                    ),
                  )
                ],
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomInputField(
                  hintText: "Город",
                  obscureText: false,
                  controller: cityController,
                  width: 350),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomInputField(
                  hintText: "Район",
                  obscureText: false,
                  controller: districtController,
                  width: 350),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: CustomInputField(
                  hintText: "Ссылка на Vk",
                  obscureText: false,
                  controller: vkController,
                  width: 350),
            ),
            Padding(
              padding: const EdgeInsets.fromLTRB(25, 10, 25, 0),
              child: DateTimeFormField(
                initialValue: birthdayState,
                dateTextStyle: GoogleFonts.manrope(
                    color: const Color.fromRGBO(0, 0, 0, 0.65), fontSize: 15),
                dateFormat: DateFormat("yyyy-MM-dd"),
                decoration: InputDecoration(
                  labelStyle: GoogleFonts.manrope(
                      color: const Color.fromRGBO(0, 0, 0, 0.65), fontSize: 15),
                  hintStyle: GoogleFonts.manrope(
                      color: const Color.fromRGBO(0, 0, 0, 0.45), fontSize: 15),
                  border: const OutlineInputBorder(
                      borderRadius: BorderRadius.all(Radius.circular(50))),
                  suffixIcon: const Icon(Icons.event_note),
                ),
                onDateSelected: (value) {
                  setState(() {
                    birthdayState = DateTime.parse(value.toString());
                  });
                },
              ),
            ),
            Padding(
                padding: const EdgeInsets.fromLTRB(50, 10, 50, 0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    DropdownButton(
                      value: genreValue,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      hint: Text("Жанр",
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                          )),
                      onChanged: (String? newValue) {
                        setState(() {
                          genreValue = newValue!;
                        });
                      },
                      items: <String>[
                        "Фолк",
                        "Рок",
                        "Рэп",
                        "Металл",
                        "Классика"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                    DropdownButton(
                      value: skillValue,
                      borderRadius: const BorderRadius.all(Radius.circular(15)),
                      hint: Text("Интрумент",
                          style: GoogleFonts.manrope(
                            fontSize: 15,
                          )),
                      onChanged: (String? newValue) {
                        setState(() {
                          skillValue = newValue!;
                        });
                      },
                      items: <String>[
                        "Гитара",
                        "Скрипка",
                        "Вокал",
                        "Синтезатор",
                        "Барабаны"
                      ].map<DropdownMenuItem<String>>((String value) {
                        return DropdownMenuItem<String>(
                          value: value,
                          child: Text(value),
                        );
                      }).toList(),
                    ),
                  ],
                )),
            Padding(
              padding: const EdgeInsets.only(top: 10),
              child: DropdownButton(
                value: statusValue,
                borderRadius: const BorderRadius.all(Radius.circular(15)),
                hint: Text("Статус",
                    style: GoogleFonts.manrope(
                      fontSize: 15,
                    )),
                onChanged: (String? newValue) {
                  setState(() {
                    statusValue = newValue!;
                  });
                },
                items: <String>[
                  "В поисках группы",
                  "В поисках людей в группу",
                  "Нет статуса",
                ].map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(value),
                  );
                }).toList(),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
