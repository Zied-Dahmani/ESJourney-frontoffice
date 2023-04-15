import 'package:esjourney/presentation/screens/curriculum/games/draw/core/httt_client/base_response.dart';
import 'package:esjourney/presentation/screens/curriculum/games/draw/feature/room/model/room_model.dart';

abstract class RoomRepository {
  Future<BaseResponse<List<RoomModel>>> getRooms();

  Future<BaseResponse<RoomModel>> createRoom(String username);

  Future<BaseResponse> joinRoom(String id, String username);
}
