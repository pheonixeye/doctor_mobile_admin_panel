import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:doctor_mobile_admin_panel/extensions/model_image_url_extractor.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/hero_item.dart';
import 'package:doctor_mobile_admin_panel/providers/px_hero_items.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HeroItemImagePicker extends StatelessWidget {
  const HeroItemImagePicker({
    super.key,
    required this.item,
    required this.imageKey,
    required this.title,
  });
  final HeroItem item;
  final String imageKey;
  final String title;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(4.0),
      child: Card.outlined(
        color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
        elevation: 0,
        child: ListTile(
          title: Row(
            children: [
              Expanded(
                child: Text(title),
              ),
              IconButton.outlined(
                onPressed: () async {
                  final _result = await FilePicker.platform.pickFiles(
                    allowMultiple: false,
                    allowedExtensions: AppConstants.imageAllowedExtentions,
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
                        await context.read<PxHeroItems>().updateHeroItemImage(
                              id: item.id,
                              fileBytes: _result.files.first.bytes ?? [],
                              fileName_key:
                                  '$imageKey.${_result.xFiles.first.name.split('.').last}',
                            );
                      },
                    );
                  }
                },
                icon: const Icon(Icons.add),
              ),
              SizedBox(width: 10),
            ],
          ),
          subtitle: Padding(
            padding: const EdgeInsets.all(8.0),
            child: CachedNetworkImage(
              imageUrl: item.imageUrl(item.toJson()[imageKey] ?? '') ?? '',
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
              errorWidget: (context, url, error) => Icon(Icons.error),
            ),
          ),
        ),
      ),
    );
  }
}
