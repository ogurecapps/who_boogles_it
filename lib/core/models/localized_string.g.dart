// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'localized_string.dart';

// **************************************************************************
// IsarEmbeddedGenerator
// **************************************************************************

// coverage:ignore-file
// ignore_for_file: duplicate_ignore, non_constant_identifier_names, constant_identifier_names, invalid_use_of_protected_member, unnecessary_cast, prefer_const_constructors, lines_longer_than_80_chars, require_trailing_commas, inference_failure_on_function_invocation, unnecessary_parenthesis, unnecessary_raw_strings, unnecessary_null_checks, join_return_with_assignment, prefer_final_locals, avoid_js_rounded_ints, avoid_positional_boolean_parameters, always_specify_types

const LocalizedStringSchema = Schema(
  name: r'LocalizedString',
  id: -606093928960831987,
  properties: {
    r'langCode': PropertySchema(
      id: 0,
      name: r'langCode',
      type: IsarType.string,
    ),
    r'text': PropertySchema(
      id: 1,
      name: r'text',
      type: IsarType.string,
    )
  },
  estimateSize: _localizedStringEstimateSize,
  serialize: _localizedStringSerialize,
  deserialize: _localizedStringDeserialize,
  deserializeProp: _localizedStringDeserializeProp,
);

int _localizedStringEstimateSize(
  LocalizedString object,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  var bytesCount = offsets.last;
  {
    final value = object.langCode;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  {
    final value = object.text;
    if (value != null) {
      bytesCount += 3 + value.length * 3;
    }
  }
  return bytesCount;
}

void _localizedStringSerialize(
  LocalizedString object,
  IsarWriter writer,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  writer.writeString(offsets[0], object.langCode);
  writer.writeString(offsets[1], object.text);
}

LocalizedString _localizedStringDeserialize(
  Id id,
  IsarReader reader,
  List<int> offsets,
  Map<Type, List<int>> allOffsets,
) {
  final object = LocalizedString(
    langCode: reader.readStringOrNull(offsets[0]),
    text: reader.readStringOrNull(offsets[1]),
  );
  return object;
}

P _localizedStringDeserializeProp<P>(
  IsarReader reader,
  int propertyId,
  int offset,
  Map<Type, List<int>> allOffsets,
) {
  switch (propertyId) {
    case 0:
      return (reader.readStringOrNull(offset)) as P;
    case 1:
      return (reader.readStringOrNull(offset)) as P;
    default:
      throw IsarError('Unknown property with id $propertyId');
  }
}

extension LocalizedStringQueryFilter
    on QueryBuilder<LocalizedString, LocalizedString, QFilterCondition> {
  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'langCode',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'langCode',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'langCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'langCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'langCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'langCode',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'langCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'langCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'langCode',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'langCode',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'langCode',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      langCodeIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'langCode',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textIsNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textIsNotNull() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(const FilterCondition.isNotNull(
        property: r'text',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textEqualTo(
    String? value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textGreaterThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textLessThan(
    String? value, {
    bool include = false,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.lessThan(
        include: include,
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textBetween(
    String? lower,
    String? upper, {
    bool includeLower = true,
    bool includeUpper = true,
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.between(
        property: r'text',
        lower: lower,
        includeLower: includeLower,
        upper: upper,
        includeUpper: includeUpper,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textStartsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.startsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textEndsWith(
    String value, {
    bool caseSensitive = true,
  }) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.endsWith(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textContains(String value, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.contains(
        property: r'text',
        value: value,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textMatches(String pattern, {bool caseSensitive = true}) {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.matches(
        property: r'text',
        wildcard: pattern,
        caseSensitive: caseSensitive,
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textIsEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.equalTo(
        property: r'text',
        value: '',
      ));
    });
  }

  QueryBuilder<LocalizedString, LocalizedString, QAfterFilterCondition>
      textIsNotEmpty() {
    return QueryBuilder.apply(this, (query) {
      return query.addFilterCondition(FilterCondition.greaterThan(
        property: r'text',
        value: '',
      ));
    });
  }
}

extension LocalizedStringQueryObject
    on QueryBuilder<LocalizedString, LocalizedString, QFilterCondition> {}
