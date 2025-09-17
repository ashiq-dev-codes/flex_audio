# flex\_audio

**flex\_audio** is a **flexible and customizable audio player** for Flutter apps. It works great for chat apps but is fully usable in any Flutter project. Easily play local or network audio, with multiple UI styles and full playback controls.

---

## Features

* Play audio from **local files** or **network URLs**.
* Supports **pause, stop, seek**, and **playback progress**.
* **Multiple customizable UI styles** for audio player widgets.
* Fully **controller-driven**: separate playback logic from UI.
* Lightweight and **easy to integrate** into any Flutter app.
* Built-in **duration formatting**, slider, and play button widgets.
* Extensible: add new styles or integrate with other Flutter widgets easily.

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
final audioController = AudioController();
```

### 2. Add the Audio Player Widget

```dart
ChatAudioPlayer(
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

### Using Multiple Styles

```dart
ChatAudioPlayer(
  audioPath: 'audio_file.mp3',
  audioController: audioController,
  style: 2, // Switch between available UI styles
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

MIT License © \[Your Name]
