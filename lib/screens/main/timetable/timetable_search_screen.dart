import 'package:danvery/modules/orb/components/components.dart';
import 'package:danvery/screens/main/timetable/widgets/schedule_table.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/timetable/timetable_provider.dart';


class TimetableSearchScreen extends ConsumerStatefulWidget {
  const TimetableSearchScreen({super.key});


  @override
  ConsumerState<ConsumerStatefulWidget> createState() {
    // TODO: implement createState
    return _TimetableSearchScreen();
  }
}

class _TimetableSearchScreen extends ConsumerState<TimetableSearchScreen> {
  late final FocusNode searchFocusNode;
  late final TextEditingController searchController;

  @override
  void initState() {
    // TODO: implement initState
    searchFocusNode = FocusNode();
    searchController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    searchFocusNode.dispose();
    searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    // TODO: implement build
    final ThemeData themeData = Theme.of(context);
    return OrbScaffold(
      shrinkWrap: true,
      scrollBody: false,
      orbAppBar: const OrbAppBar(
        title: '교과목 검색',
      ),
      body: Column(
        children: [
          TextFormField(
            focusNode: searchFocusNode,
            controller: searchController,
            textInputAction: TextInputAction.search,
            decoration: InputDecoration(
              hintText: '과목명',
              hintStyle: Theme.of(context).textTheme.bodyMedium,
              prefixIcon: Icon(Icons.search, color: themeData.colorScheme.onSurface),
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: BorderSide(
                  color: themeData.colorScheme.surfaceVariant,
                ),
              ),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 16,
                vertical: 8,
              ),
              counterText: '',
              suffixIcon: ref.watch(timetableSearchTextProvider).isNotEmpty
                  ? TextButton(
                      onPressed: () {
                        ref
                            .read(timetableSearchTextProvider.notifier)
                            .update((state) => "");
                        searchController.clear();
                        searchFocusNode.unfocus();
                      },
                      child: Text(
                        '취소',
                        style: themeData.textTheme.bodyMedium,
                      ),
                    )
                  : null,
            ),
            maxLines: 1,
            maxLength: 50,
            onChanged: (value) {
              ref
                  .read(timetableSearchTextProvider.notifier)
                  .update((state) => value);
            },
            onFieldSubmitted: (value) {},
          ),
          const SizedBox(height: 16),
          Expanded(
            child: ref.watch(timetableSearchProvider).when(
              data: (value) {
                if (value == null) {
                  return const SizedBox();
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: value.length,
                  itemBuilder: (context, index) {
                    final String weeks = value[index]
                        .times
                        .map((e) => WeekDays.values
                            .firstWhere(
                              (element) => element.english == e.week,
                            )
                            .korean)
                        .join(", ");
                    final String times = value[index]
                        .times
                        .map((e) =>
                            "${e.start.substring(0, 5)} ~ ${e.end.substring(0, 5)}")
                        .toSet()
                        .join(", ");
                    final String place = "(${value[index]
                        .times
                        .map((e) => e.place)
                        .toSet()
                        .join(", ")})".replaceAll("(null)", "(강의실 미정)");
                    final String grade = "${value[index].grade.toString()}학년".replaceAll("null학년", "학년 미정");
                    final String lectureCode = "${value[index].lectureCode} - ${value[index].classNumber}";
                    final String professor = value[index].professor.isNotEmpty ? value[index].professor : "교수자 미정";
                    return InkWell(
                      onTap: (){
                        Navigator.of(context).pop(value[index]);
                      },
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            value[index].name,
                            style: themeData.textTheme.bodyLarge?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            professor,
                            style: themeData.textTheme.bodyMedium,
                          ),
                          const SizedBox(height: 8),
                          Text(
                            "$weeks $times$place",
                            style: themeData.textTheme.bodyMedium?.copyWith(
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          Text(
                            "$grade, ${value[index].category}, ${value[index].credit}학점, $lectureCode",
                            style: themeData.textTheme.bodyMedium,
                          ),
                          const OrbDivider(),
                        ],
                      ),
                    );
                  },
                );
              },
              loading: () {
                return const SizedBox();
              },
              error: (error, stackTrace) {
                return const SizedBox();
              },
            ),
          ),
        ],
      ),
    );
  }
}
