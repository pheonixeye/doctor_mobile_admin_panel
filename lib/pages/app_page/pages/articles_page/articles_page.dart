import 'package:doctor_mobile_admin_panel/components/central_loading.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/articles_page/widgets/article_view_edit_card.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/articles_page/widgets/create_article_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_articles.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlesPage extends StatelessWidget {
  const ArticlesPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        heroTag: 'create-article-dialog',
        child: const Icon(Icons.add),
        onPressed: () async {
          final _article = await showDialog<Article?>(
            context: context,
            builder: (context) {
              return const CreateArticleDialog();
            },
          );
          if (_article == null) {
            return;
          }
          if (context.mounted) {
            await shellFunction(
              context,
              toExecute: () async {
                await context.read<PxArticles>().addNewArticle(_article);
              },
            );
          }
        },
      ),
      body: Consumer<PxArticles>(
        builder: (context, a, _) {
          while (a.articles == null) {
            return const CentralLoading();
          }
          return ListView(
            cacheExtent: 3000,
            restorationId: 'articles-page-items',
            children: [
              ListTile(
                leading: const CircleAvatar(),
                title: Text(context.loc.articles),
                subtitle: const Divider(),
              ),
              if (a.articles == null)
                Center(
                  child: CircularProgressIndicator(),
                )
              else
                ...a.articles!.map((model) {
                  return ArticleViewEditCard(model: model);
                })
            ],
          );
        },
      ),
    );
  }
}
