import 'package:billiards/entities/user/user_repository.dart';
import 'package:billiards/services/theme/theme_service.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:get/get.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_animate/flutter_animate.dart';
import 'package:billiards/services/theme/i_theme_service.dart';
import 'package:billiards/entities/user/user.dart';
import 'package:billiards/entities/user/i_user.dart';

class PlayerSelectionWidget extends ConsumerStatefulWidget {
  final Function(User player1, User player2) onPlayersSelected;

  const PlayerSelectionWidget({
    super.key,
    required this.onPlayersSelected,
  });

  @override
  ConsumerState<PlayerSelectionWidget> createState() =>
      _PlayerSelectionWidgetState();
}

class _PlayerSelectionWidgetState extends ConsumerState<PlayerSelectionWidget> {
  User? player1;
  User? player2;
  final TextEditingController _player1Controller = TextEditingController();
  final TextEditingController _player2Controller = TextEditingController();
  List<IUser>? _existingPlayers;
  List<IUser> _filteredPlayers = [];
  bool _isPlayer1Focused = false;
  bool _isPlayer2Focused = false;

  @override
  void initState() {
    super.initState();
    _loadExistingPlayers();
  }

  Future<void> _loadExistingPlayers() async {
    final repository = await ref.read(userRepositoryProvider.future);
    final players = await repository.getAll();
    setState(() {
      _existingPlayers = players;
      _filteredPlayers = players;
    });
  }

  void _filterPlayers(String query, bool isPlayer1) {
    if (_existingPlayers == null) return;

    setState(() {
      _filteredPlayers = _existingPlayers!
          .where((player) =>
              player.name.toLowerCase().contains(query.toLowerCase()) &&
              player.id != player1?.id &&
              player.id != player2?.id)
          .toList();
    });
  }

