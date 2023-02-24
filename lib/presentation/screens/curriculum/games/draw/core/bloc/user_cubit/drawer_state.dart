part of 'drawer_cubit.dart';

@freezed
class DrawerState with _$DrawerState {
  const factory DrawerState({
    @Default("") String username,
  }) = _DrawerState;
}
