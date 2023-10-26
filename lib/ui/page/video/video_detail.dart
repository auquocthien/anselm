import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class VideoDetail extends StatefulWidget {
  static String routeName = '/video_detail';
  final String url;
  final String label;
  const VideoDetail(this.label, this.url, {super.key});
  @override
  State<VideoDetail> createState() => _VideoDetailState();
}

class _VideoDetailState extends State<VideoDetail> {
  late VideoPlayerController _controller;
  late ChewieController _videoController;

  @override
  void initState() {
    _videoController = ChewieController(
        videoPlayerController:
            VideoPlayerController.networkUrl(Uri.parse(widget.url)),
        aspectRatio: 16 / 9,
        autoInitialize: true,
        looping: true,
        errorBuilder: (context, errorMessage) {
          return const Center(child: CircularProgressIndicator());
        });
    super.initState();
  }

  @override
  void dispose() {
    // _controller.dispose();
    _videoController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(widget.label),
      ),
      body: Column(
        children: [
          Container(
              padding: const EdgeInsets.all(8),
              height: 240,
              child: Chewie(controller: _videoController)),
          const Padding(
            padding: EdgeInsets.all(8.0),
            child: Divider(
              height: 10,
              thickness: 5,
            ),
          )
        ],
      ),
    );
  }
}