  @override
  Widget build(BuildContext context) {
    final theme = ref.watch(themeServiceProvider);

    return Container(
      padding: EdgeInsets.all(16.w),
      decoration: BoxDecoration(
        gradient: theme.gradients.surfaceGradient,
        borderRadius: BorderRadius.circular(12),
        boxShadow: theme.shadows.primaryShadow,
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            'select_players'.tr,
            style: theme.textStyles.headlineMedium,
          ).animate().fadeIn(duration: 500.ms),
          SizedBox(height: 24.h),
          _buildPlayerInput(
            theme,
            controller: _player1Controller,
            label: 'player_1'.tr,
            selectedPlayer: player1,
            isFocused: _isPlayer1Focused,
            onFocusChanged: (focused) {
              setState(() {
                _isPlayer1Focused = focused;
                if (focused) {
                  _filterPlayers(_player1Controller.text, true);
                }
              });
            },
            onPlayerSelected: (user) {
              setState(() => player1 = user as User);
            },
          ),
          SizedBox(height: 16.h),
          _buildPlayerInput(
            theme,
            controller: _player2Controller,
            label: 'player_2'.tr,
            selectedPlayer: player2,
            isFocused: _isPlayer2Focused,
            onFocusChanged: (focused) {
              setState(() {
                _isPlayer2Focused = focused;
                if (focused) {
                  _filterPlayers(_player2Controller.text, false);
                }
              });
            },
            onPlayerSelected: (user) {
              setState(() => player2 = user as User);
            },
          ),
          SizedBox(height: 24.h),
          ElevatedButton(
            onPressed: player1 != null && player2 != null
                ? () => widget.onPlayersSelected(player1!, player2!)
                : null,
            style: ElevatedButton.styleFrom(
              backgroundColor: theme.colors.primaryButton,
              padding: EdgeInsets.symmetric(horizontal: 32.w, vertical: 16.h),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(8),
              ),
            ),
            child: Text(
              'start_game'.tr,
              style: theme.textStyles.bodyLarge.copyWith(
                color: theme.colors.accentText,
              ),
            ),
          ).animate().fadeIn(duration: 500.ms),
        ],
      ),
    );
  }

  Widget _buildPlayerInput(
    IThemeService theme, {
    required TextEditingController controller,
    required String label,
    required Function(IUser) onPlayerSelected,
    required Function(bool) onFocusChanged,
    required bool isFocused,
    User? selectedPlayer,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: theme.colors.surfaceColor,
        borderRadius: BorderRadius.circular(8),
      ),
      child: Column(
        children: [
          Row(
            children: [
              Expanded(
                child: Focus(
                  onFocusChange: onFocusChanged,
                  child: TextField(
                    controller: controller,
                    style: theme.textStyles.bodyLarge,
                    onChanged: (value) {
                      _filterPlayers(value, controller == _player1Controller);
                      if (value.isEmpty) {
                        if (controller == _player1Controller) {
                          setState(() => player1 = null);
                        } else {
                          setState(() => player2 = null);
                        }
                      } else {
                        final exactMatch = _existingPlayers?.firstWhere(
                          (player) =>
                              player.name.toLowerCase() == value.toLowerCase(),
                          orElse: () => User.create(name: ''),
                        );

                        if (exactMatch?.name.isNotEmpty == true) {
                          final user = exactMatch as User;
                          if (controller == _player1Controller) {
                            if (player2?.id == user.id) {
                              Get.snackbar(
                                'error'.tr,
                                'player_already_selected'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              controller.clear();
                              setState(() => player1 = null);
                            } else {
                              setState(() => player1 = user);
                            }
                          } else {
                            if (player1?.id == user.id) {
                              Get.snackbar(
                                'error'.tr,
                                'player_already_selected'.tr,
                                snackPosition: SnackPosition.BOTTOM,
                              );
                              controller.clear();
                              setState(() => player2 = null);
                            } else {
                              setState(() => player2 = user);
                            }
                          }
                        } else {
                          if (controller == _player1Controller) {
                            setState(() => player1 = null);
                          } else {
                            setState(() => player2 = null);
                          }
                        }
                      }
                    },
                    decoration: InputDecoration(
                      labelText: label,
                      border: InputBorder.none,
                      contentPadding: EdgeInsets.symmetric(horizontal: 16.w),
                      labelStyle: theme.textStyles.bodyMedium,
                    ),
                  ),
                ),
              ),
              if (selectedPlayer == null)
                IconButton(
                  icon:
                      Icon(Icons.person_add, color: theme.colors.primaryAccent),
                  onPressed: () {
                    _createPlayer(controller, onPlayerSelected);
                  },
                ),
            ],
          ),
          if (isFocused && _filteredPlayers.isNotEmpty)
            Container(
              constraints: BoxConstraints(
                maxHeight: 100.h,
              ),
              margin: EdgeInsets.only(top: 8.h),
              decoration: BoxDecoration(
                color: theme.colors.surfaceColor,
                borderRadius: BorderRadius.circular(8),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.1),
                    blurRadius: 4,
                    offset: const Offset(0, 2),
                  ),
                ],
              ),
              child: ListView.builder(
                shrinkWrap: true,
                itemCount: _filteredPlayers.length,
                itemBuilder: (context, index) {
                  final player = _filteredPlayers[index];
                  final isSelected = player == selectedPlayer;
                  final isAlreadySelected = (controller == _player1Controller &&
                          player2?.id == player.id) ||
                      (controller == _player2Controller &&
                          player1?.id == player.id);
                  return ListTile(
                    dense: true,
                    title: Text(
                      player.name,
                      style: theme.textStyles.bodyMedium.copyWith(
                        color: isSelected
                            ? theme.colors.primaryAccent
                            : isAlreadySelected
                                ? Colors.red
                                : null,
                      ),
                    ),
                    selected: isSelected,
                    onTap: isAlreadySelected
                        ? null
                        : () {
                            controller.text = player.name;
                            onPlayerSelected(player);
                            FocusScope.of(context).unfocus();
                          },
                  );
                },
              ),
            ),
        ],
      ),
    ).animate().fadeIn(duration: 500.ms);
  }

  Future<void> _createPlayer(TextEditingController controller,
      Function(IUser) onPlayerSelected) async {
    final name = controller.text.trim();
    if (name.isEmpty) {
      Get.snackbar(
        'error'.tr,
        'name_required'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final repository = await ref.read(userRepositoryProvider.future);
    final players = await repository.getAll();
    final existingPlayer = players.firstWhere(
      (player) => player.name.toLowerCase() == name.toLowerCase(),
      orElse: () => User.create(name: ''),
    );

    if (existingPlayer.name.isNotEmpty) {
      Get.snackbar(
        'error'.tr,
        'player_exists'.tr,
        snackPosition: SnackPosition.BOTTOM,
      );
      return;
    }

    final user = User.create(name: name);
    await repository.add(user);
    await _loadExistingPlayers();
    onPlayerSelected(user);

    setState(() {
      _filteredPlayers = _existingPlayers!
          .where((player) =>
              player.name.toLowerCase().contains(name.toLowerCase()) &&
              player.id != player1?.id &&
              player.id != player2?.id)
          .toList();
    });
  }

  @override
  void dispose() {
    _player1Controller.dispose();
    _player2Controller.dispose();
    super.dispose();
  }
}
