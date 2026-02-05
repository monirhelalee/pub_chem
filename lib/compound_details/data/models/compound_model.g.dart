// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'compound_model.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

CompoundModel _$CompoundModelFromJson(Map<String, dynamic> json) =>
    CompoundModel(
      pcCompounds: (json['PC_Compounds'] as List<dynamic>?)
          ?.map((e) => PCCompound.fromJson(e as Map<String, dynamic>))
          .toList(),
    );

Map<String, dynamic> _$CompoundModelToJson(CompoundModel instance) =>
    <String, dynamic>{'PC_Compounds': instance.pcCompounds};

PCCompound _$PCCompoundFromJson(Map<String, dynamic> json) => PCCompound(
  id: json['id'] == null
      ? null
      : PCCompoundId.fromJson(json['id'] as Map<String, dynamic>),
  props: (json['props'] as List<dynamic>?)
      ?.map((e) => PCProperty.fromJson(e as Map<String, dynamic>))
      .toList(),
);

Map<String, dynamic> _$PCCompoundToJson(PCCompound instance) =>
    <String, dynamic>{'id': instance.id, 'props': instance.props};

PCCompoundId _$PCCompoundIdFromJson(Map<String, dynamic> json) => PCCompoundId(
  nestedId: json['id'] == null
      ? null
      : PCCompoundNestedId.fromJson(json['id'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PCCompoundIdToJson(PCCompoundId instance) =>
    <String, dynamic>{'id': instance.nestedId};

PCCompoundNestedId _$PCCompoundNestedIdFromJson(Map<String, dynamic> json) =>
    PCCompoundNestedId(cid: (json['cid'] as num?)?.toInt());

Map<String, dynamic> _$PCCompoundNestedIdToJson(PCCompoundNestedId instance) =>
    <String, dynamic>{'cid': instance.cid};

PCProperty _$PCPropertyFromJson(Map<String, dynamic> json) => PCProperty(
  urn: json['urn'] == null
      ? null
      : PCUrn.fromJson(json['urn'] as Map<String, dynamic>),
  value: json['value'] == null
      ? null
      : PCValue.fromJson(json['value'] as Map<String, dynamic>),
);

Map<String, dynamic> _$PCPropertyToJson(PCProperty instance) =>
    <String, dynamic>{'urn': instance.urn, 'value': instance.value};

PCUrn _$PCUrnFromJson(Map<String, dynamic> json) => PCUrn(
  label: json['label'] as String?,
  name: json['name'] as String?,
  datatype: (json['datatype'] as num?)?.toInt(),
  version: json['version'] as String?,
  software: json['software'] as String?,
  source: json['source'] as String?,
  release: json['release'] as String?,
  implementation: json['implementation'] as String?,
  parameters: json['parameters'] as String?,
);

Map<String, dynamic> _$PCUrnToJson(PCUrn instance) => <String, dynamic>{
  'label': instance.label,
  'name': instance.name,
  'datatype': instance.datatype,
  'version': instance.version,
  'software': instance.software,
  'source': instance.source,
  'release': instance.release,
  'implementation': instance.implementation,
  'parameters': instance.parameters,
};

PCValue _$PCValueFromJson(Map<String, dynamic> json) => PCValue(
  sval: json['sval'] as String?,
  ival: (json['ival'] as num?)?.toInt(),
  fval: (json['fval'] as num?)?.toDouble(),
  binary: json['binary'] as String?,
);

Map<String, dynamic> _$PCValueToJson(PCValue instance) => <String, dynamic>{
  'sval': instance.sval,
  'ival': instance.ival,
  'fval': instance.fval,
  'binary': instance.binary,
};
