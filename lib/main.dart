import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/foundation.dart';

import 'utils/dependencies_path.dart';
import 'utils/routes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  if (kIsWeb) {
    await Firebase.initializeApp(
      // Replace with actual values
      options: const FirebaseOptions(
        apiKey: "AIzaSyCuRVMHg0mo5YWLd4q1Jb3JIEkH2tYzW34",
        appId: "1:122323223165:web:27e5a4dd9ab0ff65cde714",
        messagingSenderId: "122323223165",
        projectId: "movie-ce90a",
      ),
    );
  }
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
        minTextAdapt: true,
        splitScreenMode: true,
        designSize: const Size(845, 655),
        builder: (context) => GetMaterialApp(
              initialRoute: "/",
              routes: appRoutes,
              debugShowCheckedModeBanner: false,
              theme: ThemeData().copyWith(
                  appBarTheme: const AppBarTheme(backgroundColor: Colors.cyan)),
            ));
  }
}
