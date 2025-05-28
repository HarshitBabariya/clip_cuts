import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../const/const_app_images.dart';
import '../../utils/support.dart';
import 'home_event.dart';
import 'home_model.dart';
import 'home_state.dart';

class HomeBloc extends Bloc<HomeEvent, HomeState> {

  final TextEditingController searchController = TextEditingController();
  final List<PetDetailsModel> allPetDetailsList = <PetDetailsModel>[
    PetDetailsModel(
      imgBgColor: Color(0xFFCBF25B),
      imagePath: AppImages.pet1,
      petName: "Charlie",
      petId: "A0001",
      gender: "Male",
      breedingType: "Emmy",
      isPregnancy: false,
      matingDate: parseDate('12/12/23')
    ),
    PetDetailsModel(
        imgBgColor: Color(0xFF8B98DE),
        imagePath: AppImages.pet2,
        petName: "Oliver",
        petId: "A0002",
        gender: "Male",
        breedingType: "Emmy",
        isPregnancy: false,
        matingDate: parseDate('12/12/23')
    ),
    PetDetailsModel(
        imgBgColor: Color(0xFFFFC4BD),
        imagePath: AppImages.pet3,
        petName: "Mila",
        petId: "A0003",
        gender: "Female",
        breedingType: "Emmy",
        isPregnancy: true,
        matingDate: parseDate('12/12/23')
    ),
    PetDetailsModel(
        imgBgColor: Color(0xFF56DADA),
        imagePath: AppImages.pet4,
        petName: "Rocky",
        petId: "A0004",
        gender: "Male",
        breedingType: "Emmy",
        isPregnancy: false,
        matingDate: parseDate('12/12/23')
    ),
    PetDetailsModel(
        imgBgColor: Color(0xFFFF5794),
        imagePath: AppImages.pet5,
        petName: "Coopy",
        petId: "A0005",
        gender: "Female",
        breedingType: "Emmy",
        isPregnancy: true,
        matingDate: parseDate('12/12/23')
    )
  ];

  List<PetDetailsModel> filteredPetList = [];

  HomeBloc() : super(Init()) {
    on<SearchPetsEvent>(_onSearchPets);
    filteredPetList = List.from(allPetDetailsList);
  }

  void _onSearchPets(SearchPetsEvent event, Emitter<HomeState> emit) {
    if (event.query.trim().isEmpty) {
      filteredPetList = List.from(allPetDetailsList);
    } else {
      filteredPetList = allPetDetailsList.where((pet) {
        return pet.petName!.toLowerCase().contains(event.query.toLowerCase()) ||
            pet.petId!.toLowerCase().contains(event.query.toLowerCase());
      }).toList();
    }

    emit(FilteredState(filteredList: filteredPetList));
  }


  @override
  Future<void> close() {
    searchController.dispose();
    return super.close();
  }
}
