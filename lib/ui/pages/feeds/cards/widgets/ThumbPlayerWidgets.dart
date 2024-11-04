import 'package:ovh.fso.dtubego/ui/widgets/players/P2PSourcePlayer/P2PSourcePlayer.dart';
import 'package:ovh.fso.dtubego/ui/widgets/players/YTplayerIframe.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;
import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/DTubeLogo.dart';
import 'package:ovh.fso.dtubego/utils/Random/randomGenerator.dart';
import 'package:flutter/material.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
import 'package:video_player/video_player.dart';
import 'package:webview_flutter/webview_flutter.dart';
import 'package:webview_flutter_platform_interface/webview_flutter_platform_interface.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class PlayerWidget extends StatelessWidget {
  PlayerWidget({
    Key? key,
    required bool thumbnailTapped,
    required this.videoSource,
    required this.videoUrl,
    required VideoPlayerController bpController,
    required YoutubePlayerController ytController,
    required this.placeholderSize,
    required this.placeholderWidth,
  })  : _thumbnailTapped = thumbnailTapped,
        _bpController = bpController,
        _ytController = ytController,
        super(key: key);

  final bool _thumbnailTapped;
  final String videoSource;
  final String videoUrl;
  final VideoPlayerController _bpController;
  final YoutubePlayerController _ytController;
  final double placeholderWidth;
  final double placeholderSize;

  Widget choosePlayer() {
    if (["sia", "ipfs"].contains(videoSource) && videoUrl != "") {
      // AspectRatio(
      //     aspectRatio: 16 / 9,
      // child:
      return P2PSourcePlayer(
          videoUrl: videoUrl,
          autoplay: false,
          looping: false,
          localFile: false,
          controls: true,
          usedAsPreview: false,
          allowFullscreen: true,
          portraitVideoPadding: 33.w,
          videocontroller: _bpController,
          placeholderWidth: placeholderWidth,
          placeholderSize: placeholderSize,
          // ),
        );
    } else if (videoSource == 'youtube' && videoUrl != "") {
      return YTPlayerIFrame(
        videoUrl: videoUrl,
        autoplay: false,
        allowFullscreen: false,
        controller: _ytController,
      ) as Widget;
    } else if (videoSource == "dailymotion" && videoUrl != "") {
    WebViewController webController = WebViewController();
        WebViewWidget webWidget = WebViewWidget(controller: webController);
        webController.loadHtmlString('<html><body>' +
    '<iframe id="player" frameborder="0" allowfullscreen="true" title="Dailymotion video player" width="100%" height="100%" src="https://www.dailymotion.com/embed/video/'+videoUrl+'?api=postMessage&amp;id=player&amp;mute=false;&amp;queue-enable=false"></iframe>' +
    '</body></html>');
        return webWidget;
    } else {
    return Text("no player detected") as Widget;
    }
  }

  @override
  Widget build(BuildContext context) {
    return choosePlayer();
  }
}



class ThumbnailWidget extends StatelessWidget {
  const ThumbnailWidget({
    Key? key,
    required bool thumbnailTapped,
    required this.blur,
    required this.thumbUrl,
  })  : _thumbnailTapped = thumbnailTapped,
        super(key: key);

  final bool _thumbnailTapped;
  final bool blur;
  final String thumbUrl;

  @override
  Widget build(BuildContext context) {
    return Visibility(
      visible: !_thumbnailTapped,
      child: AspectRatio(
        aspectRatio: 16 / 9,
        child: blur
            ? ClipRect(
                child: ImageFiltered(
                  imageFilter: ImageFilter.blur(
                    sigmaY: 5,
                    sigmaX: 5,
                  ),
                  child: CachedNetworkImage(
                    fit: BoxFit.fitWidth,
                    imageUrl: thumbUrl,
                    errorWidget: (context, url, error) => DTubeLogo(
                      size: 50,
                    ),
                  ),
                ),
              )
            : globals.disableAnimations
                ? ThumbnailContainer(thumbUrl: thumbUrl)
                : Shimmer(
                    duration: Duration(seconds: 5),
                    interval: Duration(seconds: generateRandom(3, 15)),
                    color: globalAlmostWhite,
                    colorOpacity: 0.1,
                    child: ThumbnailContainer(thumbUrl: thumbUrl)),
      ),
    );
  }
}

class ThumbnailContainer extends StatelessWidget {
  const ThumbnailContainer({
    Key? key,
    required this.thumbUrl,
  }) : super(key: key);

  final String thumbUrl;

  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      imageUrl: thumbUrl,
      fit: BoxFit.fitWidth,
      errorWidget: (context, url, error) => DTubeLogo(
        size: 50,
      ),
    );
  }
}
