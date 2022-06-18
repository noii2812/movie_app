class Movie {
  final String title;
  final String description;
  final int durations;
  final String imageUrl;
  final String videoUrl;
  final String genre;

  Movie(
      {required this.title,
      required this.description,
      required this.durations,
      required this.imageUrl,
      required this.videoUrl,
      required this.genre});
  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      title: json['title'],
      description: json['description'],
      durations: json['durations'],
      imageUrl: json['imageUrl'],
      videoUrl: json['videoUrl'],
      genre: json['genre'],
    );
  }
}
