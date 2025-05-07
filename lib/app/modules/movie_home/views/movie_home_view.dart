import 'package:get/get.dart';
import 'package:flutter/material.dart';
import 'package:trex/app/modules/navigation/views/navigation_view.dart';
import '../controllers/movie_home_controller.dart';
import 'package:carousel_slider/carousel_slider.dart';

class MovieHomeView extends GetView<MovieHomeController> {
  const MovieHomeView({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScaffold(
      child: Scaffold(
        appBar: AppBar(
          title: const Text("Show Spot"),
          centerTitle: true,
          actions: [
            IconButton(
                onPressed: () {}, icon: const Icon(Icons.search_rounded)),
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
                  child: const Text('Upcoming',
                      style:
                          TextStyle(fontSize: 20, fontWeight: FontWeight.bold)),
                ),
                CarouselSlider.builder(
                  itemCount: controller.upcomingMovies.length,
                  itemBuilder: (context, index, realIdx) {
                    final movie = controller.upcomingMovies[index];
                    return Container(
                      width: double.infinity,
                      decoration:
                          BoxDecoration(borderRadius: BorderRadius.circular(8)),
                      child: Image.network(
                        "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                        fit: BoxFit.cover,
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
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    itemCount: controller.popularMovies.length,
                    itemBuilder: (context, index) {
                      final movie = controller.popularMovies[index];
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
                    itemCount: controller.topRatedMovies.length,
                    itemBuilder: (context, index) {
                      final movie = controller.topRatedMovies[index];
                      return Container(
                        width: 150,
                        margin: const EdgeInsets.symmetric(horizontal: 10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(15)),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Image.network(
                            "https://image.tmdb.org/t/p/original/${movie.backDropPath}",
                            height: 120,
                            width: double.infinity,
                            fit: BoxFit.cover,
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
