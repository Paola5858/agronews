import '../errors/app_error.dart';

abstract class ViewState<T> {
  const ViewState();
}

class InitialState<T> extends ViewState<T> {
  const InitialState();
}

class LoadingState<T> extends ViewState<T> {
  const LoadingState();
}

class SuccessState<T> extends ViewState<T> {
  final T data;
  const SuccessState(this.data);
}

class ErrorState<T> extends ViewState<T> {
  final AppError error;
  const ErrorState(this.error);
}

class EmptyState<T> extends ViewState<T> {
  final String message;
  const EmptyState(this.message);
}
