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
    final controller = widget.audioController;

    return ValueListenableBuilder<ProcessingState>(
      valueListenable: controller.state,
      builder: (context, state, _) {
        final isActive = controller.currentPath.value == widget.audioPath;
        final isLoading =
            state == ProcessingState.loading ||
            state == ProcessingState.buffering;
        final isDisabled = !isActive && !isLoading;

        final position = isActive ? controller.position.value : _localPosition;
        final duration = isActive ? controller.duration.value : Duration.zero;

        final total = duration.inMilliseconds == 0
            ? 1
            : duration.inMilliseconds;
        final value = position.inMilliseconds.clamp(0, total).toDouble();

        return FlexAudioPlayerCard(
          value: value,
          position: position,
          duration: duration,
          isActive: isActive,
          max: total.toDouble(),
          isLoading: isLoading,
          isDisabled: isDisabled,
          isPlaying: controller.isPlaying.value && !isLoading,
          onPressed: () {
            if (controller.isPlaying.value) {
              controller.pause();
            } else {
              controller.play(widget.audioPath, isFile: widget.isFile);
            }
            if (!isActive) {
              setState(() => _localPosition = Duration.zero);
            }
          },
          onChanged: isActive
              ? (val) => controller.seek(Duration(milliseconds: val.toInt()))
              : null,
        );
      },
    );
  }
}
