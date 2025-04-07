import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Avatar Icon Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeAvatarIcon(
                source: 'test/assets/image.png',
                icon: MudeIcons.backLine,
                sourceLoad: MudeAvatarSourceLoad.asset,
              ),
            ),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(androidTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(iOSTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(labeledTapTargetGuideline),
          );

          await expectLater(
            widgetTester,
            meetsGuideline(textContrastGuideline),
          );

          handle.dispose();
        },
      );
    },
  );
  group(
    'Avatar Icon',
    () {
      testWidgets(
        'Should render avatar',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeAvatarIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should avatar showing icon',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeAvatarIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
              ),
            ),
          );

          expect(find.byType(MudeIcon), findsOneWidget);
          expect(find.byType(Image), findsNothing);
        },
      );

      testWidgets(
        'Should avatar showing image',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeAvatarIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
                source: 'test/assets/image.png',
              ),
            ),
          );

          expect(find.byType(MudeIcon), findsOneWidget);
          expect(find.byType(Image), findsOneWidget);
        },
      );

      testWidgets(
        'Should avatar size sm',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeAvatarIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
                source: 'test/assets/image.png',
                size: MudeAvatarSize.sm,
              ),
            ),
          );

          final icon = widgetTester.widget<MudeIcon>(find.byType(MudeIcon));
          expect(icon.size, MudeIconSize.sm);
        },
      );

      testWidgets(
        'Should avatar inverse',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeAvatarIcon(
                key: key,
                icon: MudeIcons.placeholderLine,
                source: 'test/assets/image.png',
                size: MudeAvatarSize.sm,
                inverse: true,
              ),
            ),
          );

          final icon = widgetTester.widget<MudeIcon>(find.byType(MudeIcon));
          expect(icon.color, tokens!.alias.color.inverse.onIconColor);
        },
      );
    },
  );
}
