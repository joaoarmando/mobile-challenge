import 'dart:convert';

import 'package:flutter_test/flutter_test.dart';
import 'package:mobile_challenge/app/modules/user/domain/repositories/favorites_repository.dart';
import 'package:mobile_challenge/app/modules/user/domain/usecases/verify_favorite.dart';
import 'package:mobile_challenge/app/modules/user/data/models/user_detail_model.dart';
import 'package:mobile_challenge/app/modules/user/data/models/users_detail_model.dart';
import 'package:mocktail/mocktail.dart';

import '../../../fixtures/fixture_reader.dart';


class FavoriteUserRepositoryMock extends Mock implements FavoritesRepository {}
void main() {
  late final FavoriteUserRepositoryMock repository;
  late final VerifyFavorite usecase;
  final UsersDetailModel tUserList = UsersDetailModel
      .fromMap(jsonDecode(fixture("user_detail_list.json")));
      
  final UserDetailModel tUserFavorite = tUserList.users[0];
  final UserDetailModel tUserNotFavorite = tUserList.users[1];

  setUpAll(() {
    repository = FavoriteUserRepositoryMock();
    usecase = VerifyFavoriteImpl(repository);
  });

  test('Should return true if a user is a favorite', () async {
    final tUserEntity = tUserFavorite.toEntity();  
    when(() => repository.verifyFavorite(tUserEntity)).thenAnswer((_) async => true);

    final result = await usecase(tUserEntity);

    expect(result, equals(true));    
  });

  test('Should return false if a user is not a favorite', () async {
    final tUserEntity = tUserNotFavorite.toEntity();
    when(() => repository.verifyFavorite(tUserEntity)).thenAnswer((_) async => false);

    final result = await usecase(tUserEntity);

    expect(result, equals(false));    
  });
}