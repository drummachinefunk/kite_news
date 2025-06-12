import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
import 'package:kagi_news/features/story_details/utilities/story_sources.dart';
import 'package:kagi_news/models/cluster.dart';

class StoryDetailsState extends Equatable {
  final Cluster cluster;
  final List<SourceItem> sources;

  const StoryDetailsState({required this.cluster, this.sources = const []});

  @override
  List<Object?> get props => [cluster, sources];

  StoryDetailsState copyWith({Cluster? cluster, List<SourceItem>? sources}) {
    return StoryDetailsState(cluster: cluster ?? this.cluster, sources: sources ?? this.sources);
  }
}

sealed class StoryDetailsEvent {
  const StoryDetailsEvent();
}

final class StoryDetailsStarted extends StoryDetailsEvent {
  const StoryDetailsStarted();
}

class StoryDetailsBloc extends Bloc<StoryDetailsEvent, StoryDetailsState> {
  StoryDetailsBloc({required Cluster cluster})
    : super(StoryDetailsState(cluster: cluster, sources: getStorySources(cluster))) {
    on<StoryDetailsStarted>((event, emit) {});
  }
}
