// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'cluster.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

Cluster _$ClusterFromJson(Map<String, dynamic> json) => Cluster(
  clusterNumber: (json['cluster_number'] as num).toInt(),
  uniqueDomains: (json['unique_domains'] as num).toInt(),
  numberOfTitles: (json['number_of_titles'] as num).toInt(),
  title: json['title'] as String,
  shortSummary: json['short_summary'] as String,
  category: json['category'] as String,
  didYouKnow: json['did_you_know'] as String,
  talkingPoints:
      (json['talking_points'] as List<dynamic>)
          .map((e) => e as String)
          .toList(),
  quote: json['quote'] as String,
  qouteAuthor: json['quote_author'] as String,
  quoteSourceUrl: json['quote_source_url'] as String,
  quoteSourceDomain: json['quote_source_domain'] as String,
  location: json['location'] as String,
  perspectives:
      (json['perspectives'] as List<dynamic>)
          .map((e) => Perspective.fromJson(e as Map<String, dynamic>))
          .toList(),
  emoji: json['emoji'] as String,
  geopoliticalContext: json['geopolitical_context'] as String,
  historicalBackground: json['historical_background'] as String,
  internationalReactions: Cluster._fromJsonStringList(
    json['international_reactions'],
  ),
  humanitarianImpact: json['humanitarian_impact'] as String,
  economicImplications: json['economic_implications'] as String,
  timeline: Cluster._fromJsonStringList(json['timeline']),
  futureOutlook: json['future_outlook'] as String,
  businessAngleText: json['business_angle_text'] as String,
  userActionItems: Cluster._fromJsonStringList(json['user_action_items']),
  scientificSignificance: Cluster._fromJsonStringList(
    json['scientific_significance'],
  ),
  travelAdvisory: Cluster._fromJsonStringList(json['travel_advisory']),
  destinationHighlights: Cluster._fromJsonStringList(
    json['destination_highlights'],
  ),
  culinarySignificance: json['culinary_significance'] as String,
  leagueStandings: json['league_standings'] as String,
  diyTips: json['diy_tips'] as String,
  designPrinciples: json['design_principles'] as String,
  userExperienceImpact: json['user_experience_impact'] as String,
  gameplayMechanics: Cluster._fromJsonStringList(json['gameplay_mechanics']),
  industryImpact: Cluster._fromJsonStringList(json['industry_impact']),
  technicalSpecifications: json['technical_specifications'] as String,
  suggestedQna:
      (json['suggested_qna'] as List<dynamic>)
          .map((e) => Qna.fromJson(e as Map<String, dynamic>))
          .toList(),
  technicalDetails: Cluster._fromJsonStringList(json['technical_details']),
  articles:
      (json['articles'] as List<dynamic>)
          .map((e) => Article.fromJson(e as Map<String, dynamic>))
          .toList(),
);

Map<String, dynamic> _$ClusterToJson(Cluster instance) => <String, dynamic>{
  'cluster_number': instance.clusterNumber,
  'unique_domains': instance.uniqueDomains,
  'number_of_titles': instance.numberOfTitles,
  'category': instance.category,
  'title': instance.title,
  'short_summary': instance.shortSummary,
  'did_you_know': instance.didYouKnow,
  'talking_points': instance.talkingPoints,
  'quote': instance.quote,
  'quote_author': instance.qouteAuthor,
  'quote_source_url': instance.quoteSourceUrl,
  'quote_source_domain': instance.quoteSourceDomain,
  'location': instance.location,
  'perspectives': instance.perspectives,
  'emoji': instance.emoji,
  'geopolitical_context': instance.geopoliticalContext,
  'historical_background': instance.historicalBackground,
  'international_reactions': instance.internationalReactions,
  'humanitarian_impact': instance.humanitarianImpact,
  'economic_implications': instance.economicImplications,
  'timeline': instance.timeline,
  'future_outlook': instance.futureOutlook,
  'business_angle_text': instance.businessAngleText,
  'user_action_items': instance.userActionItems,
  'scientific_significance': instance.scientificSignificance,
  'travel_advisory': instance.travelAdvisory,
  'destination_highlights': instance.destinationHighlights,
  'culinary_significance': instance.culinarySignificance,
  'league_standings': instance.leagueStandings,
  'diy_tips': instance.diyTips,
  'design_principles': instance.designPrinciples,
  'user_experience_impact': instance.userExperienceImpact,
  'gameplay_mechanics': instance.gameplayMechanics,
  'industry_impact': instance.industryImpact,
  'technical_specifications': instance.technicalSpecifications,
  'suggested_qna': instance.suggestedQna,
  'technical_details': instance.technicalDetails,
  'articles': instance.articles,
};
