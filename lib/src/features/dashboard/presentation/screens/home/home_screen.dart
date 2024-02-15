import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:url_launcher/url_launcher.dart';

import '../../../../../core/core.dart';
import '../../../../../modules/modules.dart';
import '../../../../features.dart';

part 'home_banner.dart';

part 'home_petition_board.dart';

part 'home_bus_info.dart';

part 'home_bottom_menu_bar.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = Theme.of(context);
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        surfaceTintColor: Colors.transparent,
        backgroundColor: themeData.colorScheme.surface,
        centerTitle: false,
        title: Text(
          "Danvery",
          style: themeData.textTheme.titleSmall?.copyWith(
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
      body: RefreshIndicator(
        onRefresh: () async {},
        child: const CustomScrollView(
          slivers: [
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  vertical: 16,
                ),
                child: HomeBanner(),
              ),
            ),
            SliverToBoxAdapter(
              child: Padding(
                padding: EdgeInsets.symmetric(
                  horizontal: 16,
                ),
                child: Column(
                  children: [
                    HomeBusInfo(),
                    SizedBox(
                      height: 16,
                    ),
                    HomePetitionBoard(),
                    SizedBox(
                      height: 16,
                    ),
                    HomeBottomMenuBar(),
                    SizedBox(
                      height: 16,
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
