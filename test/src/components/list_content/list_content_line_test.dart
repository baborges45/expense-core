import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mude_core/core.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'List Content Accessibility',
    () {
      testWidgets(
        'Should verify accessibility',
        (widgetTester) async {
          final SemanticsHandle handle = widgetTester.ensureSemantics();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
                label: 'test',
                description: 'test',
                labelRight: 'test',
                trailingButton: MudeButtonIcon(
                  icon: MudeIcons.placeholderLine,
                  onPressed: () => debugPrint(''),
                ),
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
    'List Content',
    () {
      testWidgets(
        'Should render list content',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
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
        'Should list content showing description',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
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
        'Should list content showing label right',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';
          const labelRight = 'Label Right';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
                key: key,
                label: label,
                description: description,
                labelRight: labelRight,
              ),
            ),
          );

          expect(find.text(labelRight), findsOneWidget);
        },
      );

      testWidgets(
        'Should list content showing description right',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';
          const labelRight = 'Label Right';
          const descriptionRight = 'Description Right';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
                key: key,
                label: label,
                description: description,
                labelRight: labelRight,
                descriptionRight: descriptionRight,
              ),
            ),
          );

          expect(find.text(descriptionRight), findsOneWidget);
        },
      );

      testWidgets(
        'Should list content showing tralling button',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';
          const labelRight = 'Label Right';
          const descriptionRight = 'Description Right';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
                key: key,
                label: label,
                description: description,
                labelRight: labelRight,
                descriptionRight: descriptionRight,
                trailingButton: MudeButtonIcon(
                  icon: MudeIcons.placeholderLine,
                  onPressed: () => debugPrint(''),
                ),
              ),
            ),
          );

          expect(find.byType(MudeButtonMini), findsOneWidget);
        },
      );

      testWidgets(
        'Should list content line position',
        (widgetTester) async {
          final key = UniqueKey();
          MudeThemeManager? tokens;

          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              onTokens: (t) => tokens = t,
              child: MudeListContentLine(
                key: key,
                label: label,
                description: description,
                linePosition: MudeListContentPosition.bottom,
              ),
            ),
          );

          final containers = find.byType(Container);
          final container = widgetTester.widget<Container>(containers.first);
          final decoration = container.decoration as BoxDecoration;
          final border = decoration.border as Border;

          expect(border.bottom.width, tokens!.alias.defaultt.borderWidth);
        },
      );

      testWidgets(
        'Should list content showing leading icon',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
                key: key,
                label: label,
                description: description,
                leading: MudeIcons.placeholderLine,
              ),
            ),
          );

          expect(find.byType(MudeIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list content showing leading image',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
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
        'Should list content showing leading avatar',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
                key: key,
                label: label,
                description: description,
                leading: MudeAvatarIcon(
                  icon: MudeIcons.calendarLine,
                ),
              ),
            ),
          );

          expect(find.byType(MudeAvatarIcon), findsOneWidget);
        },
      );

      testWidgets(
        'Should list content showing leading avatar icon',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
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
        'Should list content showing leading avatar business',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
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
        'Should list content showing leading credit card',
        (widgetTester) async {
          final key = UniqueKey();
          const label = 'Label';
          const description = 'Description';

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeListContentLine(
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
}
