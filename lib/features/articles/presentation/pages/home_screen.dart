import 'package:article_app/features/articles/presentation/provider/articles_provider.dart';
import 'package:article_app/features/articles/presentation/widgets/home_bottom_navigation.dart';
import 'package:article_app/features/articles/presentation/widgets/home_screen_body.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});
  @override
  Widget build(BuildContext context) {
    return Consumer<ArticlesProvider>(
      builder: (context, provider, child) {
        return Scaffold(
          appBar: AppBar(
            title: Text(
              provider.currentIndex == 1 ? "Search Page" : "Home Page",
            ),
            leading:
                provider.currentIndex == 1
                    ? IconButton(
                      onPressed: () => provider.changeIndex(0),
                      icon: Icon(Icons.arrow_back),
                    )
                    : null,
          ),
          bottomNavigationBar: HomeBottomNavigation(),
          body: RefreshIndicator(
            onRefresh: () => provider.getArticles(),
            child: Builder(
              builder: (context) {
                if (provider.status == ArticlesStatus.loading) {
                  return Center(child: CircularProgressIndicator());
                }
                if (provider.status == ArticlesStatus.error) {
                  return Center(child: Text(provider.errorMessage));
                }
                if (provider.status == ArticlesStatus.success ||
                    provider.status == ArticlesStatus.searchLoading) {
                  return HomeScreenBody();
                }
                return const SizedBox.shrink();
              },
            ),
          ),
        );
      },
    );
  }
}
