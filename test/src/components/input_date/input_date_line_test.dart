import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:intl/intl.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Input Date',
    () {
      testWidgets(
        'Should render input date',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supportText = 'Support Text';

          final firstDate = DateTime.now();
          final lastDate = DateTime.now().add(const Duration(days: 365 * 10));
          List<DateTime?> value = [];
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputDateLine(
                key: key,
                label: label,
                supportText: supportText,
                firstDate: firstDate,
                lastDate: lastDate,
                value: value,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.text(label), findsOneWidget);

          final support = widgetTester.widget<Text>(find.text(supportText));
          final style = support.style as TextStyle;
          expect(style.color, tokens!.alias.color.text.supportTextColor);
        },
      );

      testWidgets(
        'Should render input date disabled',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supportText = 'Support Text';
          final firstDate = DateTime.now();
          final lastDate = DateTime.now().add(const Duration(days: 365 * 10));
          List<DateTime?> value = [];
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputDateLine(
                key: key,
                label: label,
                supportText: supportText,
                firstDate: firstDate,
                lastDate: lastDate,
                value: value,
                disabled: true,
              ),
            ),
          );

          final container = widgetTester.widget<Container>(
            find.byKey(const Key('input-date.container')),
          );
          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, Colors.transparent);

          final support = widgetTester.widget<Text>(find.text(supportText));
          final style = support.style as TextStyle;
          expect(style.color, tokens!.alias.color.disabled.supportTextColor);
        },
      );

      testWidgets(
        'Should render input date has error',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supportText = 'Support Text';
          final firstDate = DateTime.now();
          final lastDate = DateTime.now().add(const Duration(days: 365 * 10));
          List<DateTime?> value = [];
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputDateLine(
                key: key,
                label: label,
                supportText: supportText,
                firstDate: firstDate,
                lastDate: lastDate,
                value: value,
                hasError: true,
              ),
            ),
          );

          final container = widgetTester.widget<Container>(
            find.byKey(const Key('input-date.container')),
          );
          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, Colors.transparent);

          final text = widgetTester.widget<Text>(find.text(label));
          final style = text.style as TextStyle;
          expect(style.color, tokens!.alias.color.negative.placeholderColor);

          final icon =
              widgetTester.widget<MudeIcon>(find.byType(MudeIcon).first);
          expect(icon.color, tokens!.alias.color.negative.iconColor);

          final support = widgetTester.widget<Text>(find.text(supportText));
          final styleSupport = support.style as TextStyle;
          expect(
            styleSupport.color,
            tokens!.alias.color.negative.supportTextColor,
          );
        },
      );

      testWidgets(
        'Should render input date filled',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          final firstDate = DateTime.now();
          final lastDate = DateTime.now().add(const Duration(days: 365 * 10));
          List<DateTime?> value = [DateTime.now()];
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputDateLine(
                key: key,
                label: label,
                firstDate: firstDate,
                lastDate: lastDate,
                value: value,
              ),
            ),
          );

          final text = widgetTester.widget<Text>(find.text(label));
          final style = text.style as TextStyle;
          expect(style.color, tokens!.alias.color.active.onPlaceholderColor);

          final dateFormatter = DateFormat('dd/MM/yyyy');
          final placeholderText = dateFormatter.format(DateTime.now());
          final placeholder = widgetTester.widget<Text>(
            find.text(placeholderText),
          );
          final stylePlaceholder = placeholder.style as TextStyle;
          expect(
            stylePlaceholder.color,
            tokens!.alias.color.active.onPlaceholderColor,
          );
        },
      );

      testWidgets(
        'Should render input date open and close calendar',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          final firstDate = DateTime.now();
          final lastDate = DateTime.now().add(const Duration(days: 365 * 10));
          List<DateTime?> value = [];

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputDateLine(
                key: key,
                type: MudeInputDateType.single,
                label: label,
                firstDate: firstDate,
                lastDate: lastDate,
                value: value,
                onConfirm: (v) => value = v,
              ),
            ),
          );

          // Open calendar
          await widgetTester.tap(find.text(label));
          await widgetTester.pumpAndSettle();

          final calendar = find.byType(MudeDatePicker);
          expect(calendar, findsOneWidget);

          // Select date
          final dayText = DateTime.now().day;
          final dayPicker = find.text(dayText.toString());

          final dayWidget = find.ancestor(
            of: dayPicker,
            matching: find.byType(GestureDetector),
          );

          await widgetTester.tap(dayWidget);
          await widgetTester.pumpAndSettle();

          // Pressed confirm button
          final button = find.byType(MudeButton);

          await widgetTester.tap(button);
          await widgetTester.pumpAndSettle();

          expect(calendar, findsNothing);
        },
      );
    },
  );

  group('Input Date Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        final key = UniqueKey();
        const label = 'Label';
        final firstDate = DateTime.now();
        final lastDate = DateTime.now().add(const Duration(days: 365 * 10));
        List<DateTime?> value = [];

        await widgetTester.pumpWidget(
          Wrapper(
            child: MudeInputDateLine(
              key: key,
              label: label,
              firstDate: firstDate,
              lastDate: lastDate,
              value: value,
              semanticsLabel: 'Label semantics',
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
