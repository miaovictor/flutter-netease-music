import 'package:fluentui_system_icons/fluentui_system_icons.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:quiet/common/extension.dart';
import 'package:quiet/ncmapi/models/personalized_newsong.dart';
import 'package:quiet/ncmapi/models/personalized_playlist.dart';
import 'package:quiet/states/netease.dart';
import 'package:quiet/widgets/buttons.dart';
import 'package:quiet/widgets/swiper.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: context.colorScheme.backgroundSecondary,
      body: CustomScrollView(
        slivers: [
          const _AppBar(),
          SliverPadding(
            padding: const EdgeInsets.all(0),
            sliver: SliverList(
                delegate: SliverChildListDelegate([
                  const _Banner(),
                  const _MenuBar(),
                  _Header('推荐歌单', () {}),
                  _RecommendPlaylist(),
                  _Header('最新音乐', () {}),
                  _RecommendNewSong(),
                ])),
          ),

        ],
      ),
    );
  }
}

class _AppBar extends ConsumerWidget {
  const _AppBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final background = context.colorScheme.background;
    return SliverAppBar(
      leading: AppIconButton(
        onPressed: () {},
        color: context.colorScheme.textPrimary,
        icon: FluentIcons.person_heart_20_regular,
      ),
      centerTitle: true,
      titleSpacing: 0,
      title: SizedBox(
        height: 36,
        child: CupertinoSearchTextField(
          placeholderStyle: const TextStyle(
            color: Color.fromARGB(255, 139, 140, 153),
          ),
          style:
          TextStyle(color: context.colorScheme.textPrimary, fontSize: 16),
          // backgroundColor: background,
          prefixIcon: const Icon(FluentIcons.search_24_regular),
          prefixInsets: const EdgeInsetsDirectional.fromSTEB(10, 0, 0, 0),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(50),
            border: Border.all(
              color: const Color.fromARGB(255, 232, 217, 233),
              width: 0.5,
            ),
            color: const Color.fromARGB(255, 241, 228, 241),
          ),
        ),
      ),
      backgroundColor: background,
      actions: [
        AppIconButton(
            onPressed: () {},
            color: context.colorScheme.textPrimary,
            icon: FluentIcons.settings_20_regular)
      ],
    );
  }
}

class _Banner extends ConsumerWidget {
  const _Banner({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final images = [
      "1.jpg",
      "2.jpg",
      "3.jpg",
      "4.jpg",
      "5.jpg",
      "6.jpg",
      "7.jpg",
      "8.jpg"
    ].map((e) =>
        ClipRRect(
          borderRadius: BorderRadius.circular(10),
          clipBehavior: Clip.antiAlias,
          child: Image.asset("assets/banner/$e", fit: BoxFit.cover),
        )).toList();
    return AspectRatio(
      aspectRatio: 54.0 / 21.0,
      child: Swiper(
        indicatorAlignment: AlignmentDirectional.bottomCenter,
        speed: 400,
        controller: SwiperController(initialPage: 1),
        interval: const Duration(seconds: 10),
        viewportFraction: 1.0,
        indicator: CircleSwiperIndicator(),
        children: images.map((e) =>
            Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: e))
            .toList(),
      ),
    );
  }
}

class _MenuBar extends ConsumerWidget {
  const _MenuBar({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 15),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          _MenuItem(
            Icons.today,
            context.strings.dailyRecommend,
                () => {},
          ),
          _MenuItem(
            Icons.queue_music,
            context.strings.playlist,
                () => {},
          ),
          _MenuItem(
            Icons.show_chart,
            context.strings.leaderboard,
                () => {},
          ),
          _MenuItem(
            Icons.album,
            context.strings.album,
                () => {},
          ),
        ],
      ),
    );
  }
}

class _MenuItem extends StatelessWidget {
  const _MenuItem(this.icon, this.text, this.onTap);

  final IconData icon;

