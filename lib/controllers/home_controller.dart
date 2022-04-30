import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:movies_test/services/firestore_services.dart';
import 'package:movies_test/utils/dependencies_path.dart';
import 'package:movies_test/utils/model_paths.dart';
import 'package:movies_test/utils/services_paths.dart';

class HomeController extends GetxController {
  final moviesModelList = <Results>[].obs;
  final searchMovieModel = MoviesModel().obs;
  final movieDetails = Results().obs;
  final scrollController = ScrollController();
  final favouriteList = <bool>[].obs;
  final pageNo = 1.obs;
  final isLoading = true.obs;
  final isSearch = false.obs;
  final mockLoading = false.obs;
  final favouriteTvShowList = <FavouriteModel>[].obs;

  getMovies() async {
    var response =
        await ApiServices.apiServices.getMoviesData(pageNo.value.toString());
    if (response == null) {
      return;
    } else {
      MoviesModel moviesModel = MoviesModel.fromJson(response);
      for (var temp in moviesModel.results!) {
        moviesModelList.add(Results(
            name: temp.name,
            id: temp.id,
            firstAirDate: temp.firstAirDate,
            originalLanguage: temp.originalLanguage,
            voteAverage: temp.voteAverage,
            overview: temp.overview));
        if (!kIsWeb) {
          await LocalDatabaseService.localDatabaseServices
              .checkMovie(temp.name!)
              .then((value) {
            favouriteList.add(value);
          });
        } else {
          await FirestoreServices.firestoreServices
              .checkData(temp.id.toString())
              .then((value) {
            favouriteList.add(value);
          });
        }
      }
      isLoading(false);
      mockLoading(false);
    }
  }

  searchMovie(String movieName) async {
    isLoading(true);
    isSearch(true);
    var response = await ApiServices.apiServices.searchMovieData(movieName);
    if (response == null) {
      return;
    } else {
      isLoading(false);
      searchMovieModel(MoviesModel.fromJson(response));
    }
  }

  void pagination() {
    if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent &&
        moviesModelList.length < 1000) {
      mockLoading(true);
      pageNo.value++;
      getMovies();
    }
  }

  getFavourite() async {
    favouriteTvShowList.clear();
    if (!kIsWeb) {
      var data = await LocalDatabaseService.localDatabaseServices.getMovies();
      for (var temp in data) {
        favouriteTvShowList.add(temp);
      }
    } else {
      List<QueryDocumentSnapshot> data =
          await FirestoreServices.firestoreServices.getFavouriteList();
      for (var temp in data) {
        favouriteTvShowList.add(FavouriteModel(
            name: temp["name"],
            date: temp["date"],
            movieId: temp["movieId"],
            language: temp["language"],
            rating: temp["rating"],
            description: temp["description"]));
      }
    }
  }

  @override
  void onInit() {
    super.onInit();
    getMovies();
    getFavourite();
    scrollController.addListener(pagination);
    // TODO: implement onInit
  }
}
