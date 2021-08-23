import 'dart:async';

import 'package:mobx/mobx.dart';

import '../../../../core/error/failures.dart';
import '../../domain/entities/user_entity.dart';
import '../../domain/usecases/search_user.dart';

part 'search_page_controller.g.dart';

enum SearchPageState{IDLE,LOADING, NO_INTERNET}

class SearchPageController = _SearchPageControllerBase with _$SearchPageController;

abstract class _SearchPageControllerBase with Store {
  ObservableList<UserEntity> searchedUsers = ObservableList();
  late final SearchUser usecase;

  @observable
  SearchPageState state = SearchPageState.IDLE;

  _SearchPageControllerBase(this.usecase);


  @action
  Future<Null> searchUsers(String searchText) async{
    state = SearchPageState.LOADING;
    searchedUsers.clear();
    
    try {
      final result = await usecase(searchText);
      searchedUsers.addAll(result);
    } on ServerFailure {
      //Delay gives the user a feedback that something happens after he types some text
      await Future.delayed(Duration(milliseconds: 300))
        .then((_) => state = SearchPageState.NO_INTERNET);    
      return;
    } catch(exception) {}

    state = SearchPageState.IDLE;
  }
}