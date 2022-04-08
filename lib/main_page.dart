import 'package:flutter/cupertino.dart';
import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:mband_app/profile.dart';
import 'package:mband_app/profile_page.dart';
import 'package:mband_app/search_page.dart';
import 'package:mband_app/subs_page.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key, required this.profile, required this.profiles, required this.subs}) : super(key: key);
  final List<Profile> profiles;
  final Profile profile;
  final List<Profile> subs;

  @override
  State<StatefulWidget> createState() => MainPageState(profile, profiles, subs);
}

class MainPageState extends State<MainPage> {
  MainPageState(this.profile, this.profiles, this.subs);
  final List<Profile> subs;
  final List<Profile> profiles;
  final Profile profile;

  int selectedIndex = 1;
  int selectedPage = 1;
  PageController pageController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: null,
        bottomNavigationBar: BottomNavigationBar(
          onTap: (index) {
            setState(() {
              selectedIndex = index;
              selectedPage = index;
              pageController.animateToPage(selectedPage,
                  duration: const Duration(milliseconds: 300),
                  curve: Curves.fastOutSlowIn);
            });
          },
          iconSize: 30,
          selectedItemColor: const Color.fromRGBO(0, 0, 0, 1),
          selectedFontSize: 0,
          unselectedItemColor: const Color.fromRGBO(0, 0, 0, 0.45),
          unselectedFontSize: 0,
          showSelectedLabels: false,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(Icons.people_alt_outlined), label: ""),
            BottomNavigationBarItem(icon: Icon(Icons.search), label: ""),
            BottomNavigationBarItem(
                icon: Icon(Icons.person_outline_rounded), label: ""),
          ],
          currentIndex: selectedIndex,
        ),
        body: PageView(

          onPageChanged: (index) {
            setState(() {
              selectedPage = index;
              selectedIndex = index;
            });
          },
          controller: pageController,
          children: <Widget> [SubsPage(subs: subs,), SearchPage(profiles: profiles,), ProfilePage(profile: profile,)],
        ));
  }


}
