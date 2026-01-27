import 'package:get/Get.dart';
import 'package:rai_fanancil_services/features/user/financial%20data%20collection/controller/property_details_controller.dart';
import 'package:rai_fanancil_services/features/user/financial%20data%20collection/controller/tax_region_state_dropdown_controller.dart';

import 'borrowing_adults_controller.dart';
import 'finacial_data_collection_text_editing_controller.dart';
import 'income_details_property_drop_down_controller.dart';

class FinancialDataApiController extends GetxController{
  RxString? _errorMes;
  RxString? get errorMessage => _errorMes;
  RxBool _isLoading = false.obs;
  RxBool get isLoading => _isLoading;

  final BorrowingAdultsController borrowingAdultsController = Get.put(BorrowingAdultsController());
  final FinacialDataCollectionTextEditingController finacialDataCollectionTextEditingController = Get.put(FinacialDataCollectionTextEditingController());
  final PrimaryIncomeDropdownController primaryIncomeDropdownController = Get.put(
    PrimaryIncomeDropdownController(),
  );
  final TaxRegionStateDropdownController taxRegionStateDropdownController = Get.put(
    TaxRegionStateDropdownController(),
  );
final IncomeDetailsPropertyDropdownController incomeDetailsPropertyDropdownController = Get.put(
    IncomeDetailsPropertyDropdownController(),
  );
  final PropertyController propertyController = Get.put(PropertyController());
final Property cult= Property();
  Future<bool> financialDataApiMethod()async{
    bool isSuccess=false;
    try{

      _isLoading==true;
      update();
      final ctrls = borrowingAdultsController.adultControllers[index];

      final List<Map<String, dynamic>> mapBody = [
        {
          "adults": [
            {
              "name": "${ctrls.['name']}",
              "dob": "${ctrls.['dob']}",
              "email": "${ctrls.['email']}",
              "phone": "${ctrls.['phone']}",
              "incomes": [
                {
                  "type": "${primaryIncomeDropdownController.selectedProperty}",
                  "source": "Software Engineering",
                  "amount": finacialDataCollectionTextEditingController.propertyController1.text.trim(),
                  "otherIncome":finacialDataCollectionTextEditingController.otherIncomeController.text.trim(),
                  "taxRegion": "${taxRegionStateDropdownController.selectedProperty}",
                  "frequency": "${incomeDetailsPropertyDropdownController.properties}"
                }
              ]
            },
          ],
          "dependents": [
            {
              "name": "Jane Doe Jr.2",
              "dob": "2015-08-20"
            }
          ],
          "expenses": [
            {
              "livingSituation": "${finacialDataCollectionTextEditingController.selectedResidences}",
              "food": finacialDataCollectionTextEditingController.foodController,
              "transport": finacialDataCollectionTextEditingController.transportController,
              "utilities": finacialDataCollectionTextEditingController.utilitiesController,
              "insurance": finacialDataCollectionTextEditingController.insuranceController,
              "entertainment": finacialDataCollectionTextEditingController.entertainmentController,
              "healthcare": 100,
              "education": 0,
              "monthlyRentalPayment": finacialDataCollectionTextEditingController.monthlyMortgagePaymentController,
              "otherExpenses": 50
            }
          ],
          "propertyDetails": [
            {
              "type": "${finacialDataCollectionTextEditingController.selectedPropertyButton}",
              "address": cult.addressController,
              "loanTerm": cult.loanTermController,
              "purchasePrice": cult.purchaseDateController,
              "purchaseDate": cult.purchaseDateController,
              "currentEstimateValue": cult.estimatedValueController,
              "mortgageProvider": cult.mortgageProviderController,
              "currentMortgageAmount": cult.mortgageAmountController,
              "currentMortgageRate": cult.mortgageRateController,
              "currentMortgageInterestRate": cult.interestRateController,
              "mortgageFinishedRate": cult.finishedRateController,
              "mortgageType": "",
              "interestRemainingMonth": "240"
            }
          ],
          "assets": [
            {
              "totalAssets": 50000,
              "bankName": "Commonwealth Bank",
              "accountType": "Savings",
              "interestRate": 2.5,
              "cashSaving": 20000,
              "investment": 15000,
              "superannuation": 150000,
              "otherAssets": 0
            }
          ],
          "liabilities": [
            {
              "hecsDebt": 12000,
              "loans": [
                {
                  "bankName": "ANZ",
                  "currentBalance": 15000,
                  "interestRate": 8.5,
                  "monthlyPayment": 400,
                  "remainingMonths": 48
                }
              ],
              "creditCards": [
                {
                  "bankName": "Nab",
                  "creditLimit": 10000,
                  "currentBalance": 2500,
                  "monthlyPayment": "5%",
                  "remainingMonths": 0
                }
              ],
              "buyNowPayLaters": [
                {
                  "bankName": "hhb",
                  "currentBalance": 46000,
                  "interestRate": 1.5,
                  "monthlyPayment": 4000,
                  "remainingMonths": 5
                }
              ],
              "smsfs": [
                {
                  "bankName": "bgdf",
                  "loanBalance": 50000,
                  "rate": 5,
                  "monthlyAmount": 566,
                  "remainingMonths": 10
                }
              ]
            }
          ]
        }
      ];
      print("---Map Body---$mapBody");


    }catch(e){
      _errorMes=e.toString() as RxString?;
    }

    return isSuccess;
  }
}