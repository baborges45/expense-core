import 'dart:async';

import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:just_audio_background/just_audio_background.dart';
import 'package:expense_core/src/components/dropdown/models/dropdown_item.dart';
import 'package:rxdart/rxdart.dart';

import 'audio_source.dart';

export 'package:just_audio/just_audio.dart';

class ProgressBarController {
  final AudioPlayer _player = AudioPlayer();
  StreamSubscription? _stateSub;
  ValueNotifier<ExpenseDropdownItem?> selectedSpeed = ValueNotifier<ExpenseDropdownItem?>(null);

  Stream<PositionData> get positionDataStream => Rx.combineLatest3<Duration, Duration, Duration?, PositionData>(
        _player.positionStream,
        _player.bufferedPositionStream,
        _player.durationStream,
        (position, bufferedPosition, duration) => PositionData(position, bufferedPosition, duration ?? Duration.zero),
      );

  Stream<SequenceState?> get sequenceStateStream => _player.sequenceStateStream;
  Stream<PlayerState> get playerStateStream => _player.playerStateStream;
  IndexedAudioSource? get currentPlaying => _player.sequenceState?.currentSource;

  bool get isPlaying => _player.playerState.playing;
  int get position => _player.position.inSeconds;

  void seek(Duration toValue) {
    _player.seek(toValue);
  }

  void dispose() {
    _player.dispose();
    _stateSub?.cancel();
  }

  void setSpeed(double speed) {
    _player.setSpeed(speed);
  }

  void rearward(int time) {
    seek(Duration(seconds: _player.position.inSeconds - time));
  }

  void forward(int time) {
    seek(Duration(seconds: _player.position.inSeconds + time));
  }

  void play() {
    _player.play();
  }

  void pause() {
    _player.pause();
  }

  void restart() {
    _player.seek(Duration.zero, index: _player.effectiveIndices!.first);
  }

  void setPlayList(List<ProgressBarAudioSource> playList) {
    final playlist = ConcatenatingAudioSource(
      children: playList
          .map(
            (src) => AudioSource.uri(
              Uri.parse(src.url),
              tag: MediaItem(
                id: '${src.id}',
                album: "Expense Journey",
                title: src.title,
                artist: src.author,
                artUri: src.imageUrl != null ? Uri.parse(src.imageUrl!) : null,
              ),
            ),
          )
          .toList(),
    );
    _player.setAudioSource(playlist);
  }

  void playSingleAudio(
    ProgressBarAudioSource src, {
    required Future<void> Function() onFinishPlay,
  }) {
    _stateSub?.cancel();
    _stateSub = _player.playerStateStream.listen((event) {
      if (event.processingState == ProcessingState.completed) {
        onFinishPlay();
      }
    });
    _player.audioSource?.sequence.clear();
    _player.setAudioSource(
      AudioSource.uri(
        Uri.parse(src.url),
        tag: MediaItem(
          id: '${src.id}',
          album: "Expense Journey",
          title: src.title,
          artist: src.author,
          artUri: src.imageUrl != null ? Uri.parse(src.imageUrl!) : null,
        ),
      ),
    );
  }
}

class PositionData {
  final Duration position;
  final Duration bufferedPosition;
  final Duration duration;

  PositionData(this.position, this.bufferedPosition, this.duration);
}
