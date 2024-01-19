<<<<<<< HEAD
import 'dart:developer';

import 'package:ovh.fso.dtubego/ui/pages/feeds/cards/widgets/ThumbPlayerWidgets.dart';
import 'package:ovh.fso.dtubego/ui/widgets/UnsortedCustomWidgets.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;

import 'dart:io';
import 'package:ovh.fso.dtubego/bloc/user/user_bloc_full.dart';
=======
import 'package:dtube_go/ui/widgets/UnsortedCustomWidgets.dart';
import 'package:dtube_go/utils/GlobalStorage/globalVariables.dart' as globals;

import 'dart:io';
import 'package:dtube_go/bloc/user/user_bloc_full.dart';
import 'package:dtube_go/style/ThemeData.dart';
import 'package:dtube_go/ui/widgets/dtubeLogoPulse/DTubeLogo.dart';
import 'package:dtube_go/utils/Random/randomGenerator.dart';
>>>>>>> edcb13a (post details now rsposnive #2)
import 'package:flutter/foundation.dart';
import 'package:flutter_animator/flutter_animator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
<<<<<<< HEAD

import 'package:ovh.fso.dtubego/ui/widgets/AccountAvatar.dart';
import 'package:ovh.fso.dtubego/utils/Navigation/navigationShortcuts.dart';
import 'package:flutter/material.dart';
=======
import 'package:dtube_go/ui/widgets/players/P2PSourcePlayer.dart';
import 'dart:ui';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dtube_go/ui/widgets/players/YTplayerIframe.dart';
import 'package:dtube_go/ui/widgets/AccountAvatar.dart';
import 'package:dtube_go/utils/Navigation/navigationShortcuts.dart';
import 'package:flutter/material.dart';
import 'package:shimmer_animation/shimmer_animation.dart';
>>>>>>> edcb13a (post details now rsposnive #2)
import 'package:video_player/video_player.dart';
import 'package:visibility_detector/visibility_detector.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class NewsPostListCard extends StatefulWidget {
<<<<<<< HEAD
  const NewsPostListCard(
      {Key? key,
      required this.thumbnailUrl,
      required this.title,
      required this.description,
      required this.author,
      required this.link,
      required this.publishDate,
      required this.videoUrl,
      required this.videoSource,
      required this.indexOfList,
      required this.mainTag,
      required this.oc,
      required this.autoPauseVideoOnPopup,
      required this.crossAxisCount})
      : super(key: key);

=======
  const NewsPostListCard({
    Key? key,
    required this.blur,
    required this.thumbnailUrl,
    required this.title,
    required this.description,
    required this.author,
    required this.link,
    required this.publishDate,
    required this.duration,
    required this.dtcValue,
    required this.videoUrl,
    required this.videoSource,
    required this.alreadyVoted,
    required this.alreadyVotedDirection,
    required this.upvotesCount,
    required this.downvotesCount,
    required this.indexOfList,
    required this.mainTag,
    required this.oc,
    required this.autoPauseVideoOnPopup,
  }) : super(key: key);

  final bool blur;
>>>>>>> edcb13a (post details now rsposnive #2)
  final bool autoPauseVideoOnPopup;
  final String thumbnailUrl;
  final String title;
  final String description;
  final String author;
  final String link;
  final String publishDate;
<<<<<<< HEAD

  final String videoUrl;
  final String videoSource;

  final int indexOfList;
  final String mainTag;
  final bool oc;
  final int crossAxisCount;
=======
  final Duration duration;
  final String dtcValue;
  final String videoUrl;
  final String videoSource;
  final bool alreadyVoted;
  final bool alreadyVotedDirection;
  final int upvotesCount;
  final int downvotesCount;
  final int indexOfList;
  final String mainTag;
  final bool oc;
>>>>>>> edcb13a (post details now rsposnive #2)

  @override
  _NewsPostListCardState createState() => _NewsPostListCardState();
}

class _NewsPostListCardState extends State<NewsPostListCard> {
<<<<<<< HEAD
=======
  double _avatarSize = 10.w;
>>>>>>> edcb13a (post details now rsposnive #2)
  bool _thumbnailTapped = false;
  TextEditingController _replyController = new TextEditingController();
  TextEditingController _giftMemoController = new TextEditingController();
  TextEditingController _giftDTCController = new TextEditingController();

  late bool _showVotingBars;

  late bool _votingDirection; // true = upvote | false = downvote

  late bool _showCommentInput;
  late bool _showGiftInput;

  late UserBloc _userBloc;
  int _currentVp = 0;
  late VideoPlayerController _bpController;
  late YoutubePlayerController _ytController;

  @override
  void initState() {
    super.initState();
    _showVotingBars = false;
    _votingDirection = true;
    _showCommentInput = false;
    _showGiftInput = false;
    _userBloc = BlocProvider.of<UserBloc>(context);
    _bpController = VideoPlayerController.asset('assets/videos/firstpage.mp4');
    _ytController = YoutubePlayerController(
      initialVideoId: widget.videoUrl,
      params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: true,
<<<<<<< HEAD
          desktopMode: kIsWeb ? true : !Platform.isIOS && !Platform.isAndroid,
          privacyEnhanced: true,
          useHybridComposition: false,
          autoPlay: true,
      ),
=======
          desktopMode: kIsWeb ? true : !Platform.isIOS,
          privacyEnhanced: true,
          useHybridComposition: true,
          autoPlay: true),
>>>>>>> edcb13a (post details now rsposnive #2)
    );
  }

  @override
  void dispose() {
    _replyController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return VisibilityDetector(
      key: Key('newslist-large' + widget.link),
      onVisibilityChanged: (visibilityInfo) {
        var visiblePercentage = visibilityInfo.visibleFraction * 100;

        if (visiblePercentage < 95 &&
            !_showCommentInput &&
            !_showGiftInput &&
            !_showVotingBars) {
          _ytController.pause();
          _bpController.pause();
<<<<<<< HEAD
          log("VISIBILITY OF " +
=======
          print("VISIBILITY OF " +
>>>>>>> edcb13a (post details now rsposnive #2)
              widget.author +
              "/" +
              widget.link +
              "CHANGED TO " +
              visiblePercentage.toString());
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: MobilePostData(
          thumbnailTapped: _thumbnailTapped,
<<<<<<< HEAD
          author: widget.author,
          link: widget.link,
          publishDate: widget.publishDate,
          title: widget.title,
          bpController: _bpController,
          ytController: _ytController,
          userBloc: _userBloc,
          thumbUrl: widget.thumbnailUrl,
          videoSource: widget.videoSource,
          videoUrl: widget.videoUrl,
          crossAxisCount: widget.crossAxisCount,
=======
          widget: widget,
          bpController: _bpController,
          ytController: _ytController,
          showVotingBars: _showVotingBars,
          userBloc: _userBloc,
          votingDirection: _votingDirection,
          showCommentInput: _showCommentInput,
          replyController: _replyController,
          showGiftInput: _showGiftInput,
          giftDTCController: _giftDTCController,
          giftMemoController: _giftMemoController,
          avatarSize: _avatarSize,
          blur: widget.blur,
          thumbUrl: widget.thumbnailUrl,
          videoSource: widget.videoSource,
          videoUrl: widget.videoUrl,
>>>>>>> edcb13a (post details now rsposnive #2)
          thumbnailTappedCallback: () {
            setState(() {
              _thumbnailTapped = true;
            });
          },
<<<<<<< HEAD
=======
          votingOpenCallback: () {
            setState(() {
              _showVotingBars = false;
            });
          },
          commentOpenCallback: () {
            setState(() {
              _showCommentInput = false;
              _replyController.text = '';
            });
          },
          giftOpenCallback: () {
            setState(() {
              _showGiftInput = false;
            });
          },
>>>>>>> edcb13a (post details now rsposnive #2)
        ),
      ),
    );
  }
}

class MobilePostData extends StatefulWidget {
  MobilePostData(
      {Key? key,
      required bool thumbnailTapped,
<<<<<<< HEAD
      required VideoPlayerController bpController,
      required YoutubePlayerController ytController,
      required UserBloc userBloc,
      required this.thumbnailTappedCallback,
      required this.author,
      required this.link,
      required this.title,
      required this.publishDate,
      required this.videoSource,
      required this.videoUrl,
      required this.thumbUrl,
      required this.crossAxisCount})
      : _thumbnailTapped = thumbnailTapped,
        _bpController = bpController,
        _ytController = ytController,
        super(key: key);

  final bool _thumbnailTapped;
  final VideoPlayerController _bpController;

  final YoutubePlayerController _ytController;

  final String author;
  final String link;
  final String publishDate;
  final String title;

  final VoidCallback thumbnailTappedCallback;

  final String videoSource;
  final String videoUrl;

  final String thumbUrl;
  final int crossAxisCount;
=======
      required this.widget,
      required VideoPlayerController bpController,
      required YoutubePlayerController ytController,
      required bool showVotingBars,
      required UserBloc userBloc,
      required bool votingDirection,
      required bool showCommentInput,
      required TextEditingController replyController,
      required bool showGiftInput,
      required TextEditingController giftDTCController,
      required TextEditingController giftMemoController,
      required double avatarSize,
      required this.thumbnailTappedCallback,
      required this.votingOpenCallback,
      required this.commentOpenCallback,
      required this.giftOpenCallback,
      required this.videoSource,
      required this.videoUrl,
      required this.thumbUrl,
      required this.blur})
      : _thumbnailTapped = thumbnailTapped,
        _bpController = bpController,
        _ytController = ytController,
        _showVotingBars = showVotingBars,
        _userBloc = userBloc,
        _votingDirection = votingDirection,
        _showCommentInput = showCommentInput,
        _replyController = replyController,
        _showGiftInput = showGiftInput,
        _giftDTCController = giftDTCController,
        _giftMemoController = giftMemoController,
        _avatarSize = avatarSize,
        super(key: key);

  final bool _thumbnailTapped;
  final NewsPostListCard widget;
  final VideoPlayerController _bpController;

  final YoutubePlayerController _ytController;
  bool _showVotingBars;
  final UserBloc _userBloc;
  final bool _votingDirection;
  bool _showCommentInput;
  final TextEditingController _replyController;
  bool _showGiftInput;
  final TextEditingController _giftDTCController;
  final TextEditingController _giftMemoController;
  final double _avatarSize;
  VoidCallback thumbnailTappedCallback;
  VoidCallback votingOpenCallback;
  VoidCallback commentOpenCallback;
  VoidCallback giftOpenCallback;
  String videoSource;
  String videoUrl;
  bool blur;
  String thumbUrl;
>>>>>>> edcb13a (post details now rsposnive #2)

  @override
  State<MobilePostData> createState() => _MobilePostDataState();
}

class _MobilePostDataState extends State<MobilePostData> {
  @override
  Widget build(BuildContext context) {
    return DTubeFormCard(
      avoidAnimation: true,
      waitBeforeFadeIn: Duration(seconds: 0),
      childs: [
        InkWell(
          onTap: () {
<<<<<<< HEAD
            if (widget.videoSource != "") {
              widget.thumbnailTappedCallback();
            }
=======
            widget.thumbnailTappedCallback();
>>>>>>> edcb13a (post details now rsposnive #2)
          },
          child: Stack(
            alignment: Alignment.topCenter,
            children: [
              ThumbnailWidget(
                  thumbnailTapped: widget._thumbnailTapped,
<<<<<<< HEAD
                  blur: false,
=======
                  blur: widget.blur,
>>>>>>> edcb13a (post details now rsposnive #2)
                  thumbUrl: widget.thumbUrl),
              PlayerWidget(
                thumbnailTapped: widget._thumbnailTapped,
                bpController: widget._bpController,
                videoSource: widget.videoSource,
                videoUrl: widget.videoUrl,
                ytController: widget._ytController,
                placeholderWidth: 100.w,
                placeholderSize: 40.w,
              ),
            ],
          ),
        ),
        PostInfoBaseRow(
<<<<<<< HEAD
          videoController: widget._bpController,
          ytController: widget._ytController,
          author: widget.author,
          link: widget.link,
          title: widget.title,
          crossAxisCount: widget.crossAxisCount,
        ),
        globals.disableAnimations
            ? PostInfoDetailsRow(
                author: widget.author,
                publishDate: widget.publishDate,
=======
          avatarSize: widget._avatarSize,
          widget: widget.widget,
          videoController: widget._bpController,
          ytController: widget._ytController,
        ),
        globals.disableAnimations
            ? PostInfoDetailsRow(
                widget: widget.widget,
>>>>>>> edcb13a (post details now rsposnive #2)
              )
            : FadeInDown(
                preferences:
                    AnimationPreferences(offset: Duration(milliseconds: 500)),
<<<<<<< HEAD
                child: PostInfoDetailsRow(
                  author: widget.author,
                  publishDate: widget.publishDate,
=======
                child: Padding(
                  padding: EdgeInsets.only(left: 12.w),
                  child: PostInfoDetailsRow(
                    widget: widget.widget,
                  ),
>>>>>>> edcb13a (post details now rsposnive #2)
                ),
              ),
        SizedBox(height: 1.h),
      ],
    );
  }
}

class PostInfoDetailsRow extends StatelessWidget {
<<<<<<< HEAD
  const PostInfoDetailsRow(
      {Key? key, required this.author, required this.publishDate})
      : super(key: key);

  final String author;
  final String publishDate;
=======
  const PostInfoDetailsRow({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final NewsPostListCard widget;
>>>>>>> edcb13a (post details now rsposnive #2)

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Text(
<<<<<<< HEAD
          '@${author}',
          style: Theme.of(context).textTheme.bodyMedium,
=======
          '@${widget.author}',
          style: Theme.of(context).textTheme.bodyText2,
>>>>>>> edcb13a (post details now rsposnive #2)
          overflow: TextOverflow.ellipsis,
        ),
        Row(
          children: [
            Text(
<<<<<<< HEAD
              publishDate,
              style: Theme.of(context).textTheme.bodyMedium,
=======
              '${widget.publishDate}',
              style: Theme.of(context).textTheme.bodyText2,
            ),
            Text(
              ' - ' +
                  (widget.duration.inHours == 0
                      ? widget.duration.toString().substring(2, 7) + ' min'
                      : widget.duration.toString().substring(0, 7) + ' h'),
              style: Theme.of(context).textTheme.bodyText2,
>>>>>>> edcb13a (post details now rsposnive #2)
            ),
          ],
        ),
      ],
    );
  }
}

class PostInfoBaseRow extends StatelessWidget {
<<<<<<< HEAD
  PostInfoBaseRow(
      {Key? key,
      required this.ytController,
      required this.videoController,
      required this.author,
      required this.link,
      required this.title,
      required this.crossAxisCount})
      : super(key: key);

  YoutubePlayerController ytController;
  VideoPlayerController videoController;
  final String author;
  final String link;
  final String title;
  final int crossAxisCount;
=======
  PostInfoBaseRow({
    Key? key,
    required this.widget,
    required double avatarSize,
    required this.ytController,
    required this.videoController,
  })  : _avatarSize = avatarSize,
        super(key: key);

  final NewsPostListCard widget;

  final double _avatarSize;
  YoutubePlayerController ytController;
  VideoPlayerController videoController;
>>>>>>> edcb13a (post details now rsposnive #2)

  @override
  Widget build(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.center,
<<<<<<< HEAD
      mainAxisAlignment: MainAxisAlignment.start,
      children: <Widget>[
        Row(
          mainAxisAlignment: MainAxisAlignment.start,
          children: [
            globals.disableAnimations
                ? AuthorContainer(
                    author: author,
                    avatarSize: crossAxisCount == 1 ? 10.w : 3.w,
                  )
=======
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: <Widget>[
        Row(
          children: [
            globals.disableAnimations
                ? BaseRowContainer(widget: widget, avatarSize: _avatarSize)
>>>>>>> edcb13a (post details now rsposnive #2)
                : FadeIn(
                    preferences: AnimationPreferences(
                        offset: Duration(milliseconds: 500),
                        duration: Duration(seconds: 1)),
<<<<<<< HEAD
                    child: AuthorContainer(
                      author: author,
                      avatarSize: crossAxisCount == 1 ? 10.w : 3.w,
                    )),
            // SizedBox(width: 1.w),
            globals.disableAnimations
                ? TitleContainer(
                    author: author,
                    link: link,
                    title: title,
                    crossAxisCount: crossAxisCount,
                  )
=======
                    child: BaseRowContainer(
                        widget: widget, avatarSize: _avatarSize),
                  ),
            SizedBox(width: 2.w),
            globals.disableAnimations
                ? TitleWidgetForRow(widget: widget)
>>>>>>> edcb13a (post details now rsposnive #2)
                : FadeInLeftBig(
                    preferences: AnimationPreferences(
                      offset: Duration(milliseconds: 100),
                      duration: Duration(milliseconds: 350),
                    ),
<<<<<<< HEAD
                    child: TitleContainer(
                      author: author,
                      link: link,
                      title: title,
                      crossAxisCount: crossAxisCount,
                    )),
=======
                    child: TitleWidgetForRow(widget: widget),
                  ),
>>>>>>> edcb13a (post details now rsposnive #2)
          ],
        ),
      ],
    );
  }
}

<<<<<<< HEAD
class AuthorContainer extends StatelessWidget {
  const AuthorContainer({
    Key? key,
    required this.author,
=======
class BaseRowContainer extends StatelessWidget {
  const BaseRowContainer({
    Key? key,
    required this.widget,
>>>>>>> edcb13a (post details now rsposnive #2)
    required double avatarSize,
  })  : _avatarSize = avatarSize,
        super(key: key);

<<<<<<< HEAD
  final double _avatarSize;
  final String author;
=======
  final NewsPostListCard widget;
  final double _avatarSize;
>>>>>>> edcb13a (post details now rsposnive #2)

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () {
<<<<<<< HEAD
        navigateToUserDetailPage(context, author, () {});
=======
        navigateToUserDetailPage(context, widget.author, () {});
>>>>>>> edcb13a (post details now rsposnive #2)
      },
      child: AccountIconBase(
        avatarSize: _avatarSize,
        showVerified: true,
<<<<<<< HEAD
        username: author,
=======
        username: widget.author,
>>>>>>> edcb13a (post details now rsposnive #2)
      ),
    );
  }
}

<<<<<<< HEAD
class TitleContainer extends StatelessWidget {
  const TitleContainer({
    Key? key,
    required this.author,
    required this.link,
    required this.title,
    required this.crossAxisCount,
  }) : super(key: key);

  final String author;
  final String link;
  final String title;
  final int crossAxisCount;
=======
class TitleWidgetForRow extends StatelessWidget {
  const TitleWidgetForRow({
    Key? key,
    required this.widget,
  }) : super(key: key);

  final NewsPostListCard widget;
>>>>>>> edcb13a (post details now rsposnive #2)

  @override
  Widget build(BuildContext context) {
    return Container(
<<<<<<< HEAD
      width: crossAxisCount == 1
          ? 70.w
          : crossAxisCount == 2
              ? 35.w
              : 18.w,
      child: InkWell(
        onTap: () {
          navigateToPostDetailPage(context, author, link, "none", false, () {});
        },
        child: Text(
          title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.titleLarge,
=======
      width: 70.w,
      child: InkWell(
        onTap: () {
          navigateToPostDetailPage(
              context, widget.author, widget.link, "none", false, () {});
        },
        child: Text(
          widget.title,
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: Theme.of(context).textTheme.headline6,
>>>>>>> edcb13a (post details now rsposnive #2)
        ),
      ),
    );
  }
}
<<<<<<< HEAD
=======

class PlayerWidget extends StatelessWidget {
  PlayerWidget(
      {Key? key,
      required bool thumbnailTapped,
      required this.videoSource,
      required this.videoUrl,
      required VideoPlayerController bpController,
      required YoutubePlayerController ytController,
      required this.placeholderSize,
      required this.placeholderWidth})
      : _thumbnailTapped = thumbnailTapped,
        _bpController = bpController,
        _ytController = ytController,
        super(key: key);

  final bool _thumbnailTapped;
  String videoSource;
  String videoUrl;
  final VideoPlayerController _bpController;
  final YoutubePlayerController _ytController;
  double placeholderWidth;
  double placeholderSize;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Visibility(
        visible: _thumbnailTapped,
        child: (["sia", "ipfs"].contains(videoSource) && videoUrl != "")
            ?
            // AspectRatio(
            //     aspectRatio: 16 / 9,
            // child:
            ChewiePlayer(
                videoUrl: videoUrl,
                autoplay: true,
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
              )
            : (videoSource == 'youtube' && videoUrl != "")
                ? YTPlayerIFrame(
                    videoUrl: videoUrl,
                    autoplay: true,
                    allowFullscreen: false,
                    controller: _ytController,
                  )
                : Text("no player detected"),
      ),
    );
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
>>>>>>> edcb13a (post details now rsposnive #2)
