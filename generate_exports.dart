// ignore_for_file: avoid_print

import 'dart:io';

void main() {
  const fileExports = 'lib/core.dart';
  final directory = Directory('lib/src/components');
  final List<String> ignoreDirectories = [
    'docs',
    'widgets',
    'mixins',
    'validations',
    'utils',
    'input_formatters',
  ];

  final List<String> exportsWidgets = [];
  final List<String> exportsModels = [];
  final List<String> exportsTypes = [];

  bool filterDir(FileSystemEntity entity) {
    return ignoreDirectories.every((dir) => !entity.path.contains('/$dir/'));
  }

  void updateFileExport(String content) {
    final file = File(fileExports);
    file.readAsStringSync();
    file.writeAsStringSync(content, mode: FileMode.write);

    print('Exportação finalizada!');
  }

  directory.listSync(recursive: true).forEach((entity) {
    if (entity is File && entity.path.endsWith('.dart') && filterDir(entity)) {
      String newPath = 'export \'${entity.path.replaceAll('lib/', '')}\';';

      if (entity.path.contains('models')) {
        exportsModels.add(newPath);
      } else if (entity.path.contains('types')) {
        exportsTypes.add(newPath);
      } else {
        exportsWidgets.add(newPath);
      }
    }
  });

  String n = '\n';
  List<String> exportContent = [
    'library expense_core;$n',
    n,
    '// Libs$n',
    'export \'package:ds_assets/assets.dart\';$n',
    'export \'package:ds_tokens/tokens.dart\';$n',
    n,
    '// Components$n',
    exportsWidgets.join(n),
    n,
    n,
    '// Models$n',
    exportsModels.join(n),
    n,
    n,
    '// Types$n',
    exportsTypes.join(n),
  ];

  updateFileExport(exportContent.join(''));
}
