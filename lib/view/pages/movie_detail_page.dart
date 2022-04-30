import 'package:movies_test/utils/controller_paths.dart';
import 'package:movies_test/utils/dependencies_path.dart';

class MovieDetailsPage extends StatelessWidget {
  MovieDetailsPage({Key? key}) : super(key: key);
  final homeController = Get.find<HomeController>();
  final space = const SizedBox(
    height: 20,
  );

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(homeController.movieDetails.value.name!),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Expanded(
              flex: MediaQuery.of(context).size.width < 845 ? 2 : 4,
              child: Row(
                children: [
                  Expanded(
                    child: Card(
                      color: Colors.cyan.shade200,
                      child: Center(
                        child: Text(homeController.movieDetails.value.name!),
                      ),
                    ),
                  ),
                  MediaQuery.of(context).size.width > 845
                      ? Expanded(
                          flex: 2,
                          child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              Text(
                                homeController.movieDetails.value.name!,
                                style: const TextStyle(
                                    fontWeight: FontWeight.bold),
                              ),
                              space,
                              Text(
                                "Release Date: ${homeController.movieDetails.value.firstAirDate!}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                              space,
                              Text(
                                "IMDB : ${homeController.movieDetails.value.voteAverage!}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                                textAlign: TextAlign.start,
                              ),
                              space,
                              Text(
                                "Language : ${homeController.movieDetails.value.originalLanguage!}",
                                style: const TextStyle(
                                    fontWeight: FontWeight.w600),
                              ),
                            ],
                          ))
                      : Expanded(
                          child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Text(
                              homeController.movieDetails.value.name!,
                              style:
                                  const TextStyle(fontWeight: FontWeight.bold),
                            ),
                            space,
                            Text(
                              "Release Date: ${homeController.movieDetails.value.firstAirDate!}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                            space,
                            Text(
                              "IMDB : ${homeController.movieDetails.value.voteAverage!}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                              textAlign: TextAlign.start,
                            ),
                            space,
                            Text(
                              "Language : ${homeController.movieDetails.value.originalLanguage!}",
                              style:
                                  const TextStyle(fontWeight: FontWeight.w600),
                            ),
                          ],
                        ))
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Expanded(
              flex: 2,
              child: Text(
                "Description: ${homeController.movieDetails.value.overview!}",
                style: const TextStyle(
                    fontWeight: FontWeight.w400, wordSpacing: 2, fontSize: 16),
                textAlign: TextAlign.justify,
              ),
            )
          ],
        ),
      ),
    );
  }
}
