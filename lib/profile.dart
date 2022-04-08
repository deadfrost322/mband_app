import 'dart:convert';
import 'dart:developer';
import 'package:intl/intl.dart';
import 'package:mband_app/genre.dart';
import 'package:mband_app/skill.dart';

class Profile {
  int? id;
  int? profileId;
  String? email;
  String? username;
  String? firstName;
  String? lastName;
  DateTime? birthday;
  String? district;
  String? city;
  String? status;
  String? photoPath;
  String? linkYT;
  String? linkVK;
  List<Skill>? skills;
  List<Genre>? genres;

  Profile(
      {this.id,
        this.profileId,
       this.email,
       this.username,
      this.firstName,
      this.lastName,
      this.birthday,
      this.district,
      this.city,
      this.status,
      this.photoPath,
      this.linkYT,
      this.linkVK,
      this.skills,
      this.genres});

  factory Profile.fromJson(Map<String, dynamic> json) {
    DateFormat format = DateFormat("yyyy-MM-dd");
    DateFormat newFormat = DateFormat("dd.MM.yyyy");
    List<dynamic> skillsData = json['skills'] as List<dynamic>;
    List<Skill> skills =
        List.generate(skillsData.length, (i) => Skill.fromJson(skillsData[i]));
    List<dynamic> genreData = json['genres'] as List<dynamic>;
    List<Genre> genres =
        List.generate(genreData.length, (i) => Genre.fromJson(genreData[i]));
    return Profile(
        id: (json['id']),
        profileId: json['profiles']['id'],
        email: (json['profiles']['user']['email']),
        username: (json['profiles']['user']['username']??'не указан'),
        firstName: (json['profiles']['first_name']??'не указан'),
        lastName: (json['profiles']['last_name']??'не указан'),
        birthday: (format.parse(json['profiles']['birthday'])),
        district: (json['profiles']['district']??'не указан'),
        city: (json['profiles']['city']??'не указан'),
        status: (json['profiles']['status']??'не указан'),
        photoPath: (json['profiles']['photo']??'не указан'),
        linkYT: (json['profiles']['linkYT']??'не указан'),
        linkVK: (json['profiles']['linkVK']),
        skills: skills,
        genres: genres,
    );
  }
}
