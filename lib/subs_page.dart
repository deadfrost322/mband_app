import 'package:flutter/material.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/users_card_widget.dart';


class SubsPage extends StatefulWidget {
  const SubsPage({Key? key, required this.subs}) : super(key: key);
  final List<Profile> subs;

  @override
  State<SubsPage> createState() => SubsPageState(subs);
}

class SubsPageState extends State<SubsPage> {
  SubsPageState(this.subs);

  List<Profile> subs;
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
        child:
              ListView.builder(
                padding: const EdgeInsets.fromLTRB(13, 60, 13, 15),
                  physics: BouncingScrollPhysics(),
                  shrinkWrap: true,
                  itemBuilder: (BuildContext context, int i) {
                    return Padding(
                      padding: const EdgeInsets.only(top: 15),
                      child: UserCard(
                        firstName: subs[i].firstName.toString(),
                        lastName: subs[i].lastName.toString(),
                        status: subs[i].status.toString(),
                        city: subs[i].city.toString(),
                        district: subs[i].district.toString(),
                        skills: subs[i].skills,
                        genres: subs[i].genres,
                        profile: subs[i],
                      ),
                    );
                  },
                  itemCount: subs.length),
      ),
    );
  }
}
// floatingActionButton: NeumorphicButton(
// onPressed: () {},
// style: NeumorphicStyle(
// depth: 3,
// color: const Color.fromRGBO(244, 244, 244, 1),
// boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(15)),
// shape: NeumorphicShape.concave,
// lightSource: LightSource.topLeft),
// child: SizedBox(
// width: MediaQuery.of(context).size.width * 0.055,
// height: MediaQuery.of(context).size.height * 0.043,
// child: const Icon(
// Icons.filter_list_rounded,
// size: 20,
// color: Color.fromRGBO(0, 0, 0, 0.45),
// ))),
