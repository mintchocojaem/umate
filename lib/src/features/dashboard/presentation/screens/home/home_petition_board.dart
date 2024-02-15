part of 'home_screen.dart';

class HomePetitionBoard extends ConsumerStatefulWidget{

  const HomePetitionBoard({
    super.key,
  });

  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    return _HomePetitionBoardState();
  }

}
class _HomePetitionBoardState extends ConsumerState<HomePetitionBoard>{

  late final Future<PetitionBoardModel> homePetitionBoard;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    homePetitionBoard = ref.read(petitionRepositoryProvider).getPetitionBoard(
      status: PetitionStatus.expired.value,
      page: 0,
      size: 4,
    );
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return OrbBoardContainer(
      titleText: "청원 게시판",
      child: FutureBuilder<PetitionBoardModel>(
        future: homePetitionBoard,
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            final petitionList = (snapshot.data as PetitionBoardModel).content;
            return Column(
              children: [
                for (final petition in petitionList)
                  HomePetitionListTile(
                    title: petition.title,
                    body: petition.body,
                    createdAt: DateTimeFormatter.dateFormatRelative(
                      petition.createdAt,
                    ),
                  ),
              ],
            );
          } else {
            return const OrbShimmerContent();
          }
        },
      ),
    );
  }
}

class HomePetitionListTile extends StatelessWidget {
  final String title;
  final String body;
  final String createdAt;

  const HomePetitionListTile({
    super.key,
    required this.title,
    required this.body,
    required this.createdAt,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      contentPadding: const EdgeInsets.all(0),
      visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
      title: Text(
        title,
        style: Theme.of(context).textTheme.bodyLarge?.copyWith(
              fontWeight: FontWeight.w500,
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      subtitle: Text(
        body,
        style: Theme.of(context).textTheme.bodyMedium?.copyWith(
              color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
            ),
        maxLines: 1,
        overflow: TextOverflow.ellipsis,
      ),
      onTap: () {
        //
      },
      leading: Text(
        createdAt,
        style: Theme.of(context).textTheme.bodyMedium,
      ),
      trailing: const Icon(
        Icons.chevron_right_outlined,
      ),
    );
  }
}
