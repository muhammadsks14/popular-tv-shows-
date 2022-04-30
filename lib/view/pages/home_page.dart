import 'package:flutter/foundation.dart';
import 'package:movies_test/services/firestore_services.dart';
import 'package:movies_test/utils/controller_paths.dart';
import 'package:movies_test/utils/dependencies_path.dart';
import 'package:movies_test/utils/model_paths.dart';
import 'package:movies_test/utils/services_paths.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  bool isSearchField = false;
  TextEditingController textEditingController = TextEditingController();
  final homeController = Get.put(HomeController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      body: Obx(
        () => homeController.isLoading.isFalse
            ? isSearchField == false
                ? Column(
                    children: [
                      Expanded(child: moviesGridList()),
                      homeController.mockLoading.isTrue
                          ? const Padding(
                              padding: EdgeInsets.symmetric(vertical: 10),
                              child: Center(child: CircularProgressIndicator()),
                            )
                          : Container()
                    ],
                  )
                : homeController.isSearch.isTrue
                    ? homeController.searchMovieModel.value.results!.isNotEmpty
                        ? moviesGridSearchList()
                        : const Center(
                            child: Text("Not Found!"),
                          )
                    : const Center(
                        child: Text("Search the Tv Show"),
                      )
            : const Center(
                child: CircularProgressIndicator(),
              ),
      ),
    );
  }

  GridView moviesGridList() {
    return GridView.builder(
        itemCount: homeController.moviesModelList.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        controller: homeController.scrollController,
        physics: const ScrollPhysics(),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 845 ? 3 : 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 5),
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              homeController.movieDetails.value =
                  homeController.moviesModelList[index];
              Get.toNamed("/details");
            },
            child: Card(
              color: Colors.white,
              child: Stack(
                children: [
                  Column(
                    children: [
                      Expanded(
                          flex: 3,
                          child: Container(
                            color: Colors.cyan.shade200,
                            child: Center(
                              child: Text(
                                homeController.moviesModelList[index].name!,
                                textAlign: TextAlign.center,
                              ),
                            ),
                          )),
                    ],
                  ),
                  homeController.mockLoading.isFalse
                      ? Align(
                          alignment: Alignment.topRight,
                          child: Padding(
                            padding: const EdgeInsets.only(top: 5, right: 5),
                            child: GestureDetector(
                              onTap: () async {
                                homeController.favouriteList[index] =
                                    !homeController.favouriteList[index];
                                if (!kIsWeb) {
                                  if (homeController.favouriteList[index] ==
                                      true) {
                                    await LocalDatabaseService
                                        .localDatabaseServices
                                        .insertMovie(FavouriteModel(
                                            name: homeController
                                                .moviesModelList[index].name!,
                                            rating: homeController
                                                .moviesModelList[index]
                                                .voteAverage!
                                                .toString(),
                                            language: homeController
                                                .moviesModelList[index]
                                                .originalLanguage!,
                                            movieId: homeController
                                                .moviesModelList[index].id
                                                .toString(),
                                            description: homeController
                                                .moviesModelList[index]
                                                .overview,
                                            date: homeController
                                                .moviesModelList[index]
                                                .firstAirDate));
                                    homeController.getFavourite();
                                  } else {
                                    await LocalDatabaseService
                                        .localDatabaseServices
                                        .deleteMovie(homeController
                                            .moviesModelList[index].name!);
                                    homeController.getFavourite();
                                  }
                                } else {
                                  if (homeController.favouriteList[index] ==
                                      true) {
                                    FirestoreServices.firestoreServices
                                        .addToFavourite(FavouriteModel(
                                            name: homeController
                                                .moviesModelList[index].name!,
                                            rating: homeController
                                                .moviesModelList[index]
                                                .voteAverage!
                                                .toString(),
                                            language: homeController
                                                .moviesModelList[index]
                                                .originalLanguage!,
                                            movieId: homeController
                                                .moviesModelList[index].id
                                                .toString(),
                                            description: homeController
                                                .moviesModelList[index]
                                                .overview,
                                            date: homeController
                                                .moviesModelList[index]
                                                .firstAirDate));
                                    homeController.getFavourite();
                                  } else {
                                    FirestoreServices.firestoreServices
                                        .deleteFromFavourite(homeController
                                            .moviesModelList[index].id
                                            .toString());
                                    homeController.getFavourite();
                                  }
                                }
                              },
                              child: Obx(
                                () => CircleAvatar(
                                  radius: 15,
                                  backgroundColor:
                                      Colors.white.withOpacity(0.35),
                                  child: Icon(
                                    Icons.favorite,
                                    color: homeController.favouriteList[index]
                                        ? Colors.red
                                        : Colors.white.withOpacity(0.35),
                                    size: 25,
                                  ),
                                ),
                              ),
                            ),
                          ),
                        )
                      : Container()
                ],
              ),
            ),
          );
        });
  }

  GridView moviesGridSearchList() {
    return GridView.builder(
        itemCount: homeController.searchMovieModel.value.results!.length,
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
            crossAxisCount: MediaQuery.of(context).size.width < 845 ? 3 : 5,
            crossAxisSpacing: 10,
            mainAxisSpacing: 10,
            childAspectRatio: 3 / 5),
        itemBuilder: (context, int index) {
          return GestureDetector(
            onTap: () {
              homeController.movieDetails.value =
                  homeController.searchMovieModel.value.results![index];
              Get.toNamed("/details");
            },
            child: Card(
              color: Colors.white,
              child: Column(
                children: [
                  Expanded(
                      flex: 3,
                      child: Container(
                        color: Colors.cyan.shade200,
                        child: Center(
                          child: Text(
                            homeController
                                .searchMovieModel.value.results![index].name!,
                            textAlign: TextAlign.center,
                          ),
                        ),
                      )),
                ],
              ),
            ),
          );
        });
  }

  AppBar buildAppBar() {
    return isSearchField == false
        ? AppBar(
            title: const Text("Tv Shows Test"),
            actions: [
              IconButton(
                  onPressed: () {
                    Get.toNamed("/favourite");
                  },
                  icon: const Icon(Icons.favorite)),
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearchField = true;
                    });
                  },
                  icon: const Icon(Icons.search))
            ],
          )
        : AppBar(
            title: TextField(
              controller: textEditingController,
              onChanged: (value) {
                if (value.isNotEmpty) {
                  homeController.searchMovie(value);
                } else {
                  homeController.isSearch(false);
                }
              },
              cursorColor: Colors.black,
              decoration: const InputDecoration(
                  border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Colors.white)),
                  hintText: "Search Movie",
                  hintStyle: TextStyle(color: Colors.white)),
            ),
            actions: [
              IconButton(
                  onPressed: () {
                    setState(() {
                      isSearchField = false;
                      textEditingController.clear();
                      homeController.isSearch(false);
                    });
                  },
                  icon: const Icon(Icons.close))
            ],
          );
  }
}
