import 'package:equatable/equatable.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/category.dart';

import 'package:kagi_news/repositories/news_repository.dart';

class HomeState extends Equatable {
  final List<Category> categories;
  final DateTime date;
  final Category category;

  const HomeState({required this.categories, required this.category, required this.date});

  @override
  List<Object?> get props => [category, categories, date];

  HomeState copyWith({Category? category, List<Category>? categories, DateTime? date}) {
    return HomeState(
      category: category ?? this.category,
      categories: categories ?? this.categories,
      date: date ?? this.date,
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
    : super(
        HomeState(
          categories: const [],
          category: const Category(name: '', file: ''),
          date: DateTime(0),
        ),
      ) {
    on<HomeStarted>((event, emit) async {
      try {
        final response = await newsRepository.loadCategories();
        emit(
          state.copyWith(
            categories: response.categories,
            category: response.categories.first,
            date: DateTime.fromMillisecondsSinceEpoch(response.timestamp * 1000),
          ),
        );
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
