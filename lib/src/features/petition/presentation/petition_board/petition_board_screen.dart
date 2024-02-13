import 'dart:async';

import 'package:auto_route/annotations.dart';
import 'package:danvery/src/modules/modules.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../../common_widgets/common_widgets.dart';
import '../../../features.dart';


@RoutePage()
class PetitionBoardScreen extends ConsumerStatefulWidget {
  const PetitionBoardScreen({super.key});

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _PetitionBoardScreenState();
  }
}

class _PetitionBoardScreenState extends ConsumerState<PetitionBoardScreen>
    with PetitionBoardScreenController {
  late final TextEditingController keywordController;
  late final FocusNode focusNode;

  late PetitionStatus petitionStatus;
  late final ValueNotifier<PetitionStatus> petitionStatusNotifier;

  late Future<PetitionBoardModel> petitionBoard;
  late final ValueNotifier<Future<PetitionBoardModel>> petitionBoardNotifier;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    keywordController = TextEditingController();
    focusNode = FocusNode();

    petitionStatus = PetitionStatus.active;
    petitionStatusNotifier = ValueNotifier(petitionStatus);

    petitionBoard = getPetitionBoard(
      ref,
      status: petitionStatus,
    );
    petitionBoardNotifier = ValueNotifier(petitionBoard);
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
          keywordController: keywordController,
          focusNode: focusNode,
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16),
        child: NestedScrollView(
          floatHeaderSlivers: true,
          headerSliverBuilder: (BuildContext context, bool innerBoxIsScrolled) {
            return <Widget>[
              SliverPersistentHeader(
                floating: true,
                delegate: SliverPersistentHeaderDelegateImpl(
                  minHeight: 56,
                  maxHeight: 56,
                  child: Container(
                    color: themeData.colorScheme.background,
                    child: Center(
                      child: ValueListenableBuilder<PetitionStatus>(
                        valueListenable: petitionStatusNotifier,
                        builder: (context, value, child) {
                          return PetitionStatusBar(
                            currentStatus: value,
                            statusList: PetitionStatus.values,
                            onStatusChanged: (status) {
                              petitionBoardNotifier.value = getPetitionBoard(
                                ref,
                                status: status,
                              );
                              petitionStatusNotifier.value = status;
                            },
                          );
                        },
                      ),
                    ),
                  ),
                ),
              ),
            ];
          },
          body: ValueListenableBuilder<Future<PetitionBoardModel>>(
              valueListenable: petitionBoardNotifier,
              builder: (context, value, child) {
                return FutureListWidget(
                  futureList: value.then((value) => value.content),
                  isLoading: ListView.builder(
                    itemCount: 10,
                    itemBuilder: (context, index) {
                      return const OrbShimmerContent();
                    },
                  ),
                  hasEmptyData: Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Icon(
                          Icons.search_off_rounded,
                          color: themeData.colorScheme.secondary,
                          size: 32,
                        ),
                        const SizedBox(height: 16),
                        Text(
                          "연관된 게시글이 존재하지 않아요",
                          style: themeData.textTheme.titleSmall?.copyWith(
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ],
                    ),
                  ),
                  hasData: (item) {
                    return PetitionPreviewCard(
                      remainingDate: petitionRemainingDate(
                        expiresAt: item.expiresAt,
                      ),
                      title: item.title,
                      duration: petitionDuration(
                        createdAt: item.createdAt,
                        expiresAt: item.expiresAt,
                      ),
                      agreeCount: item.agreeCount,
                      status: getPetitionStatus(status: item.status),
                    );
                  },
                  hasError: (error, stackTrace) {
                    return ListView.builder(
                      itemCount: 10,
                      itemBuilder: (context, index) {
                        return const OrbShimmerContent();
                      },
                    );
                  },
                );
              }),
        ),
      ),
    );
  }
}
