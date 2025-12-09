// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_verificator_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$operationTemplateVerificatorHash() =>
    r'f50ab332443b5316bea6d105818f787d2733b246';

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

abstract class _$OperationTemplateVerificator
    extends
        BuildlessAutoDisposeAsyncNotifier<
          List<OperationTemplateVerificatorDto>
        > {
  late final int operationTemplateId;

  FutureOr<List<OperationTemplateVerificatorDto>> build(
    int operationTemplateId,
  );
}

/// See also [OperationTemplateVerificator].
@ProviderFor(OperationTemplateVerificator)
const operationTemplateVerificatorProvider =
    OperationTemplateVerificatorFamily();

/// See also [OperationTemplateVerificator].
class OperationTemplateVerificatorFamily
    extends Family<AsyncValue<List<OperationTemplateVerificatorDto>>> {
  /// See also [OperationTemplateVerificator].
  const OperationTemplateVerificatorFamily();

  /// See also [OperationTemplateVerificator].
  OperationTemplateVerificatorProvider call(int operationTemplateId) {
    return OperationTemplateVerificatorProvider(operationTemplateId);
  }

  @override
  OperationTemplateVerificatorProvider getProviderOverride(
    covariant OperationTemplateVerificatorProvider provider,
  ) {
    return call(provider.operationTemplateId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'operationTemplateVerificatorProvider';
}

/// See also [OperationTemplateVerificator].
class OperationTemplateVerificatorProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OperationTemplateVerificator,
          List<OperationTemplateVerificatorDto>
        > {
  /// See also [OperationTemplateVerificator].
  OperationTemplateVerificatorProvider(int operationTemplateId)
    : this._internal(
        () =>
            OperationTemplateVerificator()
              ..operationTemplateId = operationTemplateId,
        from: operationTemplateVerificatorProvider,
        name: r'operationTemplateVerificatorProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$operationTemplateVerificatorHash,
        dependencies: OperationTemplateVerificatorFamily._dependencies,
        allTransitiveDependencies:
            OperationTemplateVerificatorFamily._allTransitiveDependencies,
        operationTemplateId: operationTemplateId,
      );

  OperationTemplateVerificatorProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.operationTemplateId,
  }) : super.internal();

  final int operationTemplateId;

  @override
  FutureOr<List<OperationTemplateVerificatorDto>> runNotifierBuild(
    covariant OperationTemplateVerificator notifier,
  ) {
    return notifier.build(operationTemplateId);
  }

  @override
  Override overrideWith(OperationTemplateVerificator Function() create) {
    return ProviderOverride(
      origin: this,
      override: OperationTemplateVerificatorProvider._internal(
        () => create()..operationTemplateId = operationTemplateId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        operationTemplateId: operationTemplateId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    OperationTemplateVerificator,
    List<OperationTemplateVerificatorDto>
  >
  createElement() {
    return _OperationTemplateVerificatorProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OperationTemplateVerificatorProvider &&
        other.operationTemplateId == operationTemplateId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, operationTemplateId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OperationTemplateVerificatorRef
    on
        AutoDisposeAsyncNotifierProviderRef<
          List<OperationTemplateVerificatorDto>
        > {
  /// The parameter `operationTemplateId` of this provider.
  int get operationTemplateId;
}

class _OperationTemplateVerificatorProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OperationTemplateVerificator,
          List<OperationTemplateVerificatorDto>
        >
    with OperationTemplateVerificatorRef {
  _OperationTemplateVerificatorProviderElement(super.provider);

  @override
  int get operationTemplateId =>
      (origin as OperationTemplateVerificatorProvider).operationTemplateId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
