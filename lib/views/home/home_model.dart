import 'package:flutter/Material.dart';

class PetDetailsModel{
  Color? imgBgColor;
  String? imagePath;
  String? petName;
  String? petId;
  String? gender;
  DateTime? matingDate;
  String? breedingType;
  bool? isPregnancy;

  PetDetailsModel({this.imgBgColor,this.imagePath,this.petName,this.petId,this.gender,this.matingDate,this.breedingType,this.isPregnancy});
}