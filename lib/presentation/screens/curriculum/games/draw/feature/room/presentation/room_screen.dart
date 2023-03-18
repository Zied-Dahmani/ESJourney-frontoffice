import 'package:esjourney/presentation/router/routes.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/bloc/status/bloc_status.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/bloc/user_cubit/drawer_cubit.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/component/dialog/show_loading_dialog.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/core/component/snackbar/info_snackbar.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/room/presentation/cubit/room_cubit.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:get_it/get_it.dart';
import 'package:pull_to_refresh/pull_to_refresh.dart';

class RoomScreen extends StatelessWidget {
  const RoomScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => RoomCubit(repo: GetIt.I.get())..getRooms(),
      child: const RoomLayout(),
    );
  }
}

class RoomLayout extends StatefulWidget {
  const RoomLayout({super.key});

  @override
  State<RoomLayout> createState() => _RoomLayoutState();
}

class _RoomLayoutState extends State<RoomLayout> {
  final refreshController = RefreshController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text("Available Rooms"),
        actions: [
          IconButton(
            onPressed: () {
              context
                  .read<RoomCubit>()
                  .createRoom(context.read<DrawerCubit>().state.username);
            },
            icon: const Icon(Icons.add),
          ),
        ],
      ),
      body: BlocConsumer<RoomCubit, RoomState>(
        listener: (context, state) async {
          if (state.status == BlocStatus.success) {
            if (refreshController.isLoading) {
              refreshController.loadComplete();
            }

            if (refreshController.isRefresh) {
              refreshController.refreshCompleted();
            }
          }

          if (state.createStatus == BlocStatus.loading) {
            showLoadingDialog(context);
          }

          if (state.createStatus == BlocStatus.success) {
            Navigator.pop(context);
          }

          if (state.createStatus == BlocStatus.error) {
            Navigator.pop(context);
            showInfoSnackBar(
              context,
              "Something wrong, when creating the Room",
            );
          }

          if (state.joinStatus == BlocStatus.loading) {
            showLoadingDialog(context);
          }

          if (state.joinStatus == BlocStatus.success) {
            Navigator.pop(context);
            await Navigator.pushNamed(
              context,
              AppRoutes.drawingRoom,
              arguments: state.roomId,
            );

            await Future.delayed(const Duration(seconds: 1));
            if (!mounted) return;
            context.read<RoomCubit>().getRooms();
            return;
          }

          if (state.joinStatus == BlocStatus.error) {
            Navigator.pop(context);
            showInfoSnackBar(
              context,
              state.errorMessage ?? "Something wrong, when creating the Room",
            );
          }
        },
        builder: (context, state) {
          if (state.status == BlocStatus.initial ||
              state.status == BlocStatus.loading) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }

          if (state.status == BlocStatus.error) {
            return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: context.read<RoomCubit>().getRooms,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "Something Wrong please try again !",
                  ),
                ],
              ),
            );
          }

          if (state.status == BlocStatus.success && state.rooms.isEmpty) {
            return SmartRefresher(
              controller: refreshController,
              enablePullDown: true,
              enablePullUp: false,
              onRefresh: context.read<RoomCubit>().getRooms,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: const [
                  Text(
                    "There are no Available Room, try to create one.",
                  ),
                ],
              ),
            );
          }

          return SmartRefresher(
            controller: refreshController,
            enablePullDown: true,
            enablePullUp: false,
            onRefresh: context.read<RoomCubit>().getRooms,
            child: ListView.builder(
              padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 24),
              itemCount: state.rooms.length,
              itemBuilder: (context, index) {
                final room = state.rooms[index];
                return InkWell(
                  onTap: () {
                    final username = context.read<DrawerCubit>().state.username;
                    context.read<RoomCubit>().joinRoom(room.id ?? "", username);
                  },
                  child: Container(
                    padding: const EdgeInsets.all(16),
                    margin: const EdgeInsets.only(bottom: 10, top: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: const Color(0xFFEB4A5A)),
                      borderRadius: BorderRadius.circular(16),
                    ),
                    child: Row(
                      children: [
                        Expanded(
                          child: Column(
                            mainAxisSize: MainAxisSize.min,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Text("${room.roomOwner}'s Room"),
                              const SizedBox(height: 8),
                              Text("Players : ${room.players?.length} / 5"),
                              const SizedBox(height: 8),
                              Text("ID : ${room.id}"),
                            ],
                          ),
                        ),
                        const Icon(Icons.chevron_right),
                      ],
                    ),
                  ),
                );
              },
            ),
          );
        },
      ),
    );
  }
}
