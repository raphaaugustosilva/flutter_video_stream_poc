import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:better_player/better_player.dart';

class AppStreamBetterPlayer extends StatefulWidget {
  const AppStreamBetterPlayer({super.key});

  @override
  State<AppStreamBetterPlayer> createState() => _AppStreamChewiBetterPlayer();
}

class _AppStreamChewiBetterPlayer extends State<AppStreamBetterPlayer> {
  // final videoPlayerController = BetterPlayer.network(
  //     "https://commondatastorage.googleapis.com/gtv-videos-bucket/sample/ForBiggerBlazes.mp4",
  //     betterPlayerConfiguration: BetterPlayerConfiguration(
  //       aspectRatio: 3 / 2,
  //     ));

  late BetterPlayerController betterPlayerController;

  @override
  void initState() {
    BetterPlayerDataSource betterPlayerDataSource = BetterPlayerDataSource(
        BetterPlayerDataSourceType.network,
        "https://vz-594ab91e-2e5.b-cdn.net/6e5c52d7-8711-4cf8-a759-330d487f85e7/playlist.m3u8");

    betterPlayerController = BetterPlayerController(
        BetterPlayerConfiguration(
          aspectRatio: 3 / 2,
          eventListener: (event) => logData(event),
        ),
        betterPlayerDataSource: betterPlayerDataSource);

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
              child: BetterPlayer(controller: betterPlayerController),
            ),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  betterPlayerController.isPlaying() == true
                      ? betterPlayerController.pause()
                      : betterPlayerController.play();
                });
              },
              child: Icon(
                betterPlayerController.isPlaying() == true
                    ? Icons.pause
                    : Icons.play_arrow,
              ),
            ),
          ],
        ),
      ),
    );
  }

  logData(BetterPlayerEvent event) {
    String textoLog = "";
    bool printar = true;
    switch (event.betterPlayerEventType) {
      case BetterPlayerEventType.progress:
        textoLog = "PROGRESSO: ";
        break;

      case BetterPlayerEventType.changedTrack:
        textoLog = "ALTEROU TRACK: ";
        break;

      case BetterPlayerEventType.finished:
        textoLog = "VÍDEO FINALIZADO! ";
        break;

      case BetterPlayerEventType.pause:
        textoLog = "PAUSOU ";
        break;

      case BetterPlayerEventType.seekTo:
        textoLog = "AVANÇOU/DIMINUIU PARA O TEMPO: ";
        break;

      case BetterPlayerEventType.play:
        textoLog = "PLAY! ";
        break;

      default:
        printar = false;
        break;
    }

    if (printar) textoLog += "/n/n VALORES:" + event.parameters.toString();

    if (textoLog.isNotEmpty) log(textoLog);
  }
}
