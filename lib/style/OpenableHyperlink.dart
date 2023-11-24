import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class OpenableHyperlink extends StatelessWidget {
  final String url;
  final String? alt;
  final TextStyle? style;
  int? maxLines;
  OpenableHyperlink(
      {required this.url, this.style, this.alt, Key? key, this.maxLines})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
        child: Text(
          alt != null ? alt! : url,
          overflow: TextOverflow.ellipsis,
          style: style != null ? style : Theme.of(context).textTheme.labelSmall,
          maxLines: maxLines != null ? maxLines! : 3,
        ),
        onTap: () async {
          await canLaunchUrl(Uri.parse(url))
              ? await launchUrl(Uri.parse(url))
              : throw 'Could not launch $url';
        });
  }
}
