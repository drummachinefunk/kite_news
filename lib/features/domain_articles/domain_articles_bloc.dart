import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/features/story_details/models/source_item.dart';

class DomainArticlesState extends Equatable {
  final SourceItem source;

  const DomainArticlesState({required this.source});
  @override
  List<Object?> get props => [source];
}

sealed class DomainArticlesEvent {
  const DomainArticlesEvent();
}

final class DomainArticlesStarted extends DomainArticlesEvent {
  const DomainArticlesStarted();
}

class DomainArticlesBloc extends Bloc<DomainArticlesEvent, DomainArticlesState> {
  DomainArticlesBloc(SourceItem source) : super(DomainArticlesState(source: source)) {
    on<DomainArticlesStarted>((event, emit) {});
  }
}
