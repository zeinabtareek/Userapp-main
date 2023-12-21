




enum PaymentTypeState {
  cash,
  wallet,
  digital ,
}
PaymentTypeState enumFromString(String value) {
  return PaymentTypeState.values.firstWhere(
        (e) => e.toString().split('.').last == value,
    orElse: () => PaymentTypeState.cash, // Default value or handle as needed
  );
}
void func(){
  PaymentTypeState paymentType = PaymentTypeState.cash;

  switch (paymentType) {
    case PaymentTypeState.cash:
      print(PaymentTypeState.cash.index);
      break;
    case PaymentTypeState.wallet:
      print(PaymentTypeState.wallet.index);
      break;
    case PaymentTypeState.digital:
      print(PaymentTypeState.digital.index);
      break;
    default:
      break;
  }
}