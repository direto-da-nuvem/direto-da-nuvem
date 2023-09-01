import 'package:get/get.dart';
import 'package:sample/ui/views/dashboard_page.dart';

part './app_routes.dart';

abstract class Pages{

  static final pages = [
    GetPage(name: Routes.DASHBOARD, page:() => const DashboardPage()),
  ];
}
