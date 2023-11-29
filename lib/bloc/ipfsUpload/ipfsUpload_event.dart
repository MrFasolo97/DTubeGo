import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';

abstract class IPFSUploadEvent extends Equatable {}

class UploadVideo extends IPFSUploadEvent {
  UploadVideo(
      {required this.videoPath,
      required this.thumbnailPath,
      required this.uploadData,
      required this.context});
  final String videoPath;
  final String thumbnailPath;
  final UploadData uploadData;
  final BuildContext context;
  @override
  List<Object> get props => List.empty();
}

class IPFSUploaderInitState extends IPFSUploadEvent {
  IPFSUploaderInitState();

  @override
  List<Object> get props => List.empty();
}
