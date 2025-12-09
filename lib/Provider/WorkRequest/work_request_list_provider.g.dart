// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_request_list_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$pagedListWorkRequestHash() =>
    r'6210599f891d7c9193851ae2a2f549c362570b8c';

/// Copied from Dart SDK
class _SystemHash {
  _SystemHash._();

  static int combine(int hash, int value) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + value);
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x0007ffff & hash) << 10));
    return hash ^ (hash >> 6);
  }

  static int finish(int hash) {
    // ignore: parameter_assignments
    hash = 0x1fffffff & (hash + ((0x03ffffff & hash) << 3));
    // ignore: parameter_assignments
    hash = hash ^ (hash >> 11);
    return 0x1fffffff & (hash + ((0x00003fff & hash) << 15));
  }
}

/// See also [pagedListWorkRequest].
@ProviderFor(pagedListWorkRequest)
const pagedListWorkRequestProvider = PagedListWorkRequestFamily();

/// See also [pagedListWorkRequest].
class PagedListWorkRequestFamily
    extends Family<AsyncValue<PagedListDto<WorkRequestDto>>> {
  /// See also [pagedListWorkRequest].
  const PagedListWorkRequestFamily();

  /// See also [pagedListWorkRequest].
  PagedListWorkRequestProvider call(PagedListRequestDto dto) {
    return PagedListWorkRequestProvider(dto);
  }

  @override
  PagedListWorkRequestProvider getProviderOverride(
    covariant PagedListWorkRequestProvider provider,
  ) {
    return call(provider.dto);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'pagedListWorkRequestProvider';
}

/// See also [pagedListWorkRequest].
class PagedListWorkRequestProvider
    extends AutoDisposeFutureProvider<PagedListDto<WorkRequestDto>> {
  /// See also [pagedListWorkRequest].
  PagedListWorkRequestProvider(PagedListRequestDto dto)
    : this._internal(
        (ref) => pagedListWorkRequest(ref as PagedListWorkRequestRef, dto),
        from: pagedListWorkRequestProvider,
        name: r'pagedListWorkRequestProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$pagedListWorkRequestHash,
        dependencies: PagedListWorkRequestFamily._dependencies,
        allTransitiveDependencies:
            PagedListWorkRequestFamily._allTransitiveDependencies,
        dto: dto,
      );

  PagedListWorkRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.dto,
  }) : super.internal();

  final PagedListRequestDto dto;

  @override
  Override overrideWith(
    FutureOr<PagedListDto<WorkRequestDto>> Function(
      PagedListWorkRequestRef provider,
    )
    create,
  ) {
    return ProviderOverride(
      origin: this,
      override: PagedListWorkRequestProvider._internal(
        (ref) => create(ref as PagedListWorkRequestRef),
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        dto: dto,
      ),
    );
  }

  @override
  AutoDisposeFutureProviderElement<PagedListDto<WorkRequestDto>>
  createElement() {
    return _PagedListWorkRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is PagedListWorkRequestProvider && other.dto == dto;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, dto.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin PagedListWorkRequestRef
    on AutoDisposeFutureProviderRef<PagedListDto<WorkRequestDto>> {
  /// The parameter `dto` of this provider.
  PagedListRequestDto get dto;
}

class _PagedListWorkRequestProviderElement
    extends AutoDisposeFutureProviderElement<PagedListDto<WorkRequestDto>>
    with PagedListWorkRequestRef {
  _PagedListWorkRequestProviderElement(super.provider);

  @override
  PagedListRequestDto get dto => (origin as PagedListWorkRequestProvider).dto;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
