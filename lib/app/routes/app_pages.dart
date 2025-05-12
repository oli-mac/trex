import 'package:get/get.dart';

import '../modules/BookDetail/bindings/book_detail_binding.dart';
import '../modules/BookDetail/views/book_detail_view.dart';
import '../modules/List/bindings/list_binding.dart';
import '../modules/List/views/list_view.dart';
import '../modules/MovieDetail/bindings/movie_detail_binding.dart';
import '../modules/MovieDetail/views/movie_detail_view.dart';
import '../modules/MovieSearch/bindings/movie_search_binding.dart';
import '../modules/MovieSearch/views/movie_search_view.dart';
import '../modules/bookshome/bindings/bookshome_binding.dart';
import '../modules/bookshome/views/bookshome_view.dart';
import '../modules/home/bindings/home_binding.dart';
import '../modules/home/views/home_view.dart';
import '../modules/movie_home/bindings/movie_home_binding.dart';
import '../modules/movie_home/views/movie_home_view.dart';
import '../modules/navigation/bindings/navigation_binding.dart';
import '../modules/navigation/views/navigation_view.dart';
import '../modules/setting/bindings/setting_binding.dart';
import '../modules/setting/views/setting_view.dart';
import '../modules/splash/bindings/splash_binding.dart';
import '../modules/splash/views/splash_view.dart';
import '../modules/theme/bindings/theme_binding.dart';
import '../modules/theme/views/theme_view.dart';
import '../modules/tvshows_detail/bindings/tvshows_detail_binding.dart';
import '../modules/tvshows_detail/views/tvshows_detail_view.dart';
import '../modules/tvshows_home/bindings/tvshows_home_binding.dart';
import '../modules/tvshows_home/views/tvshows_home_view.dart';

part 'app_routes.dart';

class AppPages {
  AppPages._();

  static const INITIAL = Routes.SPLASH;

  static final routes = [
    GetPage(
      name: _Paths.HOME,
      page: () => HomeView(),
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
    GetPage(
      name: _Paths.BOOKSHOME,
      page: () => BookshomeView(),
      binding: BookshomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.NAVIGATION,
    //   page: () => const NavigationView(),
    //   binding: NavigationBinding(),
    // ),
    GetPage(
      name: _Paths.SETTING,
      page: () => const SettingView(),
      binding: SettingBinding(),
    ),
    // GetPage(
    //   name: _Paths.BOOK_DETAIL,
    //   page: () => BookDetailView(),
    //   binding: BookDetailBinding(),
    // ),
    // GetPage(
    //   name: _Paths.MOVIE_DETAIL,
    //   page: () => const MovieDetailView(),
    //   binding: MovieDetailBinding(),
    // ),
    GetPage(
      name: _Paths.MOVIE_SEARCH,
      page: () => MovieSearchView(),
      binding: MovieSearchBinding(),
    ),
    GetPage(
      name: _Paths.LIST,
      page: () => const ListView(),
      binding: ListBinding(),
    ),
    GetPage(
      name: _Paths.TVSHOWS_HOME,
      page: () => const TvshowsHomeView(),
      binding: TvshowsHomeBinding(),
    ),
    // GetPage(
    //   name: _Paths.TVSHOWS_DETAIL,
    //   page: () =>  TvshowsDetailView(),
    //   binding: TvshowsDetailBinding(),
    // ),
  ];
}
