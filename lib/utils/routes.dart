import 'package:movies_test/utils/dependencies_path.dart';
import 'package:movies_test/utils/view_path.dart';

final Map<String, WidgetBuilder> appRoutes = {
  "/": (_) => HomePage(),
  "/favourite": (_) => FavouritePage(),
  "/details": (_) => MovieDetailsPage(),
};
