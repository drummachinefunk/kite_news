import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/category.dart';

import 'package:kagi_news/repositories/news_repository.dart';

class HomeState extends Equatable {
  final List<Category> categories;
  final Category category;

  const HomeState({required this.categories, required this.category});

  @override
  List<Object?> get props => [category, categories];

  HomeState copyWith({Category? category, List<Category>? categories}) {
    return HomeState(
      category: category ?? this.category,
      categories: categories ?? this.categories,
    );
  }
}

sealed class HomeEvent {
  const HomeEvent();
}

final class HomeStarted extends HomeEvent {
  const HomeStarted();
}

final class HomePrevPressed extends HomeEvent {
  const HomePrevPressed();
}

final class HomeNextPressed extends HomeEvent {
  const HomeNextPressed();
}

final class HomeCategoryChanged extends HomeEvent {
  final Category category;

  const HomeCategoryChanged(this.category);
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsRepository newsRepository;

  HomeBloc({required this.newsRepository})
    : super(const HomeState(categories: [], category: Category(name: '', file: ''))) {
    on<HomeStarted>((event, emit) async {
      try {
        final response = await newsRepository.loadCategories();
        emit(state.copyWith(categories: response.categories, category: response.categories.first));
      } catch (e) {
        // Handle error, possibly emit an error state
        debugPrint('Error loading categories: $e');
      }
    });

    on<HomePrevPressed>((event, emit) {
      final currentIndex = state.categories.indexOf(state.category);
      if (currentIndex > 0) {
        emit(state.copyWith(category: state.categories[currentIndex - 1]));
      }
    });
    on<HomeNextPressed>((event, emit) {
      final currentIndex = state.categories.indexOf(state.category);
      if (currentIndex < state.categories.length - 1) {
        emit(state.copyWith(category: state.categories[currentIndex + 1]));
      }
    });
    on<HomeCategoryChanged>((event, emit) {
      emit(state.copyWith(category: event.category));
    });
  }
}
