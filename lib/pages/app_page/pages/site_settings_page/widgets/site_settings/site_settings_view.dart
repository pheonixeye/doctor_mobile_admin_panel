import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:doctor_mobile_admin_panel/extensions/for_widgets_on_site_settings.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/extensions/model_image_url_extractor.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/site_settings.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/site_settings/widgets/site_settings_item.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/site_settings_page/widgets/site_settings/widgets/site_settings_item_header.dart';
import 'package:doctor_mobile_admin_panel/providers/px_site_settings.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class SiteSettingsView extends StatefulWidget {
  const SiteSettingsView({super.key});

  @override
  State<SiteSettingsView> createState() => _SiteSettingsViewState();
}

class _SiteSettingsViewState extends State<SiteSettingsView> {
  late Map<String, TextEditingController> _controllers;
  late Map<String, bool> _isEditing;
  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      SiteSettings.forWidgetsJson().map(
        (entry) => MapEntry<String, bool>(
          entry,
          false,
        ),
      ),
    );
    _controllers = Map.fromEntries(
      SiteSettings.forWidgetsJson().map(
        (entry) => MapEntry<String, TextEditingController>(
          entry,
          TextEditingController(),
        ),
      ),
    );
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<PxSiteSettings>(
      builder: (context, s, _) {
        return ListView(
          cacheExtent: 3000,
          children: [
            ListTile(
              leading: const CircleAvatar(),
              title: Text(context.loc.siteSettings),
              subtitle: const Divider(),
            ),
            if (s.settings == null)
              Padding(
                padding: const EdgeInsets.only(top: 280.0),
                child: const CentralLoading(),
              )
            else ...[
              ExpansionTile(
                title: SiteSettingsItemHeader(
                  header: context.loc.websiteBackground,
                  forBackground: true,
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
                          await s.updateSiteSettingsBackground(
                            id: s.settings!.id,
                            fileBytes: _result.files.first.bytes ?? [],
                            fileName_key:
                                'website_background.${_result.xFiles.first.name.split('.').last}',
                          );
                        },
                      );
                    }
                  },
                ),
                initiallyExpanded: true,
                children: [
                  CachedNetworkImage(
                    imageUrl: s.settings
                            ?.imageUrl(s.settings?.website_background ?? '') ??
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
                    errorWidget: (context, url, error) => Icon(Icons.error),
                  ),
                ],
              ),
              ExpansionTile(
                title: SiteSettingsItemHeader(
                    header: context.loc.websiteMainTitle),
                initiallyExpanded: true,
                children: [
                  ...s.settings!
                      .websiteTitleSettings(context)
                      .entries
                      .map((entry) {
                    return SiteSettingsItem(
                      isEditing: _isEditing[entry.key]!,
                      entry: entry,
                      controller: _controllers[entry.key]!,
                    );
                  }),
                ],
              ),
              ExpansionTile(
                title:
                    SiteSettingsItemHeader(header: context.loc.websiteTitles),
                initiallyExpanded: true,
                children: [
                  ...s.settings!.titlesSettings(context).entries.map((entry) {
                    return SiteSettingsItem(
                      isEditing: _isEditing[entry.key]!,
                      entry: entry,
                      controller: _controllers[entry.key]!,
                    );
                  }),
                ],
              ),
              ExpansionTile(
                title: SiteSettingsItemHeader(
                    header: context.loc.websiteSubtitles),
                initiallyExpanded: true,
                children: [
                  ...s.settings!
                      .subtitlesSettings(context)
                      .entries
                      .map((entry) {
                    return SiteSettingsItem(
                      isEditing: _isEditing[entry.key]!,
                      entry: entry,
                      controller: _controllers[entry.key]!,
                    );
                  }),
                ],
              ),
              ExpansionTile(
                title: SiteSettingsItemHeader(header: context.loc.websiteText),
                initiallyExpanded: true,
                children: [
                  ...s.settings!.textSettings(context).entries.map((entry) {
                    return SiteSettingsItem(
                      isEditing: _isEditing[entry.key]!,
                      entry: entry,
                      controller: _controllers[entry.key]!,
                    );
                  }),
                ],
              ),
              ExpansionTile(
                title:
                    SiteSettingsItemHeader(header: context.loc.websiteButtons),
                initiallyExpanded: true,
                children: [
                  ...s.settings!.buttonSettings(context).entries.map((entry) {
                    return SiteSettingsItem(
                      isEditing: _isEditing[entry.key]!,
                      entry: entry,
                      controller: _controllers[entry.key]!,
                    );
                  }),
                ],
              ),
            ],
          ],
        );
      },
    );
  }
}
