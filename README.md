# flex\_audio

**flex\_audio** is a **flexible and customizable audio player** for Flutter apps. It works great for chat apps but is fully usable in any Flutter project. Easily play local or network audio, with multiple UI styles and full playback controls.

[![pub package](https://img.shields.io/pub/v/flex_audio.svg)](https://pub.dev/packages/flex_audio)

---

## Features

* Play audio from **local files** or **network URLs**.
* Supports **play, pause, stop, seek**, and playback progress.
* **Highly customizable UI** via `FlexAudioPlayerCard`.
* **Controller-driven**: `FlexAudioPlayerController` keeps playback logic separate from UI.
* Lightweight and **easy to integrate** into any Flutter app.
* Built-in **duration formatting**, slider, and play/pause button widgets.
* Extensible: add new styles or replace controls with your own widgets.

---

## Getting Started

Add this package to your Dart or Flutter project by adding this line to your `pubspec.yaml`:

```yaml
dependencies:
  flex_audio: ^1.0.0
```

Then import it in your Dart code:

```dart
import 'package:flex_audio/flex_audio.dart';
```

---

## Basic Usage

### 1. Create an Audio Controller

```dart
final audioController = FlexAudioPlayerController();
```

### 2. Add the Audio Player Widget

```dart
FlexAudioPlayer(
  audioPath: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-1.mp3',
  audioController: audioController,
);
```

### 3. Control Playback

```dart
// Play
audioController.play('https://example.com/audio.mp3');

// Pause
audioController.pause();

// Stop
audioController.stop();

// Seek
audioController.seek(Duration(seconds: 30));
```

---

## Advanced Usage

### Customizing the Player

```dart
FlexAudioPlayer(
  audioPath: 'audio_file.mp3',
  audioController: audioController,
  iconColor: Colors.white,
  controlButtonColor: Colors.blue,
  durationTextPosition: DurationTextPositionEnum.end,
  buildControlButton: (isActive, isPlaying, isLoading) {
    return Icon(
      isPlaying ? Icons.pause_circle_filled : Icons.play_circle_fill,
      color: Colors.red,
      size: 42,
    );
  },
);
```

---

## Example

See the `example/` folder in this package for a complete usage demo.

---

## Contributing

Contributions are welcome! Feel free to open an issue or submit a pull request.

---

## License

This package is licensed under the [MIT License](LICENSE).
