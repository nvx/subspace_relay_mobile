// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'history.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;

/// @nodoc
mixin _$HistoryEntry {

 String get id; String get name; String get brokerUrl; String get discoveryPublicKey; String get relayId; ConnectionMode get mode; DateTime get timestamp; String get log;
/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$HistoryEntryCopyWith<HistoryEntry> get copyWith => _$HistoryEntryCopyWithImpl<HistoryEntry>(this as HistoryEntry, _$identity);

  /// Serializes this HistoryEntry to a JSON map.
  Map<String, dynamic> toJson();


@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is HistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brokerUrl, brokerUrl) || other.brokerUrl == brokerUrl)&&(identical(other.discoveryPublicKey, discoveryPublicKey) || other.discoveryPublicKey == discoveryPublicKey)&&(identical(other.relayId, relayId) || other.relayId == relayId)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.log, log) || other.log == log));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,brokerUrl,discoveryPublicKey,relayId,mode,timestamp,log);

@override
String toString() {
  return 'HistoryEntry(id: $id, name: $name, brokerUrl: $brokerUrl, discoveryPublicKey: $discoveryPublicKey, relayId: $relayId, mode: $mode, timestamp: $timestamp, log: $log)';
}


}

/// @nodoc
abstract mixin class $HistoryEntryCopyWith<$Res>  {
  factory $HistoryEntryCopyWith(HistoryEntry value, $Res Function(HistoryEntry) _then) = _$HistoryEntryCopyWithImpl;
@useResult
$Res call({
 String id, String name, String brokerUrl, String discoveryPublicKey, String relayId, ConnectionMode mode, DateTime timestamp, String log
});




}
/// @nodoc
class _$HistoryEntryCopyWithImpl<$Res>
    implements $HistoryEntryCopyWith<$Res> {
  _$HistoryEntryCopyWithImpl(this._self, this._then);

  final HistoryEntry _self;
  final $Res Function(HistoryEntry) _then;

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? id = null,Object? name = null,Object? brokerUrl = null,Object? discoveryPublicKey = null,Object? relayId = null,Object? mode = null,Object? timestamp = null,Object? log = null,}) {
  return _then(_self.copyWith(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brokerUrl: null == brokerUrl ? _self.brokerUrl : brokerUrl // ignore: cast_nullable_to_non_nullable
as String,discoveryPublicKey: null == discoveryPublicKey ? _self.discoveryPublicKey : discoveryPublicKey // ignore: cast_nullable_to_non_nullable
as String,relayId: null == relayId ? _self.relayId : relayId // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ConnectionMode,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,log: null == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as String,
  ));
}

}


/// Adds pattern-matching-related methods to [HistoryEntry].
extension HistoryEntryPatterns on HistoryEntry {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _HistoryEntry value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _HistoryEntry value)  $default,){
final _that = this;
switch (_that) {
case _HistoryEntry():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _HistoryEntry value)?  $default,){
final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String id,  String name,  String brokerUrl,  String discoveryPublicKey,  String relayId,  ConnectionMode mode,  DateTime timestamp,  String log)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
return $default(_that.id,_that.name,_that.brokerUrl,_that.discoveryPublicKey,_that.relayId,_that.mode,_that.timestamp,_that.log);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String id,  String name,  String brokerUrl,  String discoveryPublicKey,  String relayId,  ConnectionMode mode,  DateTime timestamp,  String log)  $default,) {final _that = this;
switch (_that) {
case _HistoryEntry():
return $default(_that.id,_that.name,_that.brokerUrl,_that.discoveryPublicKey,_that.relayId,_that.mode,_that.timestamp,_that.log);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String id,  String name,  String brokerUrl,  String discoveryPublicKey,  String relayId,  ConnectionMode mode,  DateTime timestamp,  String log)?  $default,) {final _that = this;
switch (_that) {
case _HistoryEntry() when $default != null:
return $default(_that.id,_that.name,_that.brokerUrl,_that.discoveryPublicKey,_that.relayId,_that.mode,_that.timestamp,_that.log);case _:
  return null;

}
}

}

