import '../../repositories/home/home_repository.dart';

class GetHomeData {
  final HomeRepository repository;

  GetHomeData(this.repository);

  Future<HomeDataBundle> call() => repository.getHomeData();
}
