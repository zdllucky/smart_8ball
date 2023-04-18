import 'dart:math';

import 'package:flutter/cupertino.dart';

import '../c_r_t_glow_text.dart';

class TextResponse extends StatelessWidget {
  const TextResponse(this._text, {super.key, required this.animation});
  final String _text;
  final Animation<double> animation;

  @override
  Widget build(BuildContext context) => FittedBox(
        child: Transform.scale(
          scale: 1 / sqrt(2),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: _formatSquare(_text)
                  .map((e) => CRTGlowText(
                        e,
                        fontWeight: FontWeight.w500,
                        fontSize: 60,
                        blurRadius: animation.value.abs(),
                      ))
                  .toList()),
        ),
      );
}

List<String> _formatSquare(String input) {
  List<String> words = input.split(' ');
  int totalCharacters = input.length;

  // Calculate the optimal line length for a square-like shape
  int optimalLineLength = sqrt(totalCharacters * 2.5).ceil();

  StringBuffer result = StringBuffer();
  List<String> lines = [];
  int currentLineLength = 0;

  for (int i = 0; i < words.length; i++) {
    String word = words[i];

    if (currentLineLength + word.length <= optimalLineLength) {
      result.write(word);
      currentLineLength += word.length;
    } else {
      if (result.isNotEmpty) lines.add(result.toString().trim());
      result.clear();
      result.write(word);
      currentLineLength = word.length;
    }

    if (i < words.length - 1) {
      result.write(' ');
      currentLineLength++;
    }
  }

  if (result.isNotEmpty) lines.add(result.toString().trim());

  return lines;
}
