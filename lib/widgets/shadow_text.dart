import 'package:flutter/material.dart';

class ShadowText extends StatelessWidget {
  final double offset;
  final String text;
  final TextStyle style;
  final TextAlign textAlign;

  ShadowText(this.text,
      {Key key, @required this.offset, TextStyle style, TextAlign textAlign})
      : this.style = style,
        this.textAlign = textAlign,
        super(key: key);

  @override
  Widget build(BuildContext context) {
    return Text(
      text,
      textAlign: textAlign,
      style: style.apply(
        shadows: [
          Shadow(
            color: Colors.black.withAlpha(69),
            offset: Offset(0, offset),
          ),
        ],
      ),
    );
  }
}