/// @nodoc
@JsonSerializable()

class _HistoryEntry implements HistoryEntry {
  const _HistoryEntry({required this.id, required this.name, required this.brokerUrl, required this.discoveryPublicKey, required this.relayId, required this.mode, required this.timestamp, this.log = ''});
  factory _HistoryEntry.fromJson(Map<String, dynamic> json) => _$HistoryEntryFromJson(json);

@override final  String id;
@override final  String name;
@override final  String brokerUrl;
@override final  String discoveryPublicKey;
@override final  String relayId;
@override final  ConnectionMode mode;
@override final  DateTime timestamp;
@override@JsonKey() final  String log;

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$HistoryEntryCopyWith<_HistoryEntry> get copyWith => __$HistoryEntryCopyWithImpl<_HistoryEntry>(this, _$identity);

@override
Map<String, dynamic> toJson() {
  return _$HistoryEntryToJson(this, );
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _HistoryEntry&&(identical(other.id, id) || other.id == id)&&(identical(other.name, name) || other.name == name)&&(identical(other.brokerUrl, brokerUrl) || other.brokerUrl == brokerUrl)&&(identical(other.discoveryPublicKey, discoveryPublicKey) || other.discoveryPublicKey == discoveryPublicKey)&&(identical(other.relayId, relayId) || other.relayId == relayId)&&(identical(other.mode, mode) || other.mode == mode)&&(identical(other.timestamp, timestamp) || other.timestamp == timestamp)&&(identical(other.log, log) || other.log == log));
}

@JsonKey(includeFromJson: false, includeToJson: false)
@override
int get hashCode => Object.hash(runtimeType,id,name,brokerUrl,discoveryPublicKey,relayId,mode,timestamp,log);

@override
String toString() {
  return 'HistoryEntry(id: $id, name: $name, brokerUrl: $brokerUrl, discoveryPublicKey: $discoveryPublicKey, relayId: $relayId, mode: $mode, timestamp: $timestamp, log: $log)';
}


}

/// @nodoc
abstract mixin class _$HistoryEntryCopyWith<$Res> implements $HistoryEntryCopyWith<$Res> {
  factory _$HistoryEntryCopyWith(_HistoryEntry value, $Res Function(_HistoryEntry) _then) = __$HistoryEntryCopyWithImpl;
@override @useResult
$Res call({
 String id, String name, String brokerUrl, String discoveryPublicKey, String relayId, ConnectionMode mode, DateTime timestamp, String log
});




}
/// @nodoc
class __$HistoryEntryCopyWithImpl<$Res>
    implements _$HistoryEntryCopyWith<$Res> {
  __$HistoryEntryCopyWithImpl(this._self, this._then);

  final _HistoryEntry _self;
  final $Res Function(_HistoryEntry) _then;

/// Create a copy of HistoryEntry
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? id = null,Object? name = null,Object? brokerUrl = null,Object? discoveryPublicKey = null,Object? relayId = null,Object? mode = null,Object? timestamp = null,Object? log = null,}) {
  return _then(_HistoryEntry(
id: null == id ? _self.id : id // ignore: cast_nullable_to_non_nullable
as String,name: null == name ? _self.name : name // ignore: cast_nullable_to_non_nullable
as String,brokerUrl: null == brokerUrl ? _self.brokerUrl : brokerUrl // ignore: cast_nullable_to_non_nullable
as String,discoveryPublicKey: null == discoveryPublicKey ? _self.discoveryPublicKey : discoveryPublicKey // ignore: cast_nullable_to_non_nullable
as String,relayId: null == relayId ? _self.relayId : relayId // ignore: cast_nullable_to_non_nullable
as String,mode: null == mode ? _self.mode : mode // ignore: cast_nullable_to_non_nullable
as ConnectionMode,timestamp: null == timestamp ? _self.timestamp : timestamp // ignore: cast_nullable_to_non_nullable
as DateTime,log: null == log ? _self.log : log // ignore: cast_nullable_to_non_nullable
as String,
  ));
}


}

// dart format on
