import 'package:flutter/foundation.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;

// socket_io_mixin
mixin SocketIoMixin on GetxController {
  io.Socket? socket;

  // String serverUrl = "http://63.250.36.228:8090";
  String serverUrl = "http://arabchance.com:8090";

  final String _tag = "Socket.IO";

  String get tag => _tag;
  // Initialize the Socket?.IO connection
  void initializeSocket({
    Function()? onConnect,
    Function(io.Socket socket)? onDisconnect,
  }) {
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
      // "driver_id": Get.find<BaseController>().user!.id,
    });

    // Define your event handlers here
    socket?.on('connect', (_) {
      if (kDebugMode) {
        print('Connected to $_tag  On :: $serverUrl ');
      }
      onConnect?.call();
    });

    socket?.on('disconnect', (_) {
      if (kDebugMode) {
        print('Disconnected from $_tag On :: $serverUrl ');

        // socket?.destroy();
      }
      onDisconnect?.call(socket!);
    });
  }

  // Connect to the Socket?.IO server
  void connectSocket() {
    socket?.connect();
  }

  sendMassage(List<dynamic> args) {
    print("  sendMassage $_tag $args ");
    socket?.send([]);
  }

  // Disconnect from the Socket?.IO server
  void disconnectSocket() {
    print(" disconnectSocket $_tag ");
    socket?.disconnect();
  }

  // Send an event to the Socket?.IO server
  void sendSocketEvent<T>(String event, T data) {
    print(" sendSocketEvent $_tag  $event  $data ");
    socket?.emit(event, data);
  }

  // Listen for a specific event and handle data
  void subscribeToEvent(String event, Function(dynamic data) onData) {
    if (socket != null) {
      print(" subscribeToEvent $event $tag   ");
      socket!.on(event, (data) {
        if (kDebugMode) {
          print("  $tag   received on  $event: $data ");
        }
        onData.call(data);
      });
    }
  }

  void unsubscribeFromEvent(String event) {
    if (socket != null) {
      print("$tag Unsubscribing from event $event");
      socket?.off(event);
    }
  }

  bool isSocketConnected() {
    return socket?.connected ?? false;
  }
}
