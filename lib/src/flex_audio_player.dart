import 'package:flex_audio/flex_audio.dart';
import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

class FlexAudioPlayer extends StatefulWidget {
  const FlexAudioPlayer({
    super.key,
    this.isFile = false,
    required this.audioPath,
    required this.audioController,
  });

  final bool isFile;
  final String audioPath;
  final FlexAudioPlayerController audioController;

  @override
  State<FlexAudioPlayer> createState() => _FlexAudioPlayerState();
}

class _FlexAudioPlayerState extends State<FlexAudioPlayer> {
  Duration _localPosition = Duration.zero;

  @override
  void initState() {
    super.initState();
    widget.audioController.init();
  }

  @override
  Widget build(BuildContext context) {
    final audioController = widget.audioController;

    return ValueListenableBuilder<ProcessingState>(
      valueListenable: audioController.state,
      builder: (context, currentState, _) {
        return ValueListenableBuilder<String?>(
          valueListenable: audioController.currentPath,
          builder: (context, currentPath, _) {
            final isActive = currentPath == widget.audioPath;

            return ValueListenableBuilder(
              valueListenable: audioController.position,
              builder: (context, currentPosition, _) {
                return ValueListenableBuilder<Duration>(
                  valueListenable: audioController.duration,
                  builder: (context, currentDuration, _) {
                    return ValueListenableBuilder<bool>(
                      valueListenable: audioController.isPlaying,
                      builder: (context, isPlaying, _) {
                        // Only get position & duration if active
                        final isLoading =
                            currentState == ProcessingState.loading ||
                            currentState == ProcessingState.buffering;
                        // final isDisabled = !isActive && !isLoading;

                        final position = isActive
                            ? currentPosition
                            : _localPosition;
                        final duration = isActive
                            ? currentDuration
                            : Duration.zero;

                        final total = duration.inMilliseconds == 0
                            ? 1
                            : duration.inMilliseconds;
                        final value = position.inMilliseconds
                            .clamp(0, total)
                            .toDouble();

                        return FlexAudioPlayerCard(
                          value: value,
                          position: position,
                          duration: duration,
                          isActive: isActive,
                          max: total.toDouble(),
                          isLoading: isLoading,
                          // isDisabled: isDisabled,
                          isPlaying:
                              !audioController.hasCompleted &&
                              isPlaying &&
                              !isLoading,
                          onPressed: () {
                            if (isPlaying) {
                              audioController.pause();
                            } else {
                              audioController.play(
                                widget.audioPath,
                                isFile: widget.isFile,
                              );
                            }
                            if (!isActive) {
                              setState(() => _localPosition = Duration.zero);
                            }
                          },
                          onChanged: isActive
                              ? (val) => audioController.seek(
                                  Duration(milliseconds: val.toInt()),
                                )
                              : null,
                        );
                      },
                    );
                  },
                );
              },
            );
          },
        );
      },
    );
  }
}
