import 'package:get/get.dart';
import 'package:sample/ui/views/home_page.dart';

part './app_routes.dart';

abstract class Pages{

  static final pages = [
    GetPage(name: Routes.HOME, page:() => const HomePage()),
  ];
}
