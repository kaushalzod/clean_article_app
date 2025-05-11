import 'package:article_app/features/articles/presentation/provider/articles_provider.dart';
import 'package:article_app/features/articles/presentation/widgets/article_card.dart';
import 'package:article_app/features/articles/presentation/widgets/search_article.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreenBody extends StatelessWidget {
  const HomeScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    final provider = context.read<ArticlesProvider>();
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 12),
      child: Column(
        spacing: 8,
        children: [
          if (provider.currentIndex == 1)
            SearchArticle(controller: provider.controller),
          Expanded(
            child:
                provider.status == ArticlesStatus.searchLoading
                    ? Center(child: CircularProgressIndicator())
                    : provider.articles.isEmpty
                    ? Center(child: Text("Articles not found"))
                    : ListView.builder(
                      itemCount: provider.articles.length,
                      itemBuilder: (context, index) {
                        return ArticleCard(article: provider.articles[index]);
                      },
                    ),
          ),
        ],
      ),
    );
  }
}
