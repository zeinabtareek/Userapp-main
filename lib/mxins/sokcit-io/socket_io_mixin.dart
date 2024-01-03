// ignore_for_file: unnecessary_this

import 'dart:developer';


import 'package:socket_io_client/socket_io_client.dart' as io;

mixin SocketIoMixin {
  io.Socket? socket;

  String serverUrl = "https://www.hoood.app:8090";

  bool get isSocketRdy => this.socket != null && socketIsConnected();

  final String _tag = "Socket.IO-TAG";

  String get tag => _tag;

  void logSocket(String msg) {
    log(
      msg,
      name: tag,
      time:DateTime.now(), 
  
    );
  }

  void initializeSocket({
    Function()? onConnect,
    Function(io.Socket socket)? onDisconnect,
  }) {
    this.socket = io.io(
      serverUrl,
      <String, dynamic>{
        'transports': ['websocket'],
        'autoConnect': false,
      },
    );

    // Define your event handlers here
    socket?.on('connect', (_) {
      logSocket('Connected  On :: $serverUrl ');

      onConnect?.call();
    });

    socket?.on('disconnect', (_) {
      logSocket('Disconnected from $serverUrl ');

      socket?.dispose();
      onDisconnect?.call(socket!);
    });
  }

  void clearListeners() {
    if (socket != null) {
      if (socketIsConnected()) {
        logSocket('clearListeners from  $serverUrl ');
      }
      this.socket?.clearListeners();
    }
  }

  // Connect to the Socket?.IO server
  void connectSocket() {
    try {
      if (this.socket != null) {
        if (!socketIsConnected()) {
          this.socket?.connect();
        } else {
          logSocket('Already connected Socket from  $serverUrl ');
        }
      }
    } catch (e) {
      logSocket('un able connect to Socket from $serverUrl ');
    }
  }

  sendMassage(List<dynamic> args) {
    if (isSocketRdy) {
      logSocket("$_tag  sendMassage  $args ");
      this.socket?.send(args);
    }
  }
  // 01118719987

  // Disconnect from the Socket?.IO server
  void disconnectSocket() {
    if (isSocketRdy) {
      logSocket("$_tag socket?.disconnect ()  On :: $serverUrl ");

      this.socket!.disconnect();
      logSocket(" emit-disconnect $_tag  On :: $serverUrl ");

      this.socket?.emit(
            "disconnect",
          );
      logSocket("$_tag disconnectSocket On :: $serverUrl ");

      this.socket?.destroy();
      logSocket("$_tag socket?.destroy ()  On :: $serverUrl ");

      this.socket?.dispose();
      logSocket("$_tag socket?.dispose ()  On :: $serverUrl ");

      this.socket?.close();
      logSocket("$_tag socket?.close ()  On :: $serverUrl  ");
    }
  }

  // Send an event to the Socket?.IO server
  void sendSocketEvent<T>(String event, T data) {
    if (isSocketRdy) {
      logSocket("$tag sendSocketEvent   $event  $data ");

      this.socket?.emit(event, data);
    }
  }

  // Listen for a specific event and handle data
  void subscribeToEvent(String event, Function(dynamic data) onData) {
    if (socket != null) {
      logSocket(" $tag  subscribeToEvent $event  ");

      this.socket!.on(event, (data) {
        logSocket(" $tag received data on event $event $data  ");
        onData.call(data);
      });
    }
  }

  bool socketIsConnected() {
    return this.socket?.connected ?? false;
  }

  void unsubscribeFromEvent(String event) {
    if (socket != null) {
      logSocket("$tag Unsubscribing from event $event");

      socket?.off(event);
    }
  }
}
