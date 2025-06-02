import 'package:equatable/equatable.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class InfoState extends Equatable {
  final String title;
  final String markdown;

  const InfoState({required this.title, this.markdown = ''});

  @override
  List<Object?> get props => [title, markdown];

  InfoState copyWith({String? title, String? markdown}) {
    return InfoState(title: title ?? this.title, markdown: markdown ?? this.markdown);
  }
}

sealed class InfoEvent {
  const InfoEvent();
}

final class InfoStarted extends InfoEvent {
  const InfoStarted();
}

class InfoBloc extends Bloc<InfoEvent, InfoState> {
  InfoBloc({required String title, required String asset}) : super(InfoState(title: title)) {
    on<InfoStarted>((event, emit) async {
      final md = await rootBundle.loadString(asset);
      emit(state.copyWith(markdown: md));
    });
  }
}
