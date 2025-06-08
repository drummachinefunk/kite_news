import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/story_details/components/sources.dart';
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
  StoryDetailsBloc({required Cluster cluster}) : super(StoryDetailsState(cluster: cluster)) {
    on<StoryDetailsStarted>((event, emit) {
      final articles = cluster.articles;
      final domains = cluster.domains;

      final sources =
          domains.map((domain) {
            final articlesForDomain =
                articles.where((article) => article.domain == domain.name).toList();
            return SourceItem(
              name: domain.name,
              favicon: domain.favicon,
              articles: articlesForDomain,
            );
          }).toList();
      emit(state.copyWith(sources: sources));
    });
  }
}
