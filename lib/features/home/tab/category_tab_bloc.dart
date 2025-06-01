import 'package:equatable/equatable.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/cluster.dart';
import 'package:kagi_news/repositories/news_repository.dart';

class CategoryTabState extends Equatable {
  final List<Cluster> clusters;

  const CategoryTabState({this.clusters = const []});

  @override
  List<Object?> get props => [clusters];

  CategoryTabState copyWith({List<Cluster>? clusters}) {
    return CategoryTabState(clusters: clusters ?? this.clusters);
  }
}

sealed class CategoryTabEvent {
  const CategoryTabEvent();
}

final class CategoryTabStarted extends CategoryTabEvent {
  const CategoryTabStarted();
}

class CategoryTabBloc extends Bloc<CategoryTabEvent, CategoryTabState> {
  final Category category;
  final NewsRepository newsRepository;

  CategoryTabBloc({required this.category, required this.newsRepository})
    : super(const CategoryTabState()) {
    on<CategoryTabStarted>((event, emit) async {
      try {
        final response = await newsRepository.loadCategory(category);
        emit(state.copyWith(clusters: response.clusters));
      } catch (e) {
        // Handle error, possibly emit an error state
        debugPrint('Error loading category: $e');
      }
    });
  }
}
