
enum RequestState {
  initialState,
  getPriceState,
  findDriverState,
  driverAcceptState,
  tripOngoing,
  tripFinishedState,
}

Map<RequestState, int> request = {
  RequestState.initialState: 0,
  RequestState.getPriceState: 1,
  RequestState.findDriverState: 2,
  RequestState.driverAcceptState: 3,
  RequestState.tripOngoing: 4,
  RequestState.tripFinishedState: 5,
};
