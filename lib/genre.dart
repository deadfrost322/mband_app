class Genre {
  int id;
  String title;

  Genre({required this.id, required this.title});

  factory Genre.fromJson(Map<String, dynamic> json) {
    return Genre(id: (json['id']), title: (json['genre']));
  }
}
