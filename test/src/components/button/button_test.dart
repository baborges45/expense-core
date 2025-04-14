import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:expense_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Button Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButton(
                label: 'label',
                onPressed: () => debugPrint(''),
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
    'Button',
    () {
      testWidgets(
        'Should render button with label',
        (widgetTester) async {
          const text = 'Button';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButton(
                label: text,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          var widget = find.text(text);

          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        'Should verify button was pressed',
        (widgetTester) async {
          final key = UniqueKey();
          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButton(
                key: key,
                label: 'Button',
                onPressed: () => pressed = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));

          expect(pressed, true);
        },
      );

      testWidgets(
        'Should button is disabled and not accept tap',
        (widgetTester) async {
          final key = UniqueKey();
          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButton(
                key: key,
                label: 'Button',
                disabled: true,
                onPressed: () => pressed = true,
              ),
            ),
          );

          await widgetTester.tap(find.byKey(key));

          expect(pressed, false);
        },
      );

      testWidgets(
        'Should button is loading and not accept tap',
        (widgetTester) async {
          final key = UniqueKey();
          String text = 'Button';
          bool pressed = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButton(
                key: key,
                label: text,
                loading: true,
                onPressed: () => pressed = true,
              ),
            ),
          );

          // dont accept tap
          await widgetTester.tap(find.byKey(key));
          expect(pressed, false);

          // showing widget loading
          final widget = find.byKey(const Key('button-loading'));
          expect(widget, findsOneWidget);
        },
      );

      testWidgets(
        'Should button render icon and text',
        (widgetTester) async {
          final key = UniqueKey();
          String text = 'Button';

          await widgetTester.pumpWidget(
            Wrapper(
              child: ExpenseButton(
                key: key,
                label: text,
                icon: ExpenseIcons.plusLine,
                onPressed: () => debugPrint(''),
              ),
            ),
          );

          // showing icon
          final widgetIcon = find.byKey(const Key('ds-button-icon'));
          expect(widgetIcon, findsOneWidget);

          // showing text label
          final widgetText = find.text(text);
          expect(widgetText, findsOneWidget);
        },
      );
    },
  );

  group('Button / Mixin', () {
    testWidgets(
      'Should button inverse',
      (widgetTester) async {
        final key = UniqueKey();
        String text = 'Button';
        ExpenseThemeManager? tokens;

        await widgetTester.pumpWidget(
          Wrapper(
            onTokens: (t) => tokens = t,
            child: ExpenseButton(
              key: key,
              label: text,
              icon: ExpenseIcons.plusLine,
              onPressed: () => debugPrint(''),
              inverse: true,
            ),
          ),
        );

        final widget = widgetTester.widget<Text>(find.byType(Text));
        final style = widget.style as TextStyle;

        expect(style.color, tokens!.alias.color.inverse.onLabelColor);
      },
    );

    testWidgets(
      'Should button pressed',
      (widgetTester) async {
        final key = UniqueKey();
        String text = 'Button';
        ExpenseThemeManager? tokens;

        await widgetTester.pumpWidget(
          Wrapper(
            onTokens: (t) => tokens = t,
            child: ExpenseButtonMini(
              key: key,
              label: text,
              onPressed: () => debugPrint(''),
            ),
          ),
        );

        await widgetTester.press(find.byKey(key));
        await widgetTester.pump(const Duration(milliseconds: 200));

        final widget = widgetTester.widget<Opacity>(
          find.byType(Opacity),
        );

        expect(widget.opacity, tokens!.alias.color.pressed.containerOpacity);
      },
    );

    testWidgets('Should be loading', (widgetTester) async {
      final key = UniqueKey();
      ExpenseThemeManager? tokens;

      await widgetTester.pumpWidget(
        Wrapper(
          onTokens: (t) => tokens = t,
          child: ExpenseLoading(key: key),
        ),
      );

      final loading1 = find.byKey(const Key('loading-1'));
      final container1 = widgetTester.widget<AnimatedContainer>(loading1);
      final decoration1 = container1.decoration as BoxDecoration;
      expect(decoration1.color, tokens!.globals.colors.grey500);

      await widgetTester.pump(const Duration(milliseconds: 270));

      final loading2 = find.byKey(const Key('loading-2'));
      final container2 = widgetTester.widget<AnimatedContainer>(loading2);
      final decoration2 = container2.decoration as BoxDecoration;
      expect(decoration2.color, tokens!.globals.colors.grey500);

      await widgetTester.pump(const Duration(milliseconds: 270));

      final loading3 = find.byKey(const Key('loading-3'));
      final container3 = widgetTester.widget<AnimatedContainer>(loading3);
      final decoration3 = container3.decoration as BoxDecoration;
      expect(decoration3.color, tokens!.globals.colors.grey500);
    });
  });
}
