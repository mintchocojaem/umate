
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:intl/intl.dart';

import '../../../utils/theme/app_text_theme.dart';
import '../../../utils/theme/palette.dart';

class PetitionCard extends StatelessWidget {
  final String title; // 제목
  final String createdAt; // 청원 기간
  final String expiredAt; // 청원 기간
  final String numberOfPeople; // 참여 인원
  final String status; // 청원 상태

  const PetitionCard({
    super.key,
    required this.title,
    required this.numberOfPeople,
    required this.status,
    required this.createdAt,
    required this.expiredAt,
  });

  @override
  Widget build(BuildContext context) {

    DateTime now = DateTime.now();
    DateTime expiredDate = DateFormat("yyyy-MM-dd").parse(expiredAt);
    int period = expiredDate.difference(now).inDays;

    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: context.isDarkMode ? Palette.darkGrey : Palette.pureWhite,
        borderRadius: BorderRadius.circular(10),
        boxShadow: [
          BoxShadow(color: Colors.grey.withOpacity(0.3),
            spreadRadius: 2,
            blurRadius: 2,
            offset: const Offset(0, 2), // changes position of shadow
          ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "[학생복지]",
              style: tinyStyle.copyWith(color: Palette.lightBlue),
            ),
            Text(
              title,
              style: titleStyle,
            ),
            Padding(
              padding: const EdgeInsets.only(top: 4.0, bottom: 4),
              child: Text(
                "D - $period",
                style: regularStyle.copyWith(fontWeight: FontWeight.bold)
              ),
            ),
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text("청원기간", style: tinyStyle.copyWith(fontWeight: FontWeight.bold, color: Palette.darkGrey),),
                    Text("$createdAt ~ $expiredAt", style: tinyStyle.copyWith(color: Palette.darkGrey),)
                  ],
                ),
                const SizedBox(width: 32,),
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Text("참여인원", style: tinyStyle.copyWith(fontWeight: FontWeight.bold , color: Palette.darkGrey),),
                        const SizedBox(width: 8,),
                        Text("143명", style: tinyStyle.copyWith(color: Palette.darkGrey),),
                      ],
                    ),
                    Row(
                      children: [
                        Text("청원상태", style: tinyStyle.copyWith(fontWeight: FontWeight.bold, color: Palette.darkGrey),),
                        const SizedBox(width: 8,),
                        Text(status,style: tinyStyle.copyWith(color: Palette.blue, fontWeight: FontWeight.bold),)
                      ],
                    ),
                  ],
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
