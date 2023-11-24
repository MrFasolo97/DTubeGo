import 'package:dtube_go/bloc/hivesigner/hivesigner_bloc_full.dart';
import 'package:dtube_go/bloc/settings/settings_bloc_full.dart';
import 'package:dtube_go/bloc/transaction/transaction_bloc_full.dart';
import 'package:dtube_go/bloc/user/user_bloc_full.dart';
import 'package:dtube_go/style/ThemeData.dart';
import 'package:dtube_go/ui/pages/upload/PresetSelection/Widgets/PresetCards.dart';
import 'package:dtube_go/ui/pages/upload/UploadForm/uploadForm.dart';
import 'package:dtube_go/ui/widgets/UnsortedCustomWidgets.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter/material.dart';
import 'package:dtube_go/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

class CustomWizardDesktop extends StatefulWidget {
  CustomWizardDesktop(
      {Key? key, required this.uploaderCallback, required this.preset})
      : super(key: key);

  final VoidCallback uploaderCallback;
  final Preset preset;

  @override
  _CustomWizardDesktopState createState() => _CustomWizardDesktopState();
}

class _CustomWizardDesktopState extends State<CustomWizardDesktop> {
  TextEditingController _sourceHashController =
      new TextEditingController(text: "");
  TextEditingController _spriteHashController =
      new TextEditingController(text: "");
  TextEditingController _thumbnailUrlController =
      new TextEditingController(text: "");
  TextEditingController _video240pHashController =
      new TextEditingController(text: "");
  TextEditingController _video480pHashController =
      new TextEditingController(text: "");

  bool _video240pActivated = false;
  bool _video480pActivated = false;

  bool _spriteActivated = false;
  bool _thumbnailActivated = false;

  bool _showUploadForm = false;

  String _provider = "IPFS";
  List<String> _providerList = ["IPFS", "Skynet"];
  late SettingsBloc _settingsBloc;
  late UserBloc _userBloc;
  late HivesignerBloc _hivesignerBloc;

