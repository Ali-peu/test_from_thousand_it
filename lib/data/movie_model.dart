final Map<int, String> genres = {};

class MovieModel {
  final String name;
  final String imageUrl;
  final String description;
  final String releaseDate;
  final double voteAvarage;
  final int id;
  final String originalLanguage;
  final String originalTitle;
  final double popularity;
  final bool? isVideo;
  final int voteCount;
  final String backdropPath;
  final bool? adult;
  final List<int> genreIDs;

  const MovieModel({
    required this.genreIDs,
    required this.id,
    required this.originalLanguage,
    required this.originalTitle,
    required this.popularity,
    required this.isVideo,
    required this.voteCount,
    required this.backdropPath,
    required this.adult,
    required this.name,
    required this.imageUrl,
    required this.description,
    required this.releaseDate,
    required this.voteAvarage,
  });

  MovieModel copyWith({
    String? name,
    String? imageUrl,
    String? description,
    String? releaseDate,
    double? voteAvarage,
    int? id,
    String? originalLanguage,
    String? originalTitle,
    double? popularity,
    bool? isVideo,
    int? voteCount,
    String? backdropPath,
    bool? adult,
  }) {
    return MovieModel(
        name: name ?? this.name,
        imageUrl: imageUrl ?? this.imageUrl,
        description: description ?? this.description,
        releaseDate: releaseDate ?? this.releaseDate,
        voteAvarage: voteAvarage ?? this.voteAvarage,
        id: id ?? this.id,
        originalLanguage: originalLanguage ?? this.originalLanguage,
        originalTitle: originalTitle ?? this.originalTitle,
        popularity: popularity ?? this.popularity,
        isVideo: isVideo ?? this.isVideo,
        voteCount: voteCount ?? this.voteCount,
        backdropPath: backdropPath ?? this.backdropPath,
        adult: adult ?? this.adult,
        genreIDs: genreIDs);
  }

  static MovieModel fromJson(Map<String, dynamic> data) {
    return MovieModel(
        name: data['title'] ?? '',
        imageUrl: data['poster_path'] ?? '',
        description: data['overview'] ?? '',
        releaseDate: data['release_date'] ?? '',
        voteAvarage: data['vote_average'] ?? 0,
        id: data['id'] ?? 0,
        originalLanguage: data['original_language'] ?? '',
        originalTitle: data['original_title'] ?? '',
        popularity: data['popularity'] ?? 0.0,
        isVideo: data['video'] ?? false,
        voteCount: data['vote_count'] ?? 0,
        backdropPath: data['backdrop_path'] ?? '',
        adult: data['adult'] ?? false,
        genreIDs: List<int>.from(data['genre_ids'] ?? []));
  }

  @override
  String toString() {
    // TODO: implement toString
    return 'name : $name';
  }
}
