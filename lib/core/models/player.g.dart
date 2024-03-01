// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'player.dart';

// **************************************************************************
// IsarCollectionGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

extension GetPlayerCollection on Isar {
  IsarCollection<Player> get players => this.collection();
}

const PlayerSchema = CollectionSchema(
  name: r'Player',
  id: -1052842935974721688,
  properties: {
    r'isMe': PropertySchema(
      id: 0,
      name: r'isMe',
      type: IsarType.bool,
    ),
    r'nickname': PropertySchema(
      id: 1,
      name: r'nickname',
      type: IsarType.string,
    ),
    r'winCounter': PropertySchema(
      id: 2,
      name: r'winCounter',
      type: IsarType.long,
    )
  },
  estimateSize: _playerEstimateSize,
  serialize: _playerSerialize,
  deserialize: _playerDeserialize,
  deserializeProp: _playerDeserializeProp,
  idName: r'isarId',
  indexes: {
    r'nickname': IndexSchema(
      id: 4062737668634095984,
      name: r'nickname',
      unique: true,
      replace: true,
      properties: [
        IndexPropertySchema(
          name: r'nickname',
          type: IndexType.hash,
          caseSensitive: true,
        )
      ],
    ),
    r'isMe': IndexSchema(
      id: -5067857139706567221,
      name: r'isMe',
      unique: false,
      replace: false,
      properties: [
        IndexPropertySchema(
          name: r'isMe',
          type: IndexType.value,
          caseSensitive: false,
        )
      ],
    )
  },
  links: {},
  embeddedSchemas: {},
  getId: _playerGetId,
  getLinks: _playerGetLinks,
  attach: _playerAttach,
  version: '3.1.0',
);

int _playerEstimateSize(
  Player object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  bytesCount += 3 + object.nickname.length * 3;
  return bytesCount;
}

void _playerSerialize(
  Player object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeBool(offsets[0], object.isMe);
  writer.writeString(offsets[1], object.nickname);
  writer.writeLong(offsets[2], object.winCounter);
}

Player _playerDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = Player(
    isMe: reader.readBoolOrNull(offsets[0]) ?? false,
    nickname: reader.readString(offsets[1]),
    winCounter: reader.readLongOrNull(offsets[2]) ?? 0,
  );
  object.isarId = id;
  return object;
}

P _playerDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readBoolOrNull(offset) ?? false) as P;
    case 1:
      return (reader.readString(offset)) as P;
    case 2:
      return (reader.readLongOrNull(offset) ?? 0) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

Id _playerGetId(Player object) {
  return object.isarId;
}

List<IsarLinkBase<dynamic>> _playerGetLinks(Player object) {
  return [];
}

void _playerAttach(IsarCollection<dynamic> col, Id id, Player object) {
  object.isarId = id;
}

extension PlayerByIndex on IsarCollection<Player> {
  Future<Player?> getByNickname(String nickname) {
    return getByIndex(r'nickname', [nickname]);
  }

  Player? getByNicknameSync(String nickname) {
    return getByIndexSync(r'nickname', [nickname]);
  }

  Future<bool> deleteByNickname(String nickname) {
    return deleteByIndex(r'nickname', [nickname]);
  }

  bool deleteByNicknameSync(String nickname) {
    return deleteByIndexSync(r'nickname', [nickname]);
  }

  Future<List<Player?>> getAllByNickname(List<String> nicknameValues) {
    final values = nicknameValues.map((e) => [e]).toList();
    return getAllByIndex(r'nickname', values);
  }

  List<Player?> getAllByNicknameSync(List<String> nicknameValues) {
    final values = nicknameValues.map((e) => [e]).toList();
    return getAllByIndexSync(r'nickname', values);
  }

  Future<int> deleteAllByNickname(List<String> nicknameValues) {
    final values = nicknameValues.map((e) => [e]).toList();
    return deleteAllByIndex(r'nickname', values);
  }

  int deleteAllByNicknameSync(List<String> nicknameValues) {
    final values = nicknameValues.map((e) => [e]).toList();
    return deleteAllByIndexSync(r'nickname', values);
  }

  Future<Id> putByNickname(Player object) {
    return putByIndex(r'nickname', object);
  }

  Id putByNicknameSync(Player object, {bool saveLinks = true}) {
    return putByIndexSync(r'nickname', object, saveLinks: saveLinks);
  }

  Future<List<Id>> putAllByNickname(List<Player> objects) {
    return putAllByIndex(r'nickname', objects);
  }

  List<Id> putAllByNicknameSync(List<Player> objects, {bool saveLinks = true}) {
    return putAllByIndexSync(r'nickname', objects, saveLinks: saveLinks);
  }
}

extension PlayerQueryWhereSort on QueryBuilder<Player, Player, QWhere> {
  QueryBuilder<Player, Player, QAfterWhere> anyIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(const IdWhereClause.any());
    });
  }

  QueryBuilder<Player, Player, QAfterWhere> anyIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        const IndexWhereClause.any(indexName: r'isMe'),
      );
    });
  }
}

