import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edumate/pages/redeem/redeem_page.dart';
import 'package:edumate/state/redeem/redeem_provider.dart';
import 'package:edumate/widgets/bottom_nav.dart';
import 'package:edumate/widgets/common/custom_button.dart';
import 'package:edumate/widgets/common/theme_aware_card.dart';
import 'package:edumate/widgets/common/loading_widget.dart';
import 'package:edumate/utils/responsive_utils.dart';
import 'package:edumate/config/app_constants.dart';

/// Enhanced redemption catalog with item selection
class RedemptionCatalogPage extends ConsumerStatefulWidget {
  const RedemptionCatalogPage({super.key});

  @override
  ConsumerState<RedemptionCatalogPage> createState() => _RedemptionCatalogPageState();
}

class _RedemptionCatalogPageState extends ConsumerState<RedemptionCatalogPage> {
  @override
  Widget build(BuildContext context) {
    final itemsAsync = ref.watch(redemptionItemsProvider);
    final userCoins = ref.watch(userCoinsProvider);

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
          body: itemsAsync.when(
            data: (items) => _buildItemGrid(items, userCoins),
            loading: () => const LoadingWidget(message: 'Loading items...'),
            error: (error, stack) => _buildErrorView(error.toString()),
          ),
        ),
      ),
    );
  }

  PreferredSizeWidget _buildAppBar() {
    final userCoins = ref.watch(userCoinsProvider);
    
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
        'Redeem Store',
        style: TextStyle(
          color: Colors.white,
          fontWeight: FontWeight.w600,
        ),
      ),
      actions: [
        Container(
          margin: const EdgeInsets.only(right: 16),
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: Colors.amber.withValues(alpha: 0.2),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(color: Colors.amber.withValues(alpha: 0.3)),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.monetization_on, color: Colors.amber, size: 20),
              const SizedBox(width: 4),
              Text(
                userCoins.toString(),
                style: const TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildItemGrid(List<dynamic> items, int userCoins) {
    return SingleChildScrollView(
      padding: context.responsivePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            'Available Items',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.responsiveFontSize(24),
              fontWeight: FontWeight.bold,
            ),
          ),
          SizedBox(height: AppConstants.spaceLG),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: context.isMobile ? 1 : 2,
              childAspectRatio: context.isMobile ? 1.2 : 1.0,
              crossAxisSpacing: AppConstants.spaceMD,
              mainAxisSpacing: AppConstants.spaceMD,
            ),
            itemCount: items.length,
            itemBuilder: (context, index) {
              final item = items[index];
              final canRedeem = ref.watch(canRedeemProvider(item.cost));
              return _buildItemCard(item, canRedeem);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildItemCard(dynamic item, bool canRedeem) {
    return ThemeAwareCard(
      backgroundColor: const Color(0xFF5D5392),
      padding: AppConstants.paddingLG,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Expanded(
            flex: 2,
            child: ClipRRect(
              borderRadius: AppConstants.borderRadiusMD,
              child: Image.asset(
                item.imageUrl,
                fit: BoxFit.cover,
                width: double.infinity,
                errorBuilder: (context, error, stackTrace) {
                  return Container(
                    width: double.infinity,
                    decoration: BoxDecoration(
                      color: Colors.grey[300],
                      borderRadius: AppConstants.borderRadiusMD,
                    ),
                    child: const Icon(
                      Icons.shopping_bag_outlined,
                      size: 48,
                      color: Colors.grey,
                    ),
                  );
                },
              ),
            ),
          ),
          SizedBox(height: AppConstants.spaceMD),
          Text(
            item.name,
            style: TextStyle(
              color: Colors.white,
              fontSize: context.responsiveFontSize(18),
              fontWeight: FontWeight.w600,
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppConstants.spaceSM),
          Text(
            item.description,
            style: TextStyle(
              color: Colors.white70,
              fontSize: context.responsiveFontSize(14),
            ),
            textAlign: TextAlign.center,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          SizedBox(height: AppConstants.spaceMD),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                item.cost.toString(),
                style: TextStyle(
                  color: Colors.white,
                  fontSize: context.responsiveFontSize(20),
                  fontWeight: FontWeight.bold,
                ),
              ),
              SizedBox(width: AppConstants.spaceXS),
              const Icon(
                Icons.monetization_on,
                color: Colors.amber,
                size: 24,
              ),
            ],
          ),
          SizedBox(height: AppConstants.spaceMD),
          SizedBox(
            width: double.infinity,
            child: CustomButton(
              text: canRedeem ? 'Redeem' : 'Insufficient Coins',
              onPressed: canRedeem ? () => _navigateToRedemption(item) : null,
              backgroundColor: canRedeem ? Colors.green : Colors.grey,
              textColor: Colors.white,
              padding: EdgeInsets.symmetric(
                vertical: AppConstants.spaceSM,
                horizontal: AppConstants.spaceMD,
              ),
              borderRadius: AppConstants.radiusSM,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildErrorView(String error) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const Icon(
            Icons.error_outline,
            color: Colors.red,
            size: 64,
          ),
          SizedBox(height: AppConstants.spaceMD),
          Text(
            'Failed to load items',
            style: TextStyle(
              color: Colors.white,
              fontSize: context.responsiveFontSize(18),
              fontWeight: FontWeight.w600,
            ),
          ),
          SizedBox(height: AppConstants.spaceSM),
          Text(
            error,
            style: TextStyle(
              color: Colors.white70,
              fontSize: context.responsiveFontSize(14),
            ),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: AppConstants.spaceLG),
          CustomButton(
            text: 'Retry',
            onPressed: () => ref.refresh(redemptionItemsProvider),
            backgroundColor: Colors.blue,
            textColor: Colors.white,
          ),
        ],
      ),
    );
  }

  void _navigateToRedemption(dynamic item) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => const RedeemPage(),
      ),
    );
  }
}

/// Legacy Tshirt class for backward compatibility
@Deprecated('Use RedemptionCatalogPage instead')
class Tshirt extends StatefulWidget {
  const Tshirt({super.key});

  @override
  State<Tshirt> createState() => _TshirtState();
}

class _TshirtState extends State<Tshirt> {
  @override
  Widget build(BuildContext context) {
    return const RedemptionCatalogPage();
  }
}
