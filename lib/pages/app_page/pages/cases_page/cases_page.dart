import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/case.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/cases_page/widgets/case_view_edit_card.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/cases_page/widgets/create_case_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_cases.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class CasesPage extends StatelessWidget {
  const CasesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-service-dialog',
        child: const Icon(Icons.add),
        onPressed: () async {
          final _case = await showDialog<Case?>(
            context: context,
            builder: (context) {
              return const CreateCaseDialog();
            },
          );
          if (_case == null) {
            return;
          }
          if (context.mounted) {
            await shellFunction(
              context,
              toExecute: () async {
                await context.read<PxCases>().addNewCase(_case);
              },
            );
          }
        },
      ),
      body: Consumer<PxCases>(
        builder: (context, c, _) {
          while (c.cases == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'cases-page-items',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.cases),
                subtitle: const Divider(),
              ),
              if (c.cases == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ...c.cases!.map((model) {
                  return CaseViewEditCard(model: model);
                })
            ],
          );
        },
      ),
    );
  }
}
