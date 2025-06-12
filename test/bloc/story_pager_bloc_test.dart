import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/story_pager/story_pager_bloc.dart';
import '../mocks/mock_data.dart';

void main() {
  blocTest(
    'StoryPagerBloc state is initialized correctly',
    build: () {
      return StoryPagerBloc(
        category: mockTechCategory,
        clusters: mockTechCategoryResponse.clusters,
        index: 0,
      );
    },
    verify:
        (bloc) => expect(
          bloc.state,
          StoryPagerState(
            category: mockTechCategory,
            clusters: mockTechCategoryResponse.clusters,
            selectedIndex: 0,
          ),
        ),
  );

  blocTest(
    'StoryPagerBloc state is updated when next is pressed',
    build: () {
      return StoryPagerBloc(
        category: mockTechCategory,
        clusters: mockTechCategoryResponse.clusters,
        index: 0,
      );
    },
    act: (bloc) => bloc.add(const StoryPagerNextPressed()),
    expect:
        () => [
          StoryPagerState(
            category: mockTechCategory,
            clusters: mockTechCategoryResponse.clusters,
            selectedIndex: 1,
          ),
        ],
  );

  blocTest(
    'StoryPagerBloc state is updated when previous is pressed',
    build: () {
      return StoryPagerBloc(
        category: mockTechCategory,
        clusters: mockTechCategoryResponse.clusters,
        index: 1,
      );
    },
    act: (bloc) => bloc.add(const StoryPagerPreviousPressed()),
    expect:
        () => [
          StoryPagerState(
            category: mockTechCategory,
            clusters: mockTechCategoryResponse.clusters,
            selectedIndex: 0,
          ),
        ],
  );

  blocTest(
    'StoryPagerBloc state is updated when index is changed',
    build: () {
      return StoryPagerBloc(
        category: mockTechCategory,
        clusters: mockTechCategoryResponse.clusters,
        index: 1,
      );
    },
    act: (bloc) => bloc.add(const StoryPagerIndexChanged(0)),
    expect:
        () => [
          StoryPagerState(
            category: mockTechCategory,
            clusters: mockTechCategoryResponse.clusters,
            selectedIndex: 0,
          ),
        ],
  );
}
