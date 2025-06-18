import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/models/event.dart';
import 'package:kagi_news/repositories/news_repository.dart';

abstract class EventsState extends Equatable {
  const EventsState();

  @override
  List<Object?> get props => [];
}

final class EventsInitial extends EventsState {
  const EventsInitial();
}

final class EventsError extends EventsState {
  final String message;

  const EventsError({this.message = 'An error occurred'});

  @override
  List<Object?> get props => [message];

  EventsError copyWith({String? message}) {
    return EventsError(message: message ?? this.message);
  }
}

final class EventsLoaded extends EventsState {
  final List<Event> events;

  const EventsLoaded({this.events = const []});

  @override
  List<Object?> get props => [events];

  EventsLoaded copyWith({List<Event>? events}) {
    return EventsLoaded(events: events ?? this.events);
  }
}

sealed class EventsEvent {
  const EventsEvent();
}

final class EventsStarted extends EventsEvent {
  const EventsStarted();
}

class EventsBloc extends Bloc<EventsEvent, EventsState> {
  final NewsRepository newsRepository;
  EventsBloc({required this.newsRepository}) : super(const EventsInitial()) {
    on<EventsStarted>((event, emit) async {
      try {
        final response = await newsRepository.loadEvents();
        final events = response.events.toList();
        events.sort((a, b) => b.sortYear.compareTo(a.sortYear));
        emit(EventsLoaded(events: events));
      } catch (e) {
        emit(EventsError(message: e.toString()));
      }
    });
  }
}
