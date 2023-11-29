import 'package:ovh.fso.dtubego/bloc/web3storage/web3storage_bloc_full.dart';
import 'package:gallery_saver/gallery_saver.dart';
import 'package:ovh.fso.dtubego/bloc/hivesigner/hivesigner_bloc.dart';
import 'package:ovh.fso.dtubego/bloc/hivesigner/hivesigner_bloc_full.dart';
import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/PresetSelection/Widgets/PresetCards.dart';
import 'package:ovh.fso.dtubego/ui/pages/upload/UploadForm/uploadForm.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class WizardIPFSMobile extends StatefulWidget {
  WizardIPFSMobile(
      {Key? key, required this.uploaderCallback, required this.preset})
      : super(key: key);
  final VoidCallback uploaderCallback;
  final Preset preset;

  @override
  _WizardIPFSMobileState createState() => _WizardIPFSMobileState();
}

class _WizardIPFSMobileState extends State<WizardIPFSMobile> {
  bool _uploadPressed = false;
  late Web3StorageBloc _uploadBloc;

  late TransactionBloc _txBloc;
  late HivesignerBloc _hivesignerBloc;

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

  void childCallback(UploadData ud) {
    setState(() {
      widget.uploaderCallback();

// save to gallery

      GallerySaver.saveVideo(_uploadData.videoLocation, albumName: "DTube");

// upload video to ipfs

      _uploadData = ud;
      _uploadPressed = true;
      _uploadBloc.add(UploadVideo(
          videoPath: _uploadData.videoLocation,
          thumbnailPath: _uploadData.thumbnailLocation,
          uploadData: _uploadData,
          context: context));
    });
  }

  @override
  void initState() {
    super.initState();
    _uploadBloc = BlocProvider.of<Web3StorageBloc>(context);

    loadHiveSignerAccessToken();
  }

  void loadHiveSignerAccessToken() async {
    String _accessToken = await sec.getHiveSignerAccessToken();
    _uploadData.crossPostToHive = _accessToken != '';
  }

  @override
  Widget build(BuildContext context) {
    return UploadForm(
      uploadData: _uploadData,
      callback: childCallback,
      preset: widget.preset,
    );
  }
}
