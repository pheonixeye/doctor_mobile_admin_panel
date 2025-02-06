import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/services_page/widgets/create_service_dialog.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/services_page/widgets/service_card.dart';
import 'package:doctor_mobile_admin_panel/providers/px_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServicesPage extends StatelessWidget {
  const ServicesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-service-dialog',
        child: const Icon(Icons.add),
        onPressed: () async {
          final _service = await showDialog<Service?>(
            context: context,
            builder: (context) {
              return const CreateServiceDialog();
            },
          );
          if (_service == null) {
            return;
          }
          if (context.mounted) {
            await shellFunction(
              context,
              toExecute: () async {
                await context.read<PxServices>().createService(_service);
              },
            );
          }
        },
      ),
      body: Consumer<PxServices>(
        builder: (context, c, _) {
          while (c.services == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'services-page-items',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.services),
                subtitle: const Divider(),
              ),
              if (c.services == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ...c.services!.map((model) {
                  return ServiceCard(model: model);
                })
            ],
          );
        },
      ),
    );
  }
}
