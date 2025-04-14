import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

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
              child: ExpenseAvatarIcon(
                source: 'test/assets/image.png',
                icon: ExpenseIcons.backLine,
                sourceLoad: ExpenseAvatarSourceLoad.asset,
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
              child: ExpenseAvatarIcon(
                key: key,
                icon: ExpenseIcons.placeholderLine,
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
              child: ExpenseAvatarIcon(
                key: key,
                icon: ExpenseIcons.placeholderLine,
              ),
            ),
          );

          expect(find.byType(ExpenseIcon), findsOneWidget);
          expect(find.byType(Image), findsNothing);
        },
      );

      testWidgets(
        'Should avatar showing image',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseAvatarIcon(
                key: key,
                icon: ExpenseIcons.placeholderLine,
                source: 'test/assets/image.png',
              ),
            ),
          );

          expect(find.byType(ExpenseIcon), findsOneWidget);
          expect(find.byType(Image), findsOneWidget);
        },
      );

      testWidgets(
        'Should avatar size sm',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseAvatarIcon(
                key: key,
                icon: ExpenseIcons.placeholderLine,
                source: 'test/assets/image.png',
                size: ExpenseAvatarSize.sm,
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(find.byType(ExpenseIcon));
          expect(icon.size, ExpenseIconSize.sm);
        },
      );

      testWidgets(
        'Should avatar inverse',
        (widgetTester) async {
          final key = UniqueKey();
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseAvatarIcon(
                key: key,
                icon: ExpenseIcons.placeholderLine,
                source: 'test/assets/image.png',
                size: ExpenseAvatarSize.sm,
                inverse: true,
              ),
            ),
          );

          final icon = widgetTester.widget<ExpenseIcon>(find.byType(ExpenseIcon));
          expect(icon.color, tokens!.alias.color.inverse.onIconColor);
        },
      );
    },
  );
}
