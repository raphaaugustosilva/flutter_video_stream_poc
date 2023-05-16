import 'package:chewie/chewie.dart';
import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppStreamChewie extends StatefulWidget {
  const AppStreamChewie({super.key});

  @override
  State<AppStreamChewie> createState() => _AppStreamChewieState();
}

class _AppStreamChewieState extends State<AppStreamChewie> {
  final videoPlayerController = VideoPlayerController.network(
      'https://vz-594ab91e-2e5.b-cdn.net/6e5c52d7-8711-4cf8-a759-330d487f85e7/playlist.m3u8');
  late ChewieController chewieController;

  @override
  void initState() {
    chewieController = ChewieController(
      videoPlayerController: videoPlayerController,
      aspectRatio: 3 / 2,
      autoPlay: false,
      looping: false,
      allowFullScreen: false,
    );

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("STREAM CHEWIE"),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            AspectRatio(
              aspectRatio: 3 / 2,
              child: Chewie(controller: chewieController),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  chewieController.isPlaying
                      ? chewieController.pause()
                      : chewieController.play();
                });
              },
              child: Icon(
                chewieController.isPlaying ? Icons.pause : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
