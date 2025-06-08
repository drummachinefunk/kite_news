import 'package:json_annotation/json_annotation.dart';
import 'package:kagi_news/models/article.dart';
import 'package:kagi_news/models/domain.dart';
import 'package:kagi_news/models/parsing/string_list_parser.dart';
import 'package:kagi_news/models/perspective.dart';
import 'package:kagi_news/models/qna.dart';

part 'cluster.g.dart';

@JsonSerializable()
class Cluster {
  @JsonKey(name: 'cluster_number')
  final int clusterNumber;

  @JsonKey(name: 'unique_domains')
  final int uniqueDomains;

  @JsonKey(name: 'number_of_titles')
  final int numberOfTitles;

  final String category;

  final String title;

  @JsonKey(name: 'short_summary')
  final String shortSummary;

  @JsonKey(name: 'did_you_know')
  final String didYouKnow;

  @JsonKey(name: 'talking_points', fromJson: fromJsonStringList)
  final List<String> talkingPoints;

  final String quote;

  @JsonKey(name: 'quote_author')
  final String qouteAuthor;

  @JsonKey(name: 'quote_source_url')
  final String quoteSourceUrl;

  @JsonKey(name: 'quote_source_domain')
  final String quoteSourceDomain;

  final String location;

  final List<Perspective> perspectives;

  final String emoji;

  @JsonKey(name: 'geopolitical_context')
  final String geopoliticalContext;

  @JsonKey(name: 'historical_background')
  final String historicalBackground;

  @JsonKey(name: 'international_reactions', fromJson: fromJsonStringList)
  final List<String> internationalReactions;

  @JsonKey(name: 'humanitarian_impact')
  final String humanitarianImpact;

  @JsonKey(name: 'economic_implications')
  final String economicImplications;

  @JsonKey(fromJson: fromJsonStringList)
  final List<String> timeline;

  @JsonKey(name: 'future_outlook')
  final String futureOutlook;

  @JsonKey(name: 'business_angle_text')
  final String businessAngleText;

  @JsonKey(name: 'user_action_items', fromJson: fromJsonStringList)
  final List<String> userActionItems;

  @JsonKey(name: 'scientific_significance', fromJson: fromJsonStringList)
  final List<String> scientificSignificance;

  @JsonKey(name: 'travel_advisory', fromJson: fromJsonStringList)
  final List<String> travelAdvisory;

  @JsonKey(name: 'destination_highlights', fromJson: fromJsonStringList)
  final List<String> destinationHighlights;

  @JsonKey(name: 'culinary_significance')
  final String culinarySignificance;

  @JsonKey(name: 'league_standings')
  final String leagueStandings;

  @JsonKey(name: 'diy_tips')
  final String diyTips;

  @JsonKey(name: 'design_principles')
  final String designPrinciples;

  @JsonKey(name: 'user_experience_impact', fromJson: fromJsonStringList)
  final List<String> userExperienceImpact;

  @JsonKey(name: 'gameplay_mechanics', fromJson: fromJsonStringList)
  final List<String> gameplayMechanics;

  @JsonKey(name: 'industry_impact', fromJson: fromJsonStringList)
  final List<String> industryImpact;

  @JsonKey(name: 'technical_specifications')
  final String technicalSpecifications;

  @JsonKey(name: 'suggested_qna')
  final List<Qna> suggestedQna;

  @JsonKey(name: 'technical_details', fromJson: fromJsonStringList)
  final List<String> technicalDetails;

  final List<Article> articles;

  final List<Domain> domains;

  const Cluster({
    required this.clusterNumber,
    required this.uniqueDomains,
    required this.numberOfTitles,
    required this.title,
    required this.shortSummary,
    required this.category,
    required this.didYouKnow,
    required this.talkingPoints,
    required this.quote,
    required this.qouteAuthor,
    required this.quoteSourceUrl,
    required this.quoteSourceDomain,
    required this.location,
    required this.perspectives,
    required this.emoji,
    required this.geopoliticalContext,
    required this.historicalBackground,
    required this.internationalReactions,
    required this.humanitarianImpact,
    required this.economicImplications,
    required this.timeline,
    required this.futureOutlook,
    required this.businessAngleText,
    required this.userActionItems,
    required this.scientificSignificance,
    required this.travelAdvisory,
    required this.destinationHighlights,
    required this.culinarySignificance,
    required this.leagueStandings,
    required this.diyTips,
    required this.designPrinciples,
    required this.userExperienceImpact,
    required this.gameplayMechanics,
    required this.industryImpact,
    required this.technicalSpecifications,
    required this.suggestedQna,
    required this.technicalDetails,
    required this.articles,
    required this.domains,
  });

  factory Cluster.fromJson(Map<String, dynamic> json) => _$ClusterFromJson(json);

  Map<String, dynamic> toJson() => _$ClusterToJson(this);
}
