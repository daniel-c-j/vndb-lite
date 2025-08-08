import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'auth_token_field_controller.g.dart';

@Riverpod(keepAlive: true)
class ShowAuthTokenFieldState extends _$ShowAuthTokenFieldState {
  @override
  bool build() {
    return true;
  }

  set show(bool value) => state = value;
}

@riverpod
class AuthTokenFieldState extends _$AuthTokenFieldState {
  @override
  String build() => "";
  set value(String value) => state = value;
}

@Riverpod(keepAlive: true)
class AuthTokenFieldServerErrorState extends _$AuthTokenFieldServerErrorState {
  @override
  String build() => "";
  set error(String value) => state = value;
}
