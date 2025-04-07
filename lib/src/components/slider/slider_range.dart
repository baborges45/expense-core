import 'package:mude_core/core.dart';
import './widgets/slider_label.dart';
import './widgets/thumb.dart';
import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';

import 'package:provider/provider.dart';

class MudeSliderRange extends StatefulWidget {
  /// A [RangeValues] value that represents the progress of the bar.
  final RangeValues values;

  /// A [ValueChanged] type [RangeValues] callback triggered when the progress bar is changed.
  final ValueChanged<RangeValues> onChange;

  /// The string represents the initial label displayed below the progress bar.
  /// It should be used in conjunction with the [finalValue] parameter.
  final String? initialValue;

  /// The string represents the final label displayed below the progress bar.
  /// It should be used in conjunction with the [initialValue] parameter.
  final String? finalValue;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  const MudeSliderRange({
    super.key,
    required this.onChange,
    required this.values,
    this.initialValue,
    this.finalValue,
    this.semanticsLabel,
    this.semanticsHint,
  });

  @override
  State<MudeSliderRange> createState() => MudeSliderRangeState();
}

class MudeSliderRangeState extends State<MudeSliderRange> {
  double _containerWidth = 0;
  bool isPressedStart = false;
  bool isPressedEnd = false;
  GlobalKey containerKey = GlobalKey();

  @override
  void initState() {
    SchedulerBinding.instance.addPostFrameCallback((timeStamp) {
      setState(() {
        _containerWidth = containerKey.currentContext!.size!.width;
      });
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;
    var size = globalTokens.shapes.size;
    var thumbSize = size.s2x;
    var lineSize = size.half;
    var startPoint = widget.values.start;
    var endPoint = widget.values.end;

    Widget getLabel() {
      if (widget.finalValue != null && widget.initialValue != null) {
        return SliderLabel(
          finalValue: widget.finalValue!,
          initialValue: widget.initialValue!,
        );
      }

      return const SizedBox.shrink();
    }

    void resetIsPressed() {
      setState(() {
        isPressedEnd = false;
        isPressedStart = false;
      });
    }

    void updateValue(double dx) {
      double newPosition = dx / _containerWidth;
      setState(
        () {
          double diffStart = (newPosition - widget.values.start).abs();
          double diffEnd = (newPosition - widget.values.end).abs();

          if (diffStart < diffEnd) {
            setState(() {
              isPressedStart = true;
            });
            widget.onChange(
              RangeValues(
                newPosition.clamp(0.0, widget.values.end),
                widget.values.end,
              ),
            );
          } else {
            setState(() {
              isPressedEnd = true;
            });
            widget.onChange(
              RangeValues(
                widget.values.start,
                newPosition.clamp(widget.values.start, 1.0),
              ),
            );
          }
        },
      );
    }

    return SizedBox(
      key: containerKey,
      width: MediaQuery.of(context).size.width,
      child: Column(
        children: [
          GestureDetector(
            onHorizontalDragUpdate: (DragUpdateDetails details) {
              resetIsPressed();
              updateValue(details.localPosition.dx);
            },
            onHorizontalDragEnd: (_) {
              resetIsPressed();
            },
            onTapDown: (details) {
              updateValue(details.localPosition.dx);
            },
            onTapUp: (_) {
              resetIsPressed();
            },
            child: Container(
              height: size.s6x,
              width: _containerWidth,
              color: Colors.transparent,
              alignment: Alignment.centerLeft,
              child: Stack(
                clipBehavior: Clip.none,
                children: [
                  Container(
                    width: _containerWidth,
                    height: lineSize,
                    color: aliasTokens.color.elements.bgColor02,
                  ),
                  Container(
                    width: _containerWidth * (endPoint - startPoint),
                    height: lineSize,
                    color: Colors.black,
                    margin: EdgeInsets.only(
                      left: _containerWidth * startPoint,
                    ),
                  ),
                  Positioned(
                    top: -(thumbSize / 2) + lineSize / 2,
                    left: startPoint * (_containerWidth - thumbSize),
                    key: const Key('range.start'),
                    child: Semantics(
                      slider: true,
                      label: 'Range Slider: ${widget.semanticsLabel}',
                      hint: widget.semanticsHint,
                      value: '${(startPoint * 100).round()}% ',
                      child: ThumbSlider(
                        isPressed: isPressedStart,
                      ),
                    ),
                  ),
                  Positioned(
                    top: -(thumbSize / 2) + lineSize / 2,
                    left: endPoint * (_containerWidth - thumbSize),
                    key: const Key('range.end'),
                    child: GestureDetector(
                      onTapDown: (e) {
                        setState(() {
                          isPressedEnd = true;
                        });
                      },
                      child: Semantics(
                        slider: true,
                        label: 'Range Slider: ${widget.semanticsLabel}',
                        hint: widget.semanticsHint,
                        value: '${(endPoint * 100).round()}% ',
                        child: ThumbSlider(
                          isPressed: isPressedEnd,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          getLabel(),
        ],
      ),
    );
  }
}
