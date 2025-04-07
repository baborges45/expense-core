import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'List Navigation',
    () {
      testWidgets(
        'Should render list navigation',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.text(label), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing description',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
              ),
            ),
          );

          expect(find.text(description), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing tag',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';
          const tag = 'tag';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                tag: const MudeTagContainer(tag),
              ),
            ),
          );

          expect(find.text(tag), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing icon',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';
          const tag = 'tag';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                tag: const MudeTagContainer(tag),
                leading: MudeIcons.placeholderLine,
              ),
            ),
          );

          final icons = find.byType(MudeIcon);
          final icon = widgetTester.widget<MudeIcon>(icons.first);
          expect(find.byType(MudeIcon), findsWidgets);
          expect(icon.icon.name, MudeIcons.placeholderLine.name);
        },
      );

      testWidgets(
        'Should list navigation tap',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          const description = 'Description';
          const tag = 'tag';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                tag: const MudeTagContainer(tag),
                leading: MudeIcons.placeholderLine,
                onPressed: () => press = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));
          await widgetTester.pumpAndSettle();

          expect(press, isTrue);
        },
      );

      testWidgets(
        'Should list navigation tap cancel',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';
          const tag = 'tag';
          bool press = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                tag: const MudeTagContainer(tag),
                leading: MudeIcons.placeholderLine,
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

      testWidgets(
        'Should list navigation check background color',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          const label = 'Label';
          const description = 'Description';
          const tag = 'tag';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                tag: const MudeTagContainer(tag),
                leading: MudeIcons.placeholderLine,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pumpAndSettle();

          final containers = find.byType(Container);
          final container = widgetTester.widget<Container>(
            containers.first,
          );
          final decoration = container.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should list navigation line position',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          const label = 'Label';
          const description = 'Description';
          const tag = 'tag';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                tag: const MudeTagContainer(tag),
                leading: MudeIcons.placeholderLine,
                onPressed: () => debugPrint(''),
                linePosition: MudeListNavigationPosition.bottom,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pumpAndSettle();

          final containers = find.byType(Container);
          final container = widgetTester.widget<Container>(
            containers.first,
          );
          final decoration = container.decoration as BoxDecoration;
          final border = decoration.border as Border;

          expect(border.bottom.width, tokens!.alias.defaultt.borderWidth);
          expect(border.top.width, 0);
        },
      );

      testWidgets(
        'Should list navigation showing leading icon',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                leading: MudeIcon(icon: MudeIcons.placeholderLine),
              ),
            ),
          );

          expect(find.byType(MudeIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing leading image',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                leading: MudeImage.asset('test/assets/image.png'),
              ),
            ),
          );

          expect(find.byType(MudeImage), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing leading avatar',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                leading: MudeAvatarIcon(icon: MudeIcons.calendarLine),
              ),
            ),
          );

          expect(find.byType(MudeAvatarIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing leading avatar icon',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                leading: MudeAvatarIcon(
                  icon: MudeIcons.placeholderLine,
                ),
              ),
            ),
          );

          expect(find.byType(MudeAvatarIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing leading avatar business',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                leading: MudeAvatarIcon(
                  icon: MudeIcons.placeholderLine,
                ),
              ),
            ),
          );

          expect(find.byType(MudeAvatarIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list navigation showing leading credit card',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListNavigationLine(
                key: key,
                label: label,
                description: description,
                leading: const MudeCreditCard(),
              ),
            ),
          );

          expect(find.byType(MudeCreditCard), findsOneWidget);
        },
      );
    },
  );

  group('List Navigation Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: MudeListNavigationLine(
              label: 'List Navigator',
              semanticsLabel: 'List Navigator',
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
