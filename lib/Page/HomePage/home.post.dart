
import 'package:api_test/Services/videoplayer/normal.videoplayer.dart';
import 'package:api_test/Services/videoplayer/youtube.videoplayer.dart';
import 'package:api_test/model/dashboard_model.dart';
import 'package:flutter/material.dart';
class HomePost extends StatelessWidget {
  const HomePost({
    super.key,
    required this.image,
    required this.index,
  });
  final int index;
  final String image;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        padding: const EdgeInsets.all(10),
        decoration: BoxDecoration(
            // border: Border.all(color: Colors.black),
            borderRadius: BorderRadius.circular(10),
            color: Colors.grey.withOpacity(0.3)),
        margin: const EdgeInsetsDirectional.only(bottom: 20, start: 5, end: 5),
        width: 350,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(
              children: [
                CircleAvatar(
                  backgroundImage:
                      NetworkImage(dashboardList[index].profileUrl),
                ),
                const SizedBox(
                  width: 5,
                ),
                Text(dashboardList[index].fromUser,
                    style: const TextStyle(
                        fontWeight: FontWeight.normal, fontSize: 20)),
              ],
            ),
            Text(dashboardList[index].text,
                textAlign: TextAlign.start,
                style: const TextStyle(
                    fontWeight: FontWeight.normal, fontSize: 15)),
            Center(
              child: image.isNotEmpty
                  ? (linkCheck(image) == "Image"
                      ? Image.network(
                          image,
                          fit: BoxFit.cover,
                        )
                      : linkCheck(image) == "Youtube"
                          ? YTPlayer().videoPlayer(image)

                          : linkCheck(image) == "Video"
                              ? NormalVideoPlayer(videoUrl: image,)
                              : null)
                  : const Center(child: Text("No Image")),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Row(
                  children: [
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.favorite_outline_outlined)),
                    IconButton(
                        onPressed: () {},
                        icon: const Icon(Icons.comment_outlined)),
                    IconButton(onPressed: () {}, icon: const Icon(Icons.share)),
                  ],
                ),
                IconButton(
                    onPressed: () {}, icon: const Icon(Icons.save_as_outlined))
              ],
            )
          ],
        ),
      ),
    );
  }

  String linkCheck(String link) {
    if (RegExp(r'^(https?:\/\/)?(www\.)?youtube\.com').hasMatch(link)) {
      print("Youtube");
      return "Youtube";
    } else if (RegExp(r'\.mp4$').hasMatch(link)) {
      print("Video");
      return "Video";
    } else if (RegExp(r'\.(jpeg|jpg|png)$').hasMatch(link)) {
      print("Image");
      return "Image";
    } else {
      print("Text");
      return "Text";
    }
  }
}
