
import 'package:clip_cuts/service/auth_service.dart';
import 'package:flutter/Material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nb_utils/nb_utils.dart';

import '../../common/widget/app_component.dart';
import '../../const/const_app_fonts.dart';
import '../../const/const_app_images.dart';
import '../../const/const_app_text.dart';
import '../../const/const_color.dart';
import '../../utils/support.dart';
import 'home_bloc.dart';
import 'home_event.dart';
import 'home_model.dart';
import 'home_state.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  static Widget builder(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeBloc(),
      child: const HomeScreen(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<HomeBloc, HomeState>(
        listener: (context, state) {},
        builder: (context, state) {
          final bloc = context.read<HomeBloc>();
          List<PetDetailsModel> petsToShow = bloc.filteredPetList;
          if (state is FilteredState) {
            petsToShow = state.filteredList;
          }
          return Scaffold(
            backgroundColor: AppColors.white,
            body: Column(
              children: [
                Container(
                  // height: 50,
                  width: MediaQuery.sizeOf(context).width,
                  decoration: BoxDecoration(color: AppColors.primaryColor, borderRadius: BorderRadius.only(bottomLeft: Radius.circular(40), bottomRight: Radius.circular(40))),
                  child: Padding(
                    padding: const EdgeInsets.only(top: 30, bottom: 20),
                    child: Row(
                      spacing: 10,
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      children: [
                        Container(
                          width: 40,
                          height: 40,
                          alignment: Alignment.center,
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            shape: BoxShape.circle,
                            image: DecorationImage(image: AssetImage(AppImages.profile)),
                          ),
                        ),
                        Text(AppConstText.appLabel, style: TextStyle(fontFamily: AppConstFonts.pattayaRegular ,fontSize: 30, color: AppColors.white)),
                        InkWell(
                          onTap: (){
                            showLogoutBottomSheet(context);
                          },
                          child: Image.asset(AppImages.logout,height: 25,width: 28,alignment: Alignment.center),
                        ),
                      ],
                    ),
                  ),
                ),
                SizedBox(height: 20),
                Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: AppComponent.commonTextField(
                    controller: context.read<HomeBloc>().searchController,
                    textInputAction: TextInputAction.done,
                    textFieldType: TextFieldType.OTHER,
                    iconName: AppImages.search,
                    contexts: context,
                    hintText: AppHintText.hintSearch,
                    onChanged: (value) {
                      context.read<HomeBloc>().add(SearchPetsEvent(value));
                    },
                  ),
                ),
                SizedBox(height: 10),
                Expanded(
                  child: ListView.separated(
                    shrinkWrap: true,
                    padding: EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                    separatorBuilder: (context, ind) {
                      return SizedBox(height: 15);
                    },
                    itemCount: petsToShow.length,
                    itemBuilder: (context, index) {
                      final PetDetailsModel tempDetails = petsToShow[index];
                      return Material(
                        color: AppColors.white,
                        elevation: 2,
                        surfaceTintColor: AppColors.white,
                        shape: OutlineInputBorder(borderSide: BorderSide.none, borderRadius: BorderRadius.all(Radius.circular(8))),
                        child: Container(
                          width: MediaQuery.sizeOf(context).width,
                          padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
                          decoration: BoxDecoration(
                            color: AppColors.white,
                            borderRadius: BorderRadius.circular(8),
                          ),
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Row(
                                spacing: 10,
                                children: [
                                  Container(
                                    height: 40,
                                    width: 40,
                                    alignment: Alignment.bottomCenter,
                                    decoration: BoxDecoration(
                                      color: tempDetails.imgBgColor!.withValues(alpha: 0.1),
                                      borderRadius: BorderRadius.circular(9),
                                      border: Border.all(color: tempDetails.imgBgColor ?? AppColors.white),
                                    ),
                                    child: Image.asset(
                                      tempDetails.imagePath!,
                                      alignment: Alignment.bottomCenter,
                                    ),
                                  ),
                                  Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    children: [
                                      Row(
                                        spacing: 10,
                                        children: [
                                          Text(tempDetails.petName ?? "", style: AppFonts.ralewaySemiBold.copyWith(fontSize: 15, color: AppColors.primaryTextColor)),
                                          Container(
                                            height: 17,
                                            alignment: Alignment.center,
                                            padding: EdgeInsets.symmetric(horizontal: 7),
                                            decoration: BoxDecoration(
                                              borderRadius: BorderRadius.circular(90),
                                              color: AppColors.labelBGColor,
                                            ),
                                            child: Text(tempDetails.gender ?? "", style: AppFonts.ralewayMedium.copyWith(fontSize: 10, color: AppColors.labelColor)),
                                          )
                                        ],
                                      ),
                                      Text("${AppConstText.lblId.toUpperCase()}:${tempDetails.petId ?? ""}", style: AppFonts.ralewayMedium.copyWith(fontSize: 12, color: AppColors.labelHintColor)),
                                    ],
                                  ),
                                ],
                              ),
                              Divider(color: AppColors.normalBorderColor),
                              Row(
                                spacing: 5,
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                children: [
                                  _buildShowDetails(label: AppConstText.lblMatting, value: dateFormat(tempDetails.matingDate ?? DateTime.now())),
                                  _buildShowDetails(label: AppConstText.lblBreedingPartner, value: tempDetails.breedingType ?? ""),
                                  _buildShowDetails(label: AppConstText.lblPregnancy, value: (tempDetails.isPregnancy ?? false) ? AppConstText.lblY : AppConstText.lblN),
                                ],
                              )
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                )
              ],
            ),
          );
        });
  }

  Column _buildShowDetails({required String label, required String value}) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(label, style: AppFonts.ralewayMedium.copyWith(fontSize: 10, color: AppColors.secondaryHintColor)),
        Text(value, style: AppFonts.ralewaySemiBold.copyWith(fontSize: 13, color: AppColors.secondaryLabelColor)),
      ],
    );
  }

  void showLogoutBottomSheet(BuildContext context) {
    showModalBottomSheet(
      context: context,
      backgroundColor: AppColors.white,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(28)),
      ),
      isDismissible: true,
      isScrollControlled: true,
      builder: (context) {
        return DraggableScrollableSheet(
          expand: false,
          initialChildSize: 0.2,
          minChildSize: 0.2,
          maxChildSize: 0.2,
          builder: (context, scrollController) {
            return Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    AppConstText.lblLogOut,
                    textAlign: TextAlign.center,
                    style: AppFonts.ralewayBold.copyWith(
                      fontSize: 22,
                      color: AppColors.primaryTextColor,
                    ),
                  ),
                  const SizedBox(height: 20),
                  Row(
                    children: [
                      Expanded(
                        child: AppButton(
                          color: AppColors.secondaryBtnColor.withValues(alpha: 0.1),
                          splashColor: AppColors.btnColor,
                          width: MediaQuery.of(context).size.width,
                          shapeBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(53)),
                          ),
                          onTap: () {
                            AuthService.logout();
                          },
                          child: Text(
                            AppConstText.lblYes,
                            style: AppFonts.ralewayBold.copyWith(
                              fontSize: 16,
                              color: AppColors.primaryTextColor,
                            ),
                          ),
                        ),
                      ),
                      const SizedBox(width: 10),
                      Expanded(
                        child: AppButton(
                          color: AppColors.btnColor,
                          splashColor: AppColors.btnColor,
                          width: MediaQuery.of(context).size.width,
                          shapeBorder: const OutlineInputBorder(
                            borderRadius: BorderRadius.all(Radius.circular(53)),
                          ),
                          onTap: () {
                            Navigator.pop(context);
                          },
                          child: Text(
                            AppConstText.lblNo,
                            style: AppFonts.ralewayBold.copyWith(
                              fontSize: 16,
                              color: AppColors.white,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          },
        );
      },
    );
  }
}
