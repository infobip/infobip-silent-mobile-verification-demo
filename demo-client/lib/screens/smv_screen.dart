import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/app/app_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/models/smv_failure.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/models/smv_success.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/smv/smv_form_bloc.dart';
import 'package:infobip_mi_demo_app/utils/validators.dart';
import 'package:infobip_mi_demo_app/widgets/app_drawer.dart';
import 'package:infobip_mi_demo_app/widgets/loading_dialog.dart';
import 'package:infobip_mi_demo_app/widgets/smv/smv_error_dialog.dart';
import 'package:infobip_mi_demo_app/widgets/smv/smv_result_dialog.dart';

class SMVScreen extends StatelessWidget {
  const SMVScreen({
    super.key,
  });

  static Page page() => const MaterialPage<void>(child: SMVScreen());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: HamburgerAppBar(
          context: context, title: 'Silent Mobile Verification'),
      drawer: const AppDrawer(),
      body: BlocBuilder<AppBloc, AppState>(
        builder: (appBlocContext, appBlocState) => SingleChildScrollView(
          padding: const EdgeInsets.all(17),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 17),
              Padding(
                padding: const EdgeInsets.only(
                  top: 67,
                  left: 43,
                  right: 43,
                ),
                child: SMVForm(appBlocState),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SMVForm extends StatelessWidget {
  final AppState appState;

  const SMVForm(this.appState, {super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => SMVFormBloc(appState.debug),
      child: Builder(
        builder: (context) {
          final smvFormBloc = context.read<SMVFormBloc>();
          return FormBlocListener<SMVFormBloc, SMVSuccess, SMVFailure>(
            onSubmitting: (context, state) {
              LoadingDialog.show(context);
            },
            onSuccess: (context, state) {
              LoadingDialog.hide(context);
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => SMVResultDialog(
                      smvSuccess: state.successResponse!,
                      debugEnabled: appState.debug));
            },
            onFailure: (context, state) {
              LoadingDialog.hide(context);
              showDialog<String>(
                  context: context,
                  builder: (BuildContext context) => SMVErrorDialog(
                      failureResult: state.failureResponse!,
                      debugEnabled: appState.debug));
            },
            onSubmissionFailed: (context, state) {
              LoadingDialog.hide(context);
            },
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                children: <Widget>[
                  TextFieldBlocBuilder(
                    textFieldBloc: smvFormBloc.msisdn,
                    keyboardType: TextInputType.phone,
                    decoration: const InputDecoration(
                      labelText: 'MSISDN',
                      prefixIcon: Icon(Icons.local_phone),
                    ),
                    errorBuilder: (context, error) {
                      if (error == FieldBlocValidatorsErrors.required) {
                        return 'Required';
                      }
                      if (error == MsisdnValidator.invalidFormat) {
                        return 'Invalid phone number format';
                      }
                      return null;
                    },
                  ),
                  ElevatedButton(
                    onPressed: smvFormBloc.submit,
                    child: const Text('Verify'),
                  ),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
