// To parse this JSON data, do
//
//     final upcomingResponse = upcomingResponseFromMap(jsonString);

import 'dart:convert';

import 'package:peliculas_v2/models/models.dart';

class UpcomingResponse {
    UpcomingResponse({
        this.page,
        this.results,
        this.totalPages,
        this.totalResults,
    });

    int page;
    List<Movie> results;
    int totalPages;
    int totalResults;

    factory UpcomingResponse.fromJson(String str) => UpcomingResponse.fromMap(json.decode(str));


    factory UpcomingResponse.fromMap(Map<String, dynamic> json) => UpcomingResponse(
        page: json["page"],
        results: List<Movie>.from(json["results"].map((x) => Movie.fromMap(x))),
        totalPages: json["total_pages"],
        totalResults: json["total_results"],
    );

}
