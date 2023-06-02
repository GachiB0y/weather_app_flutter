// ignore_for_file: public_member_api_docs, sort_constructors_first
import 'dart:convert';
import 'dart:math';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class SearchViewState {
  List<String> _listItems = [];
  List<String> get itemsGet => _listItems;
  set itemSet(String val) => _listItems.add(val);

  SearchViewState({
    required List<String> listItems,
  }) : _listItems = listItems;

  SearchViewState copyWith({
    List<String>? listItems,
  }) {
    return SearchViewState(
      listItems: listItems ?? this._listItems,
    );
  }

  @override
  bool operator ==(covariant SearchViewState other) {
    if (identical(this, other)) return true;

    return listEquals(other._listItems, _listItems);
  }

  @override
  int get hashCode => _listItems.hashCode;

  Map<String, dynamic> toMap() {
    return <String, dynamic>{
      '_listItems': _listItems,
    };
  }

  factory SearchViewState.fromMap(Map<String, dynamic> map) {
    return SearchViewState(
      listItems: List<String>.from((map['_listItems'] as List<String>)),
    );
  }

  String toJson() => json.encode(toMap());

  factory SearchViewState.fromJson(String source) =>
      SearchViewState.fromMap(json.decode(source) as Map<String, dynamic>);

  @override
  String toString() => 'SearchViewState(_listItems: $_listItems)';
}

class SearchViewCubit extends Cubit<SearchViewState> {
  SearchViewCubit() : super(SearchViewState(listItems: [])) {}

  void createListItems(String query) {
    final List<String> newListItems = [...state.itemsGet];
    newListItems.add(query);
    if (newListItems.length > 5) {
      newListItems.removeAt(0);
    }
    ;
    final list = newListItems.reversed.toList();
    final newState = state.copyWith(listItems: list);
    emit(newState);
  }
}
