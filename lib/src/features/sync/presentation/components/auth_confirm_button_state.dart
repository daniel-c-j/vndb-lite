import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';

part 'auth_confirm_button_state.g.dart';

@riverpod
class AuthButtonState extends _$AuthButtonState {
  @override
  ButtonState build() {
    return ButtonState.inactive;
  }

  @override
  set state(ButtonState newState) => super.state = newState;
}
