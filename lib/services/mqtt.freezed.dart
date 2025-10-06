// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'mqtt.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$RelayMessage implements DiagnosticableTreeMixin {

 $pb.Message get message; RpcResponseMetadata? get rpcResponseMetadata;
/// Create a copy of RelayMessage
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RelayMessageCopyWith<RelayMessage> get copyWith => _$RelayMessageCopyWithImpl<RelayMessage>(this as RelayMessage, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RelayMessage'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('rpcResponseMetadata', rpcResponseMetadata));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RelayMessage&&(identical(other.message, message) || other.message == message)&&(identical(other.rpcResponseMetadata, rpcResponseMetadata) || other.rpcResponseMetadata == rpcResponseMetadata));
}


@override
int get hashCode => Object.hash(runtimeType,message,rpcResponseMetadata);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RelayMessage(message: $message, rpcResponseMetadata: $rpcResponseMetadata)';
}


}

/// @nodoc
abstract mixin class $RelayMessageCopyWith<$Res>  {
  factory $RelayMessageCopyWith(RelayMessage value, $Res Function(RelayMessage) _then) = _$RelayMessageCopyWithImpl;
@useResult
$Res call({
 $pb.Message message, RpcResponseMetadata? rpcResponseMetadata
});


$RpcResponseMetadataCopyWith<$Res>? get rpcResponseMetadata;

}
/// @nodoc
class _$RelayMessageCopyWithImpl<$Res>
    implements $RelayMessageCopyWith<$Res> {
  _$RelayMessageCopyWithImpl(this._self, this._then);

  final RelayMessage _self;
  final $Res Function(RelayMessage) _then;

/// Create a copy of RelayMessage
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? message = null,Object? rpcResponseMetadata = freezed,}) {
  return _then(_self.copyWith(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as $pb.Message,rpcResponseMetadata: freezed == rpcResponseMetadata ? _self.rpcResponseMetadata : rpcResponseMetadata // ignore: cast_nullable_to_non_nullable
as RpcResponseMetadata?,
  ));
}
/// Create a copy of RelayMessage
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


/// Adds pattern-matching-related methods to [RelayMessage].
extension RelayMessagePatterns on RelayMessage {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RelayMessage value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RelayMessage() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RelayMessage value)  $default,){
final _that = this;
switch (_that) {
case _RelayMessage():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RelayMessage value)?  $default,){
final _that = this;
switch (_that) {
case _RelayMessage() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( $pb.Message message,  RpcResponseMetadata? rpcResponseMetadata)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RelayMessage() when $default != null:
return $default(_that.message,_that.rpcResponseMetadata);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( $pb.Message message,  RpcResponseMetadata? rpcResponseMetadata)  $default,) {final _that = this;
switch (_that) {
case _RelayMessage():
return $default(_that.message,_that.rpcResponseMetadata);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( $pb.Message message,  RpcResponseMetadata? rpcResponseMetadata)?  $default,) {final _that = this;
switch (_that) {
case _RelayMessage() when $default != null:
return $default(_that.message,_that.rpcResponseMetadata);case _:
  return null;

}
}

}

/// @nodoc


class _RelayMessage with DiagnosticableTreeMixin implements RelayMessage {
  const _RelayMessage({required this.message, required this.rpcResponseMetadata});
  

@override final  $pb.Message message;
@override final  RpcResponseMetadata? rpcResponseMetadata;

/// Create a copy of RelayMessage
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RelayMessageCopyWith<_RelayMessage> get copyWith => __$RelayMessageCopyWithImpl<_RelayMessage>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RelayMessage'))
    ..add(DiagnosticsProperty('message', message))..add(DiagnosticsProperty('rpcResponseMetadata', rpcResponseMetadata));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RelayMessage&&(identical(other.message, message) || other.message == message)&&(identical(other.rpcResponseMetadata, rpcResponseMetadata) || other.rpcResponseMetadata == rpcResponseMetadata));
}


@override
int get hashCode => Object.hash(runtimeType,message,rpcResponseMetadata);

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RelayMessage(message: $message, rpcResponseMetadata: $rpcResponseMetadata)';
}


}

/// @nodoc
abstract mixin class _$RelayMessageCopyWith<$Res> implements $RelayMessageCopyWith<$Res> {
  factory _$RelayMessageCopyWith(_RelayMessage value, $Res Function(_RelayMessage) _then) = __$RelayMessageCopyWithImpl;
@override @useResult
$Res call({
 $pb.Message message, RpcResponseMetadata? rpcResponseMetadata
});


@override $RpcResponseMetadataCopyWith<$Res>? get rpcResponseMetadata;

}
/// @nodoc
class __$RelayMessageCopyWithImpl<$Res>
    implements _$RelayMessageCopyWith<$Res> {
  __$RelayMessageCopyWithImpl(this._self, this._then);

  final _RelayMessage _self;
  final $Res Function(_RelayMessage) _then;

/// Create a copy of RelayMessage
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? message = null,Object? rpcResponseMetadata = freezed,}) {
  return _then(_RelayMessage(
message: null == message ? _self.message : message // ignore: cast_nullable_to_non_nullable
as $pb.Message,rpcResponseMetadata: freezed == rpcResponseMetadata ? _self.rpcResponseMetadata : rpcResponseMetadata // ignore: cast_nullable_to_non_nullable
as RpcResponseMetadata?,
  ));
}

/// Create a copy of RelayMessage
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

/// @nodoc
mixin _$RpcResponseMetadata implements DiagnosticableTreeMixin {

 String? get responseTopic; Uint8Buffer? get correlationData;
/// Create a copy of RpcResponseMetadata
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$RpcResponseMetadataCopyWith<RpcResponseMetadata> get copyWith => _$RpcResponseMetadataCopyWithImpl<RpcResponseMetadata>(this as RpcResponseMetadata, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RpcResponseMetadata'))
    ..add(DiagnosticsProperty('responseTopic', responseTopic))..add(DiagnosticsProperty('correlationData', correlationData));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is RpcResponseMetadata&&(identical(other.responseTopic, responseTopic) || other.responseTopic == responseTopic)&&const DeepCollectionEquality().equals(other.correlationData, correlationData));
}


@override
int get hashCode => Object.hash(runtimeType,responseTopic,const DeepCollectionEquality().hash(correlationData));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RpcResponseMetadata(responseTopic: $responseTopic, correlationData: $correlationData)';
}


}

/// @nodoc
abstract mixin class $RpcResponseMetadataCopyWith<$Res>  {
  factory $RpcResponseMetadataCopyWith(RpcResponseMetadata value, $Res Function(RpcResponseMetadata) _then) = _$RpcResponseMetadataCopyWithImpl;
@useResult
$Res call({
 String? responseTopic, Uint8Buffer? correlationData
});




}
/// @nodoc
class _$RpcResponseMetadataCopyWithImpl<$Res>
    implements $RpcResponseMetadataCopyWith<$Res> {
  _$RpcResponseMetadataCopyWithImpl(this._self, this._then);

  final RpcResponseMetadata _self;
  final $Res Function(RpcResponseMetadata) _then;

/// Create a copy of RpcResponseMetadata
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? responseTopic = freezed,Object? correlationData = freezed,}) {
  return _then(_self.copyWith(
responseTopic: freezed == responseTopic ? _self.responseTopic : responseTopic // ignore: cast_nullable_to_non_nullable
as String?,correlationData: freezed == correlationData ? _self.correlationData : correlationData // ignore: cast_nullable_to_non_nullable
as Uint8Buffer?,
  ));
}

}


/// Adds pattern-matching-related methods to [RpcResponseMetadata].
extension RpcResponseMetadataPatterns on RpcResponseMetadata {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _RpcResponseMetadata value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _RpcResponseMetadata() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _RpcResponseMetadata value)  $default,){
final _that = this;
switch (_that) {
case _RpcResponseMetadata():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _RpcResponseMetadata value)?  $default,){
final _that = this;
switch (_that) {
case _RpcResponseMetadata() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( String? responseTopic,  Uint8Buffer? correlationData)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _RpcResponseMetadata() when $default != null:
return $default(_that.responseTopic,_that.correlationData);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( String? responseTopic,  Uint8Buffer? correlationData)  $default,) {final _that = this;
switch (_that) {
case _RpcResponseMetadata():
return $default(_that.responseTopic,_that.correlationData);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( String? responseTopic,  Uint8Buffer? correlationData)?  $default,) {final _that = this;
switch (_that) {
case _RpcResponseMetadata() when $default != null:
return $default(_that.responseTopic,_that.correlationData);case _:
  return null;

}
}

}

/// @nodoc


class _RpcResponseMetadata with DiagnosticableTreeMixin implements RpcResponseMetadata {
  const _RpcResponseMetadata({required this.responseTopic, required this.correlationData});
  

@override final  String? responseTopic;
@override final  Uint8Buffer? correlationData;

/// Create a copy of RpcResponseMetadata
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$RpcResponseMetadataCopyWith<_RpcResponseMetadata> get copyWith => __$RpcResponseMetadataCopyWithImpl<_RpcResponseMetadata>(this, _$identity);


@override
void debugFillProperties(DiagnosticPropertiesBuilder properties) {
  properties
    ..add(DiagnosticsProperty('type', 'RpcResponseMetadata'))
    ..add(DiagnosticsProperty('responseTopic', responseTopic))..add(DiagnosticsProperty('correlationData', correlationData));
}

@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _RpcResponseMetadata&&(identical(other.responseTopic, responseTopic) || other.responseTopic == responseTopic)&&const DeepCollectionEquality().equals(other.correlationData, correlationData));
}


@override
int get hashCode => Object.hash(runtimeType,responseTopic,const DeepCollectionEquality().hash(correlationData));

@override
String toString({ DiagnosticLevel minLevel = DiagnosticLevel.info }) {
  return 'RpcResponseMetadata(responseTopic: $responseTopic, correlationData: $correlationData)';
}


}

/// @nodoc
abstract mixin class _$RpcResponseMetadataCopyWith<$Res> implements $RpcResponseMetadataCopyWith<$Res> {
  factory _$RpcResponseMetadataCopyWith(_RpcResponseMetadata value, $Res Function(_RpcResponseMetadata) _then) = __$RpcResponseMetadataCopyWithImpl;
@override @useResult
$Res call({
 String? responseTopic, Uint8Buffer? correlationData
});




}
/// @nodoc
class __$RpcResponseMetadataCopyWithImpl<$Res>
    implements _$RpcResponseMetadataCopyWith<$Res> {
  __$RpcResponseMetadataCopyWithImpl(this._self, this._then);

  final _RpcResponseMetadata _self;
  final $Res Function(_RpcResponseMetadata) _then;

/// Create a copy of RpcResponseMetadata
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? responseTopic = freezed,Object? correlationData = freezed,}) {
  return _then(_RpcResponseMetadata(
responseTopic: freezed == responseTopic ? _self.responseTopic : responseTopic // ignore: cast_nullable_to_non_nullable
as String?,correlationData: freezed == correlationData ? _self.correlationData : correlationData // ignore: cast_nullable_to_non_nullable
as Uint8Buffer?,
  ));
}


}

// dart format on
