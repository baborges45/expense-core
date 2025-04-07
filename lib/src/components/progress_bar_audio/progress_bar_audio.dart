import 'package:audio_session/audio_session.dart';
import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';

import 'widgets/slider_progress.dart';

class MudeProgressBarAudio extends StatefulWidget {
  /// The player controller.
  final ProgressBarController controller;

  /// A boolean value that specifies whether the text should be hidden.
  final bool hideText;

  ///Indicates inverse property.
  final bool inverse;

  const MudeProgressBarAudio({
    super.key,
    required this.controller,
    this.hideText = false,
    this.inverse = false,
  });

  @override
  State<MudeProgressBarAudio> createState() => _MudeProgressBarAudioState();
}

class _MudeProgressBarAudioState extends State<MudeProgressBarAudio> {
  String _formatDuration(double value) {
    Duration duration = Duration(seconds: value.round());
    int minutes = duration.inMinutes;

    String twoDigits(int n) => n.toString().padLeft(2, "0");
    String oneOrTwoDigitMinutes =
        minutes.remainder(60) < 10 ? duration.inMinutes.remainder(60).toString() : twoDigits(duration.inMinutes.remainder(60));
    String twoDigitSeconds = twoDigits(duration.inSeconds.remainder(60));

    return '$oneOrTwoDigitMinutes:$twoDigitSeconds';
  }

  void handleSeek(double value) {
    widget.controller.seek(
      Duration(
        seconds: value.toInt(),
      ),
    );
  }

  @override
  void initState() {
    _init();
    super.initState();
  }

  Future<void> _init() async {
    final session = await AudioSession.instance;
    await session.configure(const AudioSessionConfiguration.speech());
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<PositionData>(
      stream: widget.controller.positionDataStream,
      builder: (context, snapshot) {
        final positionData = snapshot.data;

        return SeekBar(
          duration: positionData?.duration ?? Duration.zero,
          position: positionData?.position ?? Duration.zero,
          bufferedPosition: positionData?.bufferedPosition ?? Duration.zero,
          onChangeEnd: (newPosition) {
            widget.controller.seek(newPosition);
          },
          hideText: widget.hideText,
          inverse: widget.inverse,
        );
      },
    );
  }
}
