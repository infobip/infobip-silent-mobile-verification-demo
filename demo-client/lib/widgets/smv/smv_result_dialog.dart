import 'package:flutter/material.dart';
import 'package:infobip_mi_demo_app/api/models/verify_api_response.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/models/smv_success.dart';
import 'package:infobip_mi_demo_app/widgets/smv/request_id_text_field.dart';

class SMVResultDialog extends StatelessWidget {
  SMVResultDialog(
      {super.key, required this.smvSuccess, required this.debugEnabled})
      : resultImagePath = smvSuccess.result == SMVResult.valid
            ? 'assets/images/check_circle.png'
            : 'assets/images/cross_circle.png';

  final String resultImagePath;
  final SMVSuccess smvSuccess;
  final bool debugEnabled;

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    return Dialog.fullscreen(
      child: Container(
        padding: const EdgeInsets.all(16),
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                BackButton(
                  color: theme.primaryColor,
                )
              ],
            ),
            Expanded(
                child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Container(
                  margin: const EdgeInsets.only(bottom: 32),
                  child: Image.asset(
                    resultImagePath,
                    width: 125,
                    height: 125,
                  ),
                ),
                if (smvSuccess.result == SMVResult.valid) ...{
                  Text(
                    'SUCCESSFULLY VERIFIED',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                } else ...{
                  Text(
                    'FAILED TO VERIFY',
                    textAlign: TextAlign.center,
                    style: theme.textTheme.titleLarge,
                  ),
                },
                const SizedBox(height: 16),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('MSISDN: ${smvSuccess.msisdn}'),
                    if (debugEnabled) ...[
                      const SizedBox(height: 2),
                      Text('Device IP: ${smvSuccess.deviceIp}'),
                      const SizedBox(height: 2),
                      Text('Device port: ${smvSuccess.devicePort.toString()}')
                    ],
                  ],
                ),
                const SizedBox(height: 32),
                if (debugEnabled) ...{
                  RequestIdTextField(requestId: smvSuccess.token)
                },
                const SizedBox(height: 32),
                ElevatedButton(
                  child: Text(
                    'FINISH',
                    style: theme.textTheme.labelMedium
                        ?.copyWith(color: Colors.white),
                  ),
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                ),
              ],
            ))
          ],
        ),
      ),
    );
  }
}