extension PlayerQueryWhere on QueryBuilder<Player, Player, QWhereClause> {
  QueryBuilder<Player, Player, QAfterWhereClause> isarIdEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: isarId,
        upper: isarId,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isarIdNotEqualTo(Id isarId) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            )
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            );
      } else {
        return query
            .addWhereClause(
              IdWhereClause.greaterThan(lower: isarId, includeLower: false),
            )
            .addWhereClause(
              IdWhereClause.lessThan(upper: isarId, includeUpper: false),
            );
      }
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isarIdGreaterThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.greaterThan(lower: isarId, includeLower: include),
      );
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isarIdLessThan(Id isarId,
      {bool include = false}) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(
        IdWhereClause.lessThan(upper: isarId, includeUpper: include),
      );
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isarIdBetween(
    Id lowerIsarId,
    Id upperIsarId, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IdWhereClause.between(
        lower: lowerIsarId,
        includeLower: includeLower,
        upper: upperIsarId,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nicknameEqualTo(
      String nickname) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'nickname',
        value: [nickname],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> nicknameNotEqualTo(
      String nickname) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [],
              upper: [nickname],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [nickname],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [nickname],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'nickname',
              lower: [],
              upper: [nickname],
              includeUpper: false,
            ));
      }
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isMeEqualTo(bool isMe) {
    return QueryBuilder.apply(this, (query) {
      return query.addWhereClause(IndexWhereClause.equalTo(
        indexName: r'isMe',
        value: [isMe],
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterWhereClause> isMeNotEqualTo(bool isMe) {
    return QueryBuilder.apply(this, (query) {
      if (query.whereSort == Sort.asc) {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMe',
              lower: [],
              upper: [isMe],
              includeUpper: false,
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMe',
              lower: [isMe],
              includeLower: false,
              upper: [],
            ));
      } else {
        return query
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMe',
              lower: [isMe],
              includeLower: false,
              upper: [],
            ))
            .addWhereClause(IndexWhereClause.between(
              indexName: r'isMe',
              lower: [],
              upper: [isMe],
              includeUpper: false,
            ));
      }
    });
  }
}

extension PlayerQueryFilter on QueryBuilder<Player, Player, QFilterCondition> {
  QueryBuilder<Player, Player, QAfterFilterCondition> isMeEqualTo(bool value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isMe',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isarIdEqualTo(Id value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isarIdGreaterThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isarIdLessThan(
    Id value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'isarId',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> isarIdBetween(
    Id lower,
    Id upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'isarId',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameEqualTo(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameGreaterThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameLessThan(
    String value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameBetween(
    String lower,
    String upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'nickname',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameContains(
      String value,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'nickname',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameMatches(
      String pattern,
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'nickname',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> nicknameIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'nickname',
        value: '',
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> winCounterEqualTo(
      int value) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'winCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> winCounterGreaterThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'winCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> winCounterLessThan(
    int value, {
    bool include = false,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'winCounter',
        value: value,
      ));
    });
  }

  QueryBuilder<Player, Player, QAfterFilterCondition> winCounterBetween(
    int lower,
    int upper, {
    bool includeLower = true,
    bool includeUpper = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'winCounter',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
      ));
    });
  }
}

extension PlayerQueryObject on QueryBuilder<Player, Player, QFilterCondition> {}

extension PlayerQueryLinks on QueryBuilder<Player, Player, QFilterCondition> {}

extension PlayerQuerySortBy on QueryBuilder<Player, Player, QSortBy> {
  QueryBuilder<Player, Player, QAfterSortBy> sortByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByIsMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByWinCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winCounter', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> sortByWinCounterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winCounter', Sort.desc);
    });
  }
}

extension PlayerQuerySortThenBy on QueryBuilder<Player, Player, QSortThenBy> {
  QueryBuilder<Player, Player, QAfterSortBy> thenByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsMeDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isMe', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsarId() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByIsarIdDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'isarId', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByNickname() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByNicknameDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'nickname', Sort.desc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByWinCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winCounter', Sort.asc);
    });
  }

  QueryBuilder<Player, Player, QAfterSortBy> thenByWinCounterDesc() {
    return QueryBuilder.apply(this, (query) {
      return query.addSortBy(r'winCounter', Sort.desc);
    });
  }
}

extension PlayerQueryWhereDistinct on QueryBuilder<Player, Player, QDistinct> {
  QueryBuilder<Player, Player, QDistinct> distinctByIsMe() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'isMe');
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByNickname(
      {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'nickname', caseSensitive: caseSensitive);
    });
  }

  QueryBuilder<Player, Player, QDistinct> distinctByWinCounter() {
    return QueryBuilder.apply(this, (query) {
      return query.addDistinctBy(r'winCounter');
    });
  }
}

extension PlayerQueryProperty on QueryBuilder<Player, Player, QQueryProperty> {
  QueryBuilder<Player, int, QQueryOperations> isarIdProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isarId');
    });
  }

  QueryBuilder<Player, bool, QQueryOperations> isMeProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'isMe');
    });
  }

  QueryBuilder<Player, String, QQueryOperations> nicknameProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'nickname');
    });
  }

  QueryBuilder<Player, int, QQueryOperations> winCounterProperty() {
    return QueryBuilder.apply(this, (query) {
      return query.addPropertyName(r'winCounter');
    });
  }
}
