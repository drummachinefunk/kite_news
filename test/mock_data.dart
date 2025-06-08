import 'package:kagi_news/models/categories_response.dart';
import 'package:kagi_news/models/category.dart';
import 'package:kagi_news/models/category_response.dart';
import 'package:kagi_news/models/cluster.dart';

const loadingCategoriesErrorMessage = 'Failed to load categories.\nPlease try again later.';

const loadingCategoryErrorMessage = 'Failed to load category.\nPlease try again later.';

const mockTechCategory = Category(name: 'Tech', file: 'tech.json');
const mockWorldCategory = Category(name: 'World', file: 'world.json');
const mockUsaCategory = Category(name: 'USA', file: 'usa.json');

const mockCategories = CategoriesResponse(
  timestamp: 1749370099,
  categories: [
    mockTechCategory, mockWorldCategory, mockUsaCategory
  ],
);

const mockTechCategoryResponse = CategoryResponse(
  category: 'Tech',
  timestamp: 1749370099,
  read: 100,
  clusters: [
    Cluster(
      clusterNumber: 1,
      uniqueDomains: 10,
      numberOfTitles: 2,
      title: 'Tech News Title',
      shortSummary: 'This is a short summary of the tech news.',
      category: 'Tech',
      didYouKnow: '',
      talkingPoints: [],
      quote: '',
      qouteAuthor: '',
      quoteSourceUrl: '',
      quoteSourceDomain: '',
      location: '',
      perspectives: [],
      emoji: '📰',
      geopoliticalContext: '',
      historicalBackground: '',
      internationalReactions: [],
      humanitarianImpact: '',
      economicImplications: '',
      timeline: [],
      futureOutlook: '',
      businessAngleText: '',
      userActionItems: [],
      scientificSignificance: [],
      travelAdvisory: [],
      destinationHighlights: [],
      culinarySignificance: '',
      leagueStandings: '',
      diyTips: '',
      designPrinciples: '',
      userExperienceImpact: [],
      gameplayMechanics: [],
      industryImpact: [],
      technicalSpecifications: '',
      suggestedQna: [],
      technicalDetails: [],
      articles: [],
      domains: [],
    ),
  ],
);
