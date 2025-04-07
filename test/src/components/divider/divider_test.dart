import 'package:mude_core/core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';

import '../../../wrapper.dart';

void main() {
  group(
    'Divider',
    () {
      testWidgets(
        'Should be render thin correctly',
        (widgetTester) async {
          final key = UniqueKey();

          await widgetTester.pumpWidget(
            Wrapper(
              child: MudeDivider.thin(key: key),
            ),
          );
          expect(find.byKey(key), findsOneWidget);
        },
      );
    },
  );
}
