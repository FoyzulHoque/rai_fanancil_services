import 'package:flutter/material.dart';
import 'package:rai_fanancil_services/core/themes/app_colors.dart';

class SubscriptionPlansScreen extends StatefulWidget {
  const SubscriptionPlansScreen({super.key});

  @override
  State<SubscriptionPlansScreen> createState() => _SubscriptionPlansScreenState();
}

class _SubscriptionPlansScreenState extends State<SubscriptionPlansScreen> {
  bool isAnnual = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: AppColors.secondaryColors,
        foregroundColor: Colors.white,
        elevation: 0,
        toolbarHeight: 100,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back,color: Colors.white,),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Subscription Plans',
          style: TextStyle(
            color: Colors.white,
            fontSize: 20,
            fontWeight: FontWeight.w600,
          ),
        ),
        centerTitle: true,
      ),
      body: Column(
        children: [
          // Toggle: Monthly / Annual
          Container(
            margin: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            decoration: BoxDecoration(
              color: Colors.blue.shade100,
              borderRadius: BorderRadius.circular(0),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                _buildToggleButton(
                  text: "Monthly",
                  isSelected: !isAnnual,
                  onTap: () => setState(() => isAnnual = false),
                ),
                _buildToggleButton(
                  text: "Annual (Save 17%)",
                  isSelected: isAnnual,
                  onTap: () => setState(() => isAnnual = true),
                ),
              ],
            ),
          ),

          Expanded(
            child: SingleChildScrollView(
              padding: const EdgeInsets.symmetric(horizontal: 20),
              child: Column(
                children: [
                  // Professional Plan Card (example - you can add more plans)
                  _buildPlanCard(
                    price: isAnnual ? "299.99" : "29.99",
                    period: isAnnual ? "/year" : "/month",
                    title: "Professional",
                    features: const [
                      "Unlimited properties",
                      "Custom emoji anywhere",
                      "Priority support",
                      "Advanced analytics",
                    ],
                    isRecommended: true,
                    buttonText: "Choose Plan",
                  ),

                  const SizedBox(height: 24),

                  // You can add more plans here (Basic, Premium, etc.)
                  _buildPlanCard(
                    price: isAnnual ? "119.99" : "11.99",
                    period: isAnnual ? "/year" : "/month",
                    title: "Basic",
                    features: const [
                      "Limited properties",
                      "Standard emoji",
                      "Basic support",
                    ],
                    isRecommended: false,
                    buttonText: "Choose Plan",
                  ),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton({
    required String text,
    required bool isSelected,
    required VoidCallback onTap,
  }) {
    return Expanded(
      child: GestureDetector(
        onTap: onTap,
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12, horizontal: 20),
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primaryDife : Colors.transparent,
            borderRadius: BorderRadius.circular(0),
          ),
          child: Text(
            text,
            textAlign: TextAlign.center,
            style: TextStyle(
              color: isSelected ? Colors.white : AppColors.primaryDife,
              fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
              fontSize: 15,
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildPlanCard({
    required String price,
    required String period,
    required String title,
    required List<String> features,
    required bool isRecommended,
    required String buttonText,
  }) {
    return Container(
      margin: const EdgeInsets.only(bottom: 16),
      decoration: BoxDecoration(
        border: Border.all(
          color: isRecommended ? AppColors.primaryDife : Colors.grey.shade300,
          width: isRecommended ? 2 : 1,
        ),
        borderRadius: BorderRadius.circular(0),
        boxShadow: isRecommended
            ? [
          BoxShadow(
            color: Colors.blue.withOpacity(0.15),
            blurRadius: 12,
            offset: const Offset(0, 4),
          )
        ]
            : null,
      ),
      child: Column(
        children: [
          // Price & Title Header
          Container(
            width: double.infinity,
            padding: const EdgeInsets.all(20),
            decoration: BoxDecoration(
              color: isRecommended ? AppColors.primaryDife : Colors.grey.shade100,
              borderRadius: const BorderRadius.vertical(top: Radius.circular(0)),
            ),
            child: Column(
              children: [
                Text(
                  '\$$price',
                  style: TextStyle(
                    fontSize: 32,
                    fontWeight: FontWeight.bold,
                    color: isRecommended ? Colors.white : Colors.black87,
                  ),
                ),
                Text(
                  period,
                  style: TextStyle(
                    fontSize: 16,
                    color: isRecommended ? Colors.white70 : Colors.grey.shade700,
                  ),
                ),
                const SizedBox(height: 8),
                Text(
                  title,
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: isRecommended ? Colors.white : Colors.black87,
                  ),
                ),
              ],
            ),
          ),

          // Features
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 24, 24, 16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...features.map(
                      (feature) => Padding(
                    padding: const EdgeInsets.only(bottom: 12),
                    child: Row(
                      children: [
                        Icon(
                          Icons.check_circle,
                          color: isRecommended ? AppColors.primaryDife : Colors.green,
                          size: 22,
                        ),
                        const SizedBox(width: 12),
                        Expanded(
                          child: Text(
                            feature,
                            style: const TextStyle(
                              fontSize: 16,
                              height: 1.4,
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),

          // Choose Button
          Padding(
            padding: const EdgeInsets.fromLTRB(24, 8, 24, 24),
            child: SizedBox(
              width: double.infinity,
              height: 52,
              child: ElevatedButton(
                onPressed: () {
                  // TODO: Handle plan selection
                },
                style: ElevatedButton.styleFrom(
                  backgroundColor: isRecommended ? AppColors.primaryDife : Colors.grey.shade200,
                  foregroundColor: isRecommended ? Colors.white : Colors.black87,
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(0),
                  ),
                  elevation: isRecommended ? 2 : 0,
                ),
                child: Text(
                  buttonText,
                  style: const TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}