import 'package:auto_route/annotations.dart';
import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../../core/core.dart';
import '../../../../features.dart';

part 'petition_search_bar.dart';

part 'petition_status_bar.dart';

part 'petition_board_body.dart';

@RoutePage()
class PetitionBoardScreen extends ConsumerStatefulWidget {
  const PetitionBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionBoardScreenState();
  }
}

class _PetitionBoardScreenState extends ConsumerState<PetitionBoardScreen> {
  late final FocusNode focusNode;

  String? keyword;
  PetitionStatus petitionStatus = PetitionStatus.active;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    focusNode = FocusNode();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final themeData = Theme.of(context);

    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        backgroundColor: themeData.colorScheme.background,
        surfaceTintColor: Colors.transparent,
        centerTitle: false,
        title: PetitionSearchBar(
          focusNode: focusNode,
          onSearch: (value) {
            setState(() {
              keyword = value;
            });
          },
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: NestedScrollView(
            floatHeaderSlivers: true,
            headerSliverBuilder:
                (BuildContext context, bool innerBoxIsScrolled) {
              return <Widget>[
                SliverPersistentHeader(
                  floating: true,
                  delegate: SliverPersistentHeaderDelegateImpl(
                    minHeight: 56,
                    maxHeight: 56,
                    child: Container(
                      color: themeData.colorScheme.background,
                      child: Center(
                        child: PetitionStatusBar(
                          currentStatus: petitionStatus,
                          statusList: PetitionStatus.values,
                          onStatusChanged: (status) {
                            setState(() {
                              petitionStatus = status;
                            });
                          },
                        ),
                      ),
                    ),
                  ),
                ),
              ];
            },
            body: PetitionBoardBody(
              keyword: keyword,
              petitionStatus: petitionStatus,
            )),
      ),
    );
  }
}
