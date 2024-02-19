import 'package:get/get.dart';
import 'package:sample/ui/views/dashboard_page.dart';
import 'package:sample/ui/views/device_page.dart';
import 'package:sample/ui/views/login_page.dart';
import 'package:sample/ui/views/showcase_page.dart';
import 'package:sample/ui/views/edit_page.dart';
import 'package:sample/ui/views/admin_page.dart';
import 'package:sample/ui/views/device_page.dart';
import 'package:sample/ui/views/start_page.dart';
import 'package:sample/ui/views/notifications.dart';
import 'package:sample/ui/views/about.dart';

import '../ui/views/queue_page.dart';

part './app_routes.dart';

abstract class Pages{

  static final pages = [
    GetPage(name: Routes.DASHBOARD, page:() => const DashboardPage()),
    GetPage(name: Routes.DEVICES, page:() => const DeviceInfoPage()),
    GetPage(name: Routes.LOGIN, page:() => const LoginPage()),
    GetPage(name: Routes.SHOWCASE, page:() => const ShowcasePage()),
    GetPage(name: Routes.EDIT, page:() => const EditPage()),
    GetPage(name: Routes.ADMIN, page:() => const AdminPage()),
    GetPage(name: Routes.QUEUE, page:() => const QueueListPage()),
    GetPage(name: Routes.START, page:() => const StartPage()),
    GetPage(name: Routes.NOTIFICATIONS, page:() => NotificationPage()),
    GetPage(name: Routes.ABOUT, page:() => AboutPage()),

    //QueueListPage
  ];
}
