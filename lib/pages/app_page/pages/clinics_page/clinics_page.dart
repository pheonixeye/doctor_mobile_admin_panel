import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/clinic.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/clinics_page/widgets/clinic_create_dialog.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/clinics_page/widgets/clinic_view_edit_card.dart';
import 'package:doctor_mobile_admin_panel/providers/px_clinics.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ClinicsPage extends StatelessWidget {
  const ClinicsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-clinic-dialog',
        child: const Icon(Icons.add),
        onPressed: () async {
          final _clinic = await showDialog<Clinic?>(
            context: context,
            builder: (context) {
              return const ClinicCreateDialog();
            },
          );
          if (_clinic == null) {
            return;
          }
          if (context.mounted) {
            await shellFunction(
              context,
              toExecute: () async {
                await context.read<PxClinics>().createClinic(_clinic);
              },
            );
          }
        },
      ),
      body: Consumer<PxClinics>(
        builder: (context, c, _) {
          while (c.clinics == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'clinics-page-items',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.clinics),
                subtitle: const Divider(),
              ),
              ...c.clinics!.map((model) {
                return ClinicViewEditCard(model: model);
              })
            ],
          );
        },
      ),
    );
  }
}
