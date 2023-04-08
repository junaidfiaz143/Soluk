import 'package:app/module/influencer/more/bloc/bank_info/bloc/bank_info_cubit.dart';
import 'package:app/module/influencer/more/model/bank_info_model.dart';
import 'package:app/module/influencer/widgets/app_body.dart';
import 'package:app/module/influencer/widgets/saluk_gradient_button.dart';
import 'package:app/module/influencer/widgets/saluk_textfield.dart';
import 'package:app/res/constants.dart';
import 'package:app/res/globals.dart';
import 'package:app/services/localisation.dart';
import 'package:app/utils/soluk_toast.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../../repo/data_source/local_store.dart';
import '../../../../utils/model_prgress_hud.dart';
import '../../widgets/info_dialog_box.dart';
import '../bloc/bank_info/bloc/bank_info_state.dart';

class BankInfoScreen extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _BankInfoState();
  }
}

class _BankInfoState extends State<BankInfoScreen> {
  final BankInfoCubit myCubit = BankInfoCubit(BankInfoLoadingState());
  final TextEditingController _beneNameController = TextEditingController(),
      _bankNameController = TextEditingController(),
      _bankAddressController = TextEditingController(),
      _accountNumberController = TextEditingController(),
      _bankIbanController = TextEditingController(),
      _bicController = TextEditingController(),
      _swiftController = TextEditingController();
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
        title: "Bank Information",
        body: BlocBuilder<BankInfoCubit, BankInfoState>(
          bloc: myCubit,
          builder: (context, state) {
            // if (state is EditProfileLoadingState) {
            // SolukToast.showLoading();
            if (state is BankInfoUpdatedState) {
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
            } else if (state is BankInfoEmptyState) {
              SolukToast.closeAllLoading();
              return const Center(
                child: Text("No Data found"),
              );
            } else if (state is BankInfoDataLoaded) {
              SolukToast.closeAllLoading();
              if (state.bankInfoData is BankInfoModel) {
                _beneNameController.text =
                    state.bankInfoData?.responseDetails?.beneficiaryName ?? '';
                _bankNameController.text =
                    state.bankInfoData?.responseDetails?.bankName ?? '';
                _bankAddressController.text =
                    state.bankInfoData?.responseDetails?.bankAddress ?? '';
                _accountNumberController.text =
                    state.bankInfoData?.responseDetails?.bankAccountNumber ??
                        '';
                _bankIbanController.text =
                    state.bankInfoData?.responseDetails?.bankAccountIBAN ?? '';
                _bicController.text =
                    state.bankInfoData?.responseDetails?.bIC ?? '';
                _swiftController.text =
                    state.bankInfoData?.responseDetails?.swift ?? '';
              }
            }
            return CustomScrollView(
              slivers: [
                SliverFillRemaining(
                  hasScrollBody: false,
                  child: Column(
                    children: [
                      SB_1H,
                      SalukTextField(
                        textEditingController: _bankNameController,
                        hintText: "",
                        labelText: "Bank Name",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _beneNameController,
                        hintText: "",
                        labelText: "Beneficiary Name",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _bankIbanController,
                        hintText: "",
                        labelText: "IBAN",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _accountNumberController,
                        hintText: "",
                        labelText: "Account Number",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _bankAddressController,
                        hintText: "",
                        labelText: "Bank Address",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _bicController,
                        hintText: "",
                        labelText: "BIC",
                      ),
                      SB_1H,
                      SalukTextField(
                        textEditingController: _swiftController,
                        hintText: "",
                        labelText: "Swift",
                      ),
                      SB_1H,
                      SalukGradientButton(
                        title: 'Add',
                        onPressed: () {
                          myCubit.updateData(
                            beneName: _beneNameController.text,
                            bankName: _bankNameController.text,
                            bankAddress: _bankAddressController.text,
                            accountNumber: _accountNumberController.text,
                            iban: _bankIbanController.text,
                            bic: _bicController.text,
                            swift: _swiftController.text,
                          );
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
}
