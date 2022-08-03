import 'package:amazone_clone/constants/global_variables.dart';
import 'package:amazone_clone/features/account/screens/widgets/single_product.dart';
import 'package:flutter/material.dart';

class Orders extends StatefulWidget {
  const Orders({Key? key}) : super(key: key);

  @override
  State<Orders> createState() => _OrdersState();
}

class _OrdersState extends State<Orders> {
  //temporary list
  List list = [

 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',
 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',
 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',
 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',
 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',
 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',
 'https://images.unsplash.com/photo-1657810429711-53cf3be6a0f9?ixlib=rb-1.2.1&ixid=MnwxMjA3fDB8MHxlZGl0b3JpYWwtZmVlZHwzMXx8fGVufDB8fHx8&auto=format&fit=crop&w=600&q=60',


  ];


  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Container(
              padding:EdgeInsets.only(
                left: 15,
              ),
              child: const Text(
                'Your Orders', style: TextStyle(
                fontSize: 18,
                color: Colors.black,
                fontWeight: FontWeight.w600,
              ),
              ),
            ),

            Container(
              padding:EdgeInsets.only(
                right: 15,
              ),
              child:  Text(
                'See all', style: TextStyle(
                color: GlobalVariables.selectedNavBarColor,
              ),
              ),
            ),
          ],
        ),
        //displaying orders
        Container(
          height:180,
          padding: const EdgeInsets.only(
            left: 10, right: 0, top: 20,
          ),
          child:
          ListView.builder(
            scrollDirection: Axis.horizontal,
              itemCount: list.length,
              itemBuilder: (context, index){
           return SingleProduct(image: list[index]);
          }),
        ),
      ],
    );
  }
}
