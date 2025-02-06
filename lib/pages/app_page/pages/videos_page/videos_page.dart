import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/video.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/videos_page/widgets/create_video_dialog.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/videos_page/widgets/video_view_edit_card.dart';
import 'package:doctor_mobile_admin_panel/providers/px_videos.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class VideosPage extends StatefulWidget {
  const VideosPage({super.key});

  @override
  State<VideosPage> createState() => _VideosPageState();
}

class _VideosPageState extends State<VideosPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-service-dialog',
        child: const Icon(Icons.add),
        onPressed: () async {
          final _video = await showDialog<Video?>(
            context: context,
            builder: (context) {
              return const CreateVideoDialog();
            },
          );
          if (_video == null) {
            return;
          }
          if (context.mounted) {
            await shellFunction(
              context,
              toExecute: () async {
                await context.read<PxVideos>().createVideo(_video);
              },
            );
          }
        },
      ),
      body: Consumer<PxVideos>(
        builder: (context, v, _) {
          while (v.videos == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'videos-page-items',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.videos),
                subtitle: const Divider(),
              ),
              if (v.videos == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ...v.videos!.map((model) {
                  return VideoViewEditCard(model: model);
                })
            ],
          );
        },
      ),
    );
  }
}
