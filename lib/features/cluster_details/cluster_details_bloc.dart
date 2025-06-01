import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/cluster.dart';

class ClusterDetailsState extends Equatable {
  final Cluster cluster;

  const ClusterDetailsState({required this.cluster});

  @override
  List<Object?> get props => [cluster];

  ClusterDetailsState copyWith({Cluster? cluster}) {
    return ClusterDetailsState(cluster: cluster ?? this.cluster);
  }
}

sealed class ClusterDetailsEvent {
  const ClusterDetailsEvent();
}

final class ClusterDetailsStarted extends ClusterDetailsEvent {
  const ClusterDetailsStarted();
}

class ClusterDetailsBloc extends Bloc<ClusterDetailsEvent, ClusterDetailsState> {
  ClusterDetailsBloc({required Cluster cluster}) : super(ClusterDetailsState(cluster: cluster)) {
    on<ClusterDetailsStarted>((event, emit) {
      //
    });
  }
}
