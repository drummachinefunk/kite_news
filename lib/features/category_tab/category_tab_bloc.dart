import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/cluster.dart';
import 'package:kagi_news/repositories/news_repository.dart';

abstract class CategoryTabState extends Equatable {
  const CategoryTabState();
}

final class CategoryTabStateInitial extends CategoryTabState {
  const CategoryTabStateInitial();

  @override
  List<Object?> get props => [];
}

final class CategoryTabStateError extends CategoryTabState {
  final String message;

  const CategoryTabStateError({required this.message});

  @override
  List<Object?> get props => [message];
}

final class CategoryTabStateLoaded extends CategoryTabState {
  final List<Cluster> clusters;

  const CategoryTabStateLoaded({this.clusters = const []});

  @override
  List<Object?> get props => [clusters];

  CategoryTabStateLoaded copyWith({List<Cluster>? clusters}) {
    return CategoryTabStateLoaded(clusters: clusters ?? this.clusters);
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
    : super(const CategoryTabStateInitial()) {
    on<CategoryTabStarted>((event, emit) async {
      try {
        final response = await newsRepository.loadCategory(category);
        emit(CategoryTabStateLoaded(clusters: response.clusters));
      } catch (e) {
        emit(
          const CategoryTabStateError(
            message: 'Failed to load category.\nPlease try again later.',
          ),
        );
      }
    });
  }
}
