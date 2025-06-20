import 'package:billiards/core/settings.dart';
import 'package:billiards/entities/settings/i_settings.dart';
import 'package:billiards/entities/settings/i_settings_repository.dart';
import 'package:billiards/entities/settings/settings.dart';
import 'package:billiards/services/store/i_repository.dart';
import 'package:billiards/services/store/store_service.dart';
import 'package:get/get.dart';
import 'package:riverpod/riverpod.dart';

final settingsRepositoryProvider =
    FutureProvider<ISettingsRepository>((ref) async {
  final store = await ref.watch(storeServiceProvider.future);
  final repository = store.getRepository<Settings>();
  final settingsRepository = SettingsRepository(repository, ref);
  final isDev = ref.read(isDevProvider);
  final isClear = ref.read(isClearProvider);
  if (isClear) {
    await repository.clear();
  }
  if (isDev) {
    await repository.clear();
  }
  await settingsRepository.init();
  return settingsRepository;
});

class SettingsRepository implements ISettingsRepository {
  final IRepository<ISettings> _repository;
  final Ref ref;

  SettingsRepository(this._repository, this.ref);

  Future<void> init() async {
    final settings = await _repository.getAll();
    if (settings.isEmpty) {
      await _createSettings();
    }
  }

  @override
  Future<ISettings> getSettings() async {
    final settings = await _repository.getAll();
    return settings.first;
  }

  Future<ISettings> _createSettings() async {
    final settings = Settings(
      id: 0,
      themeModeId: Get.isPlatformDarkMode ? 1 : 0,
      languageCode: Get.deviceLocale?.languageCode ?? 'en',
    );
    await _repository.add(settings);
    return settings;
  }

  @override
  Future<int> updateSettings(ISettings settings) async {
    final id = await _repository.refresh(settings);
    ref.notifyListeners();
    return id;
  }
}
