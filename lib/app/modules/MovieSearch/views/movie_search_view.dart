import 'package:flutter/material.dart';

import 'package:get/get.dart';
import 'package:trex/app/modules/MovieDetail/views/movie_detail_view.dart';

import '../controllers/movie_search_controller.dart';

class MovieSearchView extends GetView<MovieSearchController> {
  final MovieSearchController controller = Get.put(MovieSearchController());
  final TextEditingController searchTextController = TextEditingController();

  @override
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Search")),
      body: Padding(
        padding: const EdgeInsets.all(12.0),
        child: Column(
          children: [
            Padding(
              padding:
                  const EdgeInsets.symmetric(vertical: 8.0, horizontal: 12),
              child: TextField(
                onChanged: (val) => controller.query.value = val.trim(),
                decoration: InputDecoration(
                  labelText: "Search movies or TV shows",
                  suffixIcon: Icon(Icons.search),
                ),
              ),
            ),
            SizedBox(height: 12),
            Expanded(
              child: Obx(() {
                if (controller.isLoading.value && controller.results.isEmpty) {
                  return Center(child: CircularProgressIndicator());
                }

                if (controller.results.isEmpty) {
                  return Center(child: Text("No results"));
                }

                return ListView.builder(
                  controller: controller.scrollController,
                  itemCount: controller.results.length + 1,
                  itemBuilder: (_, index) {
                    if (index == controller.results.length) {
                      return controller.hasMore.value
                          ? Center(
                              child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: CircularProgressIndicator()))
                          : SizedBox.shrink();
                    }

                    final item = controller.results[index];
                    final title = item['title'] ?? item['name'] ?? 'No Title';
                    final overview = item['overview'] ?? '';
                    final popularity = item['vote_average'] != null
                        ? '${item['vote_average']}'
                        : 'None';
                    final posterPath = item['poster_path'];
                    final imageUrl = posterPath != null
                        ? 'https://image.tmdb.org/t/p/w500$posterPath'
                        : null;

                    return ListTile(
                      onTap: () =>
                          Get.to(() => MovieDetailView(movieId: item['id'])),
                      leading: imageUrl != null
                          ? Image.network(imageUrl,
                              width: 50, fit: BoxFit.cover)
                          : Icon(Icons.movie),
                      title: Text(title),
                      subtitle: Text(
                        overview,
                        maxLines: 2,
                        overflow: TextOverflow.ellipsis,
                      ),
                      trailing: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          Icon(Icons.star, color: Colors.amber),
                          Text(popularity),
                        ],
                      ),
                    );
                  },
                );
              }),
            ),
          ],
        ),
      ),
    );
  }
}
