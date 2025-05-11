import 'package:article_app/features/articles/presentation/pages/favourites_articles_page.dart';
import 'package:article_app/features/articles/presentation/provider/articles_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class HomeBottomNavigation extends StatelessWidget {
  const HomeBottomNavigation({super.key});

  @override
  Widget build(BuildContext context) {
    return Selector<ArticlesProvider, int>(
      selector: (p0, p1) => p1.currentIndex,
      builder:
          (context, value, child) => BottomNavigationBar(
            currentIndex: context.read<ArticlesProvider>().currentIndex,
            onTap: (value) {
              if (value != 2) {
                context.read<ArticlesProvider>().changeIndex(value);
              } else {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => FavouritesArticlesPage(),
                  ),
                );
              }
            },
            items: [
              BottomNavigationBarItem(
                icon: Icon(Icons.home_rounded),
                label: "Home",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.search),
                label: "Search",
              ),
              BottomNavigationBarItem(
                icon: Icon(Icons.star_border_rounded),
                label: "Favourites",
              ),
            ],
          ),
    );
  }
}
