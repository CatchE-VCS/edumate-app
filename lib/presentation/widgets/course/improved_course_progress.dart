import 'package:flutter/material.dart';
import 'package:edumate/pages/your_classes/course_module.dart';
import 'package:edumate/pages/your_classes/module.dart';
import 'package:edumate/widgets/common/optimized_image.dart';
import 'package:edumate/widgets/common/theme_aware_card.dart';
import 'package:edumate/utils/asset_manager.dart';
import 'package:edumate/utils/responsive_utils.dart';

/// Improved course progress widget with optimizations and better UX
class ImprovedCourseProgress extends StatelessWidget {
  static final moduleList = Module.generateModule();

  const ImprovedCourseProgress({super.key});

  @override
  Widget build(BuildContext context) {
    return ThemeAwareCard(
      padding: context.responsivePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildHeader(context),
          SizedBox(height: context.isMobile ? 12 : 16),
          _buildModuleList(context),
        ],
      ),
    );
  }

  Widget _buildHeader(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        ThemeAwareText(
          text: 'The Progress',
          isHeading: true,
          style: const TextStyle(
            fontWeight: FontWeight.bold,
            color: Colors.white,
          ),
        ),
        _buildHeaderActions(context),
      ],
    );
  }

  Widget _buildHeaderActions(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        const SizedBox(width: 5),
        OptimizedImage(
          imageUrl: AssetManager.gridIconUrl,
          width: context.isMobile ? 18 : 20,
          height: context.isMobile ? 18 : 20,
          semanticLabel: 'Grid view icon',
          errorWidget: Icon(
            Icons.grid_view,
            size: context.isMobile ? 18 : 20,
            color: Colors.white70,
          ),
        ),
        const SizedBox(width: 3),
        SizedBox(
          width: context.isMobile ? 160 : 185,
          height: 25,
          child: Image.asset(
            AssetManager.listImage,
            color: Colors.white,
            semanticLabel: 'List view',
            errorBuilder: (context, error, stackTrace) {
              return Container(
                decoration: BoxDecoration(
                  color: Colors.white.withValues(alpha: 0.1),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: const Center(
                  child: Icon(
                    Icons.list,
                    color: Colors.white70,
                    size: 16,
                  ),
                ),
              );
            },
          ),
        ),
      ],
    );
  }

  Widget _buildModuleList(BuildContext context) {
    if (moduleList.isEmpty) {
      return const Center(
        child: Padding(
          padding: EdgeInsets.all(32),
          child: Column(
            children: [
              Icon(
                Icons.school_outlined,
                size: 48,
                color: Colors.white54,
              ),
              SizedBox(height: 16),
              ThemeAwareText(
                text: 'No modules available yet',
                style: TextStyle(color: Colors.white70),
                textAlign: TextAlign.center,
              ),
            ],
          ),
        ),
      );
    }

    return Column(
      children: moduleList.map((module) {
        return Padding(
          padding: EdgeInsets.only(
            bottom: context.isMobile ? 8 : 12,
          ),
          child: CourseModule(module: module),
        );
      }).toList(),
    );
  }
}

/// Alternative grid view for course progress
class CourseProgressGrid extends StatelessWidget {
  static final moduleList = Module.generateModule();

  const CourseProgressGrid({super.key});

  @override
  Widget build(BuildContext context) {
    final columnCount = context.getGridColumnCount();
    
    return ThemeAwareCard(
      padding: context.responsivePadding,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const ThemeAwareText(
            text: 'Course Progress',
            isHeading: true,
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          SizedBox(height: context.isMobile ? 12 : 16),
          GridView.builder(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: columnCount,
              crossAxisSpacing: 12,
              mainAxisSpacing: 12,
              childAspectRatio: context.isMobile ? 1.2 : 1.5,
            ),
            itemCount: moduleList.length,
            itemBuilder: (context, index) {
              final module = moduleList[index];
              return _buildModuleCard(context, module);
            },
          ),
        ],
      ),
    );
  }

  Widget _buildModuleCard(BuildContext context, Module module) {
    return ThemeAwareCard(
      onTap: () {
        // Handle module tap
      },
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.play_circle_outline,
            size: context.isMobile ? 32 : 40,
            color: Colors.white70,
          ),
          const SizedBox(height: 8),
          ThemeAwareText(
            text: module.title,
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.center,
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 4),
          LinearProgressIndicator(
            value: 0.7, // Replace with actual progress
            backgroundColor: Colors.white.withValues(alpha: 0.2),
            valueColor: const AlwaysStoppedAnimation<Color>(Colors.blue),
          ),
        ],
      ),
    );
  }
}