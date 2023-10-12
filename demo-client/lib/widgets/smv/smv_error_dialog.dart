import 'package:flutter/material.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/models/smv_failure.dart';
import 'package:infobip_mi_demo_app/widgets/smv/request_id_text_field.dart';

class SMVErrorDialog extends StatelessWidget {
  const SMVErrorDialog(
      {super.key, required this.failureResult, required this.debugEnabled});

  final SMVFailure failureResult;
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
                  ),
                  Text(
                    'Back',
                    style: TextStyle(color: theme.primaryColor),
                  )
                ],
              ),
              Expanded(
                  child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Container(
                    margin: const EdgeInsets.only(bottom: 32),
                    child: Image.asset(
                      'assets/images/cross_circle.png',
                      width: 125,
                      height: 125,
                    ),
                  ),
                  Text(failureResult.errorDescription,
                      textAlign: TextAlign.center,
                      style: theme.textTheme.headlineSmall),
                  const SizedBox(height: 16),
                  Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text('MSISDN: ${failureResult.msisdn}'),
                      if (failureResult.deviceIp != null &&
                          failureResult.devicePort != null &&
                          debugEnabled) ...[
                        const SizedBox(height: 2),
                        Text('Device IP: ${failureResult.deviceIp!}'),
                        const SizedBox(height: 2),
                        Text(
                            'Device port: ${failureResult.devicePort!.toString()}')
                      ],
                    ],
                  ),
                  const SizedBox(height: 32),
                  if (failureResult.token != null && debugEnabled) ...{
                    RequestIdTextField(requestId: failureResult.token!)
                  }
                ],
              ))
            ],
          )),
    );
  }
}
