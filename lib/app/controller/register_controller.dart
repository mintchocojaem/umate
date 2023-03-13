import 'package:danvery/app/data/model/register_model.dart';
import 'package:danvery/app/data/repository/register_repository.dart';
import 'package:get/get.dart';

class RegisterController extends GetxController{

  final RegisterRepository registerRepository;

  RegisterController({required this.registerRepository});

  final Rx<RegisterModel> _registerModel = RegisterModel().obs;
  final RxBool _isAuthenticated = false.obs;

  RegisterModel get registerModel => _registerModel.value;

  bool get isAuthenticated => _isAuthenticated.value;

  Future<bool> authenticate(String id, String password) async{
    await registerRepository.authenticate(id: id, password: password).then((value) {

      if(value == null){
        _isAuthenticated.value = false;
      }else{
        _registerModel.value = value;
        _isAuthenticated.value = true;
      }

    });
    return _isAuthenticated.value;
  }
}
