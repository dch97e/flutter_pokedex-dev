import 'package:flutter_pokedex/model/exception/http_exception.dart';
import 'package:flutter_pokedex/presentation/common/errorhandling/app_action.dart';
import 'package:flutter_pokedex/presentation/common/errorhandling/app_error.dart';
import 'package:flutter_pokedex/presentation/common/errorhandling/base/error_bundle.dart';
import 'package:flutter_pokedex/presentation/common/errorhandling/base/error_bundle_builder.dart';

class PokemonErrorBuilder extends ErrorBundleBuilder {
  PokemonErrorBuilder.create(super.exception, super.appAction) : super.create();

  @override
  ErrorBundle handle(HTTPException exception, AppAction appAction) {
    AppError appError = AppError.UNKNOWN;

    switch (exception.statusCode) {
      case 500:
        appError = AppError.SERVER;
        break;
    }

    return ErrorBundle(exception, appAction, appError);
  }
}
