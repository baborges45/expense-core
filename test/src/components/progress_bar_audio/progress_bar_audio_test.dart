import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'progress bar audio',
    () {
      testWidgets(
        'Should be render correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeProgressBarAudio(
                key: key,
                controller: ProgressBarController()
                  ..setPlayList(
                    [
                      ProgressBarAudioSource(
                        id: 1,
                        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
                        author: 'Mude',
                        title: 'Title 1',
                      ),
                    ],
                  ),
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be render correctly with hide text',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeProgressBarAudio(
                key: key,
                controller: ProgressBarController()
                  ..setPlayList(
                    [
                      ProgressBarAudioSource(
                        id: 1,
                        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
                        author: 'Mude',
                        title: 'Title 1',
                      ),
                    ],
                  ),
                hideText: true,
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should be render correctly with inverse',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeProgressBarAudio(
                key: key,
                controller: ProgressBarController()
                  ..setPlayList(
                    [
                      ProgressBarAudioSource(
                        id: 1,
                        url: 'https://www.soundhelix.com/examples/mp3/SoundHelix-Song-6.mp3',
                        author: 'Mude',
                        title: 'Title 1',
                      ),
                    ],
                  ),
                inverse: true,
              ),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );
    },
  );
}
