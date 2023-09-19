import 'package:geolocator/geolocator.dart';

abstract class ClintInterface implements TripEvents, MapTowerUsg {
  bool get canaAskForRequsts;

  bool get canCancelTripWithInFree;

  Duration get timeToCancelFree;

  requestTrip();
}

abstract class DriverInterface implements TripEvents, MapTowerUsg {
  completeTrip();
  bool get canListenForRequsts;
  listenToRequsts();
  stopListenToRequsts();

}

enum TripStates {
  init,
  request,
  waitingForResponse,
  // TODO:
  // pendingWithPrice
  accepting,
  waitingForMeet,
  rejecting,
  nearToYou,
  started,
  ended,
  canceled,
  alMostComplete,
  completed,
}

extension Isk on TripStates {
  bool get canListenForRequsts {
    return this != TripStates.accepting ||
        this == TripStates.init ||
        this == TripStates.request ||
        this == TripStates.waitingForResponse ||
        this != TripStates.accepting ||
        this != TripStates.waitingForMeet ||
        this == TripStates.rejecting ||
        this != TripStates.nearToYou ||
        this != TripStates.started ||
        this != TripStates.ended ||
        this == TripStates.canceled ||
        this == TripStates.alMostComplete ||
        this == TripStates.completed;
    //   || this == TripStates.pendingWithPrice
  }

  bool get canaAskForRequsts {
    return this == TripStates.init ||
        this != TripStates.request ||
        this != TripStates.waitingForResponse ||
        this != TripStates.accepting ||
        this != TripStates.waitingForMeet ||
        this == TripStates.rejecting ||
        this != TripStates.nearToYou ||
        this != TripStates.started ||
        this != TripStates.ended ||
        this == TripStates.canceled ||
        this == TripStates.completed ||
        this != TripStates.alMostComplete;
    //        this != TripStates.pendingWithPrice;
  }
}

abstract class TripEvents {
  int get tripId;
  acceptTrip();

  rejectTrip();

  cancelTrip();

  reviewTrip();
  int get distToTrackChangesLocation;

// TODO:
  Position get currantLocation;

  trackTripLiveLocation();



// TODO: not now
  // askForNewSalary();
}

abstract class MapTower<T extends DriverInterface, K extends ClintInterface> {
  // in concsuter
  K get clint;
  registerDrivers(List<T> newDrivers);

  TripStates get tripState;

  updateTripState(TripStates state);
  notifyWithTripState();
}

abstract class MapTowerUsg {
  MapTower get mapTower;

  setMapTower(MapTower newMapTower);
}



// from notification  or socket
abstract class Handler<T> {
  late Handler _nextHandler;

  void setNextHandler(Handler nextHandler) {
    _nextHandler = nextHandler;
  }

  void handleRequest(T req);
}

class SocketMapHandler implements Handler<Object> {
  late Handler _nextHandler;

  void setNextHandler(Handler nextHandler) {
    _nextHandler = nextHandler;
  }

  void handleRequest(Object req) {
    // TODO:  if current state alredy updated avoid function
  }
}

class NotificationMapHandler implements Handler<Object> {
  late Handler _nextHandler;

  void setNextHandler(Handler nextHandler) {
    _nextHandler = nextHandler;
  }

  void handleRequest(Object req) {
    // TODO:  if current state alredy updated avoid function
  }
}
