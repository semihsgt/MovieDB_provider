class PopMov {
    final int? page;
    final List<PopMovResults>? results;
    final int? totalPages;
    final int? totalResults;

    PopMov({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    factory PopMov.fromJson(Map<String, dynamic> json) {
        var jsonArray = json['results'] as List;
        List <PopMovResults> resultList = jsonArray.map((jsonArrayObject) => PopMovResults.fromJson(jsonArrayObject)).toList();
        return PopMov(
            page: json["page"],
            results: resultList,
            totalPages: json["total_pages"],
            totalResults: json["total_results"],
        );
    } 
}

class PopMovResults {
    final bool? adult;
    final String? backdropPath;
    final List<int>? genreIds;
    final int? id;
    final String? originalLanguage;
    final String? originalTitle;
    final String? overview;
    final double? popularity;
    final String? posterPath;
    final String? releaseDate;
    final String? title;
    final bool? video;
    final double? voteAverage;
    final int? voteCount;

    PopMovResults({
        this.adult,
        this.backdropPath,
        this.genreIds,
        this.id,
        this.originalLanguage,
        this.originalTitle,
        this.overview,
        this.popularity,
        this.posterPath,
        this.releaseDate,
        this.title,
        this.video,
        this.voteAverage,
        this.voteCount,
    });

    factory PopMovResults.fromJson(Map<String, dynamic> json) {
        return PopMovResults(
            adult: json["adult"],
            backdropPath: json["backdrop_path"],
            genreIds: json["genre_ids"] == null ? [] : List<int>.from(json["genre_ids"]!.map((x) => x)),
            id: json["id"],
            originalLanguage: json['original_language'],
            originalTitle: json["original_title"],
            overview: json["overview"],
            popularity: json["popularity"]?.toDouble(),
            posterPath: json["poster_path"],
            releaseDate: json["release_date"],
            title: json["title"],
            video: json["video"],
            voteAverage: json["vote_average"]?.toDouble(),
            voteCount: json["vote_count"],
        );
    }
}