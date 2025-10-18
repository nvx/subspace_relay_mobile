import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_hooks/flutter_hooks.dart';
import 'package:hooks_riverpod/hooks_riverpod.dart';
import 'package:intl/intl.dart';

import 'package:subspace_relay_mobile/services/log.dart';

class UpperCaseTextFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    return newValue.copyWith(text: newValue.text.toUpperCase());
  }
}

class RelayIdWidget extends StatelessWidget {
  final String text;
  final String _relayId;
  const RelayIdWidget(this._relayId, {this.text = 'RelayID', super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: <Widget>[
        Text('$text: $_relayId'),
        ElevatedButton(
          child: Text('Copy $text'),
          onPressed: () {
            Clipboard.setData(ClipboardData(text: _relayId));
            ScaffoldMessenger.of(context).showSnackBar(SnackBar(content: Text('Copied to Clipboard')));
          },
        ),
      ],
    );
  }
}

class RemoteLogWidget extends HookConsumerWidget {
  const RemoteLogWidget({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final remoteLog = ref.watch(remoteLogProvider).map((e) => '[${DateFormat('HH:mm:ss').format(e.timestamp)}] ${e.message}').join('\n');
    final textEditingController = useTextEditingController();

    textEditingController.text = remoteLog;

    return Expanded(
      child: Column(
        children: [
          SizedBox(height: 10),
          Expanded(
            child: TextFormField(
              maxLines: null,
              decoration: InputDecoration(border: InputBorder.none, labelText: 'Remote Log'),
              controller: textEditingController,
              readOnly: true,
            ),
          ),
        ],
      ),
    );
  }
}
