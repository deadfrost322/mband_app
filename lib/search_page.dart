import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/users_card_widget.dart';

import 'filter_page.dart';


class SearchPage extends StatefulWidget {
  const SearchPage({Key? key, required this.profiles}) : super(key: key);
  final List<Profile> profiles;

  @override
  State<SearchPage> createState() => SearchPageState(profiles);
}

class SearchPageState extends State<SearchPage> {
  SearchPageState(this.profiles);

  List<Profile> profiles;

  TextEditingController searchController = TextEditingController();



  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      appBar: null,
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
              child: ListView.builder(
                  padding: const EdgeInsets.fromLTRB(13, 60, 13, 15),
                  physics: const BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: UserCard(
                        firstName: profiles[i].firstName.toString(),
                        lastName: profiles[i].lastName.toString(),
                        status: profiles[i].status.toString(),
                        city: profiles[i].city.toString(),
                        district: profiles[i].district.toString(),
                        skills: profiles[i].skills,
                        genres: profiles[i].genres,
                        profile: profiles[i],
                      ),
                    );
                  },
                  itemCount: profiles.length),
      ),
    );
  }
}
