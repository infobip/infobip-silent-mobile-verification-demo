import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class RequestIdTextField extends StatelessWidget {
  const RequestIdTextField({super.key, required this.requestId});

  final String requestId;

  @override
  Widget build(BuildContext context) {
    TextEditingController requestIdTextFieldController =
        TextEditingController(text: requestId);

    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: TextField(
        controller: requestIdTextFieldController,
        decoration: InputDecoration(
          border: const OutlineInputBorder(),
          suffix: IconButton(
            icon: const Icon(
              Icons.content_copy,
              size: 18, // Changing Drawer Icon Size
            ),
            tooltip: 'Copy Request ID',
            onPressed: _copyRequestId,
          ),
          isDense: true,
          isCollapsed: true,
          filled: true,
          hintText: 'Unique ID for this request: $requestId',
          labelText: 'Request ID*',
        ),
        readOnly: true,
        onTap: _copyRequestId,
      ),
    );
  }

  void _copyRequestId() {
    Clipboard.setData(ClipboardData(text: requestId));
  }
}
