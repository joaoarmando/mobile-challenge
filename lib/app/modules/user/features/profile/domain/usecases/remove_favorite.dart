import '../../../profile/domain/repositories/favorites_repository.dart';
import '../entities/user_detail_entity.dart';

abstract class RemoveFavorite {
  Future<bool> removeUserFavorite(UserDetailEntity user);
}

class RemoveFavoriteImpl implements RemoveFavorite {
  final FavoritesRepository repository;

  RemoveFavoriteImpl(this.repository);
  @override
  Future<bool> removeUserFavorite(UserDetailEntity user) async {
    return await repository.removeFavorite(user);
  }

}