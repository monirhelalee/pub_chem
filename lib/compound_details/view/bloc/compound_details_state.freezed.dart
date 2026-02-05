// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'compound_details_state.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$CompoundDetailsState {





@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompoundDetailsState);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompoundDetailsState()';
}


}

/// @nodoc
class $CompoundDetailsStateCopyWith<$Res>  {
$CompoundDetailsStateCopyWith(CompoundDetailsState _, $Res Function(CompoundDetailsState) __);
}


/// Adds pattern-matching-related methods to [CompoundDetailsState].
extension CompoundDetailsStatePatterns on CompoundDetailsState {
/// A variant of `map` that fallback to returning `orElse`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeMap<TResult extends Object?>({TResult Function( CompoundDetailsInitial value)?  initial,TResult Function( CompoundDetailsLoading value)?  loading,TResult Function( CompoundDetailsLoaded value)?  loaded,TResult Function( CompoundDetailsError value)?  error,required TResult orElse(),}){
final _that = this;
switch (_that) {
case CompoundDetailsInitial() when initial != null:
return initial(_that);case CompoundDetailsLoading() when loading != null:
return loading(_that);case CompoundDetailsLoaded() when loaded != null:
return loaded(_that);case CompoundDetailsError() when error != null:
return error(_that);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// Callbacks receives the raw object, upcasted.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case final Subclass2 value:
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult map<TResult extends Object?>({required TResult Function( CompoundDetailsInitial value)  initial,required TResult Function( CompoundDetailsLoading value)  loading,required TResult Function( CompoundDetailsLoaded value)  loaded,required TResult Function( CompoundDetailsError value)  error,}){
final _that = this;
switch (_that) {
case CompoundDetailsInitial():
return initial(_that);case CompoundDetailsLoading():
return loading(_that);case CompoundDetailsLoaded():
return loaded(_that);case CompoundDetailsError():
return error(_that);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `map` that fallback to returning `null`.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case final Subclass value:
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>({TResult? Function( CompoundDetailsInitial value)?  initial,TResult? Function( CompoundDetailsLoading value)?  loading,TResult? Function( CompoundDetailsLoaded value)?  loaded,TResult? Function( CompoundDetailsError value)?  error,}){
final _that = this;
switch (_that) {
case CompoundDetailsInitial() when initial != null:
return initial(_that);case CompoundDetailsLoading() when loading != null:
return loading(_that);case CompoundDetailsLoaded() when loaded != null:
return loaded(_that);case CompoundDetailsError() when error != null:
return error(_that);case _:
  return null;

}
}
/// A variant of `when` that fallback to an `orElse` callback.
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return orElse();
/// }
/// ```

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>({TResult Function()?  initial,TResult Function()?  loading,TResult Function( Compound compound)?  loaded,TResult Function( String message)?  error,required TResult orElse(),}) {final _that = this;
switch (_that) {
case CompoundDetailsInitial() when initial != null:
return initial();case CompoundDetailsLoading() when loading != null:
return loading();case CompoundDetailsLoaded() when loaded != null:
return loaded(_that.compound);case CompoundDetailsError() when error != null:
return error(_that.message);case _:
  return orElse();

}
}
/// A `switch`-like method, using callbacks.
///
/// As opposed to `map`, this offers destructuring.
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case Subclass2(:final field2):
///     return ...;
/// }
/// ```

@optionalTypeArgs TResult when<TResult extends Object?>({required TResult Function()  initial,required TResult Function()  loading,required TResult Function( Compound compound)  loaded,required TResult Function( String message)  error,}) {final _that = this;
switch (_that) {
case CompoundDetailsInitial():
return initial();case CompoundDetailsLoading():
return loading();case CompoundDetailsLoaded():
return loaded(_that.compound);case CompoundDetailsError():
return error(_that.message);case _:
  throw StateError('Unexpected subclass');

}
}
/// A variant of `when` that fallback to returning `null`
///
/// It is equivalent to doing:
/// ```dart
/// switch (sealedClass) {
///   case Subclass(:final field):
///     return ...;
///   case _:
///     return null;
/// }
/// ```

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>({TResult? Function()?  initial,TResult? Function()?  loading,TResult? Function( Compound compound)?  loaded,TResult? Function( String message)?  error,}) {final _that = this;
switch (_that) {
case CompoundDetailsInitial() when initial != null:
return initial();case CompoundDetailsLoading() when loading != null:
return loading();case CompoundDetailsLoaded() when loaded != null:
return loaded(_that.compound);case CompoundDetailsError() when error != null:
return error(_that.message);case _:
  return null;

}
}

}

/// @nodoc


class CompoundDetailsInitial implements CompoundDetailsState {
  const CompoundDetailsInitial();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompoundDetailsInitial);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompoundDetailsState.initial()';
}


}




/// @nodoc


class CompoundDetailsLoading implements CompoundDetailsState {
  const CompoundDetailsLoading();
  






@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompoundDetailsLoading);
}


