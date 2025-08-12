# 🧹 Cleanup Script for Legacy Directories

This script helps safely remove old directories after confirming the new structure works correctly.

## ⚠️ **Important: Run This ONLY After Verification**

Before running cleanup:
1. ✅ Test the app thoroughly with `flutter run`
2. ✅ Run all tests with `flutter test`
3. ✅ Run analysis with `flutter analyze`
4. ✅ Ensure all functionality works as expected

## 🗂️ **Directories to Remove (After Verification)**

### **Safe to Remove After Testing:**
```bash
# Navigate to lib directory first
cd lib/

# Remove old utility directories
rm -rf utils/
rm -rf services/

# Remove old page structure (keep presentation/pages/)
rm -rf pages/

# Remove old widget structure (keep presentation/widgets/)
rm -rf widgets/

# Remove old theme structure (keep presentation/themes/)
rm -rf themes/

# Remove old state management (keep presentation/providers/)
rm -rf state/

# Remove old configuration (keep core/config/)
rm -rf config/

# Remove old helper files (functionality moved to domain/data layers)
rm -rf helpers/

# Remove legacy single files
rm -f redeem.dart

# Remove src directory if no longer needed (check first!)
# rm -rf src/
```

### **Windows Commands (if using Command Prompt):**
```cmd
REM Navigate to lib directory first
cd lib\

REM Remove directories
rmdir /s /q utils
rmdir /s /q services
rmdir /s /q pages
rmdir /s /q widgets
rmdir /s /q themes
rmdir /s /q state
rmdir /s /q config
rmdir /s /q helpers

REM Remove single files
del redeem.dart
```

## 📋 **Pre-Cleanup Verification Checklist**

### ✅ **File Structure Verification:**
- [ ] All files exist in new locations
- [ ] Import paths are updated
- [ ] No missing dependencies
- [ ] All widgets render correctly

### ✅ **Functionality Tests:**
- [ ] App launches successfully
- [ ] Navigation works correctly
- [ ] State management functions properly
- [ ] Theme switching works
- [ ] Responsive design functions
- [ ] Error handling works

### ✅ **Build Tests:**
- [ ] `flutter clean && flutter pub get` completes
- [ ] `flutter analyze` shows acceptable errors
- [ ] `flutter test` passes
- [ ] `flutter build apk --debug` succeeds (Android)
- [ ] App runs on physical device/emulator

## 🔍 **What Files Are Safe to Keep**

### **Keep These Directories:**
- ✅ `core/` - New core functionality
- ✅ `data/` - Data layer implementation
- ✅ `domain/` - Business logic layer
- ✅ `presentation/` - UI layer
- ✅ `shared/` - Shared utilities
- ✅ `src/` - Settings (if still needed)
- ✅ `firebase_options.dart` - Firebase configuration
- ✅ `main.dart` - App entry point

### **Documentation Files:**
- ✅ `README_STRUCTURE.md`
- ✅ `MIGRATION_CHECKLIST.md`
- ✅ `CLEANUP_SCRIPT.md` (this file)

## 🚨 **Recovery Plan (If Something Goes Wrong)**

If cleanup breaks something:

1. **Git Recovery (if using version control):**
   ```bash
   git checkout HEAD -- lib/
   git reset --hard HEAD
   ```

2. **Manual Recovery:**
   - The old files should still be in your version control
   - Or restore from backup if available

3. **Re-run Migration:**
   - Follow the `MIGRATION_CHECKLIST.md` again
   - Update import statements carefully
   - Test incrementally

## 📊 **Expected Results After Cleanup**

### **Before Cleanup:**
```
lib/
├── core/ (new)
├── data/ (new)  
├── domain/ (new)
├── presentation/ (new)
├── shared/ (new)
├── pages/ (old) ⬅️ Remove
├── widgets/ (old) ⬅️ Remove
├── utils/ (old) ⬅️ Remove
├── themes/ (old) ⬅️ Remove
├── state/ (old) ⬅️ Remove
└── ... other old dirs
```

### **After Cleanup:**
```
lib/
├── core/           # ✅ Clean architecture
├── data/           # ✅ Data layer
├── domain/         # ✅ Business logic
├── presentation/   # ✅ UI layer
├── shared/         # ✅ Shared utilities
├── src/            # ✅ Settings (if needed)
├── firebase_options.dart
└── main.dart
```

## 💡 **Tips for Safe Cleanup**

1. **Backup First:** Always backup your project before cleanup
2. **Test Thoroughly:** Don't rush the verification process
3. **Clean Incrementally:** Remove one directory at a time and test
4. **Check Dependencies:** Ensure no hidden dependencies on old files
5. **Version Control:** Commit working state before cleanup

## 🎯 **Success Metrics**

After cleanup, you should have:
- ✅ **Cleaner codebase** with only necessary files
- ✅ **Faster IDE navigation** without duplicate files
- ✅ **Reduced confusion** from old/new file conflicts
- ✅ **Pure clean architecture** implementation
- ✅ **Better build times** without unused files

## ⏰ **When to Run Cleanup**

Run cleanup when:
- ✅ All team members have migrated their branches
- ✅ All functionality has been verified
- ✅ All tests are passing
- ✅ Production deployment is successful (if applicable)
- ✅ Everyone is comfortable with the new structure

## 📞 **Support**

If you need help:
1. Check `README_STRUCTURE.md` for architecture details
2. Review `MIGRATION_CHECKLIST.md` for migration steps
3. Ensure all import paths use the new structure
4. Test thoroughly before cleanup

**Remember: It's better to keep the old files a bit longer than to break the app! 🛡️**