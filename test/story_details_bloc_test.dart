import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/story_details/story_details_bloc.dart';
import 'package:kagi_news/features/story_details/utilities/story_sources.dart';
import 'mocks/mock_data.dart';

void main() {
  blocTest(
    'StoryDetailsBloc state is initialized correctly',
    build: () {
      return StoryDetailsBloc(cluster: mockTechCategoryResponse.clusters.first);
    },
    verify:
        (bloc) => expect(
          bloc.state,
          StoryDetailsState(
            cluster: mockTechCategoryResponse.clusters.first,
            sources: getStorySources(mockTechCategoryResponse.clusters.first),
          ),
        ),
  );
}
