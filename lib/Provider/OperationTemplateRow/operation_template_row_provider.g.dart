// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_template_row_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$operationTemplateRowHash() =>
    r'e02bc338a55920ef04ff2ca92d9e28d4d11f4a24';

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

abstract class _$OperationTemplateRow
    extends BuildlessAutoDisposeAsyncNotifier<List<OperationTemplateRowDto>> {
  late final int operationTemplateId;

  FutureOr<List<OperationTemplateRowDto>> build(int operationTemplateId);
}

/// See also [OperationTemplateRow].
@ProviderFor(OperationTemplateRow)
const operationTemplateRowProvider = OperationTemplateRowFamily();

/// See also [OperationTemplateRow].
class OperationTemplateRowFamily
    extends Family<AsyncValue<List<OperationTemplateRowDto>>> {
  /// See also [OperationTemplateRow].
  const OperationTemplateRowFamily();

  /// See also [OperationTemplateRow].
  OperationTemplateRowProvider call(int operationTemplateId) {
    return OperationTemplateRowProvider(operationTemplateId);
  }

  @override
  OperationTemplateRowProvider getProviderOverride(
    covariant OperationTemplateRowProvider provider,
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
  String? get name => r'operationTemplateRowProvider';
}

/// See also [OperationTemplateRow].
class OperationTemplateRowProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OperationTemplateRow,
          List<OperationTemplateRowDto>
        > {
  /// See also [OperationTemplateRow].
  OperationTemplateRowProvider(int operationTemplateId)
    : this._internal(
        () => OperationTemplateRow()..operationTemplateId = operationTemplateId,
        from: operationTemplateRowProvider,
        name: r'operationTemplateRowProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$operationTemplateRowHash,
        dependencies: OperationTemplateRowFamily._dependencies,
        allTransitiveDependencies:
            OperationTemplateRowFamily._allTransitiveDependencies,
        operationTemplateId: operationTemplateId,
      );

  OperationTemplateRowProvider._internal(
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
  FutureOr<List<OperationTemplateRowDto>> runNotifierBuild(
    covariant OperationTemplateRow notifier,
  ) {
    return notifier.build(operationTemplateId);
  }

  @override
  Override overrideWith(OperationTemplateRow Function() create) {
    return ProviderOverride(
      origin: this,
      override: OperationTemplateRowProvider._internal(
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
    OperationTemplateRow,
    List<OperationTemplateRowDto>
  >
  createElement() {
    return _OperationTemplateRowProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OperationTemplateRowProvider &&
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
mixin OperationTemplateRowRef
    on AutoDisposeAsyncNotifierProviderRef<List<OperationTemplateRowDto>> {
  /// The parameter `operationTemplateId` of this provider.
  int get operationTemplateId;
}

class _OperationTemplateRowProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OperationTemplateRow,
          List<OperationTemplateRowDto>
        >
    with OperationTemplateRowRef {
  _OperationTemplateRowProviderElement(super.provider);

  @override
  int get operationTemplateId =>
      (origin as OperationTemplateRowProvider).operationTemplateId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
