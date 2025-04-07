import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'List Select Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                label: 'Label',
                description: 'Description',
                onChanged: (value) => debugPrint(''),
                value: null,
                semanticsTrailling: 'semanticsTrailling',
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
    'List Select',
    () {
      testWidgets(
        'Should render list select',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
              ),
            ),
          );

          expect(find.byKey(key), findsOneWidget);
        },
      );

      testWidgets(
        'Should list select showing description',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const descripiton = 'Description';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                description: descripiton,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
              ),
            ),
          );

          expect(find.text(descripiton), findsOneWidget);
        },
      );

      testWidgets(
        'Should list select tap',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
              ),
            ),
          );

          final checkout = find.byType(MudeCheckbox);
          await widgetTester.tap(checkout);
          await widgetTester.pumpAndSettle();

          expect(itemSelected, isTrue);
        },
      );

      testWidgets(
        'Should list select disabled',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
                disabled: true,
              ),
            ),
          );

          final checkout = find.byType(MudeCheckbox);
          await widgetTester.tap(checkout);
          await widgetTester.pumpAndSettle();

          expect(itemSelected, isFalse);
        },
      );

      testWidgets(
        'Should list select line position',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
                linePosition: MudeListSelectPosition.bottom,
              ),
            ),
          );

          final containers = find.byType(Container);
          final container = widgetTester.widget<Container>(
            containers.first,
          );

          final decoration = container.decoration as BoxDecoration;
          final border = decoration.border as Border;

          expect(border.bottom.width, tokens!.alias.defaultt.borderWidth);
        },
      );

      testWidgets(
        'Should list select showing icon',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
                leading: MudeIcons.placeholderLine,
              ),
            ),
          );

          expect(find.byType(MudeIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list select showing image',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
                leading: MudeImage.asset('test/assets/image.png'),
              ),
            ),
          );

          expect(find.byType(MudeImage), findsOneWidget);
        },
      );

      testWidgets(
        'Should list select showing avatar',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
                leading: MudeAvatarIcon(icon: MudeIcons.calendarLine),
              ),
            ),
          );

          expect(find.byType(MudeAvatarIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list select showing avatar icon',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
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
        'Should list select showing avatar business',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
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
        'Should list select showing credit card',
        (widgetTester) async {
          final key = UniqueKey();

          const label = 'Label';
          bool itemSelected = false;

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListSelectLine(
                key: key,
                label: label,
                onChanged: (e) {
                  itemSelected = e!;
                },
                value: itemSelected,
                leading: const MudeCreditCard(),
              ),
            ),
          );

          expect(find.byType(MudeCreditCard), findsOneWidget);
        },
      );
    },
  );
}
