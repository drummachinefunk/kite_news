import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:kagi_news/models/category.dart';

import 'package:kagi_news/repositories/news_repository.dart';

abstract class HomeState extends Equatable {
  const HomeState();
}

final class HomeStateInitial extends HomeState {
  const HomeStateInitial();

  @override
  List<Object?> get props => [];
}

final class HomeStateError extends HomeState {
  final String message;

  const HomeStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

class HomeStateLoaded extends HomeState {
  final List<Category> categories;
  final String date;
  final Category category;

  const HomeStateLoaded({
    required this.categories,
    required this.category,
    required this.date,
  });

  @override
  List<Object?> get props => [category, categories, date];

  HomeStateLoaded copyWith({
    Category? category,
    List<Category>? categories,
    String? date,
  }) {
    return HomeStateLoaded(
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

final class HomeReloadPressed extends HomeEvent {
  const HomeReloadPressed();
}

class HomeBloc extends Bloc<HomeEvent, HomeState> {
  final NewsRepository newsRepository;

  HomeBloc({required this.newsRepository}) : super(const HomeStateInitial()) {
    on<HomeStarted>((event, emit) async => _reload(emit));

    on<HomeReloadPressed>((event, emit) async => _reload(emit));

    on<HomeCategoryChanged>((event, emit) {
      if (state is HomeStateLoaded) {
        final currentState = state as HomeStateLoaded;
        if (currentState.category == event.category) return; // No change needed
        emit(currentState.copyWith(category: event.category));
      }
    });
  }

  void _reload(Emitter<HomeState> emit) async {
    try {
      final response = await newsRepository.loadCategories();
      final date = DateTime.fromMillisecondsSinceEpoch(
        response.timestamp * 1000,
      );
      final dateString = DateFormat('EEEE, MMM d').format(date);
      emit(
        HomeStateLoaded(
          categories: response.categories,
          category: response.categories.first,
          date: dateString,
        ),
      );
    } catch (e) {
      emit(
        const HomeStateError(
          message: 'Failed to load categories.\nPlease try again later.',
        ),
      );
    }
  }
}
