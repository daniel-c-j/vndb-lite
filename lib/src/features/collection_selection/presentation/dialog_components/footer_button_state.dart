import 'package:riverpod_annotation/riverpod_annotation.dart';
import 'package:vndb_lite/src/common_widgets/custom_button.dart';

part 'footer_button_state.g.dart';

@riverpod
class VnButtonState extends _$VnButtonState {
  @override
  ButtonState build() => ButtonState.active;

  @override
  set state(ButtonState newState) => super.state = newState;
}
