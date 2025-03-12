import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:doctor_mobile_admin_panel/providers/px_hero_items.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroItemViewEditCard extends StatefulWidget {
  const HeroItemViewEditCard({super.key, required this.item});
  final HeroItem item;

  @override
  State<HeroItemViewEditCard> createState() => _HeroItemViewEditCardState();
}

class _HeroItemViewEditCardState extends State<HeroItemViewEditCard> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;
  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      widget.item.toJson().entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      widget.item.toJson().entries.map(
            (entry) => MapEntry<String, TextEditingController>(
              entry.key,
              TextEditingController(),
            ),
          ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Card.outlined(
      elevation: 0,
      child: Consumer<PxHeroItems>(
        builder: (context, h, _) {
          return ExpansionTile(
            title: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(widget.item.title_en),
                Text(widget.item.title_ar),
              ],
            ),
            children: [
              Padding(
                padding: const EdgeInsets.all(4.0),
                child: Card.outlined(
                  color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
                  elevation: 0,
                  child: ExpansionTile(
                    title: Text(context.loc.heroTitle),
                    children: [
                      ListTile(
                        title: Text(context.loc.englishTitle),
                        subtitle: Row(
                          children: [
                            if (_isEditing['title_en'] == true) ...[
                              Expanded(
                                child: TextFormField(
                                  controller: _controllers['title_en']
                                    ?..text = widget.item.title_en,
                                ),
                              ),
                              SizedBox(width: 10),
                              IconButton.outlined(
                                onPressed: () async {
                                  await shellFunction(
                                    context,
                                    toExecute: () async {
                                      await h.updateHeroItem(
                                        widget.item.id,
                                        {
                                          'title_en':
                                              _controllers['title_en']?.text,
                                        },
                                      );
                                    },
                                  );
                                  setState(() {
                                    _isEditing['title_en'] = false;
                                  });
                                },
                                icon: const Icon(Icons.save),
                              ),
                            ] else
                              Text(widget.item.title_en),
                          ],
                        ),
                        trailing: IconButton.outlined(
                          onPressed: () {
                            setState(() {
                              if (_isEditing['title_en'] == true) {
                                _isEditing['title_en'] = false;
                              } else {
                                _isEditing['title_en'] = true;
                              }
                            });
                          },
                          icon: Icon(_isEditing['title_en'] == true
                              ? Icons.close
                              : Icons.edit),
                        ),
                      ),
                      ListTile(
                        title: Text(context.loc.arabicTitle),
                        subtitle: Text(widget.item.title_ar),
                        trailing: IconButton.outlined(
                          onPressed: () {},
                          icon: const Icon(Icons.edit),
                        ),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
