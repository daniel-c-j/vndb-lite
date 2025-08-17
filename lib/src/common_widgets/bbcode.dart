import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher_string.dart';
import 'package:vndb_lite/src/util/context_shortcut.dart';

// TODO bbcode

enum BBcode { b, i, u, s, url, spoiler }

class BBCodedDescription extends StatefulWidget {
  const BBCodedDescription({super.key, required this.desc});

  final String desc;

  @override
  State<BBCodedDescription> createState() => _BBCodedDescriptionState();
}

class _BBCodedDescriptionState extends State<BBCodedDescription> {
  final RegExp regex = RegExp(r"\[[b|i|u|s|url|spoiler]\](.*?)\[\/[b|i|u|s|url|spoiler]\]");

  final unSpoiledText = [];

  void _toggleTextSpoiler(String txt) {
    setState(() {
      if (unSpoiledText.contains(txt)) {
        unSpoiledText.remove(txt);
      } else {
        unSpoiledText.add(txt);
      }
    });
  }

  TextSpan _formatDesc(String text) {
    // String input = "Hello [b]everyone[/b]!";
    // final RegExp regex = RegExp(r"\[[b|s]\](.*?)\[\/b\]", unicode: true);
    // RegExp regex = RegExp(r'\[b\](.*?)\[\/b\]');

    final List<TextSpan> spans = [];
    int lastIndex = 0;

    for (final match in regex.allMatches(text)) {
      // Add the text before the match
      if (match.start > lastIndex) {
        spans.add(
          TextSpan(
            text: text.substring(lastIndex, match.start),
            style: TextStyle(color: kColor().tertiary),
          ),
        );
      }

      // Determine the style based on the tag
      GestureRecognizer? recognizer;
      TextStyle style = TextStyle();

      final textToStyle = match.group(1) ?? "";
      print(textToStyle);
      if (textToStyle == "b") {
        style = TextStyle(fontWeight: FontWeight.bold);
      }
      // try {
      //   switch (BBcode.values.byName(textToStyle)) {
      //     case BBcode.b:
      //       style = TextStyle(fontWeight: FontWeight.bold);
      //       break;
      //     case BBcode.i:
      //       style = TextStyle(fontStyle: FontStyle.italic);
      //       break;
      //     case BBcode.u:
      //       style = TextStyle(decoration: TextDecoration.underline);
      //       break;
      //     case BBcode.s:
      //       style = TextStyle(decoration: TextDecoration.lineThrough);
      //       break;
      //     case BBcode.url:
      //       style = TextStyle(fontWeight: FontWeight.w500);
      //       recognizer = TapGestureRecognizer()..onTap = () => launchUrlString(textToStyle);
      //       break;
      //     case BBcode.spoiler:
      //       if (!unSpoiledText.contains(textToStyle)) {
      //         style = TextStyle(backgroundColor: kColor().tertiary);
      //       }
      //       recognizer = TapGestureRecognizer()..onTap = () => _toggleTextSpoiler(textToStyle);
      //       break;
      //   }
      // } catch (e) {
      //   style = TextStyle(backgroundColor: kColor().tertiary);
      // }

      // Add span
      spans.add(
        TextSpan(
          text: textToStyle,
          style: style.copyWith(color: kColor().secondary),
          recognizer: recognizer,
        ),
      );
      lastIndex = match.end;
    }

    // Add any remaining text after the last match
    if (lastIndex < text.length) {
      spans.add(
        TextSpan(text: text.substring(lastIndex), style: TextStyle(color: kColor().tertiary)),
      );
    }

    return TextSpan(children: spans);
  }

  @override
  Widget build(BuildContext context) {
    return RichText(text: _formatDesc(widget.desc));
  }
}
