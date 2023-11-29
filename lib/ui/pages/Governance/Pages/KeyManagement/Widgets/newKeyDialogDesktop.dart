import 'package:flutter/services.dart';


import 'package:ovh.fso.dtubego/bloc/config/txTypes.dart';
import 'package:ovh.fso.dtubego/ui/widgets/DialogTemplates/DialogWithTitleLogo.dart';
import 'package:ovh.fso.dtubego/utils/Random/randomGenerator.dart';
import 'package:responsive_sizer/responsive_sizer.dart';

import 'package:ovh.fso.dtubego/bloc/transaction/transaction_bloc_full.dart';
import 'package:ovh.fso.dtubego/style/ThemeData.dart';
import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class NewKeyDialogDesktop extends StatefulWidget {
  NewKeyDialogDesktop({Key? key, required this.txBloc}) : super(key: key);
  final TransactionBloc txBloc;

  @override
  _NewKeyDialogDesktopState createState() => _NewKeyDialogDesktopState();
}

class _NewKeyDialogDesktopState extends State<NewKeyDialogDesktop> {
  late TextEditingController _keyNameController;
  late TextEditingController _newPubController;
  late TextEditingController _newPrivController;
  late TransactionBloc _txBloc;
  bool _copyClicked = false;
  List<int> _selectedTxTypes = [];

  void getNewKeyPair() async {
    List<String> keys = generateNewKeyPair();
    setState(() {
      _newPubController.text = keys[0];
      _newPrivController.text = keys[1];
    });
  }

  @override
  void initState() {
    super.initState();
    _keyNameController = new TextEditingController();
    _newPubController = new TextEditingController();
    _newPrivController = new TextEditingController();
    _txBloc = widget.txBloc;

    getNewKeyPair();
  }

  @override
  Widget build(BuildContext context) {
    return PopUpDialogWithTitleLogo(
      titleWidgetPadding: 25,
      titleWidgetSize: 50,
      callbackOK: () {},
      titleWidget: FaIcon(
        FontAwesomeIcons.key,
        size: 50,
        color: globalBGColor,
      ),
      showTitleWidget: true,
      child: Builder(
        builder: (context) {
          return Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            mainAxisSize: MainAxisSize.min,
            children: [
              Container(
                height: 50.h,
                child: SingleChildScrollView(
                  child: Column(
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: TextField(
                          style: Theme.of(context).textTheme.bodyLarge,
                          decoration: new InputDecoration(
                              labelText: "Key Name / Usage*"),
                          controller: _keyNameController,
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Text("Permissions:"),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Wrap(
                          spacing: 6.0,
                          runSpacing: 6.0,
                          children: List<Widget>.generate(txTypes.length,
                              (int index) {
                            return FilterChip(
                              showCheckmark: false,
                              selectedColor: globalRed,
                              padding: EdgeInsets.zero,
                              materialTapTargetSize:
                                  MaterialTapTargetSize.shrinkWrap,
                              label: Text(
                                txTypes[index]!.toString(),
                                style: Theme.of(context)
                                    .textTheme
                                    .titleSmall!
                                    .copyWith(fontSize: 10),
                              ),
                              selected: _selectedTxTypes.contains(index),
                              onSelected: (bool selected) {
                                setState(() {
                                  if (selected) {
                                    _selectedTxTypes.add(index);
                                  } else {
                                    _selectedTxTypes.remove(index);
                                  }
                                });
                              },
                            );
                          }),
                        ),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(8.0),
                        child: Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Container(
                              width: 200,
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text("public key:"),
                                  Text(
                                    _newPubController.value.text,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(top: 10),
                                    child: Text("private key:"),
                                  ),
                                  Text(
                                    _newPrivController.value.text,
                                    style: Theme.of(context).textTheme.bodySmall,
                                  ),
                                ],
                              ),
                            ),
                            Container(
                                width: 100,
                                child: ElevatedButton(
                                    onPressed:
                                        _keyNameController.value.text != ""
                                            ? () {
                                                setState(() {
                                                  _copyClicked = true;
                                                });
                                                Clipboard.setData(ClipboardData(
                                                    text:
                                                        "name / usage: ${_keyNameController.value.text}\npublic key: ${_newPubController.value.text}\nprivate key: ${_newPrivController.value.text}"));
                                              }
                                            : null,
                                    child: Center(child: Text("copy")))),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              InkWell(
                child: Container(
                  padding: EdgeInsets.only(top: 20.0, bottom: 20.0),
                  decoration: BoxDecoration(
                    color: _copyClicked &&
                            _keyNameController.value.text != "" &&
                            _selectedTxTypes.length > 0
                        ? globalRed
                        : Colors.grey,
                    borderRadius: BorderRadius.only(
                        bottomLeft: Radius.circular(20.0),
                        bottomRight: Radius.circular(20.0)),
                  ),
                  child: Text(
                    "Create key",
                    style: Theme.of(context).textTheme.headlineMedium,
                    textAlign: TextAlign.center,
                  ),
                ),
                onTap: _copyClicked &&
                        _keyNameController.value.text != "" &&
                        _selectedTxTypes.length > 0
                    ? () async {
                        TxData txdata = TxData(
                            id: _keyNameController.value.text,
                            pub: _newPubController.value.text,
                            types: _selectedTxTypes);
                        Transaction newTx = Transaction(type: 10, data: txdata);
                        _txBloc.add(SignAndSendTransactionEvent(tx: newTx));
                        Navigator.of(context).pop();
                      }
                    : null,
              ),
            ],
          );
        },
      ),
    );
  }
}
