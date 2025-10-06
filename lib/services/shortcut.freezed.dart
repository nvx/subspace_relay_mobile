// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'shortcut.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Shortcut implements DiagnosticableTreeMixin {

 List<Uint8List> get capduHeader; List<Uint8List> get capduData; Uint8List get rapdu; bool get sendCapdu; RpcResponseMetadata? get rpcResponseMetadata; bool get persistReconnect; Set<int> get usedEphemeral; List<Shortcut> get ephemeralChildren; List<Shortcut> get persistentChildren;
/// Create a copy of Shortcut
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$ShortcutCopyWith<Shortcut> get copyWith => _$ShortcutCopyWithImpl<Shortcut>(this as Shortcut, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Shortcut'))
    ..add(DiagnosticsProperty('capduHeader', capduHeader))..add(DiagnosticsProperty('capduData', capduData))..add(DiagnosticsProperty('rapdu', rapdu))..add(DiagnosticsProperty('sendCapdu', sendCapdu))..add(DiagnosticsProperty('rpcResponseMetadata', rpcResponseMetadata))..add(DiagnosticsProperty('persistReconnect', persistReconnect))..add(DiagnosticsProperty('usedEphemeral', usedEphemeral))..add(DiagnosticsProperty('ephemeralChildren', ephemeralChildren))..add(DiagnosticsProperty('persistentChildren', persistentChildren));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Shortcut&&const DeepCollectionEquality().equals(other.capduHeader, capduHeader)&&const DeepCollectionEquality().equals(other.capduData, capduData)&&const DeepCollectionEquality().equals(other.rapdu, rapdu)&&(identical(other.sendCapdu, sendCapdu) || other.sendCapdu == sendCapdu)&&(identical(other.rpcResponseMetadata, rpcResponseMetadata) || other.rpcResponseMetadata == rpcResponseMetadata)&&(identical(other.persistReconnect, persistReconnect) || other.persistReconnect == persistReconnect)&&const DeepCollectionEquality().equals(other.usedEphemeral, usedEphemeral)&&const DeepCollectionEquality().equals(other.ephemeralChildren, ephemeralChildren)&&const DeepCollectionEquality().equals(other.persistentChildren, persistentChildren));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(capduHeader),const DeepCollectionEquality().hash(capduData),const DeepCollectionEquality().hash(rapdu),sendCapdu,rpcResponseMetadata,persistReconnect,const DeepCollectionEquality().hash(usedEphemeral),const DeepCollectionEquality().hash(ephemeralChildren),const DeepCollectionEquality().hash(persistentChildren));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Shortcut(capduHeader: $capduHeader, capduData: $capduData, rapdu: $rapdu, sendCapdu: $sendCapdu, rpcResponseMetadata: $rpcResponseMetadata, persistReconnect: $persistReconnect, usedEphemeral: $usedEphemeral, ephemeralChildren: $ephemeralChildren, persistentChildren: $persistentChildren)';
}


}

/// @nodoc
abstract mixin class $ShortcutCopyWith<$Res>  {
  factory $ShortcutCopyWith(Shortcut value, $Res Function(Shortcut) _then) = _$ShortcutCopyWithImpl;
@useResult
$Res call({
 List<Uint8List> capduHeader, List<Uint8List> capduData, Uint8List rapdu, bool sendCapdu, RpcResponseMetadata? rpcResponseMetadata, bool persistReconnect, Set<int> usedEphemeral, List<Shortcut> ephemeralChildren, List<Shortcut> persistentChildren
});


$RpcResponseMetadataCopyWith<$Res>? get rpcResponseMetadata;

}
/// @nodoc
class _$ShortcutCopyWithImpl<$Res>
    implements $ShortcutCopyWith<$Res> {
  _$ShortcutCopyWithImpl(this._self, this._then);

  final Shortcut _self;
  final $Res Function(Shortcut) _then;

/// Create a copy of Shortcut
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? capduHeader = null,Object? capduData = null,Object? rapdu = null,Object? sendCapdu = null,Object? rpcResponseMetadata = freezed,Object? persistReconnect = null,Object? usedEphemeral = null,Object? ephemeralChildren = null,Object? persistentChildren = null,}) {
  return _then(_self.copyWith(
capduHeader: null == capduHeader ? _self.capduHeader : capduHeader // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,capduData: null == capduData ? _self.capduData : capduData // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,rapdu: null == rapdu ? _self.rapdu : rapdu // ignore: cast_nullable_to_non_nullable
as Uint8List,sendCapdu: null == sendCapdu ? _self.sendCapdu : sendCapdu // ignore: cast_nullable_to_non_nullable
as bool,rpcResponseMetadata: freezed == rpcResponseMetadata ? _self.rpcResponseMetadata : rpcResponseMetadata // ignore: cast_nullable_to_non_nullable
as RpcResponseMetadata?,persistReconnect: null == persistReconnect ? _self.persistReconnect : persistReconnect // ignore: cast_nullable_to_non_nullable
as bool,usedEphemeral: null == usedEphemeral ? _self.usedEphemeral : usedEphemeral // ignore: cast_nullable_to_non_nullable
as Set<int>,ephemeralChildren: null == ephemeralChildren ? _self.ephemeralChildren : ephemeralChildren // ignore: cast_nullable_to_non_nullable
as List<Shortcut>,persistentChildren: null == persistentChildren ? _self.persistentChildren : persistentChildren // ignore: cast_nullable_to_non_nullable
as List<Shortcut>,
  ));
}
/// Create a copy of Shortcut
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RpcResponseMetadataCopyWith<$Res>? get rpcResponseMetadata {
    if (_self.rpcResponseMetadata == null) {
    return null;
  }

  return $RpcResponseMetadataCopyWith<$Res>(_self.rpcResponseMetadata!, (value) {
    return _then(_self.copyWith(rpcResponseMetadata: value));
  });
}
}


