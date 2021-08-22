import 'package:mobile_challenge/app/core/error/errors.dart';
import 'package:mobile_challenge/app/modules/user/features/search/domain/errors/search_errors.dart';

import '../../domain/entities/searched_user_entity.dart';
import '../../domain/network/network_info.dart';
import '../../domain/repositories/search_user_repository.dart';
import '../datasources/search_user_datasource.dart';

class SearchUserRepositoryImpl implements SearchUserRepository {
  final SearchUserDataSource datasource;
  final NetworkInfo networkInfo;
  SearchUserRepositoryImpl({required this.datasource, required this.networkInfo});
  @override
  Future<List<SearchedUserEntity>> search(String searchText) async{
    if (await networkInfo.isConnected) {
        try {
          final result = await datasource.search(searchText);
          final users = result.map((item) => item.toEntity()).toList();
          return users;

        } on ServerException {
          throw ServerFailure();
        }
    } else {
      throw CacheException();
    }
  }
}