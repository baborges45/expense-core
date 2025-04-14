import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Input Card',
    () {
      testWidgets(
        'Should render input card',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCardLine(
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
        'Should render input card showing support text',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
              ),
            ),
          );

          expect(find.text(supporttext), findsOneWidget);
        },
      );

      testWidgets(
        'Should render input card disabled',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
                disabled: true,
              ),
            ),
          );

          final widget = widgetTester.widget<Container>(
            find.byKey(const Key('input-card.container')),
          );
          final decoration = widget.decoration as BoxDecoration;
          final border = decoration.border as Border;
          final borderBottom = border.bottom;

          expect(borderBottom.color, tokens!.alias.color.disabled.borderColor);
        },
      );

      testWidgets(
        'Should render input card pressed',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
              ),
            ),
          );

          await widgetTester.press(find.byKey(key));
          await widgetTester.pump(const Duration(milliseconds: 200));

          final widget = widgetTester.widget<Container>(
            find.byKey(const Key('input-card.container')),
          );
          final decoration = widget.decoration as BoxDecoration;

          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should render input card with error',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
                hasError: true,
              ),
            ),
          );

          final widget = widgetTester.widget<Container>(
            find.byKey(const Key('input-card.container')),
          );
          final decoration = widget.decoration as BoxDecoration;
          final border = decoration.border as Border;
          final borderBottom = border.bottom;

          expect(borderBottom.color, tokens!.alias.color.negative.borderColor);
        },
      );

      testWidgets(
        'Should render input card filled',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          ExpenseThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
              ),
            ),
          );

          await widgetTester.tap(find.byType(TextField));
          await widgetTester.pumpAndSettle();

          final widget = widgetTester.widget<TextField>(find.byType(TextField));
          final style = widget.style as TextStyle;

          expect(style.color, tokens!.alias.color.active.placeholderColor);
        },
      );

      testWidgets(
        'Should render input card type card',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          const value = '1111222233334444';
          const valueCorrect = '1111 2222 3333 4444';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
                type: ExpenseInputCardType.card,
              ),
            ),
          );

          await widgetTester.enterText(find.byType(TextField), value);
          await widgetTester.pump();

          final widget = widgetTester.widget<TextField>(find.byType(TextField));

          final formatter = widget.inputFormatters as List<TextInputFormatter>;
          final formatterLenght = formatter[2] as LengthLimitingTextInputFormatter;

          expect(formatterLenght.maxLength, 19);
          expect(widget.controller!.text, valueCorrect);
        },
      );

      testWidgets(
        'Should render input card type validate',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          const value = '1223';
          const valueCorrect = '12/23';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
                type: ExpenseInputCardType.validate,
              ),
            ),
          );

          await widgetTester.enterText(find.byType(TextField), value);
          await widgetTester.pump();

          final widget = widgetTester.widget<TextField>(find.byType(TextField));

          final formatter = widget.inputFormatters as List<TextInputFormatter>;
          final formatterLenght = formatter[2] as LengthLimitingTextInputFormatter;

          expect(formatterLenght.maxLength, 5);
          expect(widget.controller!.text, valueCorrect);
        },
      );

      testWidgets(
        'Should render input card type cvv',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const supporttext = 'Support text';
          const value = '123';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseInputCardLine(
                key: key,
                label: label,
                supportText: supporttext,
                type: ExpenseInputCardType.cvv,
              ),
            ),
          );

          await widgetTester.enterText(find.byType(TextField), value);
          await widgetTester.pump();

          final widget = widgetTester.widget<TextField>(find.byType(TextField));

          final formatter = widget.inputFormatters as List<TextInputFormatter>;
          final formatterLenght = formatter[1] as LengthLimitingTextInputFormatter;

          expect(formatterLenght.maxLength, 3);
          expect(widget.controller!.text, value);
        },
      );
    },
  );

  group('Input Card Accessibility', () {
    testWidgets(
      'Should verify accessibility',
      (widgetTester) async {
        final SemanticsHandle handle = widgetTester.ensureSemantics();

        await widgetTester.pumpWidget(
          const Wrapper(
            child: ExpenseInputCardLine(
              label: 'Label',
              semanticsLabel: 'Label',
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