@override
int get hashCode => runtimeType.hashCode;

@override
String toString() {
  return 'CompoundDetailsState.loading()';
}


}




/// @nodoc


class CompoundDetailsLoaded implements CompoundDetailsState {
  const CompoundDetailsLoaded({required this.compound});
  

 final  Compound compound;

/// Create a copy of CompoundDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompoundDetailsLoadedCopyWith<CompoundDetailsLoaded> get copyWith => _$CompoundDetailsLoadedCopyWithImpl<CompoundDetailsLoaded>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompoundDetailsLoaded&&(identical(other.compound, compound) || other.compound == compound));
}


@override
int get hashCode => Object.hash(runtimeType,compound);

@override
String toString() {
  return 'CompoundDetailsState.loaded(compound: $compound)';
}


}

/// @nodoc
abstract mixin class $CompoundDetailsLoadedCopyWith<$Res> implements $CompoundDetailsStateCopyWith<$Res> {
  factory $CompoundDetailsLoadedCopyWith(CompoundDetailsLoaded value, $Res Function(CompoundDetailsLoaded) _then) = _$CompoundDetailsLoadedCopyWithImpl;
@useResult
$Res call({
 Compound compound
});


$CompoundCopyWith<$Res> get compound;

}
/// @nodoc
class _$CompoundDetailsLoadedCopyWithImpl<$Res>
    implements $CompoundDetailsLoadedCopyWith<$Res> {
  _$CompoundDetailsLoadedCopyWithImpl(this._self, this._then);

  final CompoundDetailsLoaded _self;
  final $Res Function(CompoundDetailsLoaded) _then;

/// Create a copy of CompoundDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? compound = null,}) {
  return _then(CompoundDetailsLoaded(
compound: null == compound ? _self.compound : compound // ignore: cast_nullable_to_non_nullable
as Compound,
  ));
}

/// Create a copy of CompoundDetailsState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$CompoundCopyWith<$Res> get compound {
  
  return $CompoundCopyWith<$Res>(_self.compound, (value) {
    return _then(_self.copyWith(compound: value));
  });
}
}

/// @nodoc


class CompoundDetailsError implements CompoundDetailsState {
  const CompoundDetailsError({required this.message});
  

 final  String message;

/// Create a copy of CompoundDetailsState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CompoundDetailsErrorCopyWith<CompoundDetailsError> get copyWith => _$CompoundDetailsErrorCopyWithImpl<CompoundDetailsError>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is CompoundDetailsError&&(identical(other.message, message) || other.message == message));
}


@override
int get hashCode => Object.hash(runtimeType,message);

@override
String toString() {
  return 'CompoundDetailsState.error(message: $message)';
}


}

/// @nodoc
abstract mixin class $CompoundDetailsErrorCopyWith<$Res> implements $CompoundDetailsStateCopyWith<$Res> {
  factory $CompoundDetailsErrorCopyWith(CompoundDetailsError value, $Res Function(CompoundDetailsError) _then) = _$CompoundDetailsErrorCopyWithImpl;
@useResult
$Res call({
 String message
});




}
/// @nodoc
class _$CompoundDetailsErrorCopyWithImpl<$Res>
    implements $CompoundDetailsErrorCopyWith<$Res> {
  _$CompoundDetailsErrorCopyWithImpl(this._self, this._then);

  final CompoundDetailsError _self;
  final $Res Function(CompoundDetailsError) _then;

/// Create a copy of CompoundDetailsState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') $Res call({Object? message = null,}) {
  return _then(CompoundDetailsError(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
