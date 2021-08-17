import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/favorites/domain/entities/user_favorite.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/datasources/get_favorites_datasource.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/models/user_favorite_model.dart';
import 'package:mobile_challenge/app/modules/favorites/infra/repositories/favorites_repository_impl.dart';
import 'package:mocktail/mocktail.dart';

class GetFavoritesDataSourceMock extends Mock implements GetFavoritesDataSource {}

void main() {
  test('Should return a list of UserFavorites', () async {
    final datasource = GetFavoritesDataSourceMock();
    final repository = FavoritesRepositoryImpl(datasource);

    when(() => datasource.getFavorites()).thenAnswer((_) async => <UserFavoriteModel>[]);

    final result = await repository.getFavorites();

    expect(result, isA<List<UserFavorite>>());
  });
}