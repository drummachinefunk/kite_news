import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:kagi_news/components/loading_indicator.dart';
import 'package:kagi_news/features/events/components/event_tile.dart';
import 'package:kagi_news/features/events/events_bloc.dart';
import 'package:kagi_news/navigation/navigation.dart';

class EventsPage extends StatelessWidget {
  const EventsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<EventsBloc, EventsState>(
      builder: (context, state) {
        switch (state) {
          case EventsInitial():
            return const Center(child: LoadingIndicator());
          case EventsError():
            return Center(
              child: Text(
                state.message,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          case EventsLoaded(:final events):
            return ListView.separated(
              itemBuilder:
                  (context, index) => EventTile(
                    event: events[index],
                    onLinkTapped: (url) => presentUrl(url),
                  ),
              separatorBuilder:
                  (context, index) => const Divider(indent: 16, endIndent: 16),
              itemCount: state.events.length,
            );
        }
        return Container();
      },
    );
  }
}
