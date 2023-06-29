import 'package:auto_orientation/auto_orientation.dart';
import 'package:flutter/services.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';


class YoutubePlayerFullScreenPage extends StatefulWidget {
  final String link;

  YoutubePlayerFullScreenPage({Key? key, required this.link})
      : super(key: key);
  @override
  _YoutubePlayerFullScreenPageState createState() =>
      _YoutubePlayerFullScreenPageState(link);
}

class _YoutubePlayerFullScreenPageState
    extends State<YoutubePlayerFullScreenPage> {
  late YoutubePlayerController _controller;
  final String link;

  bool full = false;
  final UniqueKey youtubeKey = UniqueKey();

  _YoutubePlayerFullScreenPageState(this.link);

  @override
  void initState() {
    _controller = YoutubePlayerController.fromVideoId(
      autoPlay: true,
      videoId: widget.link,
      params: YoutubePlayerParams(
          showControls: false,
          showFullscreenButton: true,
          ),
    );
    AutoOrientation.landscapeAutoMode();
    super.initState();
  }

  @override
  void dispose() {
    _controller.pauseVideo();
    _controller.close();
    AutoOrientation.portraitAutoMode();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    _controller.loadVideoById(videoId: widget.link);
    _controller.setFullScreenListener((isFullscreen) {
      if(!isFullscreen) {
        dispose();
      }
    });
    return YoutubePlayerScaffold(
      enableFullScreenOnVerticalDrag: false,
      autoFullScreen: false,
      controller: _controller,
      defaultOrientations: [DeviceOrientation.landscapeLeft, DeviceOrientation.landscapeRight],
      builder: (context, player) {
        return Material(child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Stack(
              children: [
                Align(
                  alignment: Alignment.topCenter,
                  child: YoutubePlayer(
                      controller: _controller,
                      aspectRatio: 16 / 9,
                    ),
                )
              ],
            ),
          ),
        ));
      });
  }
}
