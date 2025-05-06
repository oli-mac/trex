import 'package:get/get.dart';

import '../modules/home/views/home_view.dart';
import '../modules/theme/views/theme_view.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/theme/bindings/theme_binding.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/movie_home/views/movie_home_view.dart';
import '../modules/movie_home/bindings/movie_home_binding.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.MOVIE_HOME;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => const HomeView(),
      binding: HomeBinding(),
    ),
    GetPage(
      name: _Paths.SPLASH,
      page: () => const SplashView(),
      binding: SplashBinding(),
    ),
    // GetPage(
    //   name: _Paths.THEME,
    //   page: () => const ThemeView(),
    //   binding: ThemeBinding(),
    // ),
    GetPage(
      name: _Paths.MOVIE_HOME,
      page: () => const MovieHomeView(),
      binding: MovieHomeBinding(),
    ),
  ];
}
