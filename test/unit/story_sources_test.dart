import 'package:flutter_test/flutter_test.dart';
import 'package:kagi_news/features/story_details/utilities/story_sources.dart';
import 'package:kagi_news/models/article.dart';
import 'package:kagi_news/models/cluster.dart';
import 'package:kagi_news/models/domain.dart';

void main() {
  test('Story sources are calculated properly', () {
    final story = Cluster(
      clusterNumber: 1,
      uniqueDomains: 10,
      numberOfTitles: 2,
      title: 'Tech News Title 1',
      shortSummary: '',
      category: '',
      didYouKnow: '',
      talkingPoints: const [],
      quote: '',
      qouteAuthor: '',
      quoteSourceUrl: '',
      quoteSourceDomain: '',
      location: '',
      perspectives: const [],
      emoji: '📰',
      geopoliticalContext: '',
      historicalBackground: '',
      internationalReactions: const [],
      humanitarianImpact: '',
      economicImplications: '',
      timeline: const [],
      futureOutlook: '',
      businessAngleText: '',
      userActionItems: const [],
      scientificSignificance: const [],
      travelAdvisory: const [],
      destinationHighlights: const [],
      culinarySignificance: '',
      leagueStandings: '',
      diyTips: '',
      designPrinciples: '',
      userExperienceImpact: const [],
      gameplayMechanics: const [],
      industryImpact: const [],
      technicalSpecifications: '',
      suggestedQna: const [],
      technicalDetails: const [],
      articles: [
        Article(
          title: 'QuantumOS Launch',
          link: 'https://example.com/quantumos-launch',
          date: DateTime.fromMicrosecondsSinceEpoch(1623490634000000),
          domain: 'example.com',
          image: 'https://example.com/quantumos-launch.jpg',
          imageCaption: 'QuantumOS Launch Event',
        ),
        Article(
          title: 'QuantumOS Features',
          link: 'https://example.com/quantumos-features',
          date: DateTime.fromMicrosecondsSinceEpoch(1623490634000000),
          domain: 'example.com',
          image: 'https://example.com/quantumos-features.jpg',
          imageCaption: 'Exploring QuantumOS Features',
        ),
        Article(
          title: 'QuantumOS Developer Guide',
          link: 'https://world.com/quantumos-developer-guide',
          date: DateTime.fromMicrosecondsSinceEpoch(1623490634000000),
          domain: 'world.com',
          image: 'https://world.com/quantumos-developer-guide.jpg',
          imageCaption: 'Guide for QuantumOS Developers',
        ),
      ],
      domains: const [
        Domain(name: 'example.com', favicon: 'https://example.com/favicon.ico'),
        Domain(name: 'world.com', favicon: 'https://world.com/favicon.ico'),
      ],
    );
    final sources = getStorySources(story);
    expect(sources.length, 2);
    expect(sources[0].name, 'example.com');
    expect(sources[0].favicon, 'https://example.com/favicon.ico');
    expect(sources[0].articles.length, 2);
    expect(sources[0].articles[0].title, 'QuantumOS Launch');
    expect(sources[0].articles[1].title, 'QuantumOS Features');
    expect(sources[1].name, 'world.com');
    expect(sources[1].favicon, 'https://world.com/favicon.ico');
    expect(sources[1].articles.length, 1);
    expect(sources[1].articles[0].title, 'QuantumOS Developer Guide');
  });

  test('Domains with no articles are not added', () {
    final story = Cluster(
      clusterNumber: 1,
      uniqueDomains: 10,
      numberOfTitles: 2,
      title: 'Tech News Title 1',
      shortSummary: '',
      category: '',
      didYouKnow: '',
      talkingPoints: const [],
      quote: '',
      qouteAuthor: '',
      quoteSourceUrl: '',
      quoteSourceDomain: '',
      location: '',
      perspectives: const [],
      emoji: '📰',
      geopoliticalContext: '',
      historicalBackground: '',
      internationalReactions: const [],
      humanitarianImpact: '',
      economicImplications: '',
      timeline: const [],
      futureOutlook: '',
      businessAngleText: '',
      userActionItems: const [],
      scientificSignificance: const [],
      travelAdvisory: const [],
      destinationHighlights: const [],
      culinarySignificance: '',
      leagueStandings: '',
      diyTips: '',
      designPrinciples: '',
      userExperienceImpact: const [],
      gameplayMechanics: const [],
      industryImpact: const [],
      technicalSpecifications: '',
      suggestedQna: const [],
      technicalDetails: const [],
      articles: [
        Article(
          title: 'QuantumOS Launch',
          link: 'https://example.com/quantumos-launch',
          date: DateTime.fromMicrosecondsSinceEpoch(1623490634000000),
          domain: 'example.com',
          image: 'https://example.com/quantumos-launch.jpg',
          imageCaption: 'QuantumOS Launch Event',
        ),
        Article(
          title: 'QuantumOS Features',
          link: 'https://example.com/quantumos-features',
          date: DateTime.fromMicrosecondsSinceEpoch(1623490634000000),
          domain: 'example.com',
          image: 'https://example.com/quantumos-features.jpg',
          imageCaption: 'Exploring QuantumOS Features',
        ),
      ],
      domains: const [
        Domain(name: 'example.com', favicon: 'https://example.com/favicon.ico'),
        Domain(name: 'world.com', favicon: 'https://world.com/favicon.ico'),
      ],
    );
    final sources = getStorySources(story);
    expect(sources.length, 1);
    expect(sources[0].name, 'example.com');
    expect(sources[0].favicon, 'https://example.com/favicon.ico');
    expect(sources[0].articles.length, 2);
    expect(sources[0].articles[0].title, 'QuantumOS Launch');
    expect(sources[0].articles[1].title, 'QuantumOS Features');
  });
}
