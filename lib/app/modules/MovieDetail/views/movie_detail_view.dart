// movie_detail_view.dart
import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/movie_detail_controller.dart';

class MovieDetailView extends StatelessWidget {
  final int movieId;
  final controller = Get.put(MovieDetailController());

  MovieDetailView({super.key, required this.movieId}) {
    controller.fetchMovieDetails(movieId);
  }

  String formatCurrency(int value) {
    final formatter = NumberFormat("#,###");
    return "\$${formatter.format(value)}";
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Movie Detail")),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final d = controller.movieDetails;
        return SingleChildScrollView(
          // padding: const EdgeInsets.symmetric(vertical: 16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (d["poster_path"] != null)
                Container(
                  width: double.infinity,
                  decoration: BoxDecoration(
                    image: DecorationImage(
                      image: NetworkImage(
                          "https://image.tmdb.org/t/p/original${d["poster_path"]}"),
                      fit: BoxFit.cover,
                      opacity: 0.4,
                    ),
                  ),
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      Center(
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${d["poster_path"]}",
                          height: 300,
                        ),
                      ),
                      Center(
                        child: Text(d["title"] ?? "",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      _titleText(d["tagline"]),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          _titleText("${d["runtime"]} minutes"),
                          // _titleText("\$${d["budget"]}"),
                          _titleText(formatCurrency(d["budget"])),
                          _titleText("${d["status"]}"),

                          // _titleText(d["adult"].toString() == "true"
                          //     ? "Adult"
                          //     : "Not Adult"),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  _rowText("Vote", d["vote_average"].toString()),
                  _rowText("Language", d["original_language"]),
                  _rowText("Date", d["release_date"]),
                  _rowText("Revenue", formatCurrency(d["revenue"])),

                  // _rowText("Revenue", "\$${d["revenue"]}"),
                ],
              ),
              const SizedBox(height: 8),
              _infoText("Overview", d["overview"]),
              _listSection("Genres", d["genres"], (e) => e["name"]),
              _listSection("Spoken Languages", d["spoken_languages"],
                  (e) => e["english_name"]),
              _listSection("Production Countries", d["production_countries"],
                  (e) => e["name"]),
              _listSection("Production Companies", d["production_companies"],
                  (e) => "${e["name"]} (${e["origin_country"]})"),
              _listSection("Origin Countries", d["origin_country"]),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [],
              ),
              // _infoText("Popularity", d["popularity"].toString()),
              // _infoText("Vote Count", d["vote_count"].toString()),
              // _infoText("IMDB ID", d["imdb_id"]),

              const SizedBox(height: 24),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    ElevatedButton.icon(
                      icon: const Icon(
                        BoxIcons.bxl_imdb,
                        size: 25,
                      ),
                      label: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: Text(d["imdb_id"] ?? "No IMDB ID"),
                      ),
                      onPressed: d["imdb_id"] != null
                          ? () {
                              Get.snackbar("IMDB ID", d["imdb_id"]);
                            }
                          : null,
                    ),
                    ElevatedButton.icon(
                      icon: const Icon(Icons.link),
                      label: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: const Text("Movie Link"),
                      ),
                      onPressed: d["homepage"] != null &&
                              d["homepage"].toString().isNotEmpty
                          ? () async {
                              final url = Uri.parse(d["homepage"]);
                              if (await canLaunchUrl(url)) {
                                await launchUrl(url,
                                    mode: LaunchMode.externalApplication);
                              } else {
                                Get.snackbar(
                                    "Error", "Could not open Movie URL");
                              }
                            }
                          : null,
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),

              const SizedBox(height: 12),
            ],
          ),
        );
      }),
    );
  }

  Widget _infoText(String title, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Text("$title: $value", style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _titleText(String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Text("$value", style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _rowText(String title, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Column(
        children: [
          Text("$title",
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Text("$value", style: const TextStyle(fontSize: 12)),
        ],
      ),
    );
  }

  Widget _listSection(String title, dynamic items,
      [String Function(dynamic)? getText]) {
    if (items == null || (items is List && items.isEmpty))
      return const SizedBox.shrink();

    final values = (items as List)
        .map((e) => getText != null ? getText(e) : e.toString())
        .toList();

    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "$title:",
            style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 16),
          ),
          const SizedBox(height: 8),
          Wrap(
            spacing: 8,
            runSpacing: 8,
            children: values
                .map(
                  (v) => Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 8, horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.transparent,
                      border: Border.all(color: Color(0xFF6DE1D2)),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: Text(
                      v,
                      style: const TextStyle(fontSize: 15),
                    ),
                  ),
                )
                .toList(),
          ),
        ],
      ),
    );
  }
}
