import 'package:flex_audio/flex_audio.dart';
import 'package:flutter_test/flutter_test.dart';

void main() {
  group('AudioController Tests', () {
    late FlexAudioPlayerController audioController;

    setUp(() {
      audioController = FlexAudioPlayerController();
    });

    test('Initial state should be correct', () {
      expect(audioController.isPlaying.value, false);
      expect(audioController.currentPath.value, null);
      expect(audioController.position.value, Duration.zero);
      expect(audioController.duration.value, Duration.zero);
    });

    test('Play sets currentPath and isPlaying', () async {
      final testUrl =
          'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3';
      await audioController.play(testUrl);
      expect(audioController.currentPath.value, testUrl);
      expect(audioController.isPlaying.value, true);
    });

    test('Pause stops playback', () async {
      await audioController.play(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      );
      audioController.pause();
      expect(audioController.isPlaying.value, false);
    });

    test('Stop resets state', () async {
      await audioController.play(
        'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
      );
      await audioController.stop();
      expect(audioController.isPlaying.value, false);
      expect(audioController.currentPath.value, null);
      expect(audioController.position.value, Duration.zero);
      expect(audioController.duration.value, Duration.zero);
    });
  });
}
