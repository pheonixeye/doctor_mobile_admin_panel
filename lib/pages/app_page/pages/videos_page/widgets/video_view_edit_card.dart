import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:doctor_mobile_admin_panel/extensions/model_image_url_extractor.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:doctor_mobile_admin_panel/providers/px_videos.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideoViewEditCard extends StatefulWidget {
  const VideoViewEditCard({super.key, required this.model});
  final Video model;
  @override
  State<VideoViewEditCard> createState() => _VideoViewEditCardState();
}

class _VideoViewEditCardState extends State<VideoViewEditCard> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      Video.editableStrings(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );
    _controllers = Map.fromEntries(
      Video.editableStrings(context).entries.map(
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
    _controllers.entries.map((e) => e.value.dispose());
    super.dispose();
  }

  int _maxLines(String key) {
    return switch (key) {
      'description_en' || 'description_ar' => 4,
      _ => 2,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxVideos, PxLocale>(
      builder: (context, v, l, _) {
        return Card.outlined(
          elevation: 0,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          child: Padding(
            padding: const EdgeInsets.all(8.0),
            child: ExpansionTile(
              leading: const CircleAvatar(
                child: Text('@'),
              ),
              title: Text(
                l.isEnglish ? widget.model.title_en : widget.model.title_ar,
              ),
              children: [
                ...Video.editableStrings(context).entries.map((entry) {
                  if (entry.key == 'is_long') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: CheckboxListTile(
                        contentPadding:
                            const EdgeInsets.symmetric(horizontal: 4),
                        controlAffinity: ListTileControlAffinity.trailing,
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry.value),
                        ),
                        value: widget.model.is_long,
                        onChanged: (value) async {
                          if (value != null) {
                            await shellFunction(
                              context,
                              toExecute: () async {
                                await v.updateVideoData(
                                  widget.model.id,
                                  {
                                    entry.key: value,
                                  },
                                );
                              },
                            );
                          }
                        },
                      ),
                    );
                  }
                  if (entry.key == 'thumbnail') {
                    return Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: ExpansionTile(
                        title: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(entry.value),
                        ),
                        children: [
                          ListTile(
                            contentPadding:
                                const EdgeInsets.symmetric(horizontal: 4),
                            trailing: IconButton.outlined(
                              onPressed: () async {
                                final _result =
                                    await FilePicker.platform.pickFiles(
                                  allowMultiple: false,
                                  allowedExtensions:
                                      AppConstants.imageAllowedExtentions,
                                  type: FileType.custom,
                                  withData: true,
                                );
                                if (_result == null) {
                                  return;
                                }

                                if (context.mounted) {
                                  await shellFunction(
                                    context,
                                    toExecute: () async {
                                      await v.updateVideoThumbnail(
                                        id: widget.model.id,
                                        fileBytes:
                                            _result.files.first.bytes ?? [],
                                        fileName_key: 'thumbnail',
                                      );
                                    },
                                  );
                                }
                              },
                              icon: const Icon(Icons.add),
                            ),
                          ),
                          const SizedBox(height: 30),
                          CachedNetworkImage(
                            imageUrl:
                                widget.model.imageUrl(widget.model.thumbnail) ??
                                    '',
                            imageBuilder: (context, imageProvider) => Container(
                              width: MediaQuery.sizeOf(context).width - 60,
                              height: 300,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: imageProvider,
                                  fit: BoxFit.contain,
                                ),
                                border: Border.all(),
                                borderRadius: BorderRadius.circular(8),
                              ),
                            ),
                            placeholder: (context, url) => Center(
                              child: CircularProgressIndicator(),
                            ),
                            errorWidget: (context, url, error) =>
                                Icon(Icons.error),
                          ),
                        ],
                      ),
                    );
                  }
                  return ListTile(
                    contentPadding: const EdgeInsets.symmetric(horizontal: 4),
                    title: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(entry.value),
                    ),
                    subtitle: Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Row(
                        children: [
                          if (_isEditing[entry.key] == true)
                            Expanded(
                              child: TextFormField(
                                controller: _controllers[entry.key]
                                  ?..text = widget.model.toJson()[entry.key],
                                maxLines: _maxLines(entry.key),
                              ),
                            )
                          else
                            Expanded(
                              child: Text(widget.model.toJson()[entry.key]),
                            ),
                          const SizedBox(width: 10),
                          Column(
                            children: [
                              IconButton.outlined(
                                onPressed: _isEditing[entry.key] == false
                                    ? () {
                                        //change to edit
                                        setState(() {
                                          _isEditing[entry.key] = true;
                                        });
                                      }
                                    : () async {
                                        //save changes && cancel edit
                                        await shellFunction(
                                          context,
                                          toExecute: () async {
                                            //todo

                                            final _update = {
                                              entry.key:
                                                  _controllers[entry.key]?.text
                                            };
                                            await v.updateVideoData(
                                              widget.model.id,
                                              _update,
                                            );
                                            setState(() {
                                              _isEditing[entry.key] = false;
                                            });
                                          },
                                        );
                                      },
                                icon: Icon(_isEditing[entry.key] == true
                                    ? Icons.save
                                    : Icons.edit),
                              ),
                              const SizedBox(height: 10),
                              if (_isEditing[entry.key] == true)
                                IconButton.outlined(
                                  onPressed: () {
                                    setState(() {
                                      _isEditing[entry.key] = false;
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
        );
      },
    );
  }
}
