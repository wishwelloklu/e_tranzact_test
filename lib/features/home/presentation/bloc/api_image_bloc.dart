import 'package:etranzazct_test/app/config/base_url_config.dart';
import 'package:etranzazct_test/app/networks/http_service.dart';
import 'package:etranzazct_test/features/home/data/cat_model.dart';
import 'package:etranzazct_test/features/home/presentation/bloc/api_image_events.dart';
import 'package:etranzazct_test/features/home/presentation/bloc/api_image_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class ApiImageBloc extends Bloc<ApiImageEvents, ApiImageStates> {
  ApiImageBloc() : super(LoadingState()) {
    on<LoadImageEvent>((event, emit) async => _onLoadImage(event, emit));
  }

  _onLoadImage(LoadImageEvent even, Emitter<ApiImageStates> emit) async {
    final response =
        await HttpService.instance.getRequest(UrlConfig.search, {'limit': '1'});
    response.fold(
      (left) => emit(ErrorState(left.message)),
      (right) {
        emit(SuccessState(CatModel.fromMap(right[0])));
      },
    );
  }
}
