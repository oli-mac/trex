import 'package:get/get.dart';
import 'package:icons_plus/icons_plus.dart';
import 'package:intl/intl.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';
import '../controllers/tvshows_detail_controller.dart';

class TvshowsDetailView extends StatelessWidget {
  final int tvShowId;
  final controller = Get.put(TvshowsDetailController());

  TvshowsDetailView({super.key, required this.tvShowId}) {
    controller.fetchTvShowDetails(tvShowId);
  }

  String formatNumber(int value) {
    final formatter = NumberFormat("#,###");
    return formatter.format(value);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("TV Show Detail"),
        actions: [
          IconButton(
            icon: const Icon(Icons.addchart ),
            onPressed: () {
              // Implement share functionality
              Get.snackbar("Share", "Add to watchlist");
            },
          ),
        ],
      ),
      body: Obx(() {
        if (controller.isLoading.value) {
          return const Center(child: CircularProgressIndicator());
        }

        final d = controller.seriousDetails;
        return SingleChildScrollView(
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
                    children: [
                      Center(
                        child: Image.network(
                          "https://image.tmdb.org/t/p/original${d["poster_path"]}",
                          height: 300,
                        ),
                      ),
                      Center(
                        child: Text(d["name"] ?? "",
                            style: const TextStyle(
                                fontSize: 24, fontWeight: FontWeight.bold)),
                      ),
                      Center(
                        child: Text(d["tagline"] ?? "",
                            style: const TextStyle(fontSize: 16)),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          // _titleText(
                          //     "${d["number_of_seasons"]} seasons", Icons.star),
                          _titleText("${d["type"]}", Icons.list_alt),
                          _titleText("${d["status"]}", Icons.check_circle),
                        ],
                      ),
                    ],
                  ),
                ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: List.generate(7, (index) {
                  if (index.isOdd) {
                    return Container(
                      width: 1,
                      height: 30,
                      color: const Color(0xFF6DE1D2),
                      margin: const EdgeInsets.symmetric(horizontal: 8),
                    );
                  } else {
                    final itemIndex = index ~/ 2;
                    final dataMap = [
                      {
                        "label": "Vote",
                        "value": d["vote_average"].toString(),
                        "icon": Icons.star
                      },
                      {
                        "label": "Language",
                        "value": d["original_language"],
                        "icon": Icons.language
                      },
                      {
                        "label": "First Air",
                        "value": d["first_air_date"],
                        "icon": Icons.calendar_today
                      },
                      {
                        "label": "Last Air",
                        "value": d["last_air_date"],
                        "icon": Icons.calendar_month
                      },
                    ];
                    return _rowText(
                      dataMap[itemIndex]["label"]!,
                      dataMap[itemIndex]["icon"] as IconData,
                      dataMap[itemIndex]["value"]!,
                    );
                  }
                }),
              ),
              const SizedBox(height: 8),
              _infoText("", d["overview"]),
              _listSection("Genres", d["genres"], (e) => e["name"]),
              _listSection("Created By", d["created_by"], (e) => e["name"]),
              _listSection("Networks", d["networks"], (e) => e["name"]),
              _listSection("Episode Runtime", d["episode_run_time"],
                  (e) => "$e minutes"),
              _listSection("Seasons", d["seasons"],
                  (e) => "${e["name"]} (${e["episode_count"]} episodes)"),
              _listSection("Production Companies", d["production_companies"],
                  (e) => "${e["name"]} (${e["origin_country"]})"),
              _listSection("Origin Countries", d["origin_country"]),
              const SizedBox(height: 24),
              Row(
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
                    label: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Show Link"),
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
                                  "Error", "Could not open TV Show URL");
                            }
                          }
                        : null,
                  ),
                ],
              ),
              const SizedBox(height: 24),
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
      child: Text("$value", style: const TextStyle(fontSize: 16)),
    );
  }

  Widget _titleText(String? value, IconData? icon) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 16),
      child: Row(
        children: [
          Icon(
            icon,
            size: 18,
            color: const Color(0xFF6DE1D2),
          ),
          const SizedBox(width: 4),
          Text(value, style: const TextStyle(fontSize: 16)),
        ],
      ),
    );
  }

  Widget _rowText(String title, IconData icon, String? value) {
    if (value == null || value.isEmpty) return const SizedBox.shrink();
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      child: Column(
        children: [
          Text(title,
              style:
                  const TextStyle(fontSize: 16, fontWeight: FontWeight.bold)),
          Row(
            children: [
              Icon(
                icon,
                size: 18,
                color: const Color(0xFF6DE1D2),
              ),
              Text(value, style: const TextStyle(fontSize: 12)),
            ],
          ),
        ],
      ),
    );
  }

  Widget _listSection(String title, dynamic items,
      [String Function(dynamic)? getText]) {
    if (items == null || (items is List && items.isEmpty)) {
      return const SizedBox.shrink();
    }

    if (title == "Seasons") {
      final totalSeasons = controller.seriousDetails["number_of_seasons"] ?? 0;
      final totalEpisodes =
          controller.seriousDetails["number_of_episodes"] ?? 0;

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
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 12),
              decoration: BoxDecoration(
                border: Border.all(color: const Color(0xFF6DE1D2)),
                borderRadius: BorderRadius.circular(8),
              ),
              child: Obx(() => DropdownButtonHideUnderline(
                    child: DropdownButton<String>(
                      isExpanded: true,
                      hint: Text(
                        "$totalSeasons Seasons And $totalEpisodes Episodes in Total",
                        style: const TextStyle(
                          fontSize: 15,
                          // color: const Color(0xFF6DE1D2),
                        ),
                      ),
                      value: controller.selectedSeason.value.isNotEmpty
                          ? controller.selectedSeason.value
                          : null,
                      items: (items as List)
                          .map<DropdownMenuItem<String>>((season) {
                        final seasonNumber = season["season_number"] ?? 0;
                        final episodeCount = season["episode_count"] ?? 0;
                        final seasonName = season["name"] ??
                            "Season ${seasonNumber == 0 ? 'Specials' : seasonNumber}";

                        return DropdownMenuItem<String>(
                          value: seasonName,
                          child: Text(
                            "$seasonName (${episodeCount} episodes)",
                            style: const TextStyle(fontSize: 15),
                          ),
                        );
                      }).toList(),
                      onChanged: (value) {
                        controller.selectedSeason.value = value ?? "";
                      },
                      style: const TextStyle(
                        // color: Colors.white,
                        fontSize: 15,
                      ),
                      dropdownColor: Colors.grey[900],
                      icon: const Icon(Icons.arrow_drop_down,
                          color: Color(0xFF6DE1D2)),
                    ),
                  )),
            ),
          ],
        ),
      );
    }

    // Original handling for other lists
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
                      border: Border.all(color: const Color(0xFF6DE1D2)),
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
