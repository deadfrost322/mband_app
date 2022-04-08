import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:mband_app/more_about_user.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/skill.dart';

import 'genre.dart';

class UserCard extends StatefulWidget {
  const UserCard({
    Key? key,
    required this.firstName,
    required this.lastName,
    required this.status,
    this.city,
    this.district,
    this.skills,
    this.genres,
    required this.profile,
  }) : super(key: key);

  final String firstName;
  final String lastName;
  final String status;
  final String? city;
  final String? district;
  final List<Skill>? skills;
  final List<Genre>? genres;
  final Profile profile;

  // final String imagePath;

  @override
  State<StatefulWidget> createState() => UserCardState(
      firstName, lastName, status, city, district, skills, genres, profile);
}

class UserCardState extends State<UserCard> {
  UserCardState(
    this.firstName,
    this.lastName,
    this.status,
    this.city,
    this.district,
    this.skills,
    this.genres,
    this.profile,
  );

  final String firstName;
  final String lastName;
  final String status;
  final String? city;
  final String? district;
  final List<Skill>? skills;
  final List<Genre>? genres;
  final Profile profile;

  String genresAndSkills(List<Genre>? genres, List<Skill>? skills) {
    String genresAndSkills = "";
    if (genres != null && skills != null) {
      for (var e in genres) {
        e == null
            ? genresAndSkills = genresAndSkills
            : genresAndSkills = genresAndSkills + " " + e.title.toString();
      }
      for (var e in skills) {
        e == null
            ? genresAndSkills = genresAndSkills
            : genresAndSkills = genresAndSkills + " " + e.title.toString();
      }
      return genresAndSkills;
    } else {
      return "Не указаны";
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        onTap: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => MorePage(profile: profile),
              ));
        },
        child: Container(
            width: MediaQuery.of(context).size.width * 0.93,
            height: 123,
            decoration: const BoxDecoration(
                color: Color.fromRGBO(244, 244, 244, 1),
                borderRadius: BorderRadius.all(Radius.circular(15)),
                boxShadow: [
                  BoxShadow(
                    color: Colors.grey,
                    offset: Offset(4, 4),
                    blurRadius: 15,
                    spreadRadius: 1,
                  ),
                  BoxShadow(
                    color: Colors.white,
                    offset: Offset(-4, -4),
                    blurRadius: 15,
                    spreadRadius: 5,
                  )
                ]),
            child: Padding(
              padding: const EdgeInsets.fromLTRB(13, 13, 0, 0),
              child: Row(
                children: [
                  Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    children: [
                      Container(
                        height: 75,
                        width: 75,
                        decoration: const BoxDecoration(
                            shape: BoxShape.circle, color: Colors.black45),
                        child: const Icon(Icons.photo_camera_outlined,
                          color: Colors.white24,
                          size: 32,),
                      )
                    ],
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 15),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        Text(
                          firstName + " " + lastName,
                          style: GoogleFonts.manrope(
                            fontSize: 20,
                            color: const Color.fromRGBO(0, 0, 0, 0.65),
                          ),
                        ),
                        Row(
                          children: [
                            const Icon(
                              Icons.sensors,
                              color: Color.fromRGBO(70, 221, 32, 1),
                            ),
                            Padding(
                              padding: const EdgeInsets.only(left: 5),
                              child: Text(
                                status,
                                style: GoogleFonts.manrope(
                                    fontSize: 16,
                                    color:
                                        const Color.fromRGBO(70, 221, 32, 1)),
                              ),
                            ),
                          ],
                        ),
                        Visibility(
                          visible: city != null || district != null,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.location_on_outlined,
                                size: 13,
                                color: Color.fromRGBO(0, 0, 0, 0.45),
                              ),
                              Text(
                                city.toString() + ", " + district.toString(),
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(0, 0, 0, 0.45),
                                ),
                              )
                            ],
                          ),
                        ),
                        Visibility(
                          visible: skills != null || genres != null,
                          child: Row(
                            children: [
                              const Icon(
                                Icons.music_note_outlined,
                                color: Color.fromRGBO(0, 0, 0, 0.45),
                                size: 13,
                              ),
                              Text(
                                genresAndSkills(genres, skills),
                                style: GoogleFonts.manrope(
                                  fontSize: 12,
                                  color: const Color.fromRGBO(0, 0, 0, 0.45),
                                ),
                              )
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            )));
  }
}
