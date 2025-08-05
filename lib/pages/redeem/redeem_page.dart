import 'package:flutter/material.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:edumate/widgets/common/custom_button.dart';
import 'package:edumate/widgets/common/theme_aware_card.dart';
import 'package:edumate/widgets/common/loading_widget.dart';
import 'package:edumate/utils/responsive_utils.dart';
import 'package:edumate/config/app_constants.dart';

/// Professional redeem page with form validation and responsive design
class RedeemPage extends StatefulWidget {
  const RedeemPage({super.key});

  @override
  State<RedeemPage> createState() => _RedeemPageState();
}

class _RedeemPageState extends State<RedeemPage> {
  final _formKey = GlobalKey<FormState>();
  final _emailController = TextEditingController();
  final _addressLine1Controller = TextEditingController();
  final _addressLine2Controller = TextEditingController();
  final _phoneController = TextEditingController();
  
  String _selectedSize = 'Small';
  bool _isLoading = false;
  
  static const List<String> _availableSizes = ['Small', 'Medium', 'Large', 'X-Large'];
  static const int _itemCost = 1500;
  static const String _itemName = 'Programming T-Shirt';

  @override
  void dispose() {
    _emailController.dispose();
    _addressLine1Controller.dispose();
    _addressLine2Controller.dispose();
    _phoneController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: const BoxDecoration(
        gradient: LinearGradient(
          begin: Alignment.topCenter,
          end: Alignment.bottomCenter,
          colors: [
            Color(0xFF1F0E14),
            Color(0xBF37194C),
            Color(0xB34E2178),
            Color(0xD934134F),
            Color(0xFF1F0E24),
          ],
        ),
      ),
      child: SafeArea(
        child: Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNav(context: context),
          backgroundColor: Colors.transparent,
          appBar: _buildAppBar(),
          body: LoadingOverlay(
            isLoading: _isLoading,
            message: 'Processing your redemption...',
            child: _buildBody(),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      leading: IconButton(
        onPressed: () => Navigator.pop(context),
        icon: const Icon(Icons.arrow_back_ios, color: Colors.white),
        tooltip: 'Go back',
      ),
      backgroundColor: Colors.transparent,
      elevation: 0,
      centerTitle: true,
      title: const Text(
        'Redeem Item',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
    );
  }

  Widget _buildBody() {
    return SingleChildScrollView(
      padding: context.responsivePadding,
      child: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            _buildItemCard(),
            SizedBox(height: AppConstants.spaceLG),
            _buildRedemptionForm(),
            SizedBox(height: AppConstants.spaceXL),
            _buildRedeemButton(),
            SizedBox(height: AppConstants.spaceLG),
          ],
        ),
      ),
    );
  }

  Widget _buildItemCard() {
    return ThemeAwareCard(
      backgroundColor: const Color(0xFF5D5392),
      padding: AppConstants.paddingLG,
      child: Column(
        children: [
          ClipRRect(
            borderRadius: AppConstants.borderRadiusMD,
            child: Image.asset(
              'assets/images/tshirt.png',
              height: context.isMobile ? 100 : 120,
              width: context.isMobile ? 100 : 120,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: context.isMobile ? 100 : 120,
                  width: context.isMobile ? 100 : 120,
                  decoration: BoxDecoration(
                    color: Colors.grey[300],
                    borderRadius: AppConstants.borderRadiusMD,
                  ),
                  child: const Icon(
                    Icons.shopping_bag_outlined,
                    size: 40,
                    color: Colors.grey,
                  ),
                );
              },
            ),
          ),
          SizedBox(height: AppConstants.spaceMD),
          Text(
            _itemName,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.responsiveFontSize(AppConstants.fontLG),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.spaceSM),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                _itemCost.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.responsiveFontSize(AppConstants.fontXL),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: AppConstants.spaceXS),
              Image.asset(
                'assets/images/coin.png',
                height: 24,
                width: 24,
                errorBuilder: (context, error, stackTrace) {
                  return const Icon(
                    Icons.monetization_on,
                    color: Colors.amber,
                    size: 24,
                  );
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildRedemptionForm() {
    return ThemeAwareCard(
      backgroundColor: Colors.black.withValues(alpha: 0.2),
      padding: AppConstants.paddingLG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Delivery Information',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.responsiveFontSize(AppConstants.fontLG),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.spaceLG),
          _buildTextField(
            controller: _emailController,
            label: 'Email',
            hint: 'Enter your email address',
            prefixIcon: Icons.email_outlined,
            validator: _validateEmail,
            keyboardType: TextInputType.emailAddress,
          ),
          SizedBox(height: AppConstants.spaceMD),
          _buildTextField(
            controller: _addressLine1Controller,
            label: 'Address Line 1',
            hint: 'Enter your street address',
            prefixIcon: Icons.location_on_outlined,
            validator: _validateAddress,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(height: AppConstants.spaceMD),
          _buildTextField(
            controller: _addressLine2Controller,
            label: 'Address Line 2 (Optional)',
            hint: 'Apartment, suite, etc.',
            prefixIcon: Icons.location_on_outlined,
            textCapitalization: TextCapitalization.words,
          ),
          SizedBox(height: AppConstants.spaceMD),
          _buildTextField(
            controller: _phoneController,
            label: 'Phone Number',
            hint: 'Enter your phone number',
            prefixIcon: Icons.phone_outlined,
            validator: _validatePhone,
            keyboardType: TextInputType.phone,
          ),
          SizedBox(height: AppConstants.spaceLG),
          _buildSizeSelector(),
        ],
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String label,
    required String hint,
    required IconData prefixIcon,
    String? Function(String?)? validator,
    TextInputType? keyboardType,
    TextCapitalization textCapitalization = TextCapitalization.none,
  }) {
    return TextFormField(
      controller: controller,
      validator: validator,
      keyboardType: keyboardType,
      textCapitalization: textCapitalization,
      style: const TextStyle(color: Colors.white),
      decoration: InputDecoration(
        prefixIcon: Icon(prefixIcon, color: Colors.white70),
        labelText: label,
        hintText: hint,
        labelStyle: TextStyle(
          color: Colors.white70,
          fontSize: context.responsiveFontSize(AppConstants.fontSM),
        ),
        hintStyle: TextStyle(
          color: Colors.white54,
          fontSize: context.responsiveFontSize(AppConstants.fontSM),
        ),
        filled: true,
        fillColor: Colors.white.withValues(alpha: 0.1),
        border: OutlineInputBorder(
          borderRadius: AppConstants.borderRadiusSM,
          borderSide: BorderSide.none,
        ),
        enabledBorder: OutlineInputBorder(
          borderRadius: AppConstants.borderRadiusSM,
          borderSide: BorderSide(color: Colors.white.withValues(alpha: 0.3)),
        ),
        focusedBorder: OutlineInputBorder(
          borderRadius: AppConstants.borderRadiusSM,
          borderSide: const BorderSide(color: Colors.blue, width: 2),
        ),
        errorBorder: OutlineInputBorder(
          borderRadius: AppConstants.borderRadiusSM,
          borderSide: const BorderSide(color: Colors.red, width: 2),
        ),
      ),
    );
  }

  Widget _buildSizeSelector() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Select Size',
          style: TextStyle(
            color: Colors.white,
            fontSize: context.responsiveFontSize(AppConstants.fontMD),
            fontWeight: FontWeight.w500,
          ),
        ),
        SizedBox(height: AppConstants.spaceSM),
        Container(
          width: double.infinity,
          padding: AppConstants.paddingMD,
          decoration: BoxDecoration(
            color: Colors.white.withValues(alpha: 0.1),
            borderRadius: AppConstants.borderRadiusSM,
            border: Border.all(color: Colors.white.withValues(alpha: 0.3)),
          ),
          child: DropdownButtonHideUnderline(
            child: DropdownButton<String>(
              value: _selectedSize,
              icon: const Icon(Icons.arrow_drop_down, color: Colors.white),
              style: TextStyle(
                color: Colors.white,
                fontSize: context.responsiveFontSize(AppConstants.fontMD),
              ),
              dropdownColor: const Color(0xFF5D5392),
              onChanged: (String? newValue) {
                if (newValue != null) {
                  setState(() {
                    _selectedSize = newValue;
                  });
                }
              },
              items: _availableSizes.map<DropdownMenuItem<String>>((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildRedeemButton() {
    return SizedBox(
      width: double.infinity,
      child: CustomButton(
        text: 'Redeem Now',
        onPressed: _handleRedemption,
        backgroundColor: const Color(0xFF5D5392),
        textColor: Colors.white,
        padding: EdgeInsets.symmetric(
          vertical: context.isMobile ? 16 : 20,
          horizontal: AppConstants.spaceLG,
        ),
        borderRadius: AppConstants.radiusMD,
        isLoading: _isLoading,
      ),
    );
  }

  String? _validateEmail(String? value) {
    if (value == null || value.isEmpty) {
      return 'Email is required';
    }
    if (!RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(value)) {
      return 'Please enter a valid email address';
    }
    return null;
  }

  String? _validateAddress(String? value) {
    if (value == null || value.isEmpty) {
      return 'Address is required';
    }
    if (value.length < 5) {
      return 'Please enter a complete address';
    }
    return null;
  }

  String? _validatePhone(String? value) {
    if (value == null || value.isEmpty) {
      return 'Phone number is required';
    }
    if (!RegExp(r'^\+?[\d\s\-\(\)]{10,}$').hasMatch(value)) {
      return 'Please enter a valid phone number';
    }
    return null;
  }

  Future<void> _handleRedemption() async {
    if (!_formKey.currentState!.validate()) {
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      if (mounted) {
        // Show success dialog
        await _showSuccessDialog();
        
        // Navigate back or to success page
        Navigator.pop(context);
      }
    } catch (e) {
      if (mounted) {
        _showErrorSnackBar('Failed to process redemption. Please try again.');
      }
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  Future<void> _showSuccessDialog() async {
    return showDialog<void>(
      context: context,
      barrierDismissible: false,
      builder: (BuildContext context) {
        return AlertDialog(
          backgroundColor: const Color(0xFF5D5392),
          shape: RoundedRectangleBorder(
            borderRadius: AppConstants.borderRadiusMD,
          ),
          title: const Row(
            children: [
              Icon(Icons.check_circle, color: Colors.green, size: 28),
              SizedBox(width: 8),
              Text('Success!', style: TextStyle(color: Colors.white)),
            ],
          ),
          content: Text(
            'Your redemption request has been submitted successfully. '
            'You will receive a confirmation email shortly.',
            style: TextStyle(
              color: Colors.white70,
              fontSize: context.responsiveFontSize(AppConstants.fontSM),
            ),
          ),
          actions: <Widget>[
            TextButton(
              child: const Text('OK', style: TextStyle(color: Colors.blue)),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _showErrorSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(message),
        backgroundColor: Colors.red,
        behavior: SnackBarBehavior.floating,
        shape: RoundedRectangleBorder(
          borderRadius: AppConstants.borderRadiusSM,
        ),
      ),
    );
  }
}