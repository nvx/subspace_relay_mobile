// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'relay_id.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RelayId {

 String get relayId; String get mqttClientId; SecretKey get cryptoKey;
/// Create a copy of RelayId
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelayIdCopyWith<RelayId> get copyWith => _$RelayIdCopyWithImpl<RelayId>(this as RelayId, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelayId&&(identical(other.relayId, relayId) || other.relayId == relayId)&&(identical(other.mqttClientId, mqttClientId) || other.mqttClientId == mqttClientId)&&(identical(other.cryptoKey, cryptoKey) || other.cryptoKey == cryptoKey));
}


@override
int get hashCode => Object.hash(runtimeType,relayId,mqttClientId,cryptoKey);

@override
String toString() {
  return 'RelayId(relayId: $relayId, mqttClientId: $mqttClientId, cryptoKey: $cryptoKey)';
}


}

/// @nodoc
abstract mixin class $RelayIdCopyWith<$Res>  {
  factory $RelayIdCopyWith(RelayId value, $Res Function(RelayId) _then) = _$RelayIdCopyWithImpl;
@useResult
$Res call({
 String relayId, String mqttClientId, SecretKey cryptoKey
});




}
/// @nodoc
class _$RelayIdCopyWithImpl<$Res>
    implements $RelayIdCopyWith<$Res> {
  _$RelayIdCopyWithImpl(this._self, this._then);

  final RelayId _self;
  final $Res Function(RelayId) _then;

/// Create a copy of RelayId
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? relayId = null,Object? mqttClientId = null,Object? cryptoKey = null,}) {
  return _then(_self.copyWith(
relayId: null == relayId ? _self.relayId : relayId // ignore: cast_nullable_to_non_nullable
as String,mqttClientId: null == mqttClientId ? _self.mqttClientId : mqttClientId // ignore: cast_nullable_to_non_nullable
as String,cryptoKey: null == cryptoKey ? _self.cryptoKey : cryptoKey // ignore: cast_nullable_to_non_nullable
as SecretKey,
  ));
}

}


/// Adds pattern-matching-related methods to [RelayId].
extension RelayIdPatterns on RelayId {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelayId value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelayId() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelayId value)  $default,){
final _that = this;
switch (_that) {
case _RelayId():
return $default(_that);}
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelayId value)?  $default,){
final _that = this;
switch (_that) {
case _RelayId() when $default != null:
return $default(_that);case _:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String relayId,  String mqttClientId,  SecretKey cryptoKey)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelayId() when $default != null:
return $default(_that.relayId,_that.mqttClientId,_that.cryptoKey);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String relayId,  String mqttClientId,  SecretKey cryptoKey)  $default,) {final _that = this;
switch (_that) {
case _RelayId():
return $default(_that.relayId,_that.mqttClientId,_that.cryptoKey);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String relayId,  String mqttClientId,  SecretKey cryptoKey)?  $default,) {final _that = this;
switch (_that) {
case _RelayId() when $default != null:
return $default(_that.relayId,_that.mqttClientId,_that.cryptoKey);case _:
  return null;

}
}

}

/// @nodoc


class _RelayId implements RelayId {
   _RelayId({required this.relayId, required this.mqttClientId, required this.cryptoKey});
  

@override final  String relayId;
@override final  String mqttClientId;
@override final  SecretKey cryptoKey;

/// Create a copy of RelayId
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelayIdCopyWith<_RelayId> get copyWith => __$RelayIdCopyWithImpl<_RelayId>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelayId&&(identical(other.relayId, relayId) || other.relayId == relayId)&&(identical(other.mqttClientId, mqttClientId) || other.mqttClientId == mqttClientId)&&(identical(other.cryptoKey, cryptoKey) || other.cryptoKey == cryptoKey));
}


@override
int get hashCode => Object.hash(runtimeType,relayId,mqttClientId,cryptoKey);

@override
String toString() {
  return 'RelayId(relayId: $relayId, mqttClientId: $mqttClientId, cryptoKey: $cryptoKey)';
}


}

/// @nodoc
abstract mixin class _$RelayIdCopyWith<$Res> implements $RelayIdCopyWith<$Res> {
  factory _$RelayIdCopyWith(_RelayId value, $Res Function(_RelayId) _then) = __$RelayIdCopyWithImpl;
@override @useResult
$Res call({
 String relayId, String mqttClientId, SecretKey cryptoKey
});




}
/// @nodoc
class __$RelayIdCopyWithImpl<$Res>
    implements _$RelayIdCopyWith<$Res> {
  __$RelayIdCopyWithImpl(this._self, this._then);

  final _RelayId _self;
  final $Res Function(_RelayId) _then;

/// Create a copy of RelayId
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? relayId = null,Object? mqttClientId = null,Object? cryptoKey = null,}) {
  return _then(_RelayId(
relayId: null == relayId ? _self.relayId : relayId // ignore: cast_nullable_to_non_nullable
as String,mqttClientId: null == mqttClientId ? _self.mqttClientId : mqttClientId // ignore: cast_nullable_to_non_nullable
as String,cryptoKey: null == cryptoKey ? _self.cryptoKey : cryptoKey // ignore: cast_nullable_to_non_nullable
as SecretKey,
  ));
}


}

// dart format on
