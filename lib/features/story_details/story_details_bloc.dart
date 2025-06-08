import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/cluster.dart';

class StoryDetailsState extends Equatable {
  final Cluster cluster;

  const StoryDetailsState({required this.cluster});

  @override
  List<Object?> get props => [cluster];

  StoryDetailsState copyWith({Cluster? cluster}) {
    return StoryDetailsState(cluster: cluster ?? this.cluster);
  }
}

sealed class StoryDetailsEvent {
  const StoryDetailsEvent();
}

final class StoryDetailsStarted extends StoryDetailsEvent {
  const StoryDetailsStarted();
}

class StoryDetailsBloc extends Bloc<StoryDetailsEvent, StoryDetailsState> {
  StoryDetailsBloc({required Cluster cluster}) : super(StoryDetailsState(cluster: cluster)) {
    on<StoryDetailsStarted>((event, emit) {
      //
    });
  }
}
