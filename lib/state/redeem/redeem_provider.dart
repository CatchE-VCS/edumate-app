import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:edumate/state/redeem/redeem_state.dart';
import 'package:edumate/services/network_service.dart';

/// Redemption service for handling API calls
class RedemptionService {
  final NetworkService _networkService;

  RedemptionService(this._networkService);

  /// Submit redemption request
  Future<bool> submitRedemption(RedemptionRequest request) async {
    try {
      // Simulate API call
      await Future.delayed(const Duration(seconds: 2));
      
      // In a real app, you would make an HTTP request here
      final result = await _networkService.get<Map<String, dynamic>>(
        url: 'https://api.example.com/redeem',
        parser: (data) => data as Map<String, dynamic>,
      );
      
      return result.isSuccess;
    } catch (e) {
      throw Exception('Failed to submit redemption: $e');
    }
  }

  /// Get available redemption items
  Future<List<RedemptionItem>> getRedemptionItems() async {
    try {
      // Mock data - in a real app, this would be fetched from API
      await Future.delayed(const Duration(milliseconds: 500));
      
      return [
        const RedemptionItem(
          id: 'tshirt-001',
          name: 'Programming T-Shirt',
          description: 'Comfortable cotton t-shirt with programming themes',
          cost: 1500,
          imageUrl: 'assets/images/tshirt.png',
          availableSizes: ['Small', 'Medium', 'Large', 'X-Large'],
        ),
        const RedemptionItem(
          id: 'mug-001',
          name: 'Code & Coffee Mug',
          description: 'Perfect mug for your coding sessions',
          cost: 800,
          imageUrl: 'assets/images/mug.png',
          availableSizes: ['One Size'],
        ),
        const RedemptionItem(
          id: 'sticker-001',
          name: 'Developer Sticker Pack',
          description: 'Set of 10 developer-themed stickers',
          cost: 300,
          imageUrl: 'assets/images/stickers.png',
          availableSizes: ['One Size'],
        ),
      ];
    } catch (e) {
      throw Exception('Failed to fetch redemption items: $e');
    }
  }
}

/// Provider for redemption service
final redemptionServiceProvider = Provider<RedemptionService>((ref) {
  return RedemptionService(NetworkService());
});

/// State notifier for redemption management
class RedemptionNotifier extends StateNotifier<RedemptionState> {
  final RedemptionService _redemptionService;

  RedemptionNotifier(this._redemptionService) 
      : super(const RedemptionState());

  /// Submit a redemption request
  Future<void> submitRedemption(RedemptionRequest request) async {
    state = state.copyWith(isLoading: true, error: null);

    try {
      final success = await _redemptionService.submitRedemption(request);
      
      if (success) {
        state = state.copyWith(
          isLoading: false,
          isSubmitted: true,
          currentRequest: request,
        );
      } else {
        state = state.copyWith(
          isLoading: false,
          error: 'Failed to submit redemption request',
        );
      }
    } catch (e) {
      state = state.copyWith(
        isLoading: false,
        error: e.toString(),
      );
    }
  }

  /// Reset the redemption state
  void resetState() {
    state = const RedemptionState();
  }

  /// Set error state
  void setError(String error) {
    state = state.copyWith(error: error, isLoading: false);
  }

  /// Clear error
  void clearError() {
    state = state.copyWith(error: null);
  }
}

/// Provider for redemption state
final redemptionProvider = StateNotifierProvider<RedemptionNotifier, RedemptionState>((ref) {
  final service = ref.watch(redemptionServiceProvider);
  return RedemptionNotifier(service);
});

/// Provider for available redemption items
final redemptionItemsProvider = FutureProvider<List<RedemptionItem>>((ref) async {
  final service = ref.watch(redemptionServiceProvider);
  return service.getRedemptionItems();
});

/// Provider for user's coin balance (mock)
final userCoinsProvider = StateProvider<int>((ref) => 2500);

/// Provider to check if user has enough coins for an item
final canRedeemProvider = Provider.family<bool, int>((ref, itemCost) {
  final userCoins = ref.watch(userCoinsProvider);
  return userCoins >= itemCost;
});