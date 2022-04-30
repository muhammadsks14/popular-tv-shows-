import 'dart:convert';

import 'package:http/http.dart' as https;

class ApiServices {
  static final ApiServices _apiServices = ApiServices._initialization();

  ApiServices._initialization() {
    print("initialized");
  }

  factory ApiServices() {
    return _apiServices;
  }
  static ApiServices get apiServices => _apiServices;

  final String _url = "https://api.themoviedb.org/3/";
  String? baseUrl;
  final String _key = "c9a302693c04bf71cb20a93546b2fdba";

  Future<dynamic> getMoviesData(String pageNo) async {
    baseUrl = "tv/popular?api_key=$_key&language=en-US&page=$pageNo";
    var uri = Uri.parse(_url + baseUrl!);
    try {
      var response = await https.get(uri);
      if (response.statusCode == 200) {
        var myData = jsonDecode(response.body);
        return myData;
      }
    } on Exception catch (e) {
      print(e);
    }
  }

  Future<dynamic> searchMovieData(String movieName) async {
    baseUrl =
        "search/tv?api_key=$_key&language=en-US&page=1&include_adult=false&query=$movieName";
    var uri = Uri.parse(_url + baseUrl!);
    try {
      var response = await https.get(uri);
      if (response.statusCode == 200) {
        var myData = jsonDecode(response.body);
        return myData;
      }
    } on Exception catch (e) {
      print(e);
    }
  }
}
