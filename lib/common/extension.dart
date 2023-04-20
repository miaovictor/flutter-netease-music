import 'package:flutter/material.dart';
import 'package:quiet/generated/l10n.dart';
import 'package:quiet/common/theme.dart';
import 'package:quiet/ncmapi/request.dart';

extension AppStringResourceExtension on BuildContext {
  S get strings {
    return S.of(this);
  }
}

extension QuietAppTheme on BuildContext {
  TextTheme get textTheme => Theme.of(this).textTheme;
  TextTheme get primaryTextTheme => Theme.of(this).primaryTextTheme;
  AppColorScheme get colorScheme => AppTheme.colorScheme(this);
}

extension ErrorFormat on BuildContext {
  /// human-readable error message
  String formattedError(dynamic error) {
    if (error is RequestError) {
      return error.message;
    }
    return '$error';
  }
}