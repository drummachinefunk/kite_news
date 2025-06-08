import 'package:bloc_test/bloc_test.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/category_tab/category_tab_bloc.dart';
import 'package:mocktail/mocktail.dart';
import 'mocks/mock_data.dart';
import 'mocks/mock_news_repository.dart';

void main() {
  late MockNewsRepository mockRepository;

  setUp(() {
    mockRepository = MockNewsRepository();
  });

  blocTest(
    'Category tab loading',
    build: () {
      when(
        () => mockRepository.loadCategory(mockTechCategory),
      ).thenAnswer((_) async => mockTechCategoryResponse);
      return CategoryTabBloc(
        category: mockCategories.categories[0],
        newsRepository: mockRepository,
      );
    },
    act: (bloc) => bloc.add(const CategoryTabStarted()),
    expect: () => [CategoryTabStateLoaded(clusters: mockTechCategoryResponse.clusters)],
    verify: (_) {
      verify(() => mockRepository.loadCategory(mockCategories.categories.first)).called(1);
    },
  );

  blocTest(
    'Category tab error',
    build: () {
      when(
        () => mockRepository.loadCategory(mockTechCategory),
      ).thenThrow(Exception('Error loading category'));
      return CategoryTabBloc(
        category: mockTechCategory,
        newsRepository: mockRepository,
      );
    },
    act: (bloc) => bloc.add(const CategoryTabStarted()),
    expect: () => [const CategoryTabStateError(message: loadingCategoryErrorMessage)],
    verify: (_) {
      verify(() => mockRepository.loadCategory(mockTechCategory)).called(1);
    },
  );
}
