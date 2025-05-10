import 'package:article_app/core/database/local_database.dart';
import 'package:article_app/core/network/dio_client.dart';
import 'package:article_app/features/articles/data/datasource/local_favourite_articles_datasource.dart';
import 'package:article_app/features/articles/data/datasource/remote_articles_datasource.dart';
import 'package:article_app/features/articles/data/repository/article_repository_impl.dart';
import 'package:article_app/features/articles/domain/usecases/add_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/get_article_by_id_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/get_articles_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/get_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/is_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/remove_favourite_article_usecase.dart';
import 'package:article_app/features/articles/domain/usecases/search_articles_usecase.dart';
import 'package:article_app/features/articles/presentation/provider/articles_provider.dart';
import 'package:article_app/features/articles/presentation/provider/favourite_articles_provider.dart';
import 'package:article_app/features/articles/presentation/provider/single_article_provider.dart';
import 'package:get_it/get_it.dart';

final getIt = GetIt.instance;

void setup() async {
  await registerDatabase();
  registerNetworkClient();
  registerDatasource();
  registerRepository();
  registerUsecases();
  registerProviders();
}

Future registerDatabase() async {
  await LocalDatabase.init();
  getIt.registerSingleton(LocalDatabase());
}

void registerNetworkClient() {
  getIt.registerSingleton(DioClient.instance);
}

void registerDatasource() async {
  getIt.registerSingleton(RemoteArticlesDatasource(getIt()));
  getIt.registerSingleton(LocalFavouriteArticlesDatasource(getIt()));
}

void registerRepository() async {
  getIt.registerSingleton(
    ArticleRepositoryImpl(localDatasource: getIt(), remoteDatasource: getIt()),
  );
}

void registerUsecases() {
  getIt.registerSingleton(GetArticlesUsecase(getIt()));
  getIt.registerSingleton(GetArticleByIdUsecase(getIt()));
  getIt.registerSingleton(GetFavouriteArticleUsecase(getIt()));
  getIt.registerSingleton(AddFavouriteArticleUsecase(getIt()));
  getIt.registerSingleton(RemoveFavouriteArticleUsecase(getIt()));
  getIt.registerSingleton(IsFavouriteArticleUsecase(getIt()));
  getIt.registerSingleton(SearchArticlesUsecase(getIt()));
}

void registerProviders() {
  getIt.registerSingleton(
    ArticlesProvider(
      getArticlesUsecase: getIt(),
      searchArticlesUsecase: getIt(),
    ),
  );
  getIt.registerSingleton(
    SingleArticleProvider(
      getArticleByIdUsecase: getIt(),
      isFavouriteArticleUsecase: getIt(),
    ),
  );
  getIt.registerSingleton(
    FavouriteArticlesProvider(
      addFavouriteArticleUsecase: getIt(),
      getFavouriteArticleUsecase: getIt(),
      removeFavouriteArticleUsecase: getIt(),
      isFavouriteArticleUsecase: getIt(),
    ),
  );
}
