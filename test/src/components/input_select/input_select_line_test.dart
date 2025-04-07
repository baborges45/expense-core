import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Input Select Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputSelectLine(
                label: 'label',
                items: [MudeInputSelectItem('value', 'label')],
                value: MudeInputSelectItem('value', 'label'),
                onChanged: (e) => debugPrint(''),
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
    'Input Select',
    () {
      testWidgets(
        'Should render input select',
        (widgetTester) async {
          final key = UniqueKey();
          MudeInputSelectItem? value;
          List<MudeInputSelectItem> list = [];
          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
          expect(find.text(label), findsOneWidget);
        },
      );

      testWidgets(
        'Should input select with Support text',
        (widgetTester) async {
          final key = UniqueKey();
          MudeInputSelectItem? value;
          List<MudeInputSelectItem> list = [];
          const label = 'Label';
          const supportText = 'Support text';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => debugPrint(''),
                supportText: supportText,
              ),
            ),
          );

          expect(find.text(supportText), findsOneWidget);
        },
      );

      testWidgets(
        'Should input select pressed',
        (widgetTester) async {
          final key = UniqueKey();
          MudeInputSelectItem? value;
          List<MudeInputSelectItem> list = [
            MudeInputSelectItem('1', 'Item 01'),
            MudeInputSelectItem('2', 'Item 02'),
            MudeInputSelectItem('3', 'Item 03'),
          ];

          const label = 'Label';
          const placeholder = 'Placeholder Text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => debugPrint(''),
                placeholder: placeholder,
              ),
            ),
          );

          await widgetTester.press(find.text(label));
          await widgetTester.pumpAndSettle();

          final container = widgetTester.widget<Container>(
            find.byType(Container),
          );

          final decoration = container.decoration as BoxDecoration;
          expect(decoration.color, tokens!.alias.mixin.pressedOutline);
        },
      );

      testWidgets(
        'Should input select disabled',
        (widgetTester) async {
          final key = UniqueKey();
          MudeInputSelectItem value = MudeInputSelectItem('1', 'Item 01');
          List<MudeInputSelectItem> list = [
            MudeInputSelectItem('1', 'Item 01'),
            MudeInputSelectItem('2', 'Item 02'),
            MudeInputSelectItem('3', 'Item 03'),
          ];

          const label = 'Label';
          const placeholder = 'Placeholder Text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => debugPrint(''),
                placeholder: placeholder,
                disabled: true,
              ),
            ),
          );

          final placeholderWidget = find.text(label);
          final text = widgetTester.widget<Text>(placeholderWidget);
          final style = text.style as TextStyle;

          expect(style.color, tokens!.alias.color.disabled.placeholderColor);
        },
      );

      testWidgets(
        'Should input select has error',
        (widgetTester) async {
          final key = UniqueKey();

          MudeInputSelectItem? value = MudeInputSelectItem('1', 'Item 01');
          List<MudeInputSelectItem> list = [
            MudeInputSelectItem('1', 'Item 01'),
            MudeInputSelectItem('2', 'Item 02'),
            MudeInputSelectItem('3', 'Item 03'),
          ];

          const label = 'Label';
          const supportText = 'Support text';
          MudeThemeManager? tokens;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => debugPrint(''),
                supportText: supportText,
                hasError: true,
              ),
            ),
          );

          final placeholderWidget = find.text(label);
          final text = widgetTester.widget<Text>(placeholderWidget);
          final style = text.style as TextStyle;

          expect(style.color, tokens!.alias.color.negative.placeholderColor);
        },
      );

      testWidgets(
        'Should input select tap',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          MudeInputSelectItem? value = MudeInputSelectItem('1', 'Item 01');
          List<MudeInputSelectItem> list = [
            MudeInputSelectItem('1', 'Item 01'),
            MudeInputSelectItem('2', 'Item 02'),
            MudeInputSelectItem('3', 'Item 03'),
          ];

          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => debugPrint(''),
              ),
            ),
          );

          await widgetTester.tap(find.text(label));
          await widgetTester.pumpAndSettle();

          final placeholderWidget = find.text(label);
          final text = widgetTester.widget<Text>(placeholderWidget);
          final style = text.style as TextStyle;

          expect(style.color, tokens!.alias.color.active.placeholderColor);
        },
      );

      testWidgets(
        'Should input select color label',
        (widgetTester) async {
          final key = UniqueKey();

          MudeInputSelectItem? value;
          List<MudeInputSelectItem> list = [
            MudeInputSelectItem('1', 'Item 01'),
            MudeInputSelectItem('2', 'Item 02'),
            MudeInputSelectItem('3', 'Item 03'),
          ];

          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                onChanged: (e) => value = e,
              ),
            ),
          );

          await widgetTester.tap(find.text(label));
          await widgetTester.pumpAndSettle();
          await widgetTester.pump(const Duration(seconds: 1));

          final widgets = find.descendant(
            of: find.byKey(const Key('input-select.scroll-items')),
            matching: find.byType(GestureDetector),
          );

          await widgetTester.tap(widgets.first);
          await widgetTester.pumpAndSettle();
          await widgetTester.pump(const Duration(seconds: 1));

          expect(value, isNotNull);
        },
      );

      testWidgets(
        'Should have support text disabled',
        (widgetTester) async {
          final key = UniqueKey();

          MudeInputSelectItem? value;
          List<MudeInputSelectItem> list = [
            MudeInputSelectItem('1', 'Item 01'),
            MudeInputSelectItem('2', 'Item 02'),
            MudeInputSelectItem('3', 'Item 03'),
          ];

          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeInputSelectLine(
                key: key,
                label: label,
                items: list,
                value: value,
                supportText: 'Support',
                disabled: true,
                onChanged: (e) => value = e,
              ),
            ),
          );

          expect(find.text('Support'), isNotNull);
        },
      );
    },
  );
}
