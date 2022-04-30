import 'package:movies_test/utils/controller_paths.dart';
import 'package:movies_test/utils/model_paths.dart';

import '../../utils/dependencies_path.dart';

class FavouritePage extends StatelessWidget {
  FavouritePage({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Favourite Tv Shows"),
      ),
      body: Obx(() => homeController.favouriteTvShowList.isNotEmpty
          ? GridView.builder(
              shrinkWrap: true,
              itemCount: homeController.favouriteTvShowList.length,
              padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
              gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount:
                      MediaQuery.of(context).size.width < 845 ? 3 : 5,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                  childAspectRatio: 3 / 5),
              itemBuilder: (context, int index) {
                return GestureDetector(
                  onTap: () {
                    homeController.movieDetails.value = Results(
                        name: homeController.favouriteTvShowList[index].name!,
                        overview: homeController
                            .favouriteTvShowList[index].description!,
                        voteAverage:
                            homeController.favouriteTvShowList[index].rating,
                        firstAirDate:
                            homeController.favouriteTvShowList[index].date,
                        id: int.parse(
                            homeController.favouriteTvShowList[index].movieId!),
                        originalLanguage:
                            homeController.favouriteTvShowList[index].language);
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
                                      homeController
                                          .favouriteTvShowList[index].name!,
                                      textAlign: TextAlign.center,
                                    ),
                                  ),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                );
              })
          : const Center(
              child: Text("No Favourites Selected!"),
            )),
    );
  }
}
