import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/cluster.dart';

class StoryPagerState extends Equatable {
  final Category category;
  final List<Cluster> clusters;
  final int selectedIndex;

  const StoryPagerState({required this.category, this.clusters = const [], this.selectedIndex = 0});

  @override
  List<Object?> get props => [category, clusters, selectedIndex];

  StoryPagerState copyWith({Category? category, List<Cluster>? clusters, int? selectedIndex}) {
    return StoryPagerState(
      category: category ?? this.category,
      clusters: clusters ?? this.clusters,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

sealed class StoryPagerEvent {
  const StoryPagerEvent();
}

final class StoryPagerStarted extends StoryPagerEvent {
  const StoryPagerStarted();
}

final class StoryPagerIndexChanged extends StoryPagerEvent {
  final int index;

  const StoryPagerIndexChanged(this.index);
}

final class StoryPagerPreviousPressed extends StoryPagerEvent {
  const StoryPagerPreviousPressed();
}

final class StoryPagerNextPressed extends StoryPagerEvent {
  const StoryPagerNextPressed();
}

class StoryPagerBloc extends Bloc<StoryPagerEvent, StoryPagerState> {
  final List<Cluster> clusters;

  StoryPagerBloc({required Category category, required this.clusters, required int index})
    : super(StoryPagerState(category: category, clusters: clusters, selectedIndex: index)) {
    on<StoryPagerStarted>((event, emit) {});
    on<StoryPagerIndexChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
    on<StoryPagerPreviousPressed>((event, emit) {
      final newIndex = (state.selectedIndex - 1).clamp(0, state.clusters.length - 1);
      emit(state.copyWith(selectedIndex: newIndex));
    });
    on<StoryPagerNextPressed>((event, emit) {
      final newIndex = (state.selectedIndex + 1).clamp(0, state.clusters.length - 1);
      emit(state.copyWith(selectedIndex: newIndex));
    });
  }
}
