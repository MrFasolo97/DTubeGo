import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class YTPlayerIFrame extends StatefulWidget {
  YTPlayerIFrame(
      {Key? key,
      required this.videoUrl,
      required this.autoplay,
      required this.allowFullscreen,
      required this.controller})
      : super(key: key);
  final YoutubePlayerController controller;
  final String videoUrl;
  final bool autoplay;
  final bool allowFullscreen;

  @override
  _YTPlayerIFrameState createState() => _YTPlayerIFrameState();
}

class _YTPlayerIFrameState extends State<YTPlayerIFrame> {
  // late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
  }

  // @override
  // void deactivate() {
  //   _controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    widget.controller.pause();
    widget.controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    var _ytPlayer = YoutubePlayer(controller: widget.controller);
    return YoutubePlayerBuilder(
      player: _ytPlayer,
      builder: (BuildContext context, Widget widget) {
        return widget;
      },

    );
  }
}
