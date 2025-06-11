import 'package:cached_network_image/cached_network_image.dart';
import 'package:doctor_mobile_admin_panel/components/generic_confirmation_dialog.dart';
import 'package:doctor_mobile_admin_panel/constants/constants.dart';
import 'package:doctor_mobile_admin_panel/extensions/loc_ext_fns.dart';
import 'package:doctor_mobile_admin_panel/extensions/model_image_url_extractor.dart';
import 'package:doctor_mobile_admin_panel/functions/shell_function.dart';
import 'package:doctor_mobile_admin_panel/models/article.dart';
import 'package:doctor_mobile_admin_panel/models/article_paragraph.dart';
import 'package:doctor_mobile_admin_panel/models/article_response_model.dart';
import 'package:doctor_mobile_admin_panel/pages/app_page/pages/articles_page/widgets/create_paragraph_dialog.dart';
import 'package:doctor_mobile_admin_panel/providers/px_articles.dart';
import 'package:doctor_mobile_admin_panel/providers/px_locale.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticleViewEditCard extends StatefulWidget {
  const ArticleViewEditCard({super.key, required this.model});
  final ArticleResponseModel model;

  @override
  State<ArticleViewEditCard> createState() => _ArticleViewEditCardState();
}

class _ArticleViewEditCardState extends State<ArticleViewEditCard>
    with SingleTickerProviderStateMixin {
  late Map<String, TextEditingController> _controllers;

  //TODO:
  final Map<String, Map<String, TextEditingController>> _controllersParagraph =
      {};

  late Map<String, bool> _isEditing;

  final Map<String, Map<String, bool>> _isEditingParagraph = {};

  late final TabController _tabController;

  late final ExpansibleController _tileController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(
      length: 2,
      vsync: this,
    );
    _tileController = ExpansibleController();
  }

  @override
  void didChangeDependencies() {
    _isEditing = Map.fromEntries(
      Article.editableStrings(context).entries.map(
            (entry) => MapEntry<String, bool>(
              entry.key,
              false,
            ),
          ),
    );

    _controllers = Map.fromEntries(
      Article.editableStrings(context).entries.map(
            (entry) => MapEntry<String, TextEditingController>(
              entry.key,
              TextEditingController(),
            ),
          ),
    );

    widget.model.paragraphs.map((p) {
      _isEditingParagraph[p.id] = {
        ...ArticleParagraph.editableStrings(context).map((k, v) {
          return MapEntry(k, false);
        })
      };
    }).toList();

    widget.model.paragraphs.map((p) {
      _controllersParagraph[p.id] = {
        ...ArticleParagraph.editableStrings(context).map((k, v) {
          return MapEntry(k, TextEditingController());
        })
      };
    }).toList();

    super.didChangeDependencies();
  }

  @override
  void dispose() {
    _tabController.dispose();
    _controllers.entries.map((e) => e.value.dispose()).toList();
    _controllersParagraph.entries
        .map((e) => e.value.values.map((x) => x.dispose()))
        .toList();
    super.dispose();
  }

  int _maxLinesArticles(String key) {
    return switch (key) {
      'description_en' || 'description_ar' => 4,
      _ => 2,
    };
  }

  int _maxLinesParagraph(String key) {
    return switch (key) {
      'body_en' || 'body_ar' => 4,
      _ => 2,
    };
  }

  @override
  Widget build(BuildContext context) {
    return Consumer2<PxLocale, PxArticles>(
      builder: (context, l, a, _) {
        return Card.outlined(
          elevation: 0,
          color: Theme.of(context).primaryColor.withValues(alpha: 0.2),
          child: ExpansionTile(
            controller: _tileController,
            title: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Text(
                l.isEnglish
                    ? widget.model.article.title_en
                    : widget.model.article.title_ar,
              ),
            ),
            subtitle: Row(
              spacing: 10,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                IconButton.outlined(
                  tooltip: context.loc.articleInfo,
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
                const SizedBox(width: 10),
                IconButton.outlined(
                  tooltip: context.loc.articleParagraphs,
                  onPressed: () async {
                    if (_tileController.isExpanded) {
                      setState(() {
                        _tabController.animateTo(1);
                      });
                    }
                  },
                  isSelected: _tabController.index == 1,
                  icon: const Icon(Icons.description),
                ),
                const SizedBox(width: 10),
                IconButton.outlined(
                  tooltip: context.loc.deleteClinic,
                  onPressed: () async {
                    final _toDelete = await showDialog<bool?>(
                      context: context,
                      builder: (context) {
                        return GenericConfirmationDialog(
                          title: context.loc.deleteArticle,
                          message: context.loc.deleteArticleConfirmation,
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
                          await a.deleteArticle(widget.model.article.id);
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
            children: [
              Container(
                decoration: BoxDecoration(),
                height: MediaQuery.sizeOf(context).height -
                    (MediaQuery.sizeOf(context).height * 0.2),
                width: MediaQuery.sizeOf(context).width,
                child: TabBarView(
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  children: [
                    //article main info
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
                                  title: Text(context.loc.articleInfo),
                                  subtitle: Divider(),
                                ),
                                ...Article.editableStrings(context)
                                    .entries
                                    .map((entry) {
                                  if (entry.key == 'thumbnail') {
                                    return ExpansionTile(
                                      controlAffinity:
                                          ListTileControlAffinity.leading,
                                      title: Text(entry.value),
                                      trailing: IconButton.outlined(
                                        onPressed: () async {
                                          final _result = await FilePicker
                                              .platform
                                              .pickFiles(
                                            allowMultiple: false,
                                            allowedExtensions: AppConstants
                                                .imageAllowedExtentions,
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
                                                await a.updateArticleTumbnail(
                                                  id: widget.model.article.id,
                                                  fileBytes: _result
                                                          .files.first.bytes ??
                                                      [],
                                                  fileName_key:
                                                      '${entry.key}.${_result.xFiles.first.name.split('.').last}',
                                                );
                                              },
                                            );
                                          }
                                        },
                                        icon: const Icon(Icons.add),
                                      ),
                                      children: [
                                        CachedNetworkImage(
                                          imageUrl: widget.model.article
                                                  .imageUrl(widget.model.article
                                                      .toJson()[entry.key]) ??
                                              '',
                                          imageBuilder:
                                              (context, imageProvider) =>
                                                  Container(
                                            width: MediaQuery.sizeOf(context)
                                                    .width -
                                                60,
                                            height: 300,
                                            decoration: BoxDecoration(
                                              image: DecorationImage(
                                                image: imageProvider,
                                                fit: BoxFit.contain,
                                              ),
                                              border: Border.all(),
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                            ),
                                          ),
                                          placeholder: (context, url) => Center(
                                            child: CircularProgressIndicator(),
                                          ),
                                          errorWidget: (context, url, error) =>
                                              Icon(Icons.error),
                                        ),
                                      ],
                                    );
                                  }
                                  return ListTile(
                                    title: Text(entry.value),
                                    contentPadding:
                                        EdgeInsets.symmetric(horizontal: 4),
                                    subtitle: Padding(
                                      padding: const EdgeInsets.all(8.0),
                                      child: Row(
                                        children: [
                                          if (_isEditing[entry.key] == true)
                                            Expanded(
                                              child: TextFormField(
                                                maxLines: _maxLinesArticles(
                                                    entry.key),
                                                controller:
                                                    _controllers[entry.key]
                                                      ?..text = widget
                                                          .model.article
                                                          .toJson()[entry.key],
                                              ),
                                            )
                                          else
                                            Expanded(
                                              child: Text(widget.model.article
                                                  .toJson()[entry.key]),
                                            ),
                                          const SizedBox(width: 10),
                                          Column(
                                            children: [
                                              IconButton.outlined(
                                                onPressed:
                                                    _isEditing[entry.key] ==
                                                            false
                                                        ? () {
                                                            //change to edit
                                                            setState(() {
                                                              _isEditing[entry
                                                                  .key] = true;
                                                            });
                                                          }
                                                        : () async {
                                                            //save changes && cancel edit
                                                            await shellFunction(
                                                              context,
                                                              toExecute: () {
                                                                a.updateArticleData(
                                                                  widget
                                                                      .model
                                                                      .article
                                                                      .id,
                                                                  {
                                                                    entry.key:
                                                                        _controllers[entry.key]!
                                                                            .text
                                                                  },
                                                                );

                                                                setState(() {
                                                                  _isEditing[entry
                                                                          .key] =
                                                                      false;
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
                                              const SizedBox(width: 10),
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
                    //end of article data container
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
                                  title: Text(context.loc.articleParagraphs),
                                  subtitle: Divider(),
                                  trailing: IconButton.outlined(
                                    onPressed: () async {
                                      final _paragraph =
                                          await showDialog<ArticleParagraph?>(
                                        context: context,
                                        builder: (context) {
                                          return CreateParagraphDialog(
                                            article_id: widget.model.article.id,
                                          );
                                        },
                                      );
                                      if (_paragraph == null) {
                                        return;
                                      }
                                      if (context.mounted) {
                                        await shellFunction(
                                          context,
                                          toExecute: () async {
                                            await a.addParagraphToArticle(
                                                _paragraph);
                                          },
                                        );
                                      }
                                    },
                                    icon: const Icon(Icons.add),
                                  ),
                                ),
                                ...widget.model.paragraphs.map((para) {
                                  return ExpansionTile(
                                    backgroundColor: Theme.of(context)
                                        .primaryColor
                                        .withValues(alpha: 0.1),
                                    controlAffinity:
                                        ListTileControlAffinity.leading,
                                    title: Text(
                                      l.isEnglish
                                          ? para.title_en
                                          : para.title_ar,
                                    ),
                                    trailing: IconButton.outlined(
                                      onPressed: () async {
                                        final _toDelete = await showDialog(
                                          context: context,
                                          builder: (context) {
                                            return GenericConfirmationDialog(
                                              title:
                                                  context.loc.deleteParagraph,
                                              message: context.loc
                                                  .deleteParagraphConfirmation,
                                            );
                                          },
                                        );
                                        if (_toDelete == null ||
                                            _toDelete == false) {
                                          return;
                                        }
                                        if (context.mounted) {
                                          await shellFunction(
                                            context,
                                            toExecute: () async {
                                              await a.deleteParagraph(para.id);
                                            },
                                          );
                                        }
                                      },
                                      icon: const Icon(
                                        Icons.delete,
                                        color: Colors.red,
                                      ),
                                    ),
                                    children: [
                                      ...ArticleParagraph.editableStrings(
                                              context)
                                          .entries
                                          .map((entry) {
                                        return ListTile(
                                          contentPadding: EdgeInsets.symmetric(
                                              horizontal: 4),
                                          title: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Text(entry.value),
                                          ),
                                          subtitle: Padding(
                                            padding: const EdgeInsets.all(8.0),
                                            child: Row(
                                              children: [
                                                if (_isEditingParagraph[para.id]
                                                        ?[entry.key] ==
                                                    false)
                                                  Expanded(
                                                    child: Text(para
                                                        .toJson()[entry.key]),
                                                  )
                                                else
                                                  Expanded(
                                                    child: TextFormField(
                                                      maxLines:
                                                          _maxLinesParagraph(
                                                              entry.key),
                                                      controller:
                                                          _controllersParagraph[
                                                                  para.id]
                                                              ?[entry.key]
                                                            ?..text =
                                                                para.toJson()[
                                                                    entry.key],
                                                    ),
                                                  ),
                                                const SizedBox(width: 10),
                                                Column(
                                                  children: [
                                                    IconButton.outlined(
                                                      onPressed:
                                                          _isEditingParagraph[
                                                                          para.id]
                                                                      ?[entry
                                                                          .key] ==
                                                                  false
                                                              ? () {
                                                                  //change to edit
                                                                  setState(() {
                                                                    _isEditingParagraph[
                                                                        para
                                                                            .id]?[entry
                                                                        .key] = true;
                                                                  });
                                                                }
                                                              : () async {
                                                                  //save changes && cancel edit
                                                                  await shellFunction(
                                                                    context,
                                                                    toExecute:
                                                                        () async {
                                                                      //todo

                                                                      final _update =
                                                                          {
                                                                        entry.key:
                                                                            _controllersParagraph[para.id]?[entry.key]?.text
                                                                      };
                                                                      await a
                                                                          .updateParagraphData(
                                                                        para.id,
                                                                        _update,
                                                                      );
                                                                      setState(
                                                                          () {
                                                                        _isEditingParagraph[
                                                                            para
                                                                                .id]?[entry
                                                                            .key] = false;
                                                                      });
                                                                    },
                                                                  );
                                                                },
                                                      icon: Icon(
                                                          _isEditingParagraph[
                                                                          para.id]
                                                                      ?[entry
                                                                          .key] ==
                                                                  true
                                                              ? Icons.save
                                                              : Icons.edit),
                                                    ),
                                                    const SizedBox(height: 10),
                                                    if (_isEditingParagraph[para
                                                            .id]?[entry.key] ==
                                                        true)
                                                      IconButton.outlined(
                                                        onPressed: () {
                                                          setState(() {
                                                            _isEditingParagraph[
                                                                        para.id]
                                                                    ?[
                                                                    entry.key] =
                                                                false;
                                                          });
                                                        },
                                                        icon: const Icon(
                                                            Icons.close),
                                                      ),
                                                  ],
                                                ),
                                                const SizedBox(width: 10),
                                              ],
                                            ),
                                          ),
                                        );
                                      }),
                                    ],
                                  );
                                }),
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
