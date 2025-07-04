// GENERATED CODE - DO NOT MODIFY BY HAND
// This code was generated by ObjectBox. To update it run the generator again
// with `dart run build_runner build`.
// See also https://docs.objectbox.io/getting-started#generate-objectbox-code

// ignore_for_file: camel_case_types, depend_on_referenced_packages
// coverage:ignore-file

import 'dart:typed_data';

import 'package:flat_buffers/flat_buffers.dart' as fb;
import 'package:objectbox/internal.dart'
    as obx_int; // generated code can access "internal" functionality
import 'package:objectbox/objectbox.dart' as obx;
import 'package:objectbox_flutter_libs/objectbox_flutter_libs.dart';

import 'entities/game_state/game_state.dart';
import 'entities/match/match.dart';
import 'entities/player/player.dart';
import 'entities/round/round.dart';
import 'entities/settings/settings.dart';
import 'entities/user/user.dart';

export 'package:objectbox/objectbox.dart'; // so that callers only have to import this file

final _entities = <obx_int.ModelEntity>[
  obx_int.ModelEntity(
    id: const obx_int.IdUid(1, 8823484483872583564),
    name: 'Match',
    lastPropertyId: const obx_int.IdUid(3, 6637337926269234629),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 7068007530814462651),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 1866504726469463554),
        name: 'start',
        type: 10,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 6637337926269234629),
        name: 'end',
        type: 10,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[
      obx_int.ModelRelation(
        id: const obx_int.IdUid(1, 3201475119944613779),
        name: 'rrounds',
        targetId: const obx_int.IdUid(3, 8850380683997713648),
      ),
      obx_int.ModelRelation(
        id: const obx_int.IdUid(3, 8506586501518462432),
        name: 'rusers',
        targetId: const obx_int.IdUid(4, 1844088988516406394),
      ),
    ],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(2, 5799082958551474771),
    name: 'Player',
    lastPropertyId: const obx_int.IdUid(23, 1916505604589242650),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 8075854112387216936),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 4644923304084604128),
        name: 'leftBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 8180012316877201177),
        name: 'whiteBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 6395767254854043813),
        name: 'enemyBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(8, 7985921073482274135),
        name: 'randomBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(9, 2621559025177809195),
        name: 'ruserId',
        type: 11,
        flags: 520,
        indexId: const obx_int.IdUid(1, 2927373450712375417),
        relationTarget: 'User',
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(10, 8149210944306512497),
        name: 'win',
        type: 1,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(12, 5401486008566625118),
        name: 'startMoveTime',
        type: 10,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(13, 4315342696714674610),
        name: 'currentMoveInLine',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(14, 7998621858266097080),
        name: 'moves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(15, 3815692317313391783),
        name: 'moveScores',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(16, 4795826996052213338),
        name: 'movesInLines',
        type: 27,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(17, 7423605950409367711),
        name: 'errorMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(18, 2901484206855070669),
        name: 'loseMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(19, 8382464838430087321),
        name: 'simpleMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(20, 3246099946926157507),
        name: 'scoreMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(21, 829091882409044943),
        name: 'blackBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(22, 7130086737777386930),
        name: 'currentBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(23, 1916505604589242650),
        name: 'moveDurationsInSeconds',
        type: 27,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(3, 8850380683997713648),
    name: 'Round',
    lastPropertyId: const obx_int.IdUid(3, 192225978172356198),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 723309352357233898),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 2113862404194963765),
        name: 'start',
        type: 10,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 192225978172356198),
        name: 'end',
        type: 10,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[
      obx_int.ModelRelation(
        id: const obx_int.IdUid(2, 8452975213217083069),
        name: 'rplayers',
        targetId: const obx_int.IdUid(2, 5799082958551474771),
      ),
    ],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(4, 1844088988516406394),
    name: 'User',
    lastPropertyId: const obx_int.IdUid(23, 4709930221051408544),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 6014912301216048633),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 8436235138743539314),
        name: 'name',
        type: 9,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 4240919488686161265),
        name: 'whiteBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 6676802067475142855),
        name: 'enemyBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(8, 6534135976818461332),
        name: 'randomBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(9, 7914097180419844075),
        name: 'blackBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(11, 5277333744141606055),
        name: 'currentBalls',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(12, 3094527332175618442),
        name: 'errorMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(13, 7077358426971950268),
        name: 'loseMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(14, 2706302984216546123),
        name: 'simpleMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(15, 6802801475002725823),
        name: 'scoreMoves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(16, 1035745847401764328),
        name: 'rounds',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(17, 8054069373030374586),
        name: 'roundWins',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(18, 6169072092677392469),
        name: 'roundLoses',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(19, 3546414518688401436),
        name: 'moveScores',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(20, 2329278746853728007),
        name: 'moves',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(22, 6280935072645254707),
        name: 'moveDurationsInSeconds',
        type: 27,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(23, 4709930221051408544),
        name: 'movesInLines',
        type: 27,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(5, 6930276505038089956),
    name: 'GameState',
    lastPropertyId: const obx_int.IdUid(5, 1822519305140696132),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 2931636363696360382),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 8799712885672641349),
        name: 'rcurrentMatchId',
        type: 11,
        flags: 520,
        indexId: const obx_int.IdUid(2, 6339833616565097545),
        relationTarget: 'Match',
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 3548920613511380075),
        name: 'rcurrentRoundId',
        type: 11,
        flags: 520,
        indexId: const obx_int.IdUid(3, 3584177699823624675),
        relationTarget: 'Round',
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(4, 4141130351968983147),
        name: 'rcurrentPlayerId',
        type: 11,
        flags: 520,
        indexId: const obx_int.IdUid(4, 2014322154969818487),
        relationTarget: 'Player',
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(5, 1822519305140696132),
        name: 'gameStatusIndex',
        type: 6,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
  obx_int.ModelEntity(
    id: const obx_int.IdUid(6, 3982585001122521069),
    name: 'Settings',
    lastPropertyId: const obx_int.IdUid(3, 1041311771095684919),
    flags: 0,
    properties: <obx_int.ModelProperty>[
      obx_int.ModelProperty(
        id: const obx_int.IdUid(1, 5257803636779872110),
        name: 'id',
        type: 6,
        flags: 1,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(2, 2158243982790154508),
        name: 'themeModeId',
        type: 6,
        flags: 0,
      ),
      obx_int.ModelProperty(
        id: const obx_int.IdUid(3, 1041311771095684919),
        name: 'languageCode',
        type: 9,
        flags: 0,
      ),
    ],
    relations: <obx_int.ModelRelation>[],
    backlinks: <obx_int.ModelBacklink>[],
  ),
];

