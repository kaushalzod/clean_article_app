import 'package:article_app/core/di/get_it.dart';
import 'package:article_app/features/articles/presentation/provider/favourite_articles_provider.dart';
import 'package:article_app/features/articles/presentation/widgets/article_card.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FavouritesArticlesPage extends StatelessWidget {
  const FavouritesArticlesPage({super.key});
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) {
        return getIt<FavouriteArticlesProvider>()..getFavouriteArticles();
      },
      child: Scaffold(
        appBar: AppBar(title: Text("Favourites")),
        body: Consumer<FavouriteArticlesProvider>(
          builder: (context, provider, child) {
            if (provider.status == FavouriteArticlesStatus.loading) {
              return Center(child: CircularProgressIndicator());
            }
            if (provider.status == FavouriteArticlesStatus.error) {
              return Center(child: Text(provider.errorMessage));
            }
            if (provider.status == FavouriteArticlesStatus.success) {
              if (provider.favouriteArticles.isEmpty)
                return Center(child: Text("No Favourites Found"));
              return ListView.builder(
                itemCount: provider.favouriteArticles.length,
                itemBuilder: (context, index) {
                  return ArticleCard(
                    article: provider.favouriteArticles[index],
                  );
                },
              );
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
