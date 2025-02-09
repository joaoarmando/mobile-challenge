import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/domain/entities/user_entity.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/get_favorites.dart';
import 'package:mocktail/mocktail.dart';

class FavoritesRepositoryMock extends Mock implements FavoritesRepository {}

void main() {
  test('Should return a list of UserFavorites', () async {
    final repository = FavoritesRepositoryMock();
    final usecase = GetFavoritesImpl(repository);
    when(() => repository.getFavorites()).thenAnswer((_) async => <UserEntity>[]);

    final result = await usecase();

    expect(result, isA<List<UserEntity>>());
  });
}