/// Adds pattern-matching-related methods to [Shortcut].
extension ShortcutPatterns on Shortcut {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Shortcut value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Shortcut() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Shortcut value)  $default,){
final _that = this;
switch (_that) {
case _Shortcut():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Shortcut value)?  $default,){
final _that = this;
switch (_that) {
case _Shortcut() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( List<Uint8List> capduHeader,  List<Uint8List> capduData,  Uint8List rapdu,  bool sendCapdu,  RpcResponseMetadata? rpcResponseMetadata,  bool persistReconnect,  Set<int> usedEphemeral,  List<Shortcut> ephemeralChildren,  List<Shortcut> persistentChildren)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Shortcut() when $default != null:
return $default(_that.capduHeader,_that.capduData,_that.rapdu,_that.sendCapdu,_that.rpcResponseMetadata,_that.persistReconnect,_that.usedEphemeral,_that.ephemeralChildren,_that.persistentChildren);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( List<Uint8List> capduHeader,  List<Uint8List> capduData,  Uint8List rapdu,  bool sendCapdu,  RpcResponseMetadata? rpcResponseMetadata,  bool persistReconnect,  Set<int> usedEphemeral,  List<Shortcut> ephemeralChildren,  List<Shortcut> persistentChildren)  $default,) {final _that = this;
switch (_that) {
case _Shortcut():
return $default(_that.capduHeader,_that.capduData,_that.rapdu,_that.sendCapdu,_that.rpcResponseMetadata,_that.persistReconnect,_that.usedEphemeral,_that.ephemeralChildren,_that.persistentChildren);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( List<Uint8List> capduHeader,  List<Uint8List> capduData,  Uint8List rapdu,  bool sendCapdu,  RpcResponseMetadata? rpcResponseMetadata,  bool persistReconnect,  Set<int> usedEphemeral,  List<Shortcut> ephemeralChildren,  List<Shortcut> persistentChildren)?  $default,) {final _that = this;
switch (_that) {
case _Shortcut() when $default != null:
return $default(_that.capduHeader,_that.capduData,_that.rapdu,_that.sendCapdu,_that.rpcResponseMetadata,_that.persistReconnect,_that.usedEphemeral,_that.ephemeralChildren,_that.persistentChildren);case _:
  return null;

}
}

}

/// @nodoc


class _Shortcut extends Shortcut with DiagnosticableTreeMixin {
  const _Shortcut({required this.capduHeader, required this.capduData, required this.rapdu, required this.sendCapdu, required this.rpcResponseMetadata, required this.persistReconnect, required this.usedEphemeral, required this.ephemeralChildren, required this.persistentChildren}): super._();
  

@override final  List<Uint8List> capduHeader;
@override final  List<Uint8List> capduData;
@override final  Uint8List rapdu;
@override final  bool sendCapdu;
@override final  RpcResponseMetadata? rpcResponseMetadata;
@override final  bool persistReconnect;
@override final  Set<int> usedEphemeral;
@override final  List<Shortcut> ephemeralChildren;
@override final  List<Shortcut> persistentChildren;

/// Create a copy of Shortcut
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$ShortcutCopyWith<_Shortcut> get copyWith => __$ShortcutCopyWithImpl<_Shortcut>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'Shortcut'))
    ..add(DiagnosticsProperty('capduHeader', capduHeader))..add(DiagnosticsProperty('capduData', capduData))..add(DiagnosticsProperty('rapdu', rapdu))..add(DiagnosticsProperty('sendCapdu', sendCapdu))..add(DiagnosticsProperty('rpcResponseMetadata', rpcResponseMetadata))..add(DiagnosticsProperty('persistReconnect', persistReconnect))..add(DiagnosticsProperty('usedEphemeral', usedEphemeral))..add(DiagnosticsProperty('ephemeralChildren', ephemeralChildren))..add(DiagnosticsProperty('persistentChildren', persistentChildren));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Shortcut&&const DeepCollectionEquality().equals(other.capduHeader, capduHeader)&&const DeepCollectionEquality().equals(other.capduData, capduData)&&const DeepCollectionEquality().equals(other.rapdu, rapdu)&&(identical(other.sendCapdu, sendCapdu) || other.sendCapdu == sendCapdu)&&(identical(other.rpcResponseMetadata, rpcResponseMetadata) || other.rpcResponseMetadata == rpcResponseMetadata)&&(identical(other.persistReconnect, persistReconnect) || other.persistReconnect == persistReconnect)&&const DeepCollectionEquality().equals(other.usedEphemeral, usedEphemeral)&&const DeepCollectionEquality().equals(other.ephemeralChildren, ephemeralChildren)&&const DeepCollectionEquality().equals(other.persistentChildren, persistentChildren));
}


