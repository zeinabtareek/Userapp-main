import 'package:get/get.dart';

import '../../helper/display_helper.dart';
import '../data/models/base_model.dart';
import '../data_state.dart';

void checkStatus<T extends BaseResModel>(
  DataState<T> state, {
  Function(T? res)? onSuccess,
  Function(T? error)? onError,
  bool showErrorToast = true,
  bool showSuccessToast = false,
}) {
  if (state is DataSuccess<T>) {
    if (state.data != null && state.data!.status == 200) {
      _handelSuccess<T>(showSuccessToast, state, onSuccess);
    } else {
      _handelError<T>(showErrorToast, state, onError);
    }
  } else {
    _handelError<T>(showErrorToast, state, onError);
  }
}

void _handelSuccess<T extends BaseResModel>(
  bool showSuccessToast,
  DataSuccess<dynamic> state,
  Function(T? res)? onSuccess,
) async {
  if (showSuccessToast) {
    await Future.delayed(Duration.zero);
    showCustomSnackBar(state.data?.massage ?? state.data?.msg ?? "",
        isError: false);
  }
  onSuccess?.call(state.data);
}

void _handelError<T extends BaseResModel>(
  bool showErrorToast,
  DataState<T> state,
  Function(T? error)? onError,
) async {
  if (showErrorToast) {
    await Future.delayed(Duration.zero);
    showCustomSnackBar(state.errorMsg ?? "");
  }
  onError?.call(state.data);
}
