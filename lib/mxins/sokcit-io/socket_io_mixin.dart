import 'package:flutter/foundation.dart';
import 'package:socket_io_client/socket_io_client.dart' as io;
// socket_io_mixin
mixin SocketIoMixin {
  io.Socket? socket;

  // Initialize the Socket?.IO connection
  void initializeSocket(
    String serverUrl, {
    Function()? onConnect,
    Function(io.Socket socket)? onDisconnect,
  }) {
    socket = io.io(serverUrl, <String, dynamic>{
      'transports': ['websocket'],
      'autoConnect': false,
    });

    // Define your event handlers here
    socket?.on('connect', (_) {
      if (kDebugMode) {
        print('Connected to Socket.IO  On :: $serverUrl ');
      }
      // onConnect?.call();
    });

    socket?.on('disconnect', (_) {
      if (kDebugMode) {
        print('Disconnected from Socket.IO On :: $serverUrl ');

        // socket?.destroy();
      }
      // onDisconnect?.call(socket!);
    });
  }

  // Connect to the Socket?.IO server
  void connectSocket() {
    socket?.connect();
  }

  // Disconnect from the Socket?.IO server
  void disconnectSocket() {
    socket?.disconnect();
  }

  // Send an event to the Socket?.IO server
  void sendSocketEvent<T>(String event, T data) {
    socket?.emit(event, data);
  }

  // Listen for a specific event and handle data
  void subscribeToEvent(String event, Function(dynamic data) onData) {
    if (socket != null) {
      socket!.on(event, onData);
    }
  }
}
