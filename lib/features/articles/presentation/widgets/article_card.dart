import 'package:article_app/features/articles/domain/entities/article.dart';
import 'package:article_app/features/articles/presentation/pages/article_page.dart';
import 'package:flutter/material.dart';

class ArticleCard extends StatelessWidget {
  const ArticleCard({super.key, required this.article});
  final Article article;

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 0,
      child: ListTile(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => ArticlePage(article: article),
            ),
          );
        },
        title: Text(
          article.title,
          maxLines: 1,
          overflow: TextOverflow.ellipsis,
        ),
        subtitle: Text(
          article.body,
          overflow: TextOverflow.ellipsis,
          maxLines: 2,
        ),
        trailing: Icon(Icons.navigate_next_rounded),
      ),
    );
  }
}
