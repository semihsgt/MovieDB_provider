abstract class BaseModel<T> {
  int? statusCode;
  T fromJson(Map<String, dynamic> json);
}

final class MovieData extends BaseModel {
  final int? page;
  final List<Movie>? results;
  final int? totalPages;
  final int? totalResults;

  MovieData({this.page, this.results, this.totalPages, this.totalResults});

  factory MovieData.fromJson(Map<String, dynamic> json) {
    var jsonArray = json['results'] as List;
    List<Movie> resultList =
        jsonArray
            .map((jsonArrayObject) => Movie.fromJson(jsonArrayObject))
            .toList();
    return MovieData(
      page: json["page"],
      results: resultList,
      totalPages: json["total_pages"],
      totalResults: json["total_results"],
    );
  }

  @override
  MovieData fromJson(Map<String, dynamic> json) {
    return MovieData.fromJson(json);
  }
}

class Movie extends BaseModel {
  @override
  Movie fromJson(Map<String, dynamic> json) {
    return Movie.fromJson(json);
  }

  final bool? adult;
  final String? backdropPath;
  final dynamic belongsToCollection;
  final int? budget;
  final List<Genre>? genres;
  final String? homepage;
  final int? id;
  final String? imdbId;
  final List<String>? originCountry;
  final String? originalLanguage;
  final String? originalTitle;
  final String? overview;
  final double? popularity;
  final String? posterPath;
  final List<ProductionCompany>? productionCompanies;
  final List<ProductionCountry>? productionCountries;
  final String? releaseDate;
  final int? revenue;
  final int? runtime;
  final List<SpokenLanguage>? spokenLanguages;
  final String? status;
  final String? tagline;
  final String? title;
  final bool? video;
  final double? voteAverage;
  final int? voteCount;
  bool isFavorite;
  bool isInWatchlist;

  Movie({
    this.adult,
    this.backdropPath,
    this.belongsToCollection,
    this.budget,
    this.genres,
    this.homepage,
    this.id,
    this.imdbId,
    this.originCountry,
    this.originalLanguage,
    this.originalTitle,
    this.overview,
    this.popularity,
    this.posterPath,
    this.productionCompanies,
    this.productionCountries,
    this.releaseDate,
    this.revenue,
    this.runtime,
    this.spokenLanguages,
    this.status,
    this.tagline,
    this.title,
    this.video,
    this.voteAverage,
    this.voteCount,
    this.isFavorite = false,
    this.isInWatchlist = false,
  });

  factory Movie.fromJson(Map<String, dynamic> json) => Movie(
    adult: json["adult"],
    backdropPath: json["backdrop_path"],
    belongsToCollection: json["belongs_to_collection"],
    budget: json["budget"],
    genres:
        json["genres"] == null
            ? []
            : List<Genre>.from(json["genres"]!.map((x) => Genre.fromJson(x))),
    homepage: json["homepage"],
    id: json["id"],
    imdbId: json["imdb_id"],
    originCountry:
        json["origin_country"] == null
            ? []
            : List<String>.from(json["origin_country"]!.map((x) => x)),
    originalLanguage: json["original_language"],
    originalTitle: json["original_title"],
    overview: json["overview"],
    popularity: json["popularity"]?.toDouble(),
    posterPath: json["poster_path"],
    productionCompanies:
        json["production_companies"] == null
            ? []
            : List<ProductionCompany>.from(
              json["production_companies"]!.map(
                (x) => ProductionCompany.fromJson(x),
              ),
            ),
    productionCountries:
        json["production_countries"] == null
            ? []
            : List<ProductionCountry>.from(
              json["production_countries"]!.map(
                (x) => ProductionCountry.fromJson(x),
              ),
            ),
    releaseDate: json["release_date"],
    revenue: json["revenue"],
    runtime: json["runtime"],
    spokenLanguages:
        json["spoken_languages"] == null
            ? []
            : List<SpokenLanguage>.from(
              json["spoken_languages"]!.map((x) => SpokenLanguage.fromJson(x)),
            ),
    status: json["status"],
    tagline: json["tagline"],
    title: json["title"],
    video: json["video"],
    voteAverage: json["vote_average"]?.toDouble(),
    voteCount: json["vote_count"],
    // isFavorite and isInWatchlist are handled later in data processing
  );
}

class Genre {
  final int? id;
  final String? name;

  Genre({this.id, this.name});

  factory Genre.fromJson(Map<String, dynamic> json) =>
      Genre(id: json["id"], name: json["name"]);
}

class ProductionCompany {
  final int? id;
  final String? logoPath;
  final String? name;
  final String? originCountry;

  ProductionCompany({this.id, this.logoPath, this.name, this.originCountry});

  factory ProductionCompany.fromJson(Map<String, dynamic> json) =>
      ProductionCompany(
        id: json["id"],
        logoPath: json["logo_path"],
        name: json["name"],
        originCountry: json["origin_country"],
      );
}

class ProductionCountry {
  final String? iso31661;
  final String? name;

  ProductionCountry({this.iso31661, this.name});

  factory ProductionCountry.fromJson(Map<String, dynamic> json) =>
      ProductionCountry(iso31661: json["iso_3166_1"], name: json["name"]);
}

class SpokenLanguage {
  final String? englishName;
  final String? iso6391;
  final String? name;

  SpokenLanguage({this.englishName, this.iso6391, this.name});

  factory SpokenLanguage.fromJson(Map<String, dynamic> json) => SpokenLanguage(
    englishName: json["english_name"],
    iso6391: json["iso_639_1"],
    name: json["name"],
  );
}
