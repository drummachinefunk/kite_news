import 'package:equatable/equatable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';

class SettingsState extends Equatable {
  final String appVersion;

  const SettingsState({this.appVersion = ''});

  @override
  List<Object?> get props => [];
}

sealed class SettingsEvent {
  const SettingsEvent();
}

final class SettingsStarted extends SettingsEvent {
  const SettingsStarted();
}

class SettingsBloc extends Bloc<SettingsEvent, SettingsState> {
  SettingsBloc() : super(const SettingsState()) {
    on<SettingsStarted>((event, emit) async {
      final info = await PackageInfo.fromPlatform();
      emit(SettingsState(appVersion: _formatAppVersion(info)));
    });
  }

  String _formatAppVersion(PackageInfo info) {
    return '${info.version} build ${info.buildNumber}';
  }
}
