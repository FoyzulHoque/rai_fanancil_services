// lib/features/home/widget/body_widget.dart
import 'package:flutter/material.dart';

typedef VoidCallBack = VoidCallback;

class BodyWidget extends StatelessWidget {
  final String? productImage;
  final String? productName;
  final String? productPrice;
  final VoidCallback? addToCard;

  const BodyWidget({
    super.key,
    this.productImage,
    this.productName,
    this.productPrice,
    this.addToCard,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 178,
      padding: const EdgeInsets.all(8),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Image
          ClipRRect(
            borderRadius: BorderRadius.circular(16),
            child: SizedBox(
              height: 182,
              width: 178,
              child: productImage != null && productImage!.isNotEmpty
                  ? Image.network(
                productImage!,
                fit: BoxFit.cover,
                loadingBuilder: (c, child, loading) => loading == null
                    ? child
                    : const Center(child: CircularProgressIndicator(strokeWidth: 2)),
                errorBuilder: (c, e, s) => const Center(
                    child: Icon(Icons.broken_image, size: 50, color: Colors.grey)),
              )
                  : const Center(child: Icon(Icons.image_not_supported, size: 50)),
            ),
          ),

          const SizedBox(height: 10),

          // Name
          Text(
            productName ?? "No Name",
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),

          const SizedBox(height: 8),

          // Price + Cart
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Flexible(
                child: Text(
                  productPrice ?? "৳0",
                  style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  overflow: TextOverflow.ellipsis,
                ),
              ),
              GestureDetector(
                onTap: addToCard,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                  decoration: BoxDecoration(
                    color: const Color(0xFFB2F7F5),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      Image.asset("assets/icons/mdi_cart-outline.png",
                          width: 18, height: 18),
                      const SizedBox(width: 6),
                      const Text("Cart",
                          style: TextStyle(fontSize: 13, fontWeight: FontWeight.w600)),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}