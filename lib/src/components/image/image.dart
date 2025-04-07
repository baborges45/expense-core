// ignore_for_file: must_be_immutable

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:mude_core/core.dart';
import 'package:provider/provider.dart';

class MudeImage extends StatelessWidget {
  ///A string value that refers to the local or web path to load an image.
  final String src;

  /// A [MudeImageAspectRatio] objetc that defines the image aspect radio,
  /// The default value is [MudeImageAspectRatio.fillContainer].
  final MudeImageAspectRatio aspectRatio;

  /// A bool value that if true will make the image fill the container.
  /// The default value is false.
  final bool fillContainer;

  ///(Optional) A double value that represents the image width.
  /// The height will follow along with the proportions
  final double? width;

  ///A image repeat object that defines how to paint any portions of a box not covered by an image.
  ///The default value is [ImageRepeat.noRepeat].
  final ImageRepeat repeat;

  /// A [BoxFit] value that determines how the image should be fitted within its container.
  /// The default value is [BoxFit.cover].
  final BoxFit? fit;

  /// A [BorderRadius] object that represents the border radius of the image.
  final BorderRadius? borderRadius;

  /// A [MudeImageType] enum value that let you choose which type of source you will be using.
  /// It can be asset or network.
  late MudeImageType type;

  ///A string value that provides a descriptive label for accessibility purposes.
  ///The default value is null
  final String? semanticsLabel;

  ///A string value that indicates additional accessibility information.
  ///The default value is null
  final String? semanticsHint;

  ///A boolean value that determines whether to ignore automatic accessibility settings for the widget.
  ///The default value is false
  final bool excludeSemantics;

  /// With [asset] you must load an image locally
  MudeImage.asset(
    this.src, {
    super.key,
    this.aspectRatio = MudeImageAspectRatio.ratio_1x1,
    this.fillContainer = false,
    this.repeat = ImageRepeat.noRepeat,
    this.fit = BoxFit.cover,
    this.width,
    this.borderRadius,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
  }) {
    type = MudeImageType.asset;
  }

  /// With [network] you must load an image from the internet
  MudeImage.network(
    this.src, {
    super.key,
    this.aspectRatio = MudeImageAspectRatio.ratio_1x1,
    this.fillContainer = false,
    this.repeat = ImageRepeat.noRepeat,
    this.fit = BoxFit.cover,
    this.width,
    this.borderRadius,
    this.semanticsLabel,
    this.semanticsHint,
    this.excludeSemantics = false,
  }) {
    type = MudeImageType.network;
  }

  @override
  Widget build(BuildContext context) {
    var tokens = Provider.of<MudeThemeManager>(context);
    var globalTokens = tokens.globals;
    var aliasTokens = tokens.alias;

    _MudeImageAspectRatioSize getSize() {
      switch (aspectRatio) {
        case MudeImageAspectRatio.ratio_1x1:
          return _MudeImageAspectRatioSize(
            width: globalTokens.shapes.size.s5x,
            height: null,
            aspectRatio: 1 / 1,
          );
        case MudeImageAspectRatio.ratio_3x2:
          return _MudeImageAspectRatioSize(
            width: globalTokens.shapes.size.s4x,
            height: null,
            aspectRatio: 3 / 2,
          );
        case MudeImageAspectRatio.ratio_16x9:
          return _MudeImageAspectRatioSize(
            width: globalTokens.shapes.size.s8x,
            height: null,
            aspectRatio: 16 / 9,
          );
        case MudeImageAspectRatio.ratio_2x3:
          return _MudeImageAspectRatioSize(
            width: globalTokens.shapes.size.s4x,
            height: null,
            aspectRatio: 2 / 3,
          );
        case MudeImageAspectRatio.ratio_4x3:
          return _MudeImageAspectRatioSize(
            width: globalTokens.shapes.size.s4x,
            height: null,
            aspectRatio: 4 / 3,
          );
      }
    }

    Widget getImage() {
      double newBorderRadius = fillContainer ? globalTokens.shapes.border.radiusMd : aliasTokens.defaultt.borderRadius;

      BorderRadius borderRadiusChoice = borderRadius ?? BorderRadius.circular(newBorderRadius);

      switch (type) {
        case MudeImageType.asset:
          return Semantics(
            image: true,
            label: semanticsLabel,
            hint: semanticsHint,
            excludeSemantics: excludeSemantics,
            child: ClipRRect(
              borderRadius: borderRadiusChoice,
              child: Image.asset(
                src,
                fit: fit,
                repeat: repeat,
              ),
            ),
          );

        case MudeImageType.network:
          return Semantics(
            image: true,
            label: semanticsLabel,
            hint: semanticsHint,
            excludeSemantics: excludeSemantics,
            child: ClipRRect(
              borderRadius: borderRadiusChoice,
              child: CachedNetworkImage(
                imageUrl: src,
                fit: fit,
                repeat: repeat,
              ),
            ),
          );
      }
    }

    double? getSizeImage() {
      if (fillContainer) return null;

      return width ?? getSize().width;
    }

    return SizedBox(
      width: getSizeImage(),
      child: AspectRatio(
        aspectRatio: getSize().aspectRatio!,
        child: getImage(),
      ),
    );
  }
}

class _MudeImageAspectRatioSize {
  final double? width;
  final double? height;
  final double? aspectRatio;

  _MudeImageAspectRatioSize({
    required this.width,
    required this.height,
    required this.aspectRatio,
  });
}
