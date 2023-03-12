
import 'package:danvery/app/ui/theme/app_text_theme.dart';
import 'package:danvery/app/ui/theme/palette.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class PetitionCard extends StatelessWidget {
  final String title; // 제목
  final String dueDate; // 마감 일자
  final String petitionPeriod; // 청원 기간
  final String numberOfPeople; // 참여 인원
  final String petitionStatus; // 청원 상태

  const PetitionCard({
    super.key,
    required this.title,
    required this.dueDate,
    required this.petitionPeriod,
    required this.numberOfPeople,
    required this.petitionStatus,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => {

      },
      child: Container(
        width: double.infinity,
        decoration: BoxDecoration(
          color: context.isDarkMode ? Palette.darkGrey : Palette.pureWhite,
          borderRadius: BorderRadius.circular(10),
          boxShadow: [
            BoxShadow(color: Colors.grey.withOpacity(0.4),
              spreadRadius: 2,
              blurRadius: 2,
              offset: const Offset(0, 1), // changes position of shadow
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
                style: tinyStyle.copyWith(color: Palette.blue),
              ),
              Text(
                title,
                style: titleStyle,
              ),
              Padding(
                padding: const EdgeInsets.only(top: 4.0, bottom: 4),
                child: Text(
                  dueDate,
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
                      Text("2023-01-15 ~ 2023/02-15", style: tinyStyle.copyWith(color: Palette.darkGrey),)
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
                          Text("청원 중",style: tinyStyle.copyWith(color: Palette.blue, fontWeight: FontWeight.bold),)
                        ],
                      ),
                    ],
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
