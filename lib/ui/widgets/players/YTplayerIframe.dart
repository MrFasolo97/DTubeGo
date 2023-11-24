import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

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
    widget.controller.close();
    widget.controller.pause();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    widget.controller.onEnterFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.landscapeRight, DeviceOrientation.landscapeLeft]);
    };
    widget.controller.onExitFullscreen = () {
      SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp]);
    };
    return YoutubePlayerControllerProvider(
      controller: widget.controller,
      child: YoutubePlayerIFrame(
        controller: widget.controller,
        aspectRatio: 16 / 9,
      ),
    );
  }
}
