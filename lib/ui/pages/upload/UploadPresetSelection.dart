import 'package:dtube_go/res/Config/InitiativePresets.dart';
import 'package:dtube_go/utils/GlobalStorage/SecureStorage.dart' as sec;
import 'package:dtube_go/style/ThemeData.dart';
import 'package:dtube_go/ui/pages/upload/widgets/PresetCards.dart';
import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'UploaderMainPage.dart';

class UploadPresetSelection extends StatefulWidget {
  UploadPresetSelection({Key? key, required this.uploaderCallback})
      : super(key: key);
  final VoidCallback uploaderCallback;

  @override
  _UploadPresetSelectionState createState() => _UploadPresetSelectionState();
}

class _UploadPresetSelectionState extends State<UploadPresetSelection> {
  List<int> _activeCustomPresets = [0];
  List<Preset> _initiativePresets = [];
  List<Preset> _customPresets = [];
  bool _presetSelected = false;
  late Preset _selectedPreset;

  late Future<bool> _customPresetsLoaded;

  Future<bool> getCustomPresets() async {
    String _customPresetSubject = await sec.getTemplateTitle();
    String _customPresetBody = await sec.getTemplateBody();
    String _customPresetTag = await sec.getTemplateTag();
    var customPreset = {
      "name": "Default",
      "icon": FontAwesomeIcons.penToSquare,
      "tag": _customPresetTag,
      "subject": _customPresetSubject,
      "description": _customPresetBody,
      "details": "",
      "moreInfoURL": "",
      "imageURL": ""
    };
    setState(() {
      _customPresets.add(new Preset.fromJson(customPreset));
    });

    return true;
  }

  @override
  void initState() {
    // load initiative preset
    initiativePresets.forEach((g) {
      _initiativePresets.add(new Preset.fromJson(g));
    });
    // load custom preset
    _customPresetsLoaded = getCustomPresets();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      //appBar: dtubeSubAppBar(true, "", context, null),
      resizeToAvoidBottomInset: true,
      body: Padding(
        padding: const EdgeInsets.only(top: 90.0),
        child: !_presetSelected
            ? Padding(
                padding: const EdgeInsets.all(8.0),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.start,
                  children: [
                    Text("Initiatives",
                        style: Theme.of(context).textTheme.headline5),
                    Container(
                      height: 30.h,
                      width: 100.w,
                      color: globalBGColor,
                      child: GridView.custom(
                        gridDelegate: SliverQuiltedGridDelegate(
                          crossAxisCount: 6,
                          mainAxisSpacing: 8,
                          crossAxisSpacing: 8,
                          repeatPattern: QuiltedGridRepeatPattern.inverted,
                          pattern: const [
                            QuiltedGridTile(4, 4),
                            QuiltedGridTile(2, 2),
                            QuiltedGridTile(2, 2),
                          ],
                        ),
                        childrenDelegate: SliverChildBuilderDelegate((context, index) {
                          return Container();
                        }),
                      ),
                    ),
                    Container(
                      color: globalBGColor,
                      width: 100.w,
                      child: Padding(
                        padding: EdgeInsets.only(top: 2.h),
                        child: Center(
                          child: Text("Your presets",
                              style: Theme.of(context).textTheme.headline5),
                        ),
                      ),
                    ),
                    FutureBuilder(
                        future: _customPresetsLoaded,
                        builder: (context, exploreTagsSnapshot) {
                          if (exploreTagsSnapshot.connectionState ==
                                  ConnectionState.none ||
                              exploreTagsSnapshot.connectionState ==
                                  ConnectionState.waiting) {
                            return Container();
                          }
                          return Container(
                            height: 30.h,
                            width: 100.w,
                            color: globalBGColor,
                            child: CustomScrollView(
                              //shrinkWrap: true,
                              // scrollDirection: Axis.vertical,
                            ),
                          );
                        })
                  ],
                ),
              )
            : UploaderMainPage(
                callback: widget.uploaderCallback,
                key: UniqueKey(),
                preset: _presetSelected ? _selectedPreset : _customPresets[0]),
      ),
    );
  }
}
