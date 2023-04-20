import 'package:chopper/chopper.dart';

part 'api_service.chopper.dart';

@ChopperApi(baseUrl: 'https://mocki.io/v1')
abstract class ApiService extends ChopperService {
  @Get(path: '/9a7cf38a-f84a-435b-afe8-c1e35452a4f0')
  Future<Response> getPosts();

  static ApiService create() {
    final client = ChopperClient(
        baseUrl: Uri.parse('https://mocki.io/v1'),
        services: [_$ApiService()],
        converter: const JsonConverter(),
        interceptors: [HttpLoggingInterceptor()]);
    return _$ApiService(client);
  }
}