  bool _mandatoryFieldsFilled = false;

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
      crossPostToHive: false);

  @override
  void initState() {
    super.initState();
    _settingsBloc = BlocProvider.of<SettingsBloc>(context);
    _settingsBloc.add(FetchSettingsEvent());
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

  void checkSourceIsFilled() {
    if (_sourceHashController.text.length > 0) {
      setState(() {
        _mandatoryFieldsFilled = true;
      });
    } else {
      setState(() {
        _mandatoryFieldsFilled = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
        child:
            Column(mainAxisAlignment: MainAxisAlignment.spaceEvenly, children: [
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
                  child: Text("1. Storage Data",
                      style: Theme.of(context).textTheme.headlineSmall),
                ),
                DropdownButtonFormField(
                  style: Theme.of(context).textTheme.bodyLarge,
                  decoration: InputDecoration(
                    labelText: 'Storage Provider',
                  ),
                  value: _provider,
                  onChanged: (newValue) {
                    setState(() {
                      _provider = newValue.toString();
                      // widget.justSaved = false;
                    });
                  },
                  items: _providerList.map((option) {
                    return DropdownMenuItem(
                      child: new Text(option),
                      value: option,
                    );
                  }).toList(),
                ),
                Container(
                  width: 40.w,
                  child: TextField(
                      decoration:
                          new InputDecoration(labelText: "Source Hash*"),
                      controller: _sourceHashController,
                      cursorColor: globalRed,
                      onChanged: (val) {
                        checkSourceIsFilled();
                      },
                      style: Theme.of(context).textTheme.bodyLarge),
                ),
                Wrap(
                  children: [
                    ChoiceChip(
                        selected: _video240pActivated,
                        label: Text('240p',
                            style: Theme.of(context).textTheme.bodyLarge),
                        labelStyle: TextStyle(color: globalAlmostWhite),
                        avatar: _video240pActivated
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                size: 15,
                              )
                            : null,
                        backgroundColor: Colors.grey.withAlpha(30),
                        selectedColor: Colors.green[700],
                        onSelected: (bool selected) {
                          setState(() {
                            _video240pActivated = !_video240pActivated;
                            if (!_video240pActivated) {
                              _video240pHashController.text = "";
                            }
                          });
                        }),
                    ChoiceChip(
                        selected: _video480pActivated,
                        label: Text('480p',
                            style: Theme.of(context).textTheme.bodyLarge),
                        labelStyle: TextStyle(color: globalAlmostWhite),
                        avatar: _video480pActivated
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                size: 15,
                              )
                            : null,
                        backgroundColor: Colors.grey.withAlpha(30),
                        selectedColor: Colors.green[700],
                        onSelected: (bool selected) {
                          setState(() {
                            _video480pActivated = !_video480pActivated;
                            if (!_video480pActivated) {
                              _video480pHashController.text = "";
                            }
                          });
                        }),
                    ChoiceChip(
                        selected: _spriteActivated,
                        label: Text('sprite',
                            style: Theme.of(context).textTheme.bodyLarge),
                        labelStyle: TextStyle(color: globalAlmostWhite),
                        avatar: _spriteActivated
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                size: 15,
                              )
                            : null,
                        backgroundColor: Colors.grey.withAlpha(30),
                        selectedColor: Colors.green[700],
                        onSelected: (bool selected) {
                          setState(() {
                            _spriteActivated = !_spriteActivated;
                            if (!_spriteActivated) {
                              _spriteHashController.text = "";
                            }
                          });
                        }),
                    ChoiceChip(
                        selected: _thumbnailActivated,
                        label: Text('thumbnail',
                            style: Theme.of(context).textTheme.bodyLarge),
                        labelStyle: TextStyle(color: globalAlmostWhite),
                        avatar: _thumbnailActivated
                            ? FaIcon(
                                FontAwesomeIcons.check,
                                size: 15,
                              )
                            : null,
                        backgroundColor: Colors.grey.withAlpha(30),
                        selectedColor: Colors.green[700],
                        onSelected: (bool selected) {
                          setState(() {
                            _thumbnailActivated = !_thumbnailActivated;
                            if (!_thumbnailActivated) {
                              _thumbnailUrlController.text = "";
                            }
                          });
                        }),
                  ],
                ),
                Visibility(
                  visible: _video240pActivated,
                  child: Container(
                    width: 40.w,
                    child: TextField(
                        decoration: new InputDecoration(labelText: "240p Hash"),
                        controller: _video240pHashController,
                        cursorColor: globalRed,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Visibility(
                  visible: _video480pActivated,
                  child: Container(
                    width: 40.w,
                    child: TextField(
                        decoration: new InputDecoration(labelText: "480p Hash"),
                        controller: _video480pHashController,
                        cursorColor: globalRed,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Visibility(
                  visible: _spriteActivated,
                  child: Container(
                    width: 40.w,
                    child: TextField(
                        decoration:
                            new InputDecoration(labelText: "Sprite Hash"),
                        controller: _spriteHashController,
                        cursorColor: globalRed,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Visibility(
                  visible: _thumbnailActivated,
                  child: Container(
                    width: 40.w,
                    child: TextField(
                        decoration:
                            new InputDecoration(labelText: "Thumbnail URL"),
                        controller: _thumbnailUrlController,
                        cursorColor: globalRed,
                        style: Theme.of(context).textTheme.bodyLarge),
                  ),
                ),
                Center(
                  child: InputChip(
                    backgroundColor: globalRed,
                    label: Text("next",
                        style: Theme.of(context).textTheme.bodyLarge),
                    isEnabled: _mandatoryFieldsFilled,
                    onPressed: () async {
                      setState(() {
                        _showUploadForm = true;
                        _uploadData = UploadData(
                            link: "",
                            title: "",
                            description: "",
                            tag: "",
                            vpPercent: 0.0,
                            vpBalance: 0,
                            burnDtc: 0,
                            dtcBalance: 0,
                            duration: "",
                            thumbnailLocation:
                                _thumbnailUrlController.value.text,
                            localThumbnail: false,
                            videoLocation: _provider,
                            localVideoFile: false,
                            originalContent: false,
                            nSFWContent: false,
                            unlistVideo: false,
                            videoSourceHash: _sourceHashController.value.text,
                            video240pHash: _video240pHashController.value.text,
                            video480pHash: _video480pHashController.value.text,
                            videoSpriteHash: _spriteHashController.value.text,
                            thumbnail640Hash: "",
                            thumbnail210Hash: "",
                            isEditing: false,
                            isPromoted: false,
                            parentAuthor: "",
                            parentPermlink: "",
                            uploaded: false,
                            crossPostToHive: _uploadData.crossPostToHive);
                      });
                    },
                  ),
                )
              ],
            ),
          ),
        ],
      ),
      Visibility(
        visible: _showUploadForm,
        child: UploadForm(
          uploadData: _uploadData,
          callback: childCallback,
          preset: widget.preset,
        ),
      ),
    ]));
  }
}
