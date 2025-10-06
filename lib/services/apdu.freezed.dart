// GENERATED CODE - DO NOT MODIFY BY HAND
// coverage:ignore-file
// ignore_for_file: type=lint
// ignore_for_file: unused_element, deprecated_member_use, deprecated_member_use_from_same_package, use_function_type_syntax_for_parameters, unnecessary_const, avoid_init_to_null, invalid_override_different_default_values_named, prefer_expression_function_bodies, annotate_overrides, invalid_annotation_target, unnecessary_question_mark

part of 'apdu.dart';

// **************************************************************************
// FreezedGenerator
// **************************************************************************

// dart format off
T _$identity<T>(T value) => value;
/// @nodoc
mixin _$Capdu {

 int get cla; int get ins; int get p1; int get p2; Uint8List get data;
/// Create a copy of Capdu
/// with the given fields replaced by the non-null parameter values.
@JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
$CapduCopyWith<Capdu> get copyWith => _$CapduCopyWithImpl<Capdu>(this as Capdu, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is Capdu&&(identical(other.cla, cla) || other.cla == cla)&&(identical(other.ins, ins) || other.ins == ins)&&(identical(other.p1, p1) || other.p1 == p1)&&(identical(other.p2, p2) || other.p2 == p2)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,cla,ins,p1,p2,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'Capdu(cla: $cla, ins: $ins, p1: $p1, p2: $p2, data: $data)';
}


}

/// @nodoc
abstract mixin class $CapduCopyWith<$Res>  {
  factory $CapduCopyWith(Capdu value, $Res Function(Capdu) _then) = _$CapduCopyWithImpl;
@useResult
$Res call({
 int cla, int ins, int p1, int p2, Uint8List data
});




}
/// @nodoc
class _$CapduCopyWithImpl<$Res>
    implements $CapduCopyWith<$Res> {
  _$CapduCopyWithImpl(this._self, this._then);

  final Capdu _self;
  final $Res Function(Capdu) _then;

/// Create a copy of Capdu
/// with the given fields replaced by the non-null parameter values.
@pragma('vm:prefer-inline') @override $Res call({Object? cla = null,Object? ins = null,Object? p1 = null,Object? p2 = null,Object? data = null,}) {
  return _then(_self.copyWith(
cla: null == cla ? _self.cla : cla // ignore: cast_nullable_to_non_nullable
as int,ins: null == ins ? _self.ins : ins // ignore: cast_nullable_to_non_nullable
as int,p1: null == p1 ? _self.p1 : p1 // ignore: cast_nullable_to_non_nullable
as int,p2: null == p2 ? _self.p2 : p2 // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}

}


/// Adds pattern-matching-related methods to [Capdu].
extension CapduPatterns on Capdu {
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

@optionalTypeArgs TResult maybeMap<TResult extends Object?>(TResult Function( _Capdu value)?  $default,{required TResult orElse(),}){
final _that = this;
switch (_that) {
case _Capdu() when $default != null:
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

@optionalTypeArgs TResult map<TResult extends Object?>(TResult Function( _Capdu value)  $default,){
final _that = this;
switch (_that) {
case _Capdu():
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

@optionalTypeArgs TResult? mapOrNull<TResult extends Object?>(TResult? Function( _Capdu value)?  $default,){
final _that = this;
switch (_that) {
case _Capdu() when $default != null:
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

@optionalTypeArgs TResult maybeWhen<TResult extends Object?>(TResult Function( int cla,  int ins,  int p1,  int p2,  Uint8List data)?  $default,{required TResult orElse(),}) {final _that = this;
switch (_that) {
case _Capdu() when $default != null:
return $default(_that.cla,_that.ins,_that.p1,_that.p2,_that.data);case _:
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

@optionalTypeArgs TResult when<TResult extends Object?>(TResult Function( int cla,  int ins,  int p1,  int p2,  Uint8List data)  $default,) {final _that = this;
switch (_that) {
case _Capdu():
return $default(_that.cla,_that.ins,_that.p1,_that.p2,_that.data);}
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

@optionalTypeArgs TResult? whenOrNull<TResult extends Object?>(TResult? Function( int cla,  int ins,  int p1,  int p2,  Uint8List data)?  $default,) {final _that = this;
switch (_that) {
case _Capdu() when $default != null:
return $default(_that.cla,_that.ins,_that.p1,_that.p2,_that.data);case _:
  return null;

}
}

}

/// @nodoc


class _Capdu implements Capdu {
  const _Capdu({required this.cla, required this.ins, required this.p1, required this.p2, required this.data});
  

@override final  int cla;
@override final  int ins;
@override final  int p1;
@override final  int p2;
@override final  Uint8List data;

/// Create a copy of Capdu
/// with the given fields replaced by the non-null parameter values.
@override @JsonKey(includeFromJson: false, includeToJson: false)
@pragma('vm:prefer-inline')
_$CapduCopyWith<_Capdu> get copyWith => __$CapduCopyWithImpl<_Capdu>(this, _$identity);



@override
bool operator ==(Object other) {
  return identical(this, other) || (other.runtimeType == runtimeType&&other is _Capdu&&(identical(other.cla, cla) || other.cla == cla)&&(identical(other.ins, ins) || other.ins == ins)&&(identical(other.p1, p1) || other.p1 == p1)&&(identical(other.p2, p2) || other.p2 == p2)&&const DeepCollectionEquality().equals(other.data, data));
}


@override
int get hashCode => Object.hash(runtimeType,cla,ins,p1,p2,const DeepCollectionEquality().hash(data));

@override
String toString() {
  return 'Capdu(cla: $cla, ins: $ins, p1: $p1, p2: $p2, data: $data)';
}


}

/// @nodoc
abstract mixin class _$CapduCopyWith<$Res> implements $CapduCopyWith<$Res> {
  factory _$CapduCopyWith(_Capdu value, $Res Function(_Capdu) _then) = __$CapduCopyWithImpl;
@override @useResult
$Res call({
 int cla, int ins, int p1, int p2, Uint8List data
});




}
/// @nodoc
class __$CapduCopyWithImpl<$Res>
    implements _$CapduCopyWith<$Res> {
  __$CapduCopyWithImpl(this._self, this._then);

  final _Capdu _self;
  final $Res Function(_Capdu) _then;

/// Create a copy of Capdu
/// with the given fields replaced by the non-null parameter values.
@override @pragma('vm:prefer-inline') $Res call({Object? cla = null,Object? ins = null,Object? p1 = null,Object? p2 = null,Object? data = null,}) {
  return _then(_Capdu(
cla: null == cla ? _self.cla : cla // ignore: cast_nullable_to_non_nullable
as int,ins: null == ins ? _self.ins : ins // ignore: cast_nullable_to_non_nullable
as int,p1: null == p1 ? _self.p1 : p1 // ignore: cast_nullable_to_non_nullable
as int,p2: null == p2 ? _self.p2 : p2 // ignore: cast_nullable_to_non_nullable
as int,data: null == data ? _self.data : data // ignore: cast_nullable_to_non_nullable
as Uint8List,
  ));
}


}

// dart format on