/// Shortcut for [obx.Store.new] that passes [getObjectBoxModel] and for Flutter
/// apps by default a [directory] using `defaultStoreDirectory()` from the
/// ObjectBox Flutter library.
///
/// Note: for desktop apps it is recommended to specify a unique [directory].
///
/// See [obx.Store.new] for an explanation of all parameters.
///
/// For Flutter apps, also calls `loadObjectBoxLibraryAndroidCompat()` from
/// the ObjectBox Flutter library to fix loading the native ObjectBox library
/// on Android 6 and older.
Future<obx.Store> openStore({
  String? directory,
  int? maxDBSizeInKB,
  int? maxDataSizeInKB,
  int? fileMode,
  int? maxReaders,
  bool queriesCaseSensitiveDefault = true,
  String? macosApplicationGroup,
}) async {
  await loadObjectBoxLibraryAndroidCompat();
  return obx.Store(
    getObjectBoxModel(),
    directory: directory ?? (await defaultStoreDirectory()).path,
    maxDBSizeInKB: maxDBSizeInKB,
    maxDataSizeInKB: maxDataSizeInKB,
    fileMode: fileMode,
    maxReaders: maxReaders,
    queriesCaseSensitiveDefault: queriesCaseSensitiveDefault,
    macosApplicationGroup: macosApplicationGroup,
  );
}

