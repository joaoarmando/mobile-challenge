import 'dart:convert';

import 'package:shared_preferences/shared_preferences.dart';

import '../../../../../shared/utils/prefs_key.dart';
import '../domain/entities/user_favorite_entity.dart';
import '../domain/errors/favorites_errors.dart';
import '../infra/datasources/favorites_datasource.dart';
import '../infra/models/user_favorite_model.dart';
import '../infra/models/users_favorite_model.dart';

class LocalFavoritesDatasource implements FavoritesDataSource {
  final SharedPreferences prefs;
  LocalFavoritesDatasource(this.prefs);

  List<UserFavoriteModel> favorites = [];
  @override
  Future<List<UserFavoriteModel>> getFavorites() async {
    final savedFavorites = prefs.getString(PrefsKey.CACHED_FAVORITES);

    if (savedFavorites != null) {
        favorites = UsersFavoriteModel.fromMap(jsonDecode(savedFavorites)).favorites;
        return favorites;
    }

    throw Exception();
  }

  @override
  Future<bool> saveFavorite(UserFavoriteEntity user) async {
    try {
      await getFavorites();
    } catch (error){}

    final userModel = UserFavoriteModel.fromEntity(user);
    final alreadyAdded = _checkIfAlreadyFavorite(userModel);

    if (alreadyAdded) throw FavoriteAlreadyExists();

    favorites.add(userModel);
    return await _updateFavoritesSharedPreferences();
  }

  @override
  Future<bool> removeFavorite(UserFavoriteEntity user) async {
    try {
      await getFavorites();
    } catch (error){}

    final index = favorites.indexWhere((item) => item.login == user.login);

    if (index == -1) throw FavoriteDoesntExists();

    favorites.removeAt(index);   

    return await _updateFavoritesSharedPreferences();
  }

  bool _checkIfAlreadyFavorite(UserFavoriteModel user) {
    for (final favorite in favorites) {
        if (favorite.login == user.login) {
            return true;
        }
    }
    return false;
  }

  Future _updateFavoritesSharedPreferences() async {
    final newFavorites = UsersFavoriteModel(favorites: favorites);
    final json =  newFavorites.toJson();
    return await prefs.setString(PrefsKey.CACHED_FAVORITES, json);
  }

  @override
  Future<bool> verifyFavorite(String userId) {
    // TODO: implement verifyFavorite
    throw UnimplementedError();
  }

}