@override
int get hashCode => Object.hash(runtimeType,const DeepCollectionEquality().hash(capduHeader),const DeepCollectionEquality().hash(capduData),const DeepCollectionEquality().hash(rapdu),sendCapdu,rpcResponseMetadata,persistReconnect,const DeepCollectionEquality().hash(usedEphemeral),const DeepCollectionEquality().hash(ephemeralChildren),const DeepCollectionEquality().hash(persistentChildren));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'Shortcut(capduHeader: $capduHeader, capduData: $capduData, rapdu: $rapdu, sendCapdu: $sendCapdu, rpcResponseMetadata: $rpcResponseMetadata, persistReconnect: $persistReconnect, usedEphemeral: $usedEphemeral, ephemeralChildren: $ephemeralChildren, persistentChildren: $persistentChildren)';
}


}

/// @nodoc
abstract mixin class _$ShortcutCopyWith<$Res> implements $ShortcutCopyWith<$Res> {
  factory _$ShortcutCopyWith(_Shortcut value, $Res Function(_Shortcut) _then) = __$ShortcutCopyWithImpl;
@override @useResult
$Res call({
 List<Uint8List> capduHeader, List<Uint8List> capduData, Uint8List rapdu, bool sendCapdu, RpcResponseMetadata? rpcResponseMetadata, bool persistReconnect, Set<int> usedEphemeral, List<Shortcut> ephemeralChildren, List<Shortcut> persistentChildren
});


@override $RpcResponseMetadataCopyWith<$Res>? get rpcResponseMetadata;

}
/// @nodoc
class __$ShortcutCopyWithImpl<$Res>
    implements _$ShortcutCopyWith<$Res> {
  __$ShortcutCopyWithImpl(this._self, this._then);

  final _Shortcut _self;
  final $Res Function(_Shortcut) _then;

/// Create a copy of Shortcut
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? capduHeader = null,Object? capduData = null,Object? rapdu = null,Object? sendCapdu = null,Object? rpcResponseMetadata = freezed,Object? persistReconnect = null,Object? usedEphemeral = null,Object? ephemeralChildren = null,Object? persistentChildren = null,}) {
  return _then(_Shortcut(
capduHeader: null == capduHeader ? _self.capduHeader : capduHeader // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,capduData: null == capduData ? _self.capduData : capduData // ignore: cast_nullable_to_non_nullable
as List<Uint8List>,rapdu: null == rapdu ? _self.rapdu : rapdu // ignore: cast_nullable_to_non_nullable
as Uint8List,sendCapdu: null == sendCapdu ? _self.sendCapdu : sendCapdu // ignore: cast_nullable_to_non_nullable
as bool,rpcResponseMetadata: freezed == rpcResponseMetadata ? _self.rpcResponseMetadata : rpcResponseMetadata // ignore: cast_nullable_to_non_nullable
as RpcResponseMetadata?,persistReconnect: null == persistReconnect ? _self.persistReconnect : persistReconnect // ignore: cast_nullable_to_non_nullable
as bool,usedEphemeral: null == usedEphemeral ? _self.usedEphemeral : usedEphemeral // ignore: cast_nullable_to_non_nullable
as Set<int>,ephemeralChildren: null == ephemeralChildren ? _self.ephemeralChildren : ephemeralChildren // ignore: cast_nullable_to_non_nullable
as List<Shortcut>,persistentChildren: null == persistentChildren ? _self.persistentChildren : persistentChildren // ignore: cast_nullable_to_non_nullable
as List<Shortcut>,
  ));
}

/// Create a copy of Shortcut
/// with the given fields replaced by the non-null parameter values.
@override
@pragma('vm:prefer-inline')
$RpcResponseMetadataCopyWith<$Res>? get rpcResponseMetadata {
    if (_self.rpcResponseMetadata == null) {
    return null;
  }

  return $RpcResponseMetadataCopyWith<$Res>(_self.rpcResponseMetadata!, (value) {
    return _then(_self.copyWith(rpcResponseMetadata: value));
  });
}
}

// dart format on
