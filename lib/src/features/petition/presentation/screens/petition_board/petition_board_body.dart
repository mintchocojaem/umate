part of 'petition_board_screen.dart';

class PetitionBoardBody extends ConsumerWidget {

  final PetitionStatus petitionStatus;
  final String? keyword;

  const PetitionBoardBody({
    super.key,
    required this.petitionStatus,
    this.keyword,
  });

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final petitionBoard = ref.read(petitionRepositoryProvider).getPetitionBoard(
      keyword: keyword,
      status: petitionStatus.value,
      page: 0,
      size: 10,
    );
    final themeData = Theme.of(context);
    return FutureBuilder<PetitionBoardModel>(
      future: petitionBoard,
      builder: (BuildContext context,
          AsyncSnapshot<PetitionBoardModel> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const OrbShimmerContent();
            },
          );
        } else if (snapshot.hasData) {
          if (snapshot.data!.content.isEmpty) {
            return Center(
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
            );
          }
          return ListView.builder(
            itemCount: snapshot.data!.content.length,
            itemBuilder: (context, index) {
              return PetitionPreviewCard(
                remainingDate: snapshot.data!.content[index].expiresAt,
                title: snapshot.data!.content[index].title,
                duration: DateTimeFormatter.dateFormatRelative(
                  snapshot.data!.content[index].createdAt,
                ),
                agreeCount: snapshot.data!.content[index].agreeCount,
                status: snapshot.data!.content[index].status,
              );
            },
          );
        }else {
          return ListView.builder(
            itemCount: 10,
            itemBuilder: (context, index) {
              return const OrbShimmerContent();
            },
          );
        }
      },
    );
  }
}

class PetitionPreviewCard extends StatelessWidget {
  final String remainingDate;
  final String title;
  final String duration;
  final int agreeCount;
  final String status;
  final VoidCallback? onTap;

  const PetitionPreviewCard({
    super.key,
    required this.remainingDate,
    required this.title,
    required this.duration,
    required this.agreeCount,
    required this.status,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return InkWell(
      onTap: onTap,
      child: Container(
        margin: const EdgeInsets.only(bottom: 16),
        decoration: BoxDecoration(
          color: themeData.colorScheme.surface,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: themeData.colorScheme.onBackground.withOpacity(0.1),
              offset: const Offset(0, 1),
              blurRadius: 1,
            ),
          ],
        ),
        child: Padding(
          padding: const EdgeInsets.all(16),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Text(
                remainingDate,
                style: Theme.of(context).textTheme.bodyMedium,
              ),
              const SizedBox(height: 4),
              Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w600,
                ),
              ),
              const SizedBox(height: 8),
              Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "청원기간",
                        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                          fontWeight: FontWeight.w600,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        duration,
                        style:
                        Theme.of(context).textTheme.bodyMedium?.copyWith(),
                      ),
                    ],
                  ),
                  const Spacer(),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Text(
                            "참여인원",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            "$agreeCount명",
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                      const SizedBox(height: 4),
                      Row(
                        children: [
                          Text(
                            "청원상태",
                            style: Theme.of(context)
                                .textTheme
                                .bodyMedium
                                ?.copyWith(
                              fontWeight: FontWeight.w600,
                            ),
                          ),
                          const SizedBox(width: 8),
                          Text(
                            status,
                            style: Theme.of(context).textTheme.bodyMedium,
                          ),
                        ],
                      ),
                    ],
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