  final String text;

  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 8, horizontal: 16),
        child: Column(
          children: <Widget>[
            Material(
              shape: const CircleBorder(),
              elevation: 5,
              child: ClipOval(
                child: Container(
                  width: 40,
                  height: 40,
                  color: Theme
                      .of(context)
                      .primaryColor,
                  child: Icon(
                    icon,
                    color: Theme
                        .of(context)
                        .primaryIconTheme
                        .color,
                  ),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 8)),
            Text(text),
          ],
        ),
      ),
    );
  }
}

class _Header extends StatelessWidget {
  const _Header(this.text, this.onTap);

  final String text;
  final GestureTapCallback onTap;

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.only(top: 10, bottom: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Padding(padding: EdgeInsets.only(left: 15)),
          Text(
            text,
            style: Theme
                .of(context)
                .textTheme
                .titleMedium!
                .copyWith(fontWeight: FontWeight.w800),
          ),
          const Icon(Icons.chevron_right),
        ],
      ),
    );
  }
}

class _RecommendPlaylist extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(personalizedPlaylistProvider);
    return provider.when(
        data: (list) {
          return LayoutBuilder(
              builder: (context, constraints) {
                final parentWidth = constraints.maxWidth - 8;
                const count = /* false ? 6 : */ 3;
                final width = (parentWidth / count).clamp(80.0, 200.0);
                final spacing = (parentWidth - width * count) / (count + 1);
                return Padding(
                  padding:
                  EdgeInsets.symmetric(horizontal: 4 + spacing.roundToDouble()),
                  child: Wrap(
                    spacing: spacing,
                    children: list.map<Widget>((p) {
                      return _PlayListItemView(playlist: p, width: width);
                    }).toList(),
                  ),
                );
              }
          );
        },
        error: (error, stacktrace) {
          return SizedBox(
            height: 200,
            child: Center(
              child: Text(context.formattedError(error)),
            ),
          );
        },
        loading: () =>
        const SizedBox(
          height: 200,
          child: Center(
            child: SizedBox.square(
              dimension: 24,
              child: CircularProgressIndicator(),
            ),
          ),
        )
    );
  }
}

class _PlayListItemView extends ConsumerWidget {
  const _PlayListItemView({
    super.key,
    required this.playlist,
    required this.width,
  });

  final PersonalizedPlaylistItem playlist;

  final double width;

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    GestureLongPressCallback? onLongPress;

    if (playlist.copywriter.isNotEmpty) {
      onLongPress = () {
        showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(
                playlist.copywriter,
                style: Theme.of(context).textTheme.bodyLarge,
              ),
            );
          },
        );
      };
    }

    return InkWell(
      onTap: () => {},
      onLongPress: onLongPress,
      child: Container(
        width: width,
        padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 8),
        child: Column(
          children: <Widget>[
            SizedBox(
              height: width,
              width: width,
              child: ClipRRect(
                borderRadius: const BorderRadius.all(Radius.circular(6)),
                child: AspectRatio(
                  aspectRatio: 1,
                  child: Image.network(playlist.picUrl),
                ),
              ),
            ),
            const Padding(padding: EdgeInsets.only(top: 4)),
            Text(
              playlist.name,
              maxLines: 2,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}

class _RecommendNewSong extends ConsumerWidget {
  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final provider = ref.watch(personalizedNewSongProvider);
    return provider.when(
      data: (songs) {
        return const Text("data");
        // return TrackTileContainer.trackList(
        //   tracks: songs,
        //   id: 'playlist_main_newsong',
        //   child: Column(
        //     children: songs
        //         .mapIndexed(
        //           (index, item) => TrackTile(
        //         track: item,
        //         index: index + 1,
        //       ),
        //     )
        //         .toList(),
        //   ),
        // );
      },
      error: (error, stacktrace) {
        return SizedBox(
          height: 200,
          child: Center(
            child: Text(context.formattedError(error)),
          ),
        );
      },
      loading: () => const SizedBox(
        height: 200,
        child: Center(
          child: SizedBox.square(
            dimension: 24,
            child: CircularProgressIndicator(),
          ),
        ),
      ),
    );
  }
}