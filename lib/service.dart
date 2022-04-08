import 'dart:developer';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mband_app/create_profile_page.dart';
import 'package:mband_app/login_page.dart';
import 'package:mband_app/main.dart';
import 'package:mband_app/profile.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'dart:convert';

class Service {
  setToken(String token) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.setString('token', token);
  }

  getToken() async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getString('token');
  }

  String url = 'http://26.249.56.39:8000/api/';

  void login(String username, String password, BuildContext context) async {
    String loginUrl = url + "login";
    var body = jsonEncode({"username": username, "password": password});
    var response = await http.post(Uri.parse(loginUrl),
        headers: {"Content-Type": "application/json"}, body: body);
    log(response.statusCode.toString());
    if (response.statusCode == 200) {
      Map<String, dynamic> data = json.decode(response.body);
      String token = data['access'].toString();
      setToken(token);
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashPage()));
    }
  }

  void registration(String username, String email, String password,
      BuildContext context) async {
    String registerUrl = url + "register";
    var body = jsonEncode(
        {"username": username, "email": email, "password": password});
    var response = await http.post(Uri.parse(registerUrl),
        headers: {"Content-Type": "application/json"}, body: body);
    log(response.statusCode.toString());
    if (response.statusCode == 201) {
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => const LoginPage()));
    }
  }

  Future<String> testToken(String token) async {
    String getProfileUrl = url + "profile/view";
    var response = await http.get(Uri.parse(getProfileUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('1 ' + response.statusCode.toString());
    return response.statusCode.toString();
  }

  Future<Profile> getProfile(String token, BuildContext context) async {
    String getProfileUrl = url + "profile/view";
    var response = await http.get(Uri.parse(getProfileUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('2 ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode(response.body.codeUnits));
      if(list[0]["profiles"] == null){
        Navigator.push(
            context, MaterialPageRoute(builder: (context) => CreateProfilePage()));
      }
      Profile profile = Profile.fromJson(list[0]);
      return profile;
    } else {
      throw 'FAILED TO GET PROFILE';
    }
  }

  Future<List<Profile>> getProfilesList(String token) async {
    String getProfilesListUrl = url + "profiles";
    var response = await http.get(Uri.parse(getProfilesListUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('3 ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode((response.body.codeUnits)));
      List<Profile> profile =
      List.generate(list.length, (i) => Profile.fromJson(list[i]));
      return profile;
    } else {
      throw 'FAILED TO GET PROFILES LIST';
    }
  }

  Future<List<Profile>> getSubsList(String token) async {
    String getSubsListUrl = url + "subscription/view";
    var response = await http.get(Uri.parse(getSubsListUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('4 ' + response.statusCode.toString());
    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(utf8.decode((response.body.codeUnits)));
      List<Profile> subs = List.generate(
          list.length, (i) => Profile.fromJson(list[i]["subscribed"]));
      return subs;
    } else {
      throw 'FAILED TO GET PROFILES LIST';
    }
  }

  void createSubscription(int id) async {
    String subscribeUrl = url + "subscription/create/$id";
    String token = await getToken();
    var response = await http.post(Uri.parse(subscribeUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('5 ' + response.statusCode.toString());
    if (response.statusCode == 201) {}
  }

  void deleteSubscription(int id) async {
    String subscribeUrl = url + "subscription/delete/$id";
    String token = await getToken();
    var response = await http.delete(Uri.parse(subscribeUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('6 ' + response.statusCode.toString());
    if (response.statusCode == 204) {}
  }

  Future<List<dynamic>> checkSub(int id) async {
    String checkSubUrl = url + "subscription/check/$id";
    String token = await getToken();
    var response = await http.get(Uri.parse(checkSubUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    if (response.statusCode == 200) {
      return json.decode(utf8.decode((response.body.codeUnits)));
    } else {
      throw 'FAILED TO CHECK SUBSCRIPTION';
    }
  }

  void createProfile(Profile profile, BuildContext context,) async {
    String createProfileUrl = url + "profile/create";
    String token = await getToken();
    String bday =  profile.birthday.toString().split(' ')[0];
    var body = jsonEncode({
      "first_name": profile.firstName,
      "last_name": profile.lastName,
      "district": profile.district,
      "city": profile.city,
      "birthday": bday,
      "status": profile.status,
      "linkVK": profile.linkVK,
    });
    var response = await http.post(Uri.parse(createProfileUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }, body:body);
    log('7 '+response.statusCode.toString());
    if(response.statusCode == 201){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashPage()));
    }
  }

  void updateProfile(Profile profile, BuildContext context,) async {
    int id = profile.profileId!.toInt();
    String updateProfileUrl = url + "profile/update/$id";
    String token = await getToken();
    String bday =  profile.birthday.toString().split(' ')[0];
    var body = jsonEncode({
      "first_name": profile.firstName,
      "last_name": profile.lastName,
      "district": profile.district,
      "city": profile.city,
      "birthday": bday,
      "status": profile.status,
      "linkVK": profile.linkVK,
    });
    var response = await http.patch(Uri.parse(updateProfileUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }, body:body);
    log('8 '+response.statusCode.toString());
    if(response.statusCode == 200){
      Navigator.push(
          context, MaterialPageRoute(builder: (context) => SplashPage()));
    }
  }

  void createGenre(String genre) async{
    String createGenreUrl = url + "genre/create";
    String token = await getToken();
    var body = jsonEncode({
      "genre": genre.toString(),
    });
    var response = await http.post(Uri.parse(createGenreUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }, body:body);
    log('8.1.1 '+response.statusCode.toString());
  }

  void deleteGenre(int id) async{
    String deleteGenreUrl = url + "genre/delete/$id";
    String token = await getToken();
    var response = await http.delete(Uri.parse(deleteGenreUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('8.1.2 '+response.statusCode.toString());
  }

  void createSkill(String skill) async{
    String createGenreUrl = url + "skill/create";
    String token = await getToken();
    var body = jsonEncode({
      "skill": skill,
    });
    var response = await http.post(Uri.parse(createGenreUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    }, body:body);
    log('8.2.1 '+response.statusCode.toString());
  }

  void deleteSkill(int id) async{
    String deleteGenreUrl = url + "skill/delete/$id";
    String token = await getToken();
    var response = await http.delete(Uri.parse(deleteGenreUrl), headers: {
      "Content-Type": "application/json",
      "Authorization": "Bearer $token"
    });
    log('8.2.2 '+response.statusCode.toString());
  }
}