/// Returns the ObjectBox model definition for this project for use with
/// [obx.Store.new].
obx_int.ModelDefinition getObjectBoxModel() {
  final model = obx_int.ModelInfo(
    entities: _entities,
    lastEntityId: const obx_int.IdUid(6, 3982585001122521069),
    lastIndexId: const obx_int.IdUid(4, 2014322154969818487),
    lastRelationId: const obx_int.IdUid(3, 8506586501518462432),
    lastSequenceId: const obx_int.IdUid(0, 0),
    retiredEntityUids: const [],
    retiredIndexUids: const [],
    retiredPropertyUids: const [
      7036696209073524790,
      4494770096057145177,
      5470657763435006791,
      8605881754107888921,
      1145099586356278743,
      8838081749321531417,
      4209730880087821329,
      3414012620668526501,
      2852846252413328750,
    ],
    retiredRelationUids: const [],
    modelVersion: 5,
    modelVersionParserMinimum: 5,
    version: 1,
  );

  final bindings = <Type, obx_int.EntityDefinition>{
    Match: obx_int.EntityDefinition<Match>(
      model: _entities[0],
      toOneRelations: (Match object) => [],
      toManyRelations:
          (Match object) => {
            obx_int.RelInfo<Match>.toMany(1, object.id): object.rrounds,
            obx_int.RelInfo<Match>.toMany(3, object.id): object.rusers,
          },
      getId: (Match object) => object.id,
      setId: (Match object, int id) {
        object.id = id;
      },
      objectToFB: (Match object, fb.Builder fbb) {
        fbb.startTable(4);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.start.millisecondsSinceEpoch);
        fbb.addInt64(2, object.end?.millisecondsSinceEpoch);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final endValue = const fb.Int64Reader().vTableGetNullable(
          buffer,
          rootOffset,
          8,
        );
        final idParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          4,
          0,
        );
        final rroundsParam = obx.ToMany<Round>();
        final rusersParam = obx.ToMany<User>();
        final startParam = DateTime.fromMillisecondsSinceEpoch(
          const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
        );
        final endParam =
            endValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(endValue);
        final object = Match(
          id: idParam,
          rrounds: rroundsParam,
          rusers: rusersParam,
          start: startParam,
          end: endParam,
        );
        obx_int.InternalToManyAccess.setRelInfo<Match>(
          object.rrounds,
          store,
          obx_int.RelInfo<Match>.toMany(1, object.id),
        );
        obx_int.InternalToManyAccess.setRelInfo<Match>(
          object.rusers,
          store,
          obx_int.RelInfo<Match>.toMany(3, object.id),
        );
        return object;
      },
    ),
    Player: obx_int.EntityDefinition<Player>(
      model: _entities[1],
      toOneRelations: (Player object) => [object.ruser],
      toManyRelations: (Player object) => {},
      getId: (Player object) => object.id,
      setId: (Player object, int id) {
        object.id = id;
      },
      objectToFB: (Player object, fb.Builder fbb) {
        final movesInLinesOffset = fbb.writeListInt64(object.movesInLines);
        final moveDurationsInSecondsOffset = fbb.writeListInt64(
          object.moveDurationsInSeconds,
        );
        fbb.startTable(24);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.leftBalls);
        fbb.addInt64(2, object.whiteBalls);
        fbb.addInt64(4, object.enemyBalls);
        fbb.addInt64(7, object.randomBalls);
        fbb.addInt64(8, object.ruser.targetId);
        fbb.addBool(9, object.win);
        fbb.addInt64(11, object.startMoveTime?.millisecondsSinceEpoch);
        fbb.addInt64(12, object.currentMoveInLine);
        fbb.addInt64(13, object.moves);
        fbb.addInt64(14, object.moveScores);
        fbb.addOffset(15, movesInLinesOffset);
        fbb.addInt64(16, object.errorMoves);
        fbb.addInt64(17, object.loseMoves);
        fbb.addInt64(18, object.simpleMoves);
        fbb.addInt64(19, object.scoreMoves);
        fbb.addInt64(20, object.blackBalls);
        fbb.addInt64(21, object.currentBalls);
        fbb.addOffset(22, moveDurationsInSecondsOffset);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final startMoveTimeValue = const fb.Int64Reader().vTableGetNullable(
          buffer,
          rootOffset,
          26,
        );
        final idParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          4,
          0,
        );
        final ruserParam = obx.ToOne<User>(
          targetId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 20, 0),
        );
        final leftBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          6,
          0,
        );
        final startMoveTimeParam =
            startMoveTimeValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(startMoveTimeValue);
        final currentMoveInLineParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          28,
          0,
        );
        final winParam = const fb.BoolReader().vTableGet(
          buffer,
          rootOffset,
          22,
          false,
        );
        final movesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          30,
          0,
        );
        final moveScoresParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          32,
          0,
        );
        final moveDurationsInSecondsParam = const fb.ListReader<int>(
          fb.Int64Reader(),
          lazy: false,
        ).vTableGet(buffer, rootOffset, 48, []);
        final movesInLinesParam = const fb.ListReader<int>(
          fb.Int64Reader(),
          lazy: false,
        ).vTableGet(buffer, rootOffset, 34, []);
        final errorMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          36,
          0,
        );
        final loseMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          38,
          0,
        );
        final simpleMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          40,
          0,
        );
        final scoreMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          42,
          0,
        );
        final whiteBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          8,
          0,
        );
        final blackBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          44,
          0,
        );
        final enemyBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          12,
          0,
        );
        final randomBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          18,
          0,
        );
        final currentBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          46,
          0,
        );
        final object = Player(
          id: idParam,
          ruser: ruserParam,
          leftBalls: leftBallsParam,
          startMoveTime: startMoveTimeParam,
          currentMoveInLine: currentMoveInLineParam,
          win: winParam,
          moves: movesParam,
          moveScores: moveScoresParam,
          moveDurationsInSeconds: moveDurationsInSecondsParam,
          movesInLines: movesInLinesParam,
          errorMoves: errorMovesParam,
          loseMoves: loseMovesParam,
          simpleMoves: simpleMovesParam,
          scoreMoves: scoreMovesParam,
          whiteBalls: whiteBallsParam,
          blackBalls: blackBallsParam,
          enemyBalls: enemyBallsParam,
          randomBalls: randomBallsParam,
          currentBalls: currentBallsParam,
        );
        object.ruser.attach(store);
        return object;
      },
    ),
    Round: obx_int.EntityDefinition<Round>(
      model: _entities[2],
      toOneRelations: (Round object) => [],
      toManyRelations:
          (Round object) => {
            obx_int.RelInfo<Round>.toMany(2, object.id): object.rplayers,
          },
      getId: (Round object) => object.id,
      setId: (Round object, int id) {
        object.id = id;
      },
      objectToFB: (Round object, fb.Builder fbb) {
        fbb.startTable(4);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.start.millisecondsSinceEpoch);
        fbb.addInt64(2, object.end?.millisecondsSinceEpoch);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final endValue = const fb.Int64Reader().vTableGetNullable(
          buffer,
          rootOffset,
          8,
        );
        final idParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          4,
          0,
        );
        final rplayersParam = obx.ToMany<Player>();
        final startParam = DateTime.fromMillisecondsSinceEpoch(
          const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
        );
        final endParam =
            endValue == null
                ? null
                : DateTime.fromMillisecondsSinceEpoch(endValue);
        final object = Round(
          id: idParam,
          rplayers: rplayersParam,
          start: startParam,
          end: endParam,
        );
        obx_int.InternalToManyAccess.setRelInfo<Round>(
          object.rplayers,
          store,
          obx_int.RelInfo<Round>.toMany(2, object.id),
        );
        return object;
      },
    ),
    User: obx_int.EntityDefinition<User>(
      model: _entities[3],
      toOneRelations: (User object) => [],
      toManyRelations: (User object) => {},
      getId: (User object) => object.id,
      setId: (User object, int id) {
        object.id = id;
      },
      objectToFB: (User object, fb.Builder fbb) {
        final nameOffset = fbb.writeString(object.name);
        final moveDurationsInSecondsOffset = fbb.writeListInt64(
          object.moveDurationsInSeconds,
        );
        final movesInLinesOffset = fbb.writeListInt64(object.movesInLines);
        fbb.startTable(24);
        fbb.addInt64(0, object.id);
        fbb.addOffset(1, nameOffset);
        fbb.addInt64(2, object.whiteBalls);
        fbb.addInt64(4, object.enemyBalls);
        fbb.addInt64(7, object.randomBalls);
        fbb.addInt64(8, object.blackBalls);
        fbb.addInt64(10, object.currentBalls);
        fbb.addInt64(11, object.errorMoves);
        fbb.addInt64(12, object.loseMoves);
        fbb.addInt64(13, object.simpleMoves);
        fbb.addInt64(14, object.scoreMoves);
        fbb.addInt64(15, object.rounds);
        fbb.addInt64(16, object.roundWins);
        fbb.addInt64(17, object.roundLoses);
        fbb.addInt64(18, object.moveScores);
        fbb.addInt64(19, object.moves);
        fbb.addOffset(21, moveDurationsInSecondsOffset);
        fbb.addOffset(22, movesInLinesOffset);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final idParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          4,
          0,
        );
        final nameParam = const fb.StringReader(
          asciiOptimization: true,
        ).vTableGet(buffer, rootOffset, 6, '');
        final whiteBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          8,
          0,
        );
        final blackBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          20,
          0,
        );
        final currentBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          24,
          0,
        );
        final randomBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          18,
          0,
        );
        final enemyBallsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          12,
          0,
        );
        final errorMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          26,
          0,
        );
        final loseMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          28,
          0,
        );
        final simpleMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          30,
          0,
        );
        final scoreMovesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          32,
          0,
        );
        final roundsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          34,
          0,
        );
        final roundWinsParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          36,
          0,
        );
        final roundLosesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          38,
          0,
        );
        final moveScoresParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          40,
          0,
        );
        final movesParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          42,
          0,
        );
        final movesInLinesParam = const fb.ListReader<int>(
          fb.Int64Reader(),
          lazy: false,
        ).vTableGet(buffer, rootOffset, 48, []);
        final moveDurationsInSecondsParam = const fb.ListReader<int>(
          fb.Int64Reader(),
          lazy: false,
        ).vTableGet(buffer, rootOffset, 46, []);
        final object = User(
          id: idParam,
          name: nameParam,
          whiteBalls: whiteBallsParam,
          blackBalls: blackBallsParam,
          currentBalls: currentBallsParam,
          randomBalls: randomBallsParam,
          enemyBalls: enemyBallsParam,
          errorMoves: errorMovesParam,
          loseMoves: loseMovesParam,
          simpleMoves: simpleMovesParam,
          scoreMoves: scoreMovesParam,
          rounds: roundsParam,
          roundWins: roundWinsParam,
          roundLoses: roundLosesParam,
          moveScores: moveScoresParam,
          moves: movesParam,
          movesInLines: movesInLinesParam,
          moveDurationsInSeconds: moveDurationsInSecondsParam,
        );

        return object;
      },
    ),
    GameState: obx_int.EntityDefinition<GameState>(
      model: _entities[4],
      toOneRelations:
          (GameState object) => [
            object.rcurrentMatch,
            object.rcurrentRound,
            object.rcurrentPlayer,
          ],
      toManyRelations: (GameState object) => {},
      getId: (GameState object) => object.id,
      setId: (GameState object, int id) {
        object.id = id;
      },
      objectToFB: (GameState object, fb.Builder fbb) {
        fbb.startTable(6);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.rcurrentMatch.targetId);
        fbb.addInt64(2, object.rcurrentRound.targetId);
        fbb.addInt64(3, object.rcurrentPlayer.targetId);
        fbb.addInt64(4, object.gameStatusIndex);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final idParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          4,
          0,
        );
        final rcurrentMatchParam = obx.ToOne<Match>(
          targetId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 6, 0),
        );
        final rcurrentRoundParam = obx.ToOne<Round>(
          targetId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 8, 0),
        );
        final rcurrentPlayerParam = obx.ToOne<Player>(
          targetId: const fb.Int64Reader().vTableGet(buffer, rootOffset, 10, 0),
        );
        final gameStatusIndexParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          12,
          0,
        );
        final object = GameState(
          id: idParam,
          rcurrentMatch: rcurrentMatchParam,
          rcurrentRound: rcurrentRoundParam,
          rcurrentPlayer: rcurrentPlayerParam,
          gameStatusIndex: gameStatusIndexParam,
        );
        object.rcurrentMatch.attach(store);
        object.rcurrentRound.attach(store);
        object.rcurrentPlayer.attach(store);
        return object;
      },
    ),
    Settings: obx_int.EntityDefinition<Settings>(
      model: _entities[5],
      toOneRelations: (Settings object) => [],
      toManyRelations: (Settings object) => {},
      getId: (Settings object) => object.id,
      setId: (Settings object, int id) {
        object.id = id;
      },
      objectToFB: (Settings object, fb.Builder fbb) {
        final languageCodeOffset = fbb.writeString(object.languageCode);
        fbb.startTable(4);
        fbb.addInt64(0, object.id);
        fbb.addInt64(1, object.themeModeId);
        fbb.addOffset(2, languageCodeOffset);
        fbb.finish(fbb.endTable());
        return object.id;
      },
      objectFromFB: (obx.Store store, ByteData fbData) {
        final buffer = fb.BufferContext(fbData);
        final rootOffset = buffer.derefObject(0);
        final idParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          4,
          0,
        );
        final themeModeIdParam = const fb.Int64Reader().vTableGet(
          buffer,
          rootOffset,
          6,
          0,
        );
        final languageCodeParam = const fb.StringReader(
          asciiOptimization: true,
        ).vTableGet(buffer, rootOffset, 8, '');
        final object = Settings(
          id: idParam,
          themeModeId: themeModeIdParam,
          languageCode: languageCodeParam,
        );

        return object;
      },
    ),
  };

  return obx_int.ModelDefinition(model, bindings);
}

