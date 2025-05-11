import 'package:article_app/core/di/get_it.dart';
import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/presentation/provider/favourite_articles_provider.dart';
import 'package:article_app/features/articles/presentation/provider/single_article_provider.dart';
import 'package:article_app/features/articles/presentation/widgets/detail_chip.dart';
import 'package:article_app/features/articles/presentation/widgets/details_container.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class ArticlePage extends StatelessWidget {
  const ArticlePage({super.key, required this.article});
  final Article article;
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create:
              (context) =>
                  getIt<SingleArticleProvider>()..getArticleById(article),
        ),
        ChangeNotifierProvider(
          create: (context) => getIt<FavouriteArticlesProvider>(),
        ),
      ],
      builder: (context, child) {
        return Scaffold(
          appBar: AppBar(title: Text("Article Page")),
          body: Card(
            margin: const EdgeInsets.all(12),
            child: Padding(
              padding: const EdgeInsets.all(12),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisSize: MainAxisSize.min,
                spacing: 10,
                children: [
                  Row(
                    spacing: 8,
                    children: [
                      DetailChip(text: "User Id: ${article.userId}"),
                      DetailChip(text: "Article Id: ${article.id}"),
                      Spacer(),
                      Consumer<SingleArticleProvider>(
                        builder: (context, value, child) {
                          return IconButton(
                            onPressed: () async {
                              value.articles!.isFavourite
                                  ? await context
                                      .read<FavouriteArticlesProvider>()
                                      .removeFavouriteArticle(article)
                                  : await context
                                      .read<FavouriteArticlesProvider>()
                                      .addFavouriteArticle(article);
                              await value.getArticleById(article);
                            },
                            icon:
                                value.articles!.isFavourite
                                    ? Icon(Icons.star_rate_rounded)
                                    : Icon(Icons.star_border_rounded),
                          );
                        },
                      ),
                    ],
                  ),
                  DetailsContainer(title: "Title:", desc: article.title),
                  DetailsContainer(
                    title: "Body:",
                    desc: article.body,
                    descTextStyle: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
