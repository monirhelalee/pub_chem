import 'dart:convert';

import 'package:freezed_annotation/freezed_annotation.dart';
import 'package:pub_chem/compound_details/domain/entities/compound.dart';

part 'compound_model.g.dart';

CompoundModel compoundModelFromJson(String str) =>
    CompoundModel.fromJson(json.decode(str) as Map<String, dynamic>);

@JsonSerializable()
class CompoundModel {
  CompoundModel({this.pcCompounds});

  factory CompoundModel.fromJson(Map<String, dynamic> json) =>
      _$CompoundModelFromJson(json);

  @JsonKey(name: 'PC_Compounds')
  List<PCCompound>? pcCompounds;

  Compound toEntity() {
    if (pcCompounds == null || pcCompounds!.isEmpty) {
      return const Compound(
        cid: 0,
        name: '',
        molecularFormula: '',
        molecularWeight: 0,
        smiles: '',
      );
    }
    return pcCompounds!.first.toEntity();
  }
}

@JsonSerializable()
class PCCompound {
  PCCompound({this.id, this.props});

  factory PCCompound.fromJson(Map<String, dynamic> json) =>
      _$PCCompoundFromJson(json);
  PCCompoundId? id;
  List<PCProperty>? props;

  Compound toEntity() {
    final cid = id?.nestedId?.cid ?? 0;

    String? name;
    String? molecularFormula;
    String? molecularWeightStr;
    String? smiles;
    String? description;

    // Extract properties from props array
    if (props != null) {
      for (final prop in props!) {
        final urn = prop.urn;
        final value = prop.value;

        if (urn == null || value == null) continue;

        final label = urn.label;
        final nameField = urn.name;

        // Extract IUPAC Name (Preferred)
        if (label == 'IUPAC Name' && nameField == 'Preferred') {
          name = value.sval;
        }
        // Extract Molecular Formula
        else if (label == 'Molecular Formula') {
          molecularFormula = value.sval;
        }
        // Extract Molecular Weight
        else if (label == 'Molecular Weight') {
          molecularWeightStr = value.sval;
        }
        // Extract SMILES (Absolute or Connectivity)
        else if (label == 'SMILES' &&
            (nameField == 'Absolute' || nameField == 'Connectivity')) {
          smiles = value.sval;
        }
      }

      // Fallback for name if Preferred is not available
      if (name == null || name.isEmpty) {
        for (final prop in props!) {
          final urn = prop.urn;
          final value = prop.value;

          if (urn == null || value == null) continue;

          if (urn.label == 'IUPAC Name') {
            name = value.sval;
            if (name != null && name.isNotEmpty) break;
          }
        }
      }

      // Fallback for SMILES if Absolute/Connectivity is not available
      if (smiles == null || smiles.isEmpty) {
        for (final prop in props!) {
          final urn = prop.urn;
          final value = prop.value;

          if (urn == null || value == null) continue;

          if (urn.label == 'SMILES') {
            smiles = value.sval;
            if (smiles != null && smiles.isNotEmpty) break;
          }
        }
      }

      // Extract description from IUPAC Name if available
      for (final prop in props!) {
        final urn = prop.urn;
        final value = prop.value;

        if (urn == null || value == null) continue;

        if (urn.label == 'IUPAC Name' && value.sval != null) {
          description = value.sval;
          break;
        }
      }
    }

    // Validate required fields
    if (name == null || name.isEmpty) {
      throw FormatException('Compound name is missing');
    }
    if (molecularFormula == null || molecularFormula.isEmpty) {
      throw FormatException('Molecular formula is missing');
    }
    if (molecularWeightStr == null || molecularWeightStr.isEmpty) {
      throw FormatException('Molecular weight is missing');
    }
    if (smiles == null || smiles.isEmpty) {
      throw FormatException('SMILES is missing');
    }

    // Parse molecular weight
    final molecularWeight = double.tryParse(molecularWeightStr);
    if (molecularWeight == null) {
      throw FormatException('Invalid molecular weight: $molecularWeightStr');
    }

    return Compound(
      cid: cid,
      name: name,
      molecularFormula: molecularFormula,
      molecularWeight: molecularWeight,
      smiles: smiles,
      description: description,
    );
  }
}

@JsonSerializable()
class PCCompoundId {
  PCCompoundId({this.nestedId});

  factory PCCompoundId.fromJson(Map<String, dynamic> json) =>
      _$PCCompoundIdFromJson(json);
  @JsonKey(name: 'id')
  PCCompoundNestedId? nestedId;
}

@JsonSerializable()
class PCCompoundNestedId {
  PCCompoundNestedId({this.cid});

  factory PCCompoundNestedId.fromJson(Map<String, dynamic> json) =>
      _$PCCompoundNestedIdFromJson(json);
  int? cid;
}

@JsonSerializable()
class PCProperty {
  PCProperty({this.urn, this.value});

  factory PCProperty.fromJson(Map<String, dynamic> json) =>
      _$PCPropertyFromJson(json);
  PCUrn? urn;
  PCValue? value;
}

@JsonSerializable()
class PCUrn {
  PCUrn({
    this.label,
    this.name,
    this.datatype,
    this.version,
    this.software,
    this.source,
    this.release,
    this.implementation,
    this.parameters,
  });

  factory PCUrn.fromJson(Map<String, dynamic> json) => _$PCUrnFromJson(json);
  String? label;
  String? name;
  int? datatype;
  String? version;
  String? software;
  String? source;
  String? release;
  String? implementation;
  String? parameters;
}

@JsonSerializable()
class PCValue {
  PCValue({this.sval, this.ival, this.fval, this.binary});

  factory PCValue.fromJson(Map<String, dynamic> json) =>
      _$PCValueFromJson(json);
  @JsonKey(name: 'sval')
  String? sval;
  @JsonKey(name: 'ival')
  int? ival;
  @JsonKey(name: 'fval')
  double? fval;
  @JsonKey(name: 'binary')
  String? binary;
}
