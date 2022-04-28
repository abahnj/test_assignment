import 'package:casino_test/src/data/repository/characters_repository.dart';
import 'package:casino_test/src/presentation/bloc/main_event.dart';
import 'package:casino_test/src/presentation/bloc/main_state.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class MainPageBloc extends Bloc<MainPageEvent, MainPageState> {
  MainPageBloc(
    MainPageState initialState,
    this._charactersRepository,
  ) : super(initialState) {
    on<GetTestDataOnMainPageEvent>(
      _getDataOnMainPageCasino,
    );
    on<DataLoadedOnMainPageEvent>(
      _dataLoadedOnMainPageCasino,
    );
    on<LoadingDataOnMainPageEvent>(
      (event, emitter) => emitter(LoadingMainPageState()),
    );
    add(const GetTestDataOnMainPageEvent());
  }

  final CharactersRepository _charactersRepository;
  int _page = 1;

  Future<void> _dataLoadedOnMainPageCasino(
    DataLoadedOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    if (state is SuccessfulMainPageState) {
      final characters = {
        ...(state as SuccessfulMainPageState).characters,
        ...event.characters
      };
      emit(SuccessfulMainPageState(characters.toList()));
    } else {
      emit(SuccessfulMainPageState(event.characters));
    }
  }

  Future<void> _getDataOnMainPageCasino(
    GetTestDataOnMainPageEvent event,
    Emitter<MainPageState> emit,
  ) async {
    //emit(LoadingMainPageState());
    try {
      await _charactersRepository.getCharacters(_page).then(
        (value) {
          _page++;

          if (_page < 43) {
            add(DataLoadedOnMainPageEvent(value));
          }
        },
      );
    } catch (_) {
      emit(UnSuccessfulMainPageState());
    }
  }
}
