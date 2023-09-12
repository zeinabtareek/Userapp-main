import '../../helper/display_helper.dart';
import '../data/models/base_model.dart';
import '../data_state.dart';

void checkStatus<T extends BaseResModel>(
  DataState<T> state, {
  Function(T? res)? onSucses,
  Function(T? error)? onError,
  bool showErrorToast = true,
  bool showSucsesToast = false,
}) {
  if (state is DataSuccess<T>) {
    if (state.data != null && state.data!.status == 200) {
      _handelSucses<T>(showSucsesToast, state, onSucses);
    } else {
      _handelError<T>(showErrorToast, state, onError);
    }
  } else {
    _handelError<T>(showErrorToast, state, onError);
  }
}

void _handelSucses<T>(
  bool showSucsesToast,
  DataSuccess<dynamic> state,
  Function(T? res)? onSucses,
) {
  if (showSucsesToast) {
    showCustomSnackBar(state.data?.msg ?? "", isError: false);
  }
  onSucses?.call(state.data);
}

void _handelError<T>(
  bool showErrorToast,
  DataState<T> state,
  Function(T? error)? onError,
) {
  if (showErrorToast) {
    showCustomSnackBar(state.errorMsg ?? "");
  }
  onError?.call(state.data);
}
