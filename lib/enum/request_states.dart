
enum RequestState {
  initialState,
  getPriceState,
  findDriverState,
  riderDetailsState,
}

Map<RequestState, int> request = {
  RequestState.initialState: 0,
  RequestState.getPriceState: 1,
  RequestState.findDriverState: 2,
  RequestState.riderDetailsState: 3,
};

