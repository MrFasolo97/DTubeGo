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

  final String videoUrl;
  final bool autoplay;
  final bool allowFullscreen;
  final YoutubePlayerController controller;

  @override
  _YTPlayerIFrameState createState() => _YTPlayerIFrameState();
}

class _YTPlayerIFrameState extends State<YTPlayerIFrame> {
  // late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    widget.controller.setFullScreenListener((isFullScreen) {
      if (isFullScreen) {
        SystemChrome.setPreferredOrientations([
          DeviceOrientation.landscapeLeft,
          DeviceOrientation.landscapeRight,
        ]);
        print('Entered Fullscreen');
      } else {
        print('Exited Fullscreen');
      }
    });
  }

  // @override
  // void deactivate() {
  //   _controller.pause();
  //   super.deactivate();
  // }

  @override
  void dispose() {
    widget.controller.close();
    widget.controller.pauseVideo();
    super.dispose();
  }

  @override
  YoutubePlayer build(BuildContext context) {
    //const _player = YoutubePlayerIFrame();
    YoutubePlayerController _controller = YoutubePlayerController.fromVideoId(videoId: widget.videoUrl,
      params: YoutubePlayerParams(
        origin: "https://www.youtube.com",
        showControls: true,
        showFullscreenButton: true,
      ),
    );
    return YoutubePlayer(
      controller: _controller,
      aspectRatio: 16 / 9,
    );
  }
}
