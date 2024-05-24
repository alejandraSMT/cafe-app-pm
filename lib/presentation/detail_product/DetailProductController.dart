import 'package:cafe_app/models/Product.dart';
import 'package:cafe_app/presentation/home/HomePageController.dart';
import 'package:get/get.dart';
import 'package:get/get_rx/get_rx.dart';
import 'package:get/get_rx/src/rx_types/rx_types.dart';


class DetailProductController extends GetxController{
  final HomePageController controller = Get.put(HomePageController());

  Rx<Product> productSelected = Product(productId: "", name: "", price: "").obs;
  RxDouble totalPrice = 0.0.obs;
  RxInt totalUnits = 1.obs;
  RxInt sizeSelected = 0.obs;

  void getProductDetail(String productId){
    productSelected.value = controller.popular.where((element) => element.productId == productId).first;
    totalPrice.value = double.parse(productSelected.value.price!);
    totalUnits.value = 1;
    sizeSelected.value = 0;
  }

  void addTotalAmount(){
    totalUnits.value += 1;
    calculateTotal();
  }

  void reduceTotalAmount(){
    if(totalUnits.value > 1){
      totalUnits.value -= 1;
      calculateTotal();
    }
  }

  void calculateTotal(){
    if(totalUnits.value > 0){
      totalPrice.value = double.parse(productSelected.value.price!)*totalUnits.value;
    }
  }

  void setSize(int size){
    sizeSelected.value = size;
  }
  
}