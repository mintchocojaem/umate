part of 'home_screen.dart';

class HomePetitionPostInfo{
  final int id;
  final String title;
  final String body;
  final String createdAt;
  final Function(int id) onTap;

  const HomePetitionPostInfo({
    required this.id,
    required this.title,
    required this.body,
    required this.createdAt,
    required this.onTap,
  });
}

class HomePetitionBoard extends StatelessWidget {
  final List<HomePetitionPostInfo> petitionInfoList;

  const HomePetitionBoard({
    super.key,
    required this.petitionInfoList,
  });

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    return ListView.builder(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      itemCount: petitionInfoList.length,
      itemBuilder: (context, index) {
        final petition = petitionInfoList[index];
        return ListTile(
          contentPadding: const EdgeInsets.all(0),
          visualDensity: const VisualDensity(horizontal: 0, vertical: -4),
          title: Text(
            petition.title,
            style: Theme.of(context).textTheme.bodyLarge?.copyWith(
                  fontWeight: FontWeight.w500,
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          subtitle: Text(
            petition.body,
            style: Theme.of(context).textTheme.bodyMedium?.copyWith(
                  color: Theme.of(context).colorScheme.onSurface.withOpacity(0.6),
                ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
          ),
          onTap: () {
            petition.onTap(petition.id);
          },
          leading: Text(
            petition.createdAt,
            style: Theme.of(context).textTheme.bodyMedium,
          ),
          trailing: const Icon(
            Icons.chevron_right_outlined,
          ),
        );
      },
    );
  }
}
