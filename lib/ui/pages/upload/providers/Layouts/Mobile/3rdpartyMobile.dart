import 'package:ovh.fso.dtubego/bloc/hivesigner/hivesigner_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/settings/settings_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/thirdpartyloader/thirdpartyloader_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/user/user_bloc_full.dart';
// import 'package:ovh.fso.dtubego/res/Config/secretConfigValues.dart' as secretConfig;
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/PresetSelection/Widgets/PresetCards.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/UploadForm/uploadForm.dart';
import 'package:ovh.fso.dtubego/ui/widgets/UnsortedCustomWidgets.dart';
import 'package:ovh.fso.dtubego/ui/widgets/dtubeLogoPulse/dtubeLoading.dart';
import 'package:ovh.fso.dtubego/ui/widgets/system/ColorChangeCircularProgressIndicator.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class Wizard3rdPartyMobile extends StatefulWidget {
  Wizard3rdPartyMobile(
      {Key? key, required this.uploaderCallback, required this.preset})
      : super(key: key);

  final VoidCallback uploaderCallback;
  final Preset preset;

  @override
  _Wizard3rdPartyMobileState createState() => _Wizard3rdPartyMobileState();
}

class _Wizard3rdPartyMobileState extends State<Wizard3rdPartyMobile> {
  TextEditingController _foreignUrlController = new TextEditingController();
  late SettingsBloc _settingsBloc;
  late UserBloc _userBloc;
  late UserBloc _userBloc2;
  late HivesignerBloc _hivesignerBloc;
  late ThirdPartyMetadataBloc _thirdPartyBloc;

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

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<UserBloc, UserState>(
        bloc: _userBloc,
        builder: (context, stateuserdata) {
          if (stateuserdata is UserLoadingState) {
            return DtubeLogoPulseWithSubtitle(
                subtitle: "loading user data", size: 20.w);
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
                        width: 95.w,
                        child: DTubeFormCard(
                          avoidAnimation: true,
                          waitBeforeFadeIn: Duration(seconds: 0),
                          childs: [
                            Align(
                              alignment: Alignment.center,
                              child: Text("1. External URL",
                                  style: Theme.of(context).textTheme.headlineSmall),
                            ),
                            Row(
                              children: [
                                Container(
                                    width: 10.w,
                                    child: FaIcon(FontAwesomeIcons.youtube,
                                        color: globalRed)),
                                Container(
                                  width: 60.w,
                                  child: TextField(
                                      decoration: new InputDecoration(
                                          labelText:
                                              "enter video url "), // TODO: support more foreign systems
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
                                  backgroundColor: globalRed,
                                  label: BlocBuilder<ThirdPartyMetadataBloc,
                                          ThirdPartyMetadataState>(
                                      bloc: _thirdPartyBloc,
                                      builder: (context, state) {
                                        if (state
                                            is ThirdPartyMetadataInitialState) {
                                          return Text("load data");
                                        } else if (state
                                            is ThirdPartyMetadataLoadedState) {
                                          return Text("reload data");
                                        } else if (state
                                            is ThirdPartyMetadataErrorState) {
                                          print(state.message);
                                          return Text("error data");
                                        } else {
                                          return ColorChangeCircularProgressIndicator();
                                        }
                                      }),
                                  onPressed: () async {
                                    _thirdPartyBloc.add(
                                        LoadThirdPartyMetadataEvent(
                                            _foreignUrlController.value.text));
                                  }),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  BlocBuilder<ThirdPartyMetadataBloc, ThirdPartyMetadataState>(
                      bloc: _thirdPartyBloc,
                      builder: (context, state) {
                        if (state is ThirdPartyMetadataLoadingState) {
                          return Container(
                            width: 95.w,
                            child: DTubeFormCard(
                                avoidAnimation: true,
                                waitBeforeFadeIn: Duration(seconds: 0),
                                childs: [Text("Loading video data...")]),
                          );
                        } else if (state is ThirdPartyMetadataLoadedState) {
                          if (stateuserdata.user.jsonString != null &&
                              stateuserdata.user.jsonString!.additionals !=
                                  null &&
                              stateuserdata.user.jsonString!.additionals!
                                      .ytchannels !=
                                  null /* &&
                              stateuserdata
                                  .user.jsonString!.additionals!.ytchannels!
                                  .contains(secretConfig.encryptYTChannelId(
                                      stateuserdata.user,
                                      state.metadata.channelId))*/ || true) { // Disable YT check, until we find a proper way to authenticate users without a secret file being involved.
                            _uploadData = UploadData(
                                link: "",
                                title: state.metadata.title,
                                description: state.metadata.description,
                                tag: "",
                                vpPercent: 0.0,
                                vpBalance: 0,
                                burnDtc: 0,
                                dtcBalance: 0,
                                duration: state.metadata.duration.inSeconds
                                    .toString(),
                                thumbnailLocation: state.metadata.thumbUrl,
                                localThumbnail: false,
                                videoLocation: state.metadata.sId,
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
                                crossPostToHive: _uploadData.crossPostToHive);
                            return BlocProvider(
                              create: (context) =>
                                  UserBloc(repository: UserRepositoryImpl()),
                              child: UploadForm(
                                uploadData: _uploadData,
                                callback: childCallback,
                                preset: widget.preset,
                              ),
                            );
                          } else {
                            return Container(
                              width: 95.w,
                              child: DTubeFormCard(
                                avoidAnimation: true,
                                waitBeforeFadeIn: Duration(seconds: 0),
                                childs: [
                                  Text(
                                      "The owning Youtube channel is not connected to your Dtube profile. Please verify the channel in your profile settings.")
                                ],
                              ),
                            );
                          }
                        }
                        return Text("Please enter video url");
                      })
                ]));
          }
          return Text("unknown in user");
        });
  }
}
