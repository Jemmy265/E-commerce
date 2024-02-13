import 'package:ecommerce/api/Api_Manager.dart';
import 'package:ecommerce/domain/dataSource/auth_online_dataSource.dart';
import 'package:ecommerce/domain/model/AuthResultDto.dart';
import 'package:injectable/injectable.dart';
@Injectable(as: AuthOnlineDataSource)
class AuthOnlineDataSourceImpl implements AuthOnlineDataSource {
  // extend -> class
  // implement -> interfaces
  ApiManager apiManager;
  AuthOnlineDataSourceImpl(
      this.apiManager); // this is called dependency -> online dataSource depends on Api
  @override
  Future<AuthResultDto> login(String email, String password) async{
    var response = await apiManager.login(email, password);
    return response.toAuthResultDto();
  }

  @override
  Future<AuthResultDto> register(String name, String email, String phone,
      String password, String repassword) async{
    var response = await apiManager.register(name, email, phone, password, repassword);
    return response.toAuthResultDto();
  }
}
