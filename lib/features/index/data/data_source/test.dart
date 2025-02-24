import 'package:injectable/injectable.dart';

@Injectable()
class ApiService {
  final Environment env;
  ApiService(this.env); // Injected automatically

  void fetchData() {
    print('Using ${env.name}');
  }
}
