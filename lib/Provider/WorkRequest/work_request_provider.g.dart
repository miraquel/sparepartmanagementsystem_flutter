// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'work_request_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$workRequestHash() => r'81031ea950d24585d67fcdbd9fb9411cc118a9fa';

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

abstract class _$WorkRequest
    extends BuildlessAutoDisposeAsyncNotifier<WorkRequestDto> {
  late final String agseamWrId;

  FutureOr<WorkRequestDto> build(String agseamWrId);
}

/// See also [WorkRequest].
@ProviderFor(WorkRequest)
const workRequestProvider = WorkRequestFamily();

/// See also [WorkRequest].
class WorkRequestFamily extends Family<AsyncValue<WorkRequestDto>> {
  /// See also [WorkRequest].
  const WorkRequestFamily();

  /// See also [WorkRequest].
  WorkRequestProvider call(String agseamWrId) {
    return WorkRequestProvider(agseamWrId);
  }

  @override
  WorkRequestProvider getProviderOverride(
    covariant WorkRequestProvider provider,
  ) {
    return call(provider.agseamWrId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'workRequestProvider';
}

/// See also [WorkRequest].
class WorkRequestProvider
    extends AutoDisposeAsyncNotifierProviderImpl<WorkRequest, WorkRequestDto> {
  /// See also [WorkRequest].
  WorkRequestProvider(String agseamWrId)
    : this._internal(
        () => WorkRequest()..agseamWrId = agseamWrId,
        from: workRequestProvider,
        name: r'workRequestProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$workRequestHash,
        dependencies: WorkRequestFamily._dependencies,
        allTransitiveDependencies: WorkRequestFamily._allTransitiveDependencies,
        agseamWrId: agseamWrId,
      );

  WorkRequestProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.agseamWrId,
  }) : super.internal();

  final String agseamWrId;

  @override
  FutureOr<WorkRequestDto> runNotifierBuild(covariant WorkRequest notifier) {
    return notifier.build(agseamWrId);
  }

  @override
  Override overrideWith(WorkRequest Function() create) {
    return ProviderOverride(
      origin: this,
      override: WorkRequestProvider._internal(
        () => create()..agseamWrId = agseamWrId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        agseamWrId: agseamWrId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<WorkRequest, WorkRequestDto>
  createElement() {
    return _WorkRequestProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is WorkRequestProvider && other.agseamWrId == agseamWrId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, agseamWrId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin WorkRequestRef on AutoDisposeAsyncNotifierProviderRef<WorkRequestDto> {
  /// The parameter `agseamWrId` of this provider.
  String get agseamWrId;
}

class _WorkRequestProviderElement
    extends AutoDisposeAsyncNotifierProviderElement<WorkRequest, WorkRequestDto>
    with WorkRequestRef {
  _WorkRequestProviderElement(super.provider);

  @override
  String get agseamWrId => (origin as WorkRequestProvider).agseamWrId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
