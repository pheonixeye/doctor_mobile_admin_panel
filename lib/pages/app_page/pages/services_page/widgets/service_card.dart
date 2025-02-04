import 'package:doctor_mobile_admin_panel/components/generic_confirmation_dialog.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/service.dart';
import 'package:doctor_mobile_admin_panel/models/service_response_model.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_services.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ServiceCard extends StatefulWidget {
  const ServiceCard({super.key, required this.model});
  final ServiceResponseModel model;

  @override
  State<ServiceCard> createState() => _ServiceCardState();
}

class _ServiceCardState extends State<ServiceCard>
    with SingleTickerProviderStateMixin {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

  late final TabController _tabController;
  late final ExpansionTileController _tileController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 3,
      vsync: this,
    );
    _tileController = ExpansionTileController();
  }

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      Service.serviceEditableFields(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      Service.serviceEditableFields(context).entries.map(
            (entry) => MapEntry<String, TextEditingController>(
              entry.key,
              TextEditingController(),
            ),
          ),
    );
    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxServices, PxLocale>(
      builder: (context, s, l, _) {
        return Card.outlined(
          elevation: 0,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          child: ExpansionTile(
            controller: _tileController,
            leading: const CircleAvatar(
              radius: 15,
              child: Text('^'),
            ),
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l.isEnglish
                    ? widget.model.service.name_en
                    : widget.model.service.name_ar,
              ),
            ),
            subtitle: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Row(
                spacing: 10,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  IconButton.outlined(
                    tooltip: context.loc.serviceInfo,
                    onPressed: () async {
                      if (_tileController.isExpanded) {
                        setState(() {
                          _tabController.animateTo(0);
                        });
                      }
                    },
                    isSelected: _tabController.index == 0,
                    icon: const Icon(Icons.info),
                  ),
                  IconButton.outlined(
                    tooltip: context.loc.serviceFaqs,
                    onPressed: () async {
                      if (_tileController.isExpanded) {
                        setState(() {
                          _tabController.animateTo(1);
                        });
                      }
                    },
                    isSelected: _tabController.index == 1,
                    icon: const Icon(Icons.question_answer),
                  ),
                  IconButton.outlined(
                    tooltip: context.loc.serviceImage,
                    onPressed: () async {
                      if (_tileController.isExpanded) {
                        setState(() {
                          _tabController.animateTo(2);
                        });
                      }
                    },
                    isSelected: _tabController.index == 2,
                    icon: const Icon(Icons.image),
                  ),
                  IconButton.outlined(
                    tooltip: context.loc.deleteClinic,
                    onPressed: () async {
                      final _toDelete = await showDialog<bool?>(
                        context: context,
                        builder: (context) {
                          return GenericConfirmationDialog(
                            title: context.loc.deleteService,
                            message: context.loc.deleteServiceConfirmation,
                          );
                        },
                      );
                      if (_toDelete == null || _toDelete == false) {
                        return;
                      }
                      if (context.mounted) {
                        await shellFunction(
                          context,
                          toExecute: () async {
                            await s.deleteService(widget.model.service.id);
                          },
                        );
                      }
                    },
                    icon: const Icon(
                      Icons.delete_forever,
                      color: Colors.red,
                    ),
                  ),
                ],
              ),
            ),
            children: [
              ConstrainedBox(
                constraints: BoxConstraints.tightForFinite(
                  height: MediaQuery.sizeOf(context).height -
                      (MediaQuery.sizeOf(context).height * 0.2),
                ),
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //main service info
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card.outlined(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: ListView(
                              children: [
                                ListTile(
                                  title: Text(context.loc.serviceInfo),
                                  subtitle: Divider(),
                                ),
                                ...Service.serviceEditableFields(context)
                                    .entries
                                    .map((entry) {
                                  return ListTile(
                                    title: Text(entry.value),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (_isEditing[entry.key] == true)
                                            Expanded(
                                              child: TextFormField(
                                                controller:
                                                    _controllers[entry.key]
                                                      ?..text = widget
                                                          .model.service
                                                          .toJson()[entry.key],
                                                maxLines: 5,
                                              ),
                                            )
                                          else
                                            Expanded(
                                              child: Text(widget.model.service
                                                  .toJson()[entry.key]),
                                            ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              IconButton.outlined(
                                                onPressed: _isEditing[
                                                            entry.key] ==
                                                        false
                                                    ? () {
                                                        //change to edit
                                                        setState(() {
                                                          _isEditing[
                                                              entry.key] = true;
                                                        });
                                                      }
                                                    : () async {
                                                        //save changes && cancel edit
                                                        await shellFunction(
                                                          context,
                                                          toExecute: () async {
                                                            //TODO
                                                            final _updatedService =
                                                                widget.model
                                                                    .service
                                                                    .copyWith(
                                                              name_en: _controllers[
                                                                      'name_en']
                                                                  ?.text,
                                                              name_ar: _controllers[
                                                                      'name_ar']
                                                                  ?.text,
                                                              description_en:
                                                                  _controllers[
                                                                          'description_en']
                                                                      ?.text,
                                                              description_ar:
                                                                  _controllers[
                                                                          'description_ar']
                                                                      ?.text,
                                                            );
                                                            final _update = {
                                                              entry.key:
                                                                  _controllers[
                                                                          entry
                                                                              .key]
                                                                      ?.text
                                                            };
                                                            await s.updateServiceData(
                                                                _updatedService);
                                                            setState(() {
                                                              _isEditing[entry
                                                                  .key] = false;
                                                            });
                                                          },
                                                        );
                                                      },
                                                icon: Icon(
                                                    _isEditing[entry.key] ==
                                                            true
                                                        ? Icons.save
                                                        : Icons.edit),
                                              ),
                                              const SizedBox(height: 10),
                                              if (_isEditing[entry.key] == true)
                                                IconButton.outlined(
                                                  onPressed: () {
                                                    setState(() {
                                                      _isEditing[entry.key] =
                                                          false;
                                                    });
                                                  },
                                                  icon: const Icon(Icons.close),
                                                ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  );
                                }),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //service faqs
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card.outlined(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(context.loc.serviceFaqs),
                                  subtitle: Divider(),
                                  trailing: IconButton.outlined(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                    //service image
                    Container(
                      decoration: BoxDecoration(),
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Card.outlined(
                          elevation: 8,
                          child: Padding(
                            padding: const EdgeInsets.all(8.0),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                ListTile(
                                  title: Text(context.loc.serviceImage),
                                  subtitle: Divider(),
                                  trailing: IconButton.outlined(
                                    onPressed: () {},
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}
