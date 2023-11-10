// import 'package:get/get.dart';

// class Provider extends GetConnect {
  
//   Future<List<dynamic>> getProvider() async {

//     try {
      
//       final response = await get('https://fakestoreapi.com/products');

//       if (response.status.hasError) {
//         return Future.error(response.statusText.toString());
//       }
//       else{
//         return response.body['image'];
//       }
//     } catch (exception) {
//         return Future.error(exception.toString());
//     }
//   }
// }