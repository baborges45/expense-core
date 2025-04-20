import 'dart:math';

import 'package:flutter/material.dart';
import 'package:expense_tokens/tokens.dart';
import 'package:provider/provider.dart';

class SeekBar extends StatefulWidget {
  final Duration duration;
  final Duration position;
  final Duration bufferedPosition;
  final ValueChanged<Duration>? onChanged;
  final ValueChanged<Duration>? onChangeEnd;
  final bool hideText;
  final bool inverse;

  const SeekBar({
    Key? key,
    required this.duration,
    required this.position,
    required this.bufferedPosition,
    this.onChanged,
    this.onChangeEnd,
    required this.hideText,
    required this.inverse,
  }) : super(key: key);

  @override
  SeekBarState createState() => SeekBarState();
}

class SeekBarState extends State<SeekBar> {
  double? _dragValue;
  late SliderThemeData _sliderThemeData;

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();

    _sliderThemeData = SliderTheme.of(context).copyWith(
      trackHeight: 2.0,
    );
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<ExpenseThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    final size = globalTokens.shapes.size;
    final colors = aliasTokens.color;

    final labelColor = colors.inverse.labelColor;
    final inverseBgColor = colors.inverse.bgColor;

    TextStyle textStyle = aliasTokens.mixin.labelMd2.merge(
      TextStyle(color: widget.inverse ? inverseBgColor : labelColor),
    );

    final duration = widget.duration.inMilliseconds.toDouble();

    final activeColor = widget.inverse ? inverseBgColor : colors.elements.bgColor01;
    final inactiveColor = activeColor.withAlpha(globalTokens.shapes.opacity.superLow * 255 ~/ 100);

    return SizedBox(
      width: MediaQuery.sizeOf(context).width,
      child: Column(
        children: [
          SizedBox(
            height: size.s1x,
            child: Stack(
              children: [
                Positioned(
                  child: SliderTheme(
                    data: _sliderThemeData.copyWith(
                      thumbShape: HiddenThumbComponentShape(),
                      activeTrackColor: activeColor,
                      inactiveTrackColor: inactiveColor,
                      trackShape: const RectangularSliderTrackShape(),
                      trackHeight: 2,
                      overlayShape: SliderComponentShape.noThumb,
                    ),
                    child: ExcludeSemantics(
                      child: Slider(
                        min: 0.0,
                        max: duration,
                        value: min(widget.bufferedPosition.inMilliseconds.toDouble(), duration),
                        onChanged: (value) {
                          setState(() {
                            _dragValue = value;
                          });
                          if (widget.onChanged != null) {
                            widget.onChanged!(Duration(milliseconds: value.round()));
                          }
                        },
                        onChangeEnd: (value) {
                          if (widget.onChangeEnd != null) {
                            widget.onChangeEnd!(Duration(milliseconds: value.round()));
                          }
                          _dragValue = null;
                        },
                      ),
                    ),
                  ),
                ),
                SliderTheme(
                  data: _sliderThemeData.copyWith(
                    activeTrackColor: activeColor,
                    thumbColor: activeColor,
                    disabledThumbColor: activeColor,
                    inactiveTrackColor: Colors.transparent,
                    thumbShape: RoundSliderThumbShape(enabledThumbRadius: size.s1x),
                    trackShape: const RectangularSliderTrackShape(),
                    trackHeight: 2,
                    overlayShape: SliderComponentShape.noThumb,
                  ),
                  child: Slider(
                    min: 0.0,
                    max: duration,
                    value: min(_dragValue ?? widget.position.inMilliseconds.toDouble(), duration),
                    onChanged: (value) {
                      setState(() {
                        _dragValue = value;
                      });
                      if (widget.onChanged != null) {
                        widget.onChanged!(Duration(milliseconds: value.round()));
                      }
                    },
                    onChangeEnd: (value) {
                      if (widget.onChangeEnd != null) {
                        widget.onChangeEnd!(Duration(milliseconds: value.round()));
                      }
                      _dragValue = null;
                    },
                  ),
                ),
              ],
            ),
          ),
          if (!widget.hideText) ...[
            SizedBox(
              height: size.s2x,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  _formatDuration(widget.position),
                  style: textStyle,
                ),
                Text(
                  _formatDuration(widget.duration),
                  style: textStyle,
                ),
              ],
            ),
          ],
        ],
      ),
    );
  }

  Duration get _remaining => widget.duration - widget.position;
}

String _formatDuration(Duration value) {
  int minutes = value.inMinutes;

  String twoDigits(int n) => n.toString().padLeft(2, "0");
  String oneOrTwoDigitMinutes = minutes.remainder(60) < 10 ? value.inMinutes.remainder(60).toString() : twoDigits(value.inMinutes.remainder(60));
  String twoDigitSeconds = twoDigits(value.inSeconds.remainder(60));

  return '$oneOrTwoDigitMinutes:$twoDigitSeconds';
}

class HiddenThumbComponentShape extends SliderComponentShape {
  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) => Size.zero;

  @override
  void paint(
    PaintingContext context,
    Offset center, {
    required Animation<double> activationAnimation,
    required Animation<double> enableAnimation,
    required bool isDiscrete,
    required TextPainter labelPainter,
    required RenderBox parentBox,
    required SliderThemeData sliderTheme,
    required TextDirection textDirection,
    required double value,
    required double textScaleFactor,
    required Size sizeWithOverflow,
  }) {}
}
