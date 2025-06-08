import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/home/home_bloc.dart';
import 'package:kagi_news/repositories/news_repository.dart';
import 'package:mocktail/mocktail.dart';

import 'mock_data.dart';

class MockNewsRepository extends Mock implements NewsRepository {}

void main() {
  late MockNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockNewsRepository();
  });

  blocTest(
    'HomeBloc error state',
    build: () {
      when(() => mockRepository.loadCategories()).thenThrow(Exception('Error loading categories'));
      return HomeBloc(newsRepository: mockRepository);
    },
    act: (bloc) => bloc.add(const HomeStarted()),
    expect: () => [const HomeStateError(message: loadingCategoriesErrorMessage)],
    verify: (_) {
      verify(() => mockRepository.loadCategories()).called(1);
    },
  );

  blocTest(
    'HomeBloc loading',
    build: () {
      when(() => mockRepository.loadCategories()).thenAnswer((_) async => mockCategories);
      return HomeBloc(newsRepository: mockRepository);
    },
    act: (bloc) => bloc.add(const HomeStarted()),
    expect:
        () => [
          HomeStateLoaded(
            categories: mockCategories.categories,
            category: mockCategories.categories.first,
            date: 'Saturday, Jun 7',
          ),
        ],
    verify: (_) {
      verify(() => mockRepository.loadCategories()).called(1);
    },
  );

  blocTest(
    'HomeBloc category change',
    build: () {
      return HomeBloc(newsRepository: mockRepository);
    },
    seed:
        () => HomeStateLoaded(
          categories: mockCategories.categories,
          category: mockCategories.categories.first,
          date: 'Saturday, Jun 7',
        ),
    act: (bloc) => bloc.add(HomeCategoryChanged(mockCategories.categories[1])),
    expect:
        () => [
          HomeStateLoaded(
            categories: mockCategories.categories,
            category: mockCategories.categories[1],
            date: 'Saturday, Jun 7',
          ),
        ],
  );

  blocTest(
    'HomeBloc reload on error',
    build: () {
      when(() => mockRepository.loadCategories()).thenAnswer((_) async => mockCategories);
      return HomeBloc(newsRepository: mockRepository);
    },
    seed: () => const HomeStateError(message: loadingCategoriesErrorMessage),
    act: (bloc) => bloc.add(const HomeReloadPressed()),
    expect:
        () => [
          HomeStateLoaded(
            categories: mockCategories.categories,
            category: mockCategories.categories[0],
            date: 'Saturday, Jun 7',
          ),
        ],
  );
}
