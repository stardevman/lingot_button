library animated_button;

import 'package:flutter/material.dart';

/// Using [ShadowDegree] with values [ShadowDegree.dark] or [ShadowDegree.light]
/// to get a darker version of the used color.
/// [duration] in milliseconds
///
class AnimatedButton extends StatefulWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final bool enabled;
  final Color color;
  final double height;
  final ShadowDegree shadowDegree;
  final int duration;
  final BoxShape shape;

  const AnimatedButton({
    Key? key,
    required this.onPressed,
    required this.child,
    this.enabled = true,
    this.color = Colors.blue,
    this.height = 36,
    this.shadowDegree = ShadowDegree.light,
    this.duration = 70,
    this.shape = BoxShape.rectangle,
  }) : super(key: key);

  @override
  _AnimatedButtonState createState() => _AnimatedButtonState();
}

class _AnimatedButtonState extends State<AnimatedButton> {
  Curve _curve = Curves.easeIn;
  double _shadowHeight = 4;
  double _position = 4;

  @override
  Widget build(BuildContext context) {
    final double _height = widget.height - _shadowHeight;

    return GestureDetector(
      onTapDown: widget.enabled ? _pressed : null,
      onTapUp: widget.enabled ? _unPressedOnTapUp : null,
      onTapCancel: widget.enabled ? _unPressed : null,
      child: LayoutBuilder(
        builder: (BuildContext context, BoxConstraints constraints) {
          return Container(
            height: _height + _shadowHeight,
            child: Stack(
              alignment: Alignment.center,
              children: [
                Positioned(
                  bottom: 0,
                  child: Container(
                    height: _height,
                    constraints: BoxConstraints(
                      minWidth: constraints.minWidth,
                    ),
                    decoration: BoxDecoration(
                      shape: widget.shape,
                      color: widget.enabled
                          ? darken(widget.color, widget.shadowDegree)
                          : darken(Colors.grey, widget.shadowDegree),
                      borderRadius: widget.shape != BoxShape.circle
                          ? BorderRadius.all(Radius.circular(16))
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(child: widget.child),
                    ),
                  ),
                ),
                AnimatedPositioned(
                  bottom: _position,
                  curve: _curve,
                  duration: Duration(milliseconds: widget.duration),
                  child: Container(
                    height: _height,
                    constraints: BoxConstraints(
                      minWidth: constraints.minWidth,
                    ),
                    decoration: BoxDecoration(
                      shape: widget.shape,
                      color: widget.enabled ? widget.color : Colors.grey,
                      borderRadius: widget.shape != BoxShape.circle
                          ? BorderRadius.all(Radius.circular(16))
                          : null,
                    ),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 10),
                      child: Center(child: widget.child),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  void _pressed(_) {
    setState(() {
      _position = 0;
    });
  }

  void _unPressedOnTapUp(_) => _unPressed();

  void _unPressed() {
    setState(() {
      _position = 4;
    });
    widget.onPressed!();
  }
}

// Get a darker color from any entered color.
// Thanks to @NearHuscarl on StackOverflow
Color darken(Color color, ShadowDegree degree) {
  final amount = degree == ShadowDegree.dark ? 0.3 : 0.12;
  final hsl = HSLColor.fromColor(color);
  final hslDark = hsl.withLightness((hsl.lightness - amount).clamp(0.0, 1.0));

  return hslDark.toColor();
}

enum ShadowDegree { light, dark }