/// [Match] entity fields to define ObjectBox queries.
class Match_ {
  /// See [Match.id].
  static final id = obx.QueryIntegerProperty<Match>(_entities[0].properties[0]);

  /// See [Match.start].
  static final start = obx.QueryDateProperty<Match>(_entities[0].properties[1]);

  /// See [Match.end].
  static final end = obx.QueryDateProperty<Match>(_entities[0].properties[2]);

  /// see [Match.rrounds]
  static final rrounds = obx.QueryRelationToMany<Match, Round>(
    _entities[0].relations[0],
  );

  /// see [Match.rusers]
  static final rusers = obx.QueryRelationToMany<Match, User>(
    _entities[0].relations[1],
  );
}

/// [Player] entity fields to define ObjectBox queries.
class Player_ {
  /// See [Player.id].
  static final id = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[0],
  );

  /// See [Player.leftBalls].
  static final leftBalls = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[1],
  );

  /// See [Player.whiteBalls].
  static final whiteBalls = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[2],
  );

  /// See [Player.enemyBalls].
  static final enemyBalls = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[3],
  );

  /// See [Player.randomBalls].
  static final randomBalls = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[4],
  );

  /// See [Player.ruser].
  static final ruser = obx.QueryRelationToOne<Player, User>(
    _entities[1].properties[5],
  );

  /// See [Player.win].
  static final win = obx.QueryBooleanProperty<Player>(
    _entities[1].properties[6],
  );

  /// See [Player.startMoveTime].
  static final startMoveTime = obx.QueryDateProperty<Player>(
    _entities[1].properties[7],
  );

  /// See [Player.currentMoveInLine].
  static final currentMoveInLine = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[8],
  );

  /// See [Player.moves].
  static final moves = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[9],
  );

  /// See [Player.moveScores].
  static final moveScores = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[10],
  );

  /// See [Player.movesInLines].
  static final movesInLines = obx.QueryIntegerVectorProperty<Player>(
    _entities[1].properties[11],
  );

  /// See [Player.errorMoves].
  static final errorMoves = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[12],
  );

  /// See [Player.loseMoves].
  static final loseMoves = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[13],
  );

  /// See [Player.simpleMoves].
  static final simpleMoves = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[14],
  );

  /// See [Player.scoreMoves].
  static final scoreMoves = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[15],
  );

  /// See [Player.blackBalls].
  static final blackBalls = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[16],
  );

  /// See [Player.currentBalls].
  static final currentBalls = obx.QueryIntegerProperty<Player>(
    _entities[1].properties[17],
  );

  /// See [Player.moveDurationsInSeconds].
  static final moveDurationsInSeconds = obx.QueryIntegerVectorProperty<Player>(
    _entities[1].properties[18],
  );
}

