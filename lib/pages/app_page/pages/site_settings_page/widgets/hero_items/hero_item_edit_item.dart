import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/align_from_string.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:doctor_mobile_admin_panel/providers/px_hero_items.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroItemEditItem extends StatefulWidget {
  const HeroItemEditItem({
    super.key,
    required this.item,
    required this.entry,
    required this.isEditing,
    required this.controller,
    required this.alignKey,
  });
  final HeroItem item;
  final MapEntry<String, dynamic> entry;
  final bool isEditing;
  final TextEditingController controller;
  final String alignKey;

  @override
  State<HeroItemEditItem> createState() => _HeroItemEditItemState();
}

class _HeroItemEditItemState extends State<HeroItemEditItem> {
  late bool _isEditing;
  late TextEditingController _controller;

  @override
  void didChangeDependencies() {
    _isEditing = widget.isEditing;
    _controller = widget.controller;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxHeroItems>(
      builder: (context, l, h, _) {
        return ListTile(
          title: Text(widget.entry.value),
          subtitle: Row(
            children: [
              if (_isEditing == true) ...[
                Expanded(
                  child: widget.entry.key == widget.alignKey
                      ? DropdownButtonFormField<AlignFromString>(
                          items: [
                            ...AlignFromString.values.map((ali) {
                              return DropdownMenuItem<AlignFromString>(
                                alignment: Alignment.center,
                                value: ali,
                                child: Text(
                                  l.isEnglish ? ali.en : ali.ar,
                                  textAlign: TextAlign.center,
                                ),
                              );
                            }),
                          ],
                          alignment: Alignment.center,
                          onChanged: (value) async {
                            await shellFunction(
                              context,
                              toExecute: () async {
                                await h.updateHeroItem(
                                  widget.item.id,
                                  {
                                    widget.entry.key: value?.name,
                                  },
                                );
                              },
                            );
                            setState(() {
                              _isEditing = false;
                            });
                          },
                        )
                      : TextFormField(
                          controller: _controller
                            ..text =
                                '${widget.item.toJson()[widget.entry.key]}',
                        ),
                ),
                SizedBox(width: 10),
                !(widget.entry.key == widget.alignKey)
                    ? IconButton.outlined(
                        onPressed: () async {
                          await shellFunction(
                            context,
                            toExecute: () async {
                              await h.updateHeroItem(
                                widget.item.id,
                                {
                                  widget.entry.key: _controller.text,
                                },
                              );
                            },
                          );
                          setState(() {
                            _isEditing = false;
                          });
                        },
                        icon: const Icon(Icons.save),
                      )
                    : SizedBox(),
              ] else
                Text((widget.entry.key == widget.alignKey)
                    ? '${alignmentFromString(widget.item.toJson()[widget.entry.key] ?? '')}'
                    : '${widget.item.toJson()[widget.entry.key] ?? ''}'),
            ],
          ),
          trailing: IconButton.outlined(
            onPressed: () {
              setState(() {
                if (_isEditing == true) {
                  _isEditing = false;
                } else {
                  _isEditing = true;
                }
              });
            },
            icon: Icon(_isEditing == true ? Icons.close : Icons.edit),
          ),
        );
      },
    );
  }
}
