// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'favorites.dart';

// **************************************************************************
// JsonSerializableGenerator
// **************************************************************************

_Favorite _$FavoriteFromJson(Map<String, dynamic> json) => _Favorite(
  id: json['id'] as String,
  name: json['name'] as String,
  brokerUrl: json['brokerUrl'] as String,
  discoveryPublicKey: json['discoveryPublicKey'] as String? ?? '',
);

Map<String, dynamic> _$FavoriteToJson(_Favorite instance) => <String, dynamic>{
  'id': instance.id,
  'name': instance.name,
  'brokerUrl': instance.brokerUrl,
  'discoveryPublicKey': instance.discoveryPublicKey,
};

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

// GENERATED CODE - DO NOT MODIFY BY HAND
// ignore_for_file: type=lint, type=warning

@ProviderFor(FavoritesList)
final favoritesListProvider = FavoritesListProvider._();

final class FavoritesListProvider
    extends $AsyncNotifierProvider<FavoritesList, List<Favorite>> {
  FavoritesListProvider._()
    : super(
        from: null,
        argument: null,
        retry: null,
        name: r'favoritesListProvider',
        isAutoDispose: true,
        dependencies: null,
        $allTransitiveDependencies: null,
      );

  @override
  String debugGetCreateSourceHash() => _$favoritesListHash();

  @$internal
  @override
  FavoritesList create() => FavoritesList();
}

String _$favoritesListHash() => r'd1b0cd4bc782e341a912efac45db86baf869f94e';

abstract class _$FavoritesList extends $AsyncNotifier<List<Favorite>> {
  FutureOr<List<Favorite>> build();
  @$mustCallSuper
  @override
  void runBuild() {
    final ref = this.ref as $Ref<AsyncValue<List<Favorite>>, List<Favorite>>;
    final element =
        ref.element
            as $ClassProviderElement<
              AnyNotifier<AsyncValue<List<Favorite>>, List<Favorite>>,
              AsyncValue<List<Favorite>>,
              Object?,
              Object?
            >;
    element.handleCreate(ref, build);
  }
}