/// [Round] entity fields to define ObjectBox queries.
class Round_ {
  /// See [Round.id].
  static final id = obx.QueryIntegerProperty<Round>(_entities[2].properties[0]);

  /// See [Round.start].
  static final start = obx.QueryDateProperty<Round>(_entities[2].properties[1]);

  /// See [Round.end].
  static final end = obx.QueryDateProperty<Round>(_entities[2].properties[2]);

  /// see [Round.rplayers]
  static final rplayers = obx.QueryRelationToMany<Round, Player>(
    _entities[2].relations[0],
  );
}

/// [User] entity fields to define ObjectBox queries.
class User_ {
  /// See [User.id].
  static final id = obx.QueryIntegerProperty<User>(_entities[3].properties[0]);

  /// See [User.name].
  static final name = obx.QueryStringProperty<User>(_entities[3].properties[1]);

  /// See [User.whiteBalls].
  static final whiteBalls = obx.QueryIntegerProperty<User>(
    _entities[3].properties[2],
  );

  /// See [User.enemyBalls].
  static final enemyBalls = obx.QueryIntegerProperty<User>(
    _entities[3].properties[3],
  );

  /// See [User.randomBalls].
  static final randomBalls = obx.QueryIntegerProperty<User>(
    _entities[3].properties[4],
  );

