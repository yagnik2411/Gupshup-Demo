import 'dart:async';
import 'dart:convert';
import 'package:api_test/Services/videoplayer/normal.videoplayer.dart';
import 'package:api_test/Services/videoplayer/youtube.videoplayer.dart';
import 'package:api_test/model/dashboard_model.dart';
import 'package:flutter/material.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'dart:math';

import 'package:video_player/video_player.dart';

class HomePost extends StatelessWidget {
  final int index;
  List<int?> autoPlayDurations = [];
  int currentItem = 0;

  HomePost({Key? key, required this.index}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<String> image = determineImage();

    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(10),
          color: Colors.grey.withOpacity(0.3),
        ),
        margin: const EdgeInsetsDirectional.only(bottom: 20, start: 5, end: 5),
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            buildUserDetails(),
            Text(
              dashboardList[index].text,
              textAlign: TextAlign.start,
              style: const TextStyle(
                fontWeight: FontWeight.normal,
                fontSize: 15,
              ),
            ),
            buildMediaContent(image),
            buildActionButtons(),
          ],
        ),
      ),
    );
  }

  List<String> determineImage() {
    String imageUrl = dashboardList[index].imageUrl;
    List<String> downloadUrls = [];

    if (imageUrl.isEmpty) {
      return downloadUrls;
    }

    try {
      var data = json.decode(imageUrl);

      for (var item in data) {
        if (item["downloadurl"] != null) {
          downloadUrls.add(item["downloadurl"]);
        }
      }

      return downloadUrls;
    } catch (e) {
      if (RegExp(r'^(https?:\/\/)?(www\.)?youtube\.com').hasMatch(imageUrl)) {
        // Handle YouTube URL case, return imageUrl in a list
        return [imageUrl];
      } else {
        // Handle other cases where imageUrl is not in JSON format
        return downloadUrls;
      }
    }
  }

  Widget buildUserDetails() {
    return Row(
      children: [
        CircleAvatar(
          backgroundImage: NetworkImage(dashboardList[index].profileUrl),
        ),
        const SizedBox(width: 5),
        Text(
          dashboardList[index].fromUser,
          style: const TextStyle(fontWeight: FontWeight.normal, fontSize: 20),
        ),
      ],
    );
  }

  Widget buildMediaContent(List<String> imageUrls) {
    if (imageUrls.isEmpty) {
      return const Center(child: Text("No Media"));
    } else if (imageUrls.length == 1) {
      // Return the single widget directly
      final imageUrl = imageUrls[0];
      if (linkCheck(imageUrl) == "Image") {
        return Image.network(imageUrl, fit: BoxFit.cover);
      } else if (linkCheck(imageUrl) == "Youtube") {
        return YTPlayer().videoPlayer(imageUrl);
      } else if (linkCheck(imageUrl) == "Video") {
        return YouTubeLikeVideoPlayer(videoUrl: imageUrl);
      }
    } else {
      // Return a carousel with multiple widgets
      return FutureBuilder<void>(
        future: fetchVideoDurations(imageUrls),
        builder: (BuildContext context, AsyncSnapshot<void> snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(
                child: Container(
                    height: 20,
                    width: 20,
                    child:
                        CircularProgressIndicator())); // Show a loading indicator while fetching durations
          } else if (snapshot.hasError) {
            return Text('Error: ${snapshot.error}');
          } else {
            CarouselController _controller = CarouselController();
            return CarouselSlider.builder(
              itemCount: imageUrls.length,
              carouselController: _controller,
              itemBuilder: (BuildContext context, int index, int realIndex) {
                // Create the media widgets here based on mediaUrls
                final mediaUrl = imageUrls[index];
                final linkType = linkCheck(mediaUrl);

                if (linkType == "Image") {
                  return Image.network(mediaUrl, fit: BoxFit.contain);
                } else if (linkType == "Video") {
                  final player = YouTubeLikeVideoPlayer(videoUrl: mediaUrl);
                  return player;
                } else if (linkType == "Youtube") {
                  final player = YTPlayer();
                  return player.videoPlayer(mediaUrl);
                }

                return Container(); // Return an empty container if unsupported media
              },
              options: CarouselOptions(
                  autoPlay: true,
                  autoPlayInterval: Duration(
                    seconds: autoPlayDurations[currentItem] as int,
                  ),
                  enlargeCenterPage: true,
                  enableInfiniteScroll: false,
                  onPageChanged: (index, _) {
                    _controller
                        .stopAutoPlay(); // Stop auto-play when page changes
                    Timer(Duration(seconds: autoPlayDurations[index] as int),
                        () {
                      currentItem = index ; // Increment currentItem
                      _controller.animateToPage(index ); // Go to next page
                      _controller
                          .startAutoPlay(); // Restart auto-play after delay
                    });
                  }),
            );
          }
        },
      );
    }

    return const Center(child: Text("No Media"));
  }

  Future<void> fetchVideoDurations(List<String> mediaUrls) async {
    for (int i = 0; i < mediaUrls.length; i++) {
      final mediaUrl = mediaUrls[i];
      final linkType = linkCheck(mediaUrl);

      if (linkType == "Image") {
        autoPlayDurations.add(1);
        // Handle image duration if needed
      } else if (linkType == "Video") {
        final player = YouTubeLikeVideoPlayer(videoUrl: mediaUrl);
        final VideoPlayerController controller =
            VideoPlayerController.network(mediaUrl);
        final duration = await player.getVideoDurationInSeconds(controller);

        autoPlayDurations.add(duration - 1);
        // Handle video duration if needed
      } else if (linkType == "Youtube") {
        final player = YTPlayer();
        final duration = await player.getVideoDuration(mediaUrl);
        autoPlayDurations.add(duration);
        // Handle YouTube video duration if needed
      }
    }
  }

  Widget buildActionButtons() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Row(
          children: [
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.favorite_outline_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.comment_outlined),
            ),
            IconButton(
              onPressed: () {},
              icon: const Icon(Icons.share),
            ),
          ],
        ),
        IconButton(
          onPressed: () {},
          icon: const Icon(Icons.save_as_outlined),
        ),
      ],
    );
  }

  String linkCheck(String link) {
    if (RegExp(r'^(https?:\/\/)?(www\.)?youtube\.com').hasMatch(link)) {
      return "Youtube";
    } else if (RegExp(r'\.mp4$').hasMatch(link)) {
      return "Video";
    } else if (RegExp(r'\.(jpeg|jpg|png)$').hasMatch(link) ||
        RegExp(r'^https:\/\/images\.unsplash\.com\/.*$').hasMatch(link)) {
      return "Image";
    } else {
      return "Text";
    }
  }
}
