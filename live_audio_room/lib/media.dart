// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

/// only share audio in room, not video
Widget simpleMediaPlayer({
  required bool canControl,
}) {
  final mediaController = ZegoUIKitPrebuiltLiveAudioRoomController().media;

  final playButton = ValueListenableBuilder<ZegoUIKitMediaPlayState>(
    valueListenable: mediaController.playStateNotifier,
    builder: (context, playState, _) {
      return ElevatedButton(
        onPressed: () {
          switch (playState) {
            case ZegoUIKitMediaPlayState.playing:
              mediaController.pause();
              break;
            case ZegoUIKitMediaPlayState.pausing:
              mediaController.resume();
              break;
            default:
              mediaController.pickFile().then((files) {
                if (files.isEmpty) {
                  debugPrint('files is empty');
                } else {
                  final mediaFile = files.first;
                  final targetPathOrURL = mediaFile.path ?? '';
                  mediaController.play(
                    filePathOrURL: targetPathOrURL,
                  );
                }
              });

              // ZegoUIKitPrebuiltLiveAudioRoomController().media.play(filePathOrURL:'https://xxx.com/xxx.mp3');
              break;
          }
        },
        child: Icon(
          ZegoUIKitMediaPlayState.playing == playState
              ? Icons.pause_circle
              : Icons.play_circle,
          color: Colors.white,
        ),
      );
    },
  );
  final stopButton = ElevatedButton(
    onPressed: () {
      mediaController.stop();
    },
    child: const Icon(
      Icons.stop_circle,
      color: Colors.red,
    ),
  );
  final volumeButton = ValueListenableBuilder<bool>(
    valueListenable: mediaController.muteNotifier,
    builder: (context, isMute, _) {
      return ElevatedButton(
        onPressed: () {
          mediaController.muteLocal(!isMute);
        },
        child: Icon(
          isMute ? Icons.volume_off : Icons.volume_up,
          color: Colors.white,
        ),
      );
    },
  );

  return canControl
      ? Stack(
          children: [
            Positioned(
              bottom: 60,
              right: 10,
              child: Row(
                children: [
                  playButton,
                  stopButton,
                  volumeButton,
                ],
              ),
            ),
          ],
        )
      : Container();
}