  /// See [User.blackBalls].
  static final blackBalls = obx.QueryIntegerProperty<User>(
    _entities[3].properties[5],
  );

  /// See [User.currentBalls].
  static final currentBalls = obx.QueryIntegerProperty<User>(
    _entities[3].properties[6],
  );

  /// See [User.errorMoves].
  static final errorMoves = obx.QueryIntegerProperty<User>(
    _entities[3].properties[7],
  );

  /// See [User.loseMoves].
  static final loseMoves = obx.QueryIntegerProperty<User>(
    _entities[3].properties[8],
  );

  /// See [User.simpleMoves].
  static final simpleMoves = obx.QueryIntegerProperty<User>(
    _entities[3].properties[9],
  );

  /// See [User.scoreMoves].
  static final scoreMoves = obx.QueryIntegerProperty<User>(
    _entities[3].properties[10],
  );

  /// See [User.rounds].
  static final rounds = obx.QueryIntegerProperty<User>(
    _entities[3].properties[11],
  );

  /// See [User.roundWins].
  static final roundWins = obx.QueryIntegerProperty<User>(
    _entities[3].properties[12],
  );

  /// See [User.roundLoses].
  static final roundLoses = obx.QueryIntegerProperty<User>(
    _entities[3].properties[13],
  );

  /// See [User.moveScores].
  static final moveScores = obx.QueryIntegerProperty<User>(
    _entities[3].properties[14],
  );

