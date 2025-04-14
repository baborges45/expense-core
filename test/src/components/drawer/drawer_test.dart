import 'package:expense_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Drawer',
    () {
      testWidgets(
        'Should render drawer',
        (widgetTester) async {
          await widgetTester.pumpWidget(
            Wrapper(
              child: const SizedBox.shrink(),
              onTap: (context) {
                ExpenseDrawer.show(
                  context,
                  children: [
                    ExpenseButton(
                      label: 'Close',
                      onPressed: () => debugPrint(''),
                    ),
                  ],
                );
              },
            ),
          );

          final button = find.byKey(const Key('wrapper-tap'));
          await widgetTester.tap(button);
          await widgetTester.pump(const Duration(milliseconds: 800));

          expect(find.byType(SingleChildScrollView), findsOneWidget);
          expect(find.byType(ExpenseButton), findsOneWidget);
        },
      );
    },
  );
}
