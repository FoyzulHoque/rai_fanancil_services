import 'package:flutter/material.dart';

class SearchWidget extends StatelessWidget {
  final TextEditingController? searchingController;
  final VoidCallback? onTap;
  final VoidCallback? cancelCallBack;
  final Function(String)? onChanged;
  final double? height;
  final double? width;
  final String? worldMap;


  const SearchWidget({
    super.key,
    this.searchingController,
    this.onTap,
    this.onChanged,
    this.height,
    this.width,
    this.cancelCallBack,
    this.worldMap,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 704,
      width: 375,
      margin: const EdgeInsets.symmetric(horizontal: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFF5F5F5),
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(16),
          topLeft: Radius.circular(16),
        ),
        border: Border.all(color: const Color(0xFFE0E0E0), width: 1),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text("Filter"),
              Spacer(),
              TextButton(onPressed: cancelCallBack, child: Text("Cancel")),
            ],
          ),
          const SizedBox(height: 5),

          Container(
            height: 346,
            width: 327,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(16),
              border: Border.all(color: Colors.grey, width: 1),
            ),
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Where to?" ,style: TextStyle(fontSize: 18,fontWeight: FontWeight.w600,color: Colors.black),),
                  const SizedBox(height: 5),
                  TextFormField(
                    controller: searchingController,
                    onChanged: onChanged,
                    onTap: onTap,
                    keyboardType: TextInputType.text,
                    textInputAction: TextInputAction.search,
                    style: const TextStyle(fontSize: 16),
                    decoration: const InputDecoration(
                      hintText: "Search location, suburb...",
                      hintStyle: TextStyle(color: Colors.grey, fontSize: 16),
                      prefixIcon: Icon(
                        Icons.search,
                        color: Colors.grey,
                        size: 28,
                      ),
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(
                        vertical: 16,
                        horizontal: 0,
                      ),
                    ),
                  ),
                  const SizedBox(height: 5,),
                  ListView.builder(
                    shrinkWrap: true,
                    physics: NeverScrollableScrollPhysics(),
                    itemCount: 10,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index){
                    return  Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Container(
                          height: 124,
                          width: 124,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(16),
                            border: Border.all(color: Colors.grey, width: 1),
                          ),
                          child: ClipRRect(
                            borderRadius: BorderRadius.circular(16),
                              child: Image.network("$worldMap"),
                          ),
                        ),
                        const SizedBox(height: 5,),
                        Text("Lebanon",style: TextStyle(fontSize: 16,fontWeight: FontWeight.w600,color: Colors.black),),

                      ],
                    );
                  })
                ],
              ),
            ),
          ),
          const SizedBox(height: 10),
          Card(
            child:ListTile(
              
            )
          )
        ],
      ),
    );
  }
}
