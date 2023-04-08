import 'package:app/module/user/subscription/subscription.dart';
import 'package:bloc/bloc.dart';

import '../../../../../../repo/data_source/local_store.dart';
import '../../../../../../res/constants.dart';

enum PaymentMethod {
  not_selected,
  card,
  apple_pay,
  google_pay,
  transaction_successful,
  transaction_failed,
  refresh
}

class PaymentMethodCubit extends Cubit<PaymentMethod> {
  PaymentMethodCubit() : super(PaymentMethod.not_selected);

  void onPaymentMethodChanged(String? name) {
    if (name == Subscription.CARD) {
      emit(PaymentMethod.card);
    } else if (name == Subscription.APPLE_PAY) {
      emit(PaymentMethod.apple_pay);
    } else if (name == Subscription.GOOGLE_PAY) {
      emit(PaymentMethod.google_pay);
    } else {
      emit(PaymentMethod.not_selected);
    }
  }

  void onTransactionChanged(bool? transaction_response) {
    if (transaction_response == true) {
      emit(PaymentMethod.transaction_successful);
    } else {
      emit(PaymentMethod.transaction_failed);
    }
  }

  void onRefresh() {
    emit(PaymentMethod.refresh);
  }

  // void updateSubscriptionFromLocal() async {
  //   isSubscribed = await LocalStore.getData(PREFS_IS_SUBSCRIBED);
  // }
}

// extension PaymentExtension on PaymentMethod {
//   String get method {
//     switch (this) {
//       case PaymentMethod.card:
//         return Subscription.CARD;
//       case PaymentMethod.apple_pay:
//         return Subscription.APPLE_PAY;
//       default:
//         return "";
//     }
//   }
// }
