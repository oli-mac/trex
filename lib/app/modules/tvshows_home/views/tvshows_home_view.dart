import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trex/app/modules/MovieDetail/views/movie_detail_view.dart';
import 'package:trex/app/modules/MovieSearch/views/movie_search_view.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';

import '../controllers/tvshows_home_controller.dart';

class TvshowsHomeView extends GetView<TvshowsHomeController> {
  const TvshowsHomeView({super.key});
  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Show Spot"),
          actions: [
            IconButton(
                onPressed: () {
                  Get.to(() => MovieSearchView());
                },
                icon: const Icon(Icons.search_rounded)),
          ],
        ),
        body: Obx(() {
          if (controller.isLoading.value) {
            return const Center(child: CircularProgressIndicator());
          }

          return SingleChildScrollView(
            padding: const EdgeInsets.all(8),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Airing Today',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                controller.airingTodaySerious.isEmpty
                    ? const SizedBox(
                        height: 200,
                        child: Center(child: Text("No upcoming movies found.")))
                    : CarouselSlider.builder(
                        itemCount: controller.airingTodaySerious.length,
                        itemBuilder: (context, index, realIdx) {
                          final serious = controller.airingTodaySerious[index];
                          return InkWell(
                            onTap: () => Get.to(
                                () => MovieDetailView(movieId: serious.id)),
                            child: Container(
                              width: double.infinity,
                              decoration: BoxDecoration(
                                  borderRadius: BorderRadius.circular(8)),
                              child: Image.network(
                                "https://image.tmdb.org/t/p/original/${serious.backDropPath ?? serious.posterPath}",
                                fit: BoxFit.cover,
                              ),
                            ),
                          );
                        },
                        options: CarouselOptions(
                          autoPlay: true,
                          enlargeCenterPage: true,
                          aspectRatio: 1.4,
                          autoPlayInterval: const Duration(seconds: 3),
                        ),
                      ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Popular',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 200,
                  child: controller.popularSerious.isEmpty
                      ? const Center(
                          child: Text("Now Playing movies unavailable"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.popularSerious.length,
                          itemBuilder: (context, index) {
                            final serious = controller.popularSerious[index];
                            return InkWell(
                              onTap: () => Get.to(
                                  () => MovieDetailView(movieId: serious.id)),
                              child: Container(
                                width: 150,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original/${serious.posterPath}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('On The Air',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 200,
                  child: controller.onTheAirSerious.isEmpty
                      ? const Center(child: Text("No On The Air available"))
                      : ListView.builder(
                          scrollDirection: Axis.horizontal,
                          itemCount: controller.onTheAirSerious.length,
                          itemBuilder: (context, index) {
                            final serious = controller.onTheAirSerious[index];
                            return InkWell(
                              onTap: () => Get.to(
                                  () => MovieDetailView(movieId: serious.id)),
                              child: Container(
                                width: 150,
                                margin:
                                    const EdgeInsets.symmetric(horizontal: 10),
                                decoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: Image.network(
                                    "https://image.tmdb.org/t/p/original/${serious.posterPath}",
                                    height: 120,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                ),
                const SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: const Text('Top Rated',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                SizedBox(
                  height: 200,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.topRatedSerious.length,
                    itemBuilder: (context, index) {
                      final serious = controller.topRatedSerious[index];
                      return InkWell(
                        onTap: () =>
                            Get.to(() => MovieDetailView(movieId: serious.id)),
                        child: Container(
                          width: 150,
                          margin: const EdgeInsets.symmetric(horizontal: 10),
                          decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(15)),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(15),
                            child: Image.network(
                              "https://image.tmdb.org/t/p/original/${serious.posterPath}",
                              height: 120,
                              width: double.infinity,
                              fit: BoxFit.cover,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ],
            ),
          );
        }),
      ),
    );
  }
}
