import 'package:ovh.fso.dtubego/bloc/hivesigner/hivesigner_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/settings/settings_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/thirdpartyloader/thirdpartyloader_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_bloc_full.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/PresetSelection/Widgets/PresetCards.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/UploadForm/uploadForm.dart';
import 'package:ovh.fso.dtubego/ui/widgets/UnsortedCustomWidgets.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/dtubeLoading.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:youtube_player_iframe/youtube_player_iframe.dart';

class Wizard3rdPartyDesktop extends StatefulWidget {
  Wizard3rdPartyDesktop(
      {Key? key, required this.uploaderCallback, required this.preset})
      : super(key: key);

  final VoidCallback uploaderCallback;
  final Preset preset;

  @override
  _Wizard3rdPartyDesktopState createState() => _Wizard3rdPartyDesktopState();
}

class _Wizard3rdPartyDesktopState extends State<Wizard3rdPartyDesktop> {
  TextEditingController _foreignUrlController = new TextEditingController();
  late SettingsBloc _settingsBloc;
  late UserBloc _userBloc;
  late UserBloc _userBloc2;
  late HivesignerBloc _hivesignerBloc;
  late ThirdPartyMetadataBloc _thirdPartyBloc;
  late YoutubePlayerController _ytController;

  UploadData _uploadData = UploadData(
      link: "",
      title: "",
      description: "",
      tag: "",
      vpPercent: 0.0,
      vpBalance: 0,
      burnDtc: 0,
      dtcBalance: 0,
      duration: "",
      thumbnailLocation: "",
      localThumbnail: true,
      videoLocation: "",
      localVideoFile: true,
      originalContent: false,
      nSFWContent: false,
      unlistVideo: false,
      videoSourceHash: "",
      video240pHash: "",
      video480pHash: "",
      videoSpriteHash: "",
      thumbnail640Hash: "",
      thumbnail210Hash: "",
      isEditing: false,
      isPromoted: false,
      parentAuthor: "",
      parentPermlink: "",
      uploaded: false,
      crossPostToHive: false);

  bool _showVideo = false;

  @override
  void initState() {
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    _settingsBloc.add(FetchSettingsEvent());
    _thirdPartyBloc = BlocProvider.of<ThirdPartyMetadataBloc>(context);
    _userBloc = BlocProvider.of<UserBloc>(context);

    // _userBloc.add(FetchDTCVPEvent());
    _userBloc.add(FetchMyAccountDataEvent());
    _hivesignerBloc = BlocProvider.of<HivesignerBloc>(context);
    _ytController = YoutubePlayerController(
      initialVideoId: '',
      params: YoutubePlayerParams(
          showControls: true,
          showFullscreenButton: false),
    );
    loadHiveSignerAccessToken();
  }

  @override
  void dispose() {
    super.dispose();
  }

  void loadHiveSignerAccessToken() async {
    String _accessToken = await sec.getHiveSignerAccessToken();
    _uploadData.crossPostToHive = _accessToken != '';
  }

  void childCallback(UploadData ud) {
    setState(() {
      widget.uploaderCallback();
      // BlocProvider.of<AppStateBloc>(context)
      //     .add(UploadStateChangedEvent(uploadState: UploadStartedState()));
      _uploadData = ud;
      BlocProvider.of<TransactionBloc>(context)
          .add(SendCommentEvent(_uploadData));
    });
  }

  void showVideo(String text) {}

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, stateuserdata) {
          if (stateuserdata is UserLoadingState) {
            return LoadingUserData();
          } else if (stateuserdata is UserLoadedState) {
            return SingleChildScrollView(
                child: Column(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                  Column(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        Container(
                            width: 80.w,
                            child: DTubeFormCard(
                                avoidAnimation: true,
                                waitBeforeFadeIn: Duration(seconds: 0),
                                childs: [
                                  Align(
                                    alignment: Alignment.center,
                                    child: Text("1. Source video",
                                        style: Theme.of(context)
                                            .textTheme
                                            .headlineSmall),
                                  ),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    children: [
                                      Container(
                                          width: 50,
                                          child: FaIcon(
                                              FontAwesomeIcons.youtube,
                                              color: globalRed)),
                                      Container(
                                        width: 40.w,
                                        child: TextField(
                                            decoration: new InputDecoration(
                                              labelText: "enter video url ",
                                            ), // TODO: support more foreign systems
                                            controller: _foreignUrlController,
                                            cursorColor: globalRed,
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodyLarge),
                                      ),
                                    ],
                                  ),
                                  Align(
                                    alignment: Alignment.topRight,
                                    child: InputChip(
                                      label: Text("next"),
                                      backgroundColor: globalRed,
                                      onPressed: () async {
                                        setState(
                                          () {
                                            _showVideo = true;
                                            _ytController =
                                                YoutubePlayerController(
                                                    initialVideoId: _foreignUrlController.text,
                                                    params: YoutubePlayerParams(
                                                    showControls: true,
                                                    showFullscreenButton: false)
                                            );
                                            _uploadData = UploadData(
                                                link: "",
                                                title: _ytController
                                                    .metadata.title,
                                                description: "",
                                                tag: "",
                                                vpPercent: 0.1,
                                                vpBalance: 0,
                                                burnDtc: 0,
                                                dtcBalance: 0,
                                                duration: _ytController
                                                    .metadata.duration.inSeconds
                                                    .toString(),
                                                thumbnailLocation:
                                                    "", //state.metadata.thumbUrl,
                                                localThumbnail: false,
                                                videoLocation:
                                                    _foreignUrlController.text
                                                        .split("=")[1],
                                                localVideoFile: false,
                                                originalContent: false,
                                                nSFWContent: false,
                                                unlistVideo: false,
                                                videoSourceHash: "",
                                                video240pHash: "",
                                                video480pHash: "",
                                                videoSpriteHash: "",
                                                thumbnail640Hash: "",
                                                thumbnail210Hash: "",
                                                isEditing: false,
                                                isPromoted: false,
                                                parentAuthor: "",
                                                parentPermlink: "",
                                                uploaded: false,
                                                crossPostToHive: _uploadData
                                                    .crossPostToHive);
                                          },
                                        );
                                      },
                                    ),
                                  ),
                                  _showVideo
                                      ? BlocProvider(
                                          create: (context) => UserBloc(
                                              repository: UserRepositoryImpl()),
                                          child: UploadForm(
                                            uploadData: _uploadData,
                                            callback: childCallback,
                                            preset: widget.preset,
                                          ),
                                        )
                                      : Container()
                                ]))
                      ])
                ]));
          }
          return LoadingUserData();
        });
  }
}

class LoadingUserData extends StatelessWidget {
  const LoadingUserData({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return DtubeLogoPulseWithSubtitle(
        subtitle: "loading user data...", size: 10.w);
  }
}
