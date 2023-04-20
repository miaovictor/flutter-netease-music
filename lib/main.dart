import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:overlay_support/overlay_support.dart';
import 'package:quiet/common/theme.dart';
import 'package:quiet/ncmapi/ncmapi.dart';
import 'package:quiet/states/preference.dart';
import 'package:quiet/states/setting.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'generated/l10n.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:quiet/routes/home/page_home.dart';


void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final prefs = await SharedPreferences.getInstance();
  await NeteaseCloudMusicAPI().initialize();
  runApp(
     ProviderScope(
        overrides: [
          sharedPreferenceProvider.overrideWithValue(prefs),
        ],
        child: const OverlaySupport.global(child: MyApp()),
    )
  );
  if(Platform.isAndroid){
    SystemUiOverlayStyle style = const SystemUiOverlayStyle(
      /// 设置状态栏背景为透明色
        statusBarColor: Colors.transparent,
        ///设置状态栏文字为白色，dark为黑色
        statusBarIconBrightness: Brightness.light
    );
    /// 应用上面的style设置
    SystemChrome.setSystemUIOverlayStyle(style);
  }
}

class MyApp extends ConsumerWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return MaterialApp(
      title: 'Quiet',
      supportedLocales: S.delegate.supportedLocales,
      localizationsDelegates: const [
        S.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      theme: lightTheme,
      darkTheme: darkTheme,
      themeMode: ref.watch(settingProvider.select((value) => value.themeMode)),
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
      builder: (context, child) {
        return AppTheme(child: child!);
      },
    );
  }
}


