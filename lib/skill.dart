class Skill {
  int id;
  String title;

  Skill({required this.id, required this.title});

  factory Skill.fromJson(Map<String, dynamic> json) {
    return Skill(id: (json['id']), title: (json['skill']));
  }
}
