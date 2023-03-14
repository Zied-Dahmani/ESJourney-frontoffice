import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

part 'drawer_state.dart';
part 'drawer_cubit.freezed.dart';

class DrawerCubit extends Cubit<DrawerState> {
  DrawerCubit() : super(const DrawerState());

  void setUsername(String value) {
    emit(state.copyWith(username: value));
  }
}
