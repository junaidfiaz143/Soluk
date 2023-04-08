import 'dart:io';

import 'package:app/module/influencer/more/widget/pop_alert_dialog.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/module/user/profile/sub_screen/edit_profile/bloc/edit_profile_cubit.dart';
import 'package:app/module/user/profile/sub_screen/edit_profile/bloc/edit_profile_state.dart';
import 'package:app/res/color.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../../../../../../repo/data_source/local_store.dart';
import '../../../../../../utils/pickers.dart';
import '../../../../../influencer/widgets/info_dialog_box.dart';
import '../../../../../influencer/workout/widgets/add_link.dart';

class EditProfileScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _EditProfileState();
  }
}

class _EditProfileState extends State<EditProfileScreen> {
  final EditProfileCubit myCubit = EditProfileCubit(EditProfileLoadingState());
  final TextEditingController _userNameController = TextEditingController(),
      _emailController = TextEditingController(),
      _fullNameController = TextEditingController(),
      _instagramController = TextEditingController(),
      _snapchatController = TextEditingController();
  XFile? _imageFile;
  String? _imagePath;
  String? userId;

  fetchUserId() async {
    LocalStore.getData(PREFS_USERID).then((value) {
      userId = value;
      myCubit.getData(userId: value);
    });
  }

  @override
  void initState() {
    fetchUserId();
    super.initState();
  }

  @override
  Widget build(BuildContext _context) {
    return Scaffold(
      backgroundColor: Colors.grey,
      body: AppBody(
        showBackButton: true,
        title: "Edit Profile",
        body: BlocBuilder<EditProfileCubit, EditProfileState>(
          bloc: myCubit,
          builder: (context, state) {
            // if (state is EditProfileLoadingState) {
            SolukToast.showLoading();
            if (state is EditProfileUpdatedState) {
              SolukToast.closeAllLoading();
              WidgetsBinding.instance.addPostFrameCallback((_) {
                showDialog(
                    context: _context,
                    builder: (BuildContext context) {
                      return InfoDialogBox(
                        icon: 'assets/images/tick_ss.png',
                        // title: AppLocalisation.getTranslated(
                        //     context, LKCongratulations),
                        title: AppLocalisation.getTranslated(
                            context, LKSuccessful),
                        description: "Your profile has been updated",
                        onPressed: () async {
                          Navigator.pop(context, true);
                          Navigator.pop(context, true);
                        },
                      );
                    });
              });

              // Navigator.pop(_context);
            } else if (state is EditProfileEmptyState) {
              SolukToast.closeAllLoading();
              return const Center(
                child: Text("No Data found"),
              );
            } else if (state is EditProfileDataLoaded) {
              SolukToast.closeAllLoading();
              _fullNameController.text = state.profileData["fullname"] ?? "";
              _userNameController.text =
                  state.profileData["client_info"]["username"] ?? "";
              _emailController.text = state.profileData["email"] ?? "";
              _instagramController.text = state.profileData["instagram"] ?? "";
              _snapchatController.text = state.profileData["snapchat"] ?? "";
              _imagePath = state.profileData['imageUrl'];
            }
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      Center(
                        child: SizedBox(
                          height: HEIGHT_5 + defaultSize.screenHeight * .02,
                          width: HEIGHT_5,
                          child: InkWell(
                            onTap: () {
                              popUpAlertDialog(
                                context,
                                AppLocalisation.getTranslated(
                                    context, 'LKProfileImage'),
                                LKProfileDetail,
                                isProfile: true,
                                mediaType: CameraMediaType.IMAGE,
                                onCameraTap: (type) {
                                  _setProfilePicture(
                                      source: ImageSource.camera);
                                },
                                onGalleryTap: () {
                                  _setProfilePicture(
                                      source: ImageSource.gallery);
                                },
                              );
                            },
                            child: Stack(
                              children: [
                                Container(
                                    height: HEIGHT_5,
                                    width: HEIGHT_5,
                                    decoration: BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: Colors.grey[300],
                                    ),
                                    child: _imageFile != null
                                        ? ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(100),
                                            child: Image(
                                                fit: BoxFit.cover,
                                                image: FileImage(
                                                    File(_imageFile!.path))),
                                          )
                                        : (_imagePath == null ||
                                                _imagePath == '')
                                            ? Icon(
                                                Icons.person,
                                                size: HEIGHT_3,
                                                color: Colors.grey[400],
                                              )
                                            : ClipRRect(
                                                borderRadius:
                                                    BorderRadius.circular(100),
                                                child: Image(
                                                    fit: BoxFit.cover,
                                                    image: NetworkImage(
                                                        _imagePath ?? '')),
                                              )),
                                Align(
                                  alignment: Alignment.bottomCenter,
                                  child: Container(
                                    height: HEIGHT_2 -
                                        defaultSize.screenHeight * .01,
                                    width: HEIGHT_2 -
                                        defaultSize.screenHeight * .01,
                                    decoration: const BoxDecoration(
                                      shape: BoxShape.circle,
                                      color: PRIMARY_COLOR,
                                    ),
                                    child: Icon(
                                      Icons.camera_enhance,
                                      size: WIDTH_1 +
                                          defaultSize.screenWidth * .01,
                                      color: Colors.white,
                                    ),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _fullNameController,
                        hintText: "",
                        labelText: "Fullname",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _userNameController,
                        hintText: "",
                        labelText: "Username",
                        enable: false,
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _emailController,
                        hintText: "",
                        labelText: "Email",
                        enable: false,
                      ),
                      SB_1H,
                      LinkItem(
                          controller: _instagramController,
                          title: 'Instagram',
                          icon: INSTAGRAM),
                      SB_1H,
                      LinkItem(
                          controller: _snapchatController,
                          title: 'Snapchat',
                          icon: SNAPCHAT),
                      Spacer(),
                      SB_1H,
                      SalukGradientButton(
                        title: 'Update',
                        onPressed: () {
                          myCubit.updateData(
                              userId: userId!,
                              fullname: _fullNameController.text,
                              instagram: _instagramController.text,
                              path: _imageFile?.path,
                              snapchat: _snapchatController.text);
                          // ChatFirebaseUtils.instance.updateUserProfile(
                          //     "https://picsum.photos/200/300");
                        },
                        buttonHeight: HEIGHT_4,
                      ),
                      SB_1H,
                    ],
                  ),
                )
              ],
            );
            // } else {
            //   return Center();
            // }
          },
        ),
      ),
    );
  }

  _setProfilePicture({required ImageSource source}) async {
    final ImagePicker _picker = ImagePicker();
    try {
      _imageFile = await _picker.pickImage(source: source);
      if (_imageFile != null) {
        setState(() {});
      }
    } catch (e) {
      print(e.toString());
    }
  }
}
