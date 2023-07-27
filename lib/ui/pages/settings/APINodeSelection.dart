import 'package:dtube_go/res/Config/APINodesConfigValues.dart';
import 'package:flutter/material.dart';
import 'package:dtube_go/utils/GlobalStorage/globalVariables.dart' as globals;
import 'package:dtube_go/utils/GlobalStorage/SecureStorage.dart' as sec;

class APINodeSelection extends StatefulWidget {


  @override
  _APINodeSelectionState createState() => _APINodeSelectionState();
}

class _APINodeSelectionState extends State<APINodeSelection> {
  List<DropdownMenuItem<String>> getItemsList() {
      List<DropdownMenuItem<String>> APINodes = [];
      for (String api in APINodeConfig.apiNodes) {
        APINodes.add(
            DropdownMenuItem(
              child: new Text(api),
              value: api,
            )
        );
      }
      return APINodes;
  }
  @override
  Widget build(BuildContext context) {
    return DropdownButtonFormField(

        style: Theme.of(context).textTheme.bodyLarge,
        decoration: InputDecoration(
          //filled: true,
          //fillColor: Hexcolor('#ecedec'),
            labelStyle: Theme.of(context)
                .textTheme
                .headlineSmall
          //border: new CustomBorderTextFieldSkin().getSkin(),
        ),
        onChanged: (newValue) {
          setState(() {
            globals.currentApiNode = newValue.toString();
            sec.persistNode(newValue.toString());
// widget.justSaved = false;
          });
        },
        items: getItemsList()
    );
  }


}