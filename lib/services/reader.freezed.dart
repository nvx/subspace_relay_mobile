// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'reader.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$ReaderRelayState implements DiagnosticableTreeMixin {

 RelayId get relayId; IsoDepAndroid get tag;
/// Create a copy of ReaderRelayState
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ReaderRelayStateCopyWith<ReaderRelayState> get copyWith => _$ReaderRelayStateCopyWithImpl<ReaderRelayState>(this as ReaderRelayState, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ReaderRelayState'))
    ..add(DiagnosticsProperty('relayId', relayId))..add(DiagnosticsProperty('tag', tag));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is ReaderRelayState&&(identical(other.relayId, relayId) || other.relayId == relayId)&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,relayId,tag);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ReaderRelayState(relayId: $relayId, tag: $tag)';
}


}

/// @nodoc
abstract mixin class $ReaderRelayStateCopyWith<$Res>  {
  factory $ReaderRelayStateCopyWith(ReaderRelayState value, $Res Function(ReaderRelayState) _then) = _$ReaderRelayStateCopyWithImpl;
@useResult
$Res call({
 RelayId relayId, IsoDepAndroid tag
});


$RelayIdCopyWith<$Res> get relayId;

}
/// @nodoc
class _$ReaderRelayStateCopyWithImpl<$Res>
    implements $ReaderRelayStateCopyWith<$Res> {
  _$ReaderRelayStateCopyWithImpl(this._self, this._then);

  final ReaderRelayState _self;
  final $Res Function(ReaderRelayState) _then;

/// Create a copy of ReaderRelayState
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? relayId = null,Object? tag = null,}) {
  return _then(_self.copyWith(
relayId: null == relayId ? _self.relayId : relayId // ignore: cast_nullable_to_non_nullable
as RelayId,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as IsoDepAndroid,
  ));
}
/// Create a copy of ReaderRelayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RelayIdCopyWith<$Res> get relayId {
  
  return $RelayIdCopyWith<$Res>(_self.relayId, (value) {
    return _then(_self.copyWith(relayId: value));
  });
}
}


/// Adds pattern-matching-related methods to [ReaderRelayState].
extension ReaderRelayStatePatterns on ReaderRelayState {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _ReaderRelayState value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _ReaderRelayState() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _ReaderRelayState value)  $default,){
final _that = this;
switch (_that) {
case _ReaderRelayState():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _ReaderRelayState value)?  $default,){
final _that = this;
switch (_that) {
case _ReaderRelayState() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( RelayId relayId,  IsoDepAndroid tag)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _ReaderRelayState() when $default != null:
return $default(_that.relayId,_that.tag);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( RelayId relayId,  IsoDepAndroid tag)  $default,) {final _that = this;
switch (_that) {
case _ReaderRelayState():
return $default(_that.relayId,_that.tag);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( RelayId relayId,  IsoDepAndroid tag)?  $default,) {final _that = this;
switch (_that) {
case _ReaderRelayState() when $default != null:
return $default(_that.relayId,_that.tag);case _:
  return null;

}
}

}

/// @nodoc


class _ReaderRelayState with DiagnosticableTreeMixin implements ReaderRelayState {
  const _ReaderRelayState({required this.relayId, required this.tag});
  

@override final  RelayId relayId;
@override final  IsoDepAndroid tag;

/// Create a copy of ReaderRelayState
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ReaderRelayStateCopyWith<_ReaderRelayState> get copyWith => __$ReaderRelayStateCopyWithImpl<_ReaderRelayState>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'ReaderRelayState'))
    ..add(DiagnosticsProperty('relayId', relayId))..add(DiagnosticsProperty('tag', tag));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _ReaderRelayState&&(identical(other.relayId, relayId) || other.relayId == relayId)&&(identical(other.tag, tag) || other.tag == tag));
}


@override
int get hashCode => Object.hash(runtimeType,relayId,tag);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'ReaderRelayState(relayId: $relayId, tag: $tag)';
}


}

/// @nodoc
abstract mixin class _$ReaderRelayStateCopyWith<$Res> implements $ReaderRelayStateCopyWith<$Res> {
  factory _$ReaderRelayStateCopyWith(_ReaderRelayState value, $Res Function(_ReaderRelayState) _then) = __$ReaderRelayStateCopyWithImpl;
@override @useResult
$Res call({
 RelayId relayId, IsoDepAndroid tag
});


@override $RelayIdCopyWith<$Res> get relayId;

}
/// @nodoc
class __$ReaderRelayStateCopyWithImpl<$Res>
    implements _$ReaderRelayStateCopyWith<$Res> {
  __$ReaderRelayStateCopyWithImpl(this._self, this._then);

  final _ReaderRelayState _self;
  final $Res Function(_ReaderRelayState) _then;

/// Create a copy of ReaderRelayState
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? relayId = null,Object? tag = null,}) {
  return _then(_ReaderRelayState(
relayId: null == relayId ? _self.relayId : relayId // ignore: cast_nullable_to_non_nullable
as RelayId,tag: null == tag ? _self.tag : tag // ignore: cast_nullable_to_non_nullable
as IsoDepAndroid,
  ));
}

/// Create a copy of ReaderRelayState
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RelayIdCopyWith<$Res> get relayId {
  
  return $RelayIdCopyWith<$Res>(_self.relayId, (value) {
    return _then(_self.copyWith(relayId: value));
  });
}
}

// dart format on
