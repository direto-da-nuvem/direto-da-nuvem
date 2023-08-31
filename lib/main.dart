import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:sample/routes/app_pages.dart';

Future<void> main() async {
  // WidgetsFlutterBinding.ensureInitialized();
  // await Firebase.initializeApp(
  //   options: DefaultFirebaseOptions.currentPlatform,
  // );


  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      title: 'Sample',
      debugShowCheckedModeBanner: true,
      theme: ThemeData(
          useMaterial3: true,
          colorScheme: ColorScheme
              .fromSwatch(primarySwatch: Colors.blue)
              .copyWith(background: Colors.black)
      ),
      getPages: Pages.pages,
      initialRoute: Routes.HOME,
    );
  }
}
