// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_column_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$operationTemplateColumnHash() =>
    r'8240cdf6dd1155c248efb9654abedd92ffc0d7de';

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

abstract class _$OperationTemplateColumn
    extends
        BuildlessAutoDisposeAsyncNotifier<List<OperationTemplateColumnDto>> {
  late final int operationTemplateId;

  FutureOr<List<OperationTemplateColumnDto>> build(int operationTemplateId);
}

/// See also [OperationTemplateColumn].
@ProviderFor(OperationTemplateColumn)
const operationTemplateColumnProvider = OperationTemplateColumnFamily();

/// See also [OperationTemplateColumn].
class OperationTemplateColumnFamily
    extends Family<AsyncValue<List<OperationTemplateColumnDto>>> {
  /// See also [OperationTemplateColumn].
  const OperationTemplateColumnFamily();

  /// See also [OperationTemplateColumn].
  OperationTemplateColumnProvider call(int operationTemplateId) {
    return OperationTemplateColumnProvider(operationTemplateId);
  }

  @override
  OperationTemplateColumnProvider getProviderOverride(
    covariant OperationTemplateColumnProvider provider,
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
  String? get name => r'operationTemplateColumnProvider';
}

/// See also [OperationTemplateColumn].
class OperationTemplateColumnProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OperationTemplateColumn,
          List<OperationTemplateColumnDto>
        > {
  /// See also [OperationTemplateColumn].
  OperationTemplateColumnProvider(int operationTemplateId)
    : this._internal(
        () =>
            OperationTemplateColumn()
              ..operationTemplateId = operationTemplateId,
        from: operationTemplateColumnProvider,
        name: r'operationTemplateColumnProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$operationTemplateColumnHash,
        dependencies: OperationTemplateColumnFamily._dependencies,
        allTransitiveDependencies:
            OperationTemplateColumnFamily._allTransitiveDependencies,
        operationTemplateId: operationTemplateId,
      );

  OperationTemplateColumnProvider._internal(
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
  FutureOr<List<OperationTemplateColumnDto>> runNotifierBuild(
    covariant OperationTemplateColumn notifier,
  ) {
    return notifier.build(operationTemplateId);
  }

  @override
  Override overrideWith(OperationTemplateColumn Function() create) {
    return ProviderOverride(
      origin: this,
      override: OperationTemplateColumnProvider._internal(
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
    OperationTemplateColumn,
    List<OperationTemplateColumnDto>
  >
  createElement() {
    return _OperationTemplateColumnProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OperationTemplateColumnProvider &&
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
mixin OperationTemplateColumnRef
    on AutoDisposeAsyncNotifierProviderRef<List<OperationTemplateColumnDto>> {
  /// The parameter `operationTemplateId` of this provider.
  int get operationTemplateId;
}

class _OperationTemplateColumnProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OperationTemplateColumn,
          List<OperationTemplateColumnDto>
        >
    with OperationTemplateColumnRef {
  _OperationTemplateColumnProviderElement(super.provider);

  @override
  int get operationTemplateId =>
      (origin as OperationTemplateColumnProvider).operationTemplateId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
