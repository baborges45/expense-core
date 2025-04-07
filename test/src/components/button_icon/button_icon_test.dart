import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Button Icon',
    () {
      testWidgets(
        'Should render button icon showing icon',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonIcon(
                icon: MudeIcons.userLine,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final widget = find.byKey(const Key('button-icon.icon'));
          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        'Should button icon tap',
        (widgetTester) async {
          bool press = false;
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.userLine,
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should button icon disabled and not accept tap',
        (widgetTester) async {
          bool press = false;
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.userLine,
                disabled: true,
                onPressed: () => press = true,
              ),
            ),
          );

          // tap is not accept
          await widgetTester.tap(find.byKey(key));
          expect(press, isFalse);

          // container opacity
          final widget = find.byKey(const Key('button-icon.animated-opacity'));
          final widgetOpacity = widgetTester.widget<Opacity>(widget);
          expect(widgetOpacity.opacity, tokens!.alias.color.disabled.opacity);
        },
      );

      testWidgets(
        'Should button icon size sm',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.userLine,
                size: MudeButtonIconSize.sm,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          final icon = widgetTester.widget<MudeIcon>(
            find.byKey(const Key('button-icon.icon')),
          );

          expect(icon.size, MudeIconSize.sm);
        },
      );

      testWidgets(
        'Should button icon change opacity with pressed',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.userLine,
                size: MudeButtonIconSize.sm,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pump(const Duration(milliseconds: 300));

          final widget = widgetTester.widget<Opacity>(
            find.byType(Opacity),
          );

          expect(widget.opacity, tokens!.alias.color.pressed.containerOpacity);
        },
      );

      testWidgets(
        'Should button icon inverse',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
                onPressed: () => debugPrint(''),
                inverse: true,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pumpAndSettle();

          var widget = find.byKey(const Key('button-icon.background'));
          final container = widgetTester.widget<Container>(widget);
          final decoration = container.decoration as BoxDecoration;
          final color = decoration.color;

          expect(color, tokens!.alias.mixin.pressedOutlineInverse);
        },
      );

      testWidgets(
        'Button icon color should be equal to background color',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
                onPressed: () => debugPrint(''),
                inverse: true,
                backgroundColor: Colors.amber,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pumpAndSettle();

          var widget = find.byKey(const Key('button-icon.background'));
          final container = widgetTester.widget<Container>(widget);
          final decoration = container.decoration as BoxDecoration;
          final color = decoration.color;

          expect(color, Colors.amber);
        },
      );

      testWidgets(
        'Should button tap cancel',
        (widgetTester) async {
          final key = UniqueKey();
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeButtonIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
                onPressed: () => press = true,
              ),
            ),
          );

          // simulate gesture tap cancel
          final gesture = await widgetTester.startGesture(
            widgetTester.getCenter(find.byType(GestureDetector)),
            pointer: 7,
          );

          await gesture.moveBy(const Offset(0, 10));
          await gesture.cancel();

          expect(press, isFalse);
        },
      );
    },
  );

  group('Button Icon Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeButtonIcon(
              icon: MudeIcons.userLine,
              onPressed: () => debugPrint(''),
              semanticsLabel: 'Button icon label',
              semanticsHint: 'Button icon hint',
            ),
          ),
        );

        // Checks that tappable nodes have a minimum size of 48 by 48 pixels
        // for Android.
        await expectLater(
          widgetTester,
          meetsGuideline(androidTapTargetGuideline),
        );

        // Checks that tappable nodes have a minimum size of 44 by 44 pixels
        // for iOS.
        await expectLater(
          widgetTester,
          meetsGuideline(iOSTapTargetGuideline),
        );

        // Checks that touch targets with a tap or long press action are labeled.
        await expectLater(
          widgetTester,
          meetsGuideline(labeledTapTargetGuideline),
        );

        // Checks whether semantic nodes meet the minimum text contrast levels.
        // The recommended text contrast is 3:1 for larger text
        // (18 point and above regular).
        await expectLater(
          widgetTester,
          meetsGuideline(textContrastGuideline),
        );

        handle.dispose();
      },
    );
  });
}
