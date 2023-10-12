import 'package:flutter/material.dart';
import 'package:flutter_form_bloc/flutter_form_bloc.dart';
import 'package:infobip_mi_demo_app/blocs/form_blocs/debug/debug_form_bloc.dart';
import 'package:infobip_mi_demo_app/widgets/loading_dialog.dart';

class DebugDialog extends StatelessWidget {
  final bool initialDebugValue;

  const DebugDialog(this.initialDebugValue, {super.key});

  @override
  Widget build(BuildContext context) => BlocProvider(
        create: (_) => DebugFormBloc(initialDebugValue),
        child: _createDebugDialog(),
      );

  Widget _createDebugDialog() => Builder(builder: (context) {
        final debugForm = context.read<DebugFormBloc>();
        return AlertDialog(
          title: Text('Debug', style: Theme.of(context).textTheme.labelMedium),
          content: SingleChildScrollView(
            child: FormBlocListener<DebugFormBloc, bool, String>(
              onSubmitting: (context, state) {
                LoadingDialog.show(context);
              },
              onSuccess: (context, state) {
                LoadingDialog.hide(context);
                Navigator.pop(context);
              },
              child: SizedBox(
                width: MediaQuery.of(context).size.width,
                child: DropdownFieldBlocBuilder(
                  showEmptyItem: false,
                  selectFieldBloc: debugForm.debug,
                  itemBuilder: (context, value) => FieldItem(
                    child: Text(value ? 'Enabled' : 'Disabled'),
                  ),
                ),
              ),
            ),
          ),
          actions: <Widget>[
            ElevatedButton(
                onPressed: debugForm.submit, child: const Text('Save'))
          ],
        );
      });
}
