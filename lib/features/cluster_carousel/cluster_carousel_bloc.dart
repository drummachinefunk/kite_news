import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/cluster.dart';

class ClusterCarouselState extends Equatable {
  final List<Cluster> clusters;
  final int selectedIndex;

  const ClusterCarouselState({this.clusters = const [], this.selectedIndex = 0});

  @override
  List<Object?> get props => [clusters, selectedIndex];

  ClusterCarouselState copyWith({List<Cluster>? clusters, int? selectedIndex}) {
    return ClusterCarouselState(
      clusters: clusters ?? this.clusters,
      selectedIndex: selectedIndex ?? this.selectedIndex,
    );
  }
}

sealed class ClusterCarouselEvent {
  const ClusterCarouselEvent();
}

final class ClusterCarouselStarted extends ClusterCarouselEvent {
  const ClusterCarouselStarted();
}

final class ClusterCarouselIndexChanged extends ClusterCarouselEvent {
  final int index;

  const ClusterCarouselIndexChanged(this.index);
}

class ClusterCarouselBloc extends Bloc<ClusterCarouselEvent, ClusterCarouselState> {
  final List<Cluster> clusters;

  ClusterCarouselBloc({required this.clusters, required int index})
    : super(ClusterCarouselState(clusters: clusters, selectedIndex: index)) {
    on<ClusterCarouselStarted>((event, emit) {
      //
    });
    on<ClusterCarouselIndexChanged>((event, emit) {
      emit(state.copyWith(selectedIndex: event.index));
    });
  }
}
