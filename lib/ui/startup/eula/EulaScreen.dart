import 'dart:developer';
import 'dart:io';

import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:ovh.fso.dtubego/ui/widgets/AppBar/DTubeSubAppBarDesktop.dart';
import 'package:ovh.fso.dtubego/utils/GlobalStorage/globalVariables.dart' as globals;
import 'package:flutter/foundation.dart';
import 'package:flutter_markdown/flutter_markdown.dart';
import 'package:markdown/markdown.dart' as md;

import 'package:responsive_sizer/responsive_sizer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart' show rootBundle;

class EULAScreen extends StatefulWidget {
  EULAScreen({Key? key, required this.eulaAcceptedCallback}) : super(key: key);

  final VoidCallback eulaAcceptedCallback;
  @override
  _EULAScreenState createState() => _EULAScreenState();
}

class _EULAScreenState extends State<EULAScreen> {
  String? _eulaTextAndroid;
  String? _eulaTextIOS;

  bool _eulaCompleted = false;

  var _controller = ScrollController();

  void loadEulaAssets() async {
    if (kIsWeb) {
      log("web release");
    } else {
      if (Platform.isAndroid && globals.eulaRequired) {
        final _loadedEulaAndroidData =
            await rootBundle.loadString('lib/res/mds/androidEULA.md');

        setState(() {
          _eulaTextAndroid = _loadedEulaAndroidData;
        });
      } else if (Platform.isIOS && globals.eulaRequired) {
        final _loadedEulaIOSData =
            await rootBundle.loadString('lib/res/mds/iOSEULA.md');

        setState(() {
          _eulaTextIOS = _loadedEulaIOSData;
        });
      } else {
        log("EULA not required.");
      }
    }
  }

  @override
  void initState() {
    loadEulaAssets();
    if (kIsWeb) {
      widget.eulaAcceptedCallback();
    } else if(globals.eulaRequired) {
      _controller.addListener(() {
        if (_controller.position.atEdge) {
          if (_controller.position.pixels == 0) {
            setState(() {
              if (_eulaTextIOS == null && _eulaTextAndroid == null) {
                _eulaCompleted = false;
              }
            });
          } else {
            setState(() {
              _eulaCompleted = true;
            });
          }
        } else {
          setState(() {
            if (_eulaTextIOS == null && _eulaTextAndroid == null) {
              _eulaCompleted = true;
            } else {
              _eulaCompleted = false;
            }
          });
        }
      });
    } else {
      widget.eulaAcceptedCallback();
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: dtubeSubAppBarDesktop(true, "", context, null),
        body: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Text("End User License Agreement",
                  style: Theme.of(context).textTheme.displaySmall),
              new Container(
                height: 70.h,
                child:
                    // new Scrollbar(
                    //     child:
                    Markdown(
                        selectable: false,
                        controller: _controller,
                        data: Theme.of(context).platform == TargetPlatform.iOS
                            ? (_eulaTextIOS != null ? _eulaTextIOS! : '')
                            : (_eulaTextAndroid != null
                                ? _eulaTextAndroid!
                                : ''),
                        extensionSet: md.ExtensionSet(
                          md.ExtensionSet.gitHubFlavored.blockSyntaxes,
                          [
                            md.EmojiSyntax(),
                            ...md.ExtensionSet.gitHubFlavored.inlineSyntaxes
                          ],
                          // ),
                        )),
              ),
              Padding(
                padding: EdgeInsets.only(top: 2.h),
                child: InputChip(
                    backgroundColor: globalRed,
                    label: Text("accept", style: TextStyle(fontSize: 24)),
                    onPressed: _eulaCompleted
                        ? () async {
                            widget.eulaAcceptedCallback();
                          }
                        : null),
              ),
            ],
          ),
        ));
  }
}
