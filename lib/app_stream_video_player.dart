import 'package:flutter/material.dart';
import 'package:video_player/video_player.dart';

class AppStreamVideoPlayer extends StatefulWidget {
  const AppStreamVideoPlayer({super.key});

  @override
  State<AppStreamVideoPlayer> createState() => _AppStreamVideoPlayerState();
}

class _AppStreamVideoPlayerState extends State<AppStreamVideoPlayer> {
  late VideoPlayerController _controller;

  @override
  void initState() {
    super.initState();
    _controller = VideoPlayerController.network(
      'https://video.bunnycdn.com/play/120655/6e5c52d7-8711-4cf8-a759-330d487f85e7',
    )..initialize().then((_) {
        // Ensure the first frame is shown after the video is initialized, even before the play button has been pressed.
        setState(() {});
      });
  }

  @override
  void dispose() {
    super.dispose();
    _controller.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("APP STREAM")),
      body: Column(
        children: [
          Center(
            child: _controller.value.isInitialized
                ? AspectRatio(
                    aspectRatio: _controller.value.aspectRatio,
                    child: VideoPlayer(_controller),
                  )
                : Container(),
          ),
          ElevatedButton(
            onPressed: () {
              setState(() {
                _controller.value.isPlaying
                    ? _controller.pause()
                    : _controller.play();
              });
            },
            child: Icon(
              _controller.value.isPlaying ? Icons.pause : Icons.play_arrow,
            ),
          ),
        ],
      ),
    );
  }
}