  /// See [User.moves].
  static final moves = obx.QueryIntegerProperty<User>(
    _entities[3].properties[15],
  );

  /// See [User.moveDurationsInSeconds].
  static final moveDurationsInSeconds = obx.QueryIntegerVectorProperty<User>(
    _entities[3].properties[16],
  );

  /// See [User.movesInLines].
  static final movesInLines = obx.QueryIntegerVectorProperty<User>(
    _entities[3].properties[17],
  );
}

/// [GameState] entity fields to define ObjectBox queries.
class GameState_ {
  /// See [GameState.id].
  static final id = obx.QueryIntegerProperty<GameState>(
    _entities[4].properties[0],
  );

  /// See [GameState.rcurrentMatch].
  static final rcurrentMatch = obx.QueryRelationToOne<GameState, Match>(
    _entities[4].properties[1],
  );

  /// See [GameState.rcurrentRound].
  static final rcurrentRound = obx.QueryRelationToOne<GameState, Round>(
    _entities[4].properties[2],
  );

  /// See [GameState.rcurrentPlayer].
  static final rcurrentPlayer = obx.QueryRelationToOne<GameState, Player>(
    _entities[4].properties[3],
  );

  /// See [GameState.gameStatusIndex].
  static final gameStatusIndex = obx.QueryIntegerProperty<GameState>(
    _entities[4].properties[4],
  );
}

/// [Settings] entity fields to define ObjectBox queries.
class Settings_ {
  /// See [Settings.id].
  static final id = obx.QueryIntegerProperty<Settings>(
    _entities[5].properties[0],
  );

  /// See [Settings.themeModeId].
  static final themeModeId = obx.QueryIntegerProperty<Settings>(
    _entities[5].properties[1],
  );

  /// See [Settings.languageCode].
  static final languageCode = obx.QueryStringProperty<Settings>(
    _entities[5].properties[2],
  );
}
