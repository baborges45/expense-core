import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class Wrapper extends StatelessWidget {
  final Widget child;
  final Function(MudeThemeManager tokens)? onTokens;
  final Function(BuildContext context)? onTap;
  final Function(BuildContext context)? onContext;

  const Wrapper({
    super.key,
    required this.child,
    this.onTokens,
    this.onTap,
    this.onContext,
  });

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (_) => MudeThemeManager(
            theme: MudeThemeOptions.default_theme,
            mode: MudeThemeMode.light,
          ),
        ),
      ],
      child: MaterialApp(
        home: WrapperHome(
          onTokens: onTokens,
          onTap: onTap,
          onContext: onContext,
          child: child,
        ),
      ),
    );
  }
}

class WrapperHome extends StatelessWidget {
  final Widget child;
  final Function(MudeThemeManager tokens)? onTokens;
  final Function(BuildContext context)? onTap;
  final Function(BuildContext context)? onContext;

  const WrapperHome({
    super.key,
    required this.child,
    this.onTokens,
    this.onTap,
    this.onContext,
  });

  @override
  Widget build(BuildContext context) {
    MudeThemeManager tokens = Provider.of<MudeThemeManager>(context);

    if (onTokens != null) {
      onTokens!(tokens);
    }

    if (onContext != null) {
      onContext!(context);
    }

    Widget getDrawerChild() {
      return Center(
        child: ElevatedButton(
          key: const Key('wrapper-tap'),
          child: const Text('Open Child'),
          onPressed: () {
            if (onTap != null) {
              onTap!(context);
            }
          },
        ),
      );
    }

    return Scaffold(body: onTap != null ? getDrawerChild() : child);
  }
}
