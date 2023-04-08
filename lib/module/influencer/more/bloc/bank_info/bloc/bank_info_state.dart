import 'package:app/module/influencer/more/model/bank_info_model.dart';

abstract class BankInfoState {
  final BankInfoModel? bankInfoData;

  BankInfoState({this.bankInfoData});
}

class BankInfoLoadingState extends BankInfoState {
  BankInfoLoadingState() : super();
}

class BankInfoEmptyState extends BankInfoState {
  BankInfoEmptyState() : super();
}

class BankInfoDataLoaded extends BankInfoState {
  BankInfoDataLoaded(BankInfoModel response) : super(bankInfoData: response);
}

class BankInfoUpdatedState extends BankInfoState {
  BankInfoUpdatedState() : super();
}
