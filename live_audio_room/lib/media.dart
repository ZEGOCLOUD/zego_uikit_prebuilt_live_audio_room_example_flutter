// Flutter imports:
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

// Package imports:
import 'package:zego_uikit/zego_uikit.dart';
import 'package:zego_uikit_prebuilt_live_audio_room/zego_uikit_prebuilt_live_audio_room.dart';

Widget advanceMediaPlayer({
  required BoxConstraints constraints,
  required bool canControl,
}) {
  const padding = 20;
  final playerSize =
      Size(constraints.maxWidth - padding * 2, constraints.maxWidth * 9 / 16);
  return ZegoUIKitMediaPlayer(
    size: playerSize,
    // filePathOrURL:
    //     'https://flutter.github.io/assets-for-api-docs/assets/videos/butterfly.mp4',
    enableRepeat: true,
    canControl: canControl,
    showSurface: true,
    initPosition: Offset(
      constraints.maxWidth - playerSize.width - padding,
      constraints.maxHeight - playerSize.height - padding - 40,
    ),
  );
}

Widget simpleMediaPlayer({
  required bool canControl,
}) {
  return canControl
      ? Stack(
          children: [
            Positioned(
              bottom: 60,
              right: 10,
              child: ValueListenableBuilder<ZegoUIKitMediaPlayState>(
                valueListenable: ZegoUIKitPrebuiltLiveAudioRoomController()
                    .media
                    .playStateNotifier,
                builder: (context, playState, _) {
                  return Row(
                    children: [
                      ElevatedButton(
                        onPressed: () {
                          if (ZegoUIKitMediaPlayState.playing == playState) {
                            ZegoUIKitPrebuiltLiveAudioRoomController()
                                .media
                                .pause();
                          } else if (ZegoUIKitMediaPlayState.pausing ==
                              playState) {
                            ZegoUIKitPrebuiltLiveAudioRoomController()
                                .media
                                .resume();
                          } else {
                            ZegoUIKitPrebuiltLiveAudioRoomController()
                                .media
                                .pickFile()
                                .then((files) {
                              if (files.isEmpty) {
                                debugPrint('files is empty');
                              } else {
                                final mediaFile = files.first;
                                final targetPathOrURL = mediaFile.path ?? '';
                                ZegoUIKitPrebuiltLiveAudioRoomController()
                                    .media
                                    .play(
                                      filePathOrURL: targetPathOrURL,
                                    );
                              }
                            });

                            // ZegoUIKitPrebuiltLiveAudioRoomController().media.play(filePathOrURL:'https://xxx.com/xxx.mp3');
                          }
                        },
                        child: Icon(
                          ZegoUIKitMediaPlayState.playing == playState
                              ? Icons.pause_circle
                              : Icons.play_circle,
                          color: Colors.white,
                        ),
                      ),
                      ElevatedButton(
                        onPressed: () {
                          ZegoUIKitPrebuiltLiveAudioRoomController()
                              .media
                              .stop();
                        },
                        child: const Icon(
                          Icons.stop_circle,
                          color: Colors.red,
                        ),
                      ),
                      ValueListenableBuilder<bool>(
                        valueListenable:
                            ZegoUIKitPrebuiltLiveAudioRoomController()
                                .media
                                .muteNotifier,
                        builder: (context, isMute, _) {
                          return ElevatedButton(
                            onPressed: () {
                              ZegoUIKitPrebuiltLiveAudioRoomController()
                                  .media
                                  .muteLocal(!isMute);
                            },
                            child: Icon(
                              isMute ? Icons.volume_off : Icons.volume_up,
                              color: Colors.white,
                            ),
                          );
                        },
                      ),
                    ],
                  );
                },
              ),
            ),
          ],
        )
      : Container();
}
