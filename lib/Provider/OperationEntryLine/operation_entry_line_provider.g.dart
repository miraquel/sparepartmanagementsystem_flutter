// GENERATED CODE - DO NOT MODIFY BY HAND

part of 'operation_entry_line_provider.dart';

// **************************************************************************
// RiverpodGenerator
// **************************************************************************

String _$operationEntryLineHash() =>
    r'e4177cc84905469035669a649b22683e7da8a716';

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

abstract class _$OperationEntryLine
    extends BuildlessAutoDisposeAsyncNotifier<List<OperationEntryLineDto>> {
  late final int operationEntryHeaderId;

  FutureOr<List<OperationEntryLineDto>> build(int operationEntryHeaderId);
}

/// See also [OperationEntryLine].
@ProviderFor(OperationEntryLine)
const operationEntryLineProvider = OperationEntryLineFamily();

/// See also [OperationEntryLine].
class OperationEntryLineFamily
    extends Family<AsyncValue<List<OperationEntryLineDto>>> {
  /// See also [OperationEntryLine].
  const OperationEntryLineFamily();

  /// See also [OperationEntryLine].
  OperationEntryLineProvider call(int operationEntryHeaderId) {
    return OperationEntryLineProvider(operationEntryHeaderId);
  }

  @override
  OperationEntryLineProvider getProviderOverride(
    covariant OperationEntryLineProvider provider,
  ) {
    return call(provider.operationEntryHeaderId);
  }

  static const Iterable<ProviderOrFamily>? _dependencies = null;

  @override
  Iterable<ProviderOrFamily>? get dependencies => _dependencies;

  static const Iterable<ProviderOrFamily>? _allTransitiveDependencies = null;

  @override
  Iterable<ProviderOrFamily>? get allTransitiveDependencies =>
      _allTransitiveDependencies;

  @override
  String? get name => r'operationEntryLineProvider';
}

/// See also [OperationEntryLine].
class OperationEntryLineProvider
    extends
        AutoDisposeAsyncNotifierProviderImpl<
          OperationEntryLine,
          List<OperationEntryLineDto>
        > {
  /// See also [OperationEntryLine].
  OperationEntryLineProvider(int operationEntryHeaderId)
    : this._internal(
        () =>
            OperationEntryLine()
              ..operationEntryHeaderId = operationEntryHeaderId,
        from: operationEntryLineProvider,
        name: r'operationEntryLineProvider',
        debugGetCreateSourceHash:
            const bool.fromEnvironment('dart.vm.product')
                ? null
                : _$operationEntryLineHash,
        dependencies: OperationEntryLineFamily._dependencies,
        allTransitiveDependencies:
            OperationEntryLineFamily._allTransitiveDependencies,
        operationEntryHeaderId: operationEntryHeaderId,
      );

  OperationEntryLineProvider._internal(
    super._createNotifier, {
    required super.name,
    required super.dependencies,
    required super.allTransitiveDependencies,
    required super.debugGetCreateSourceHash,
    required super.from,
    required this.operationEntryHeaderId,
  }) : super.internal();

  final int operationEntryHeaderId;

  @override
  FutureOr<List<OperationEntryLineDto>> runNotifierBuild(
    covariant OperationEntryLine notifier,
  ) {
    return notifier.build(operationEntryHeaderId);
  }

  @override
  Override overrideWith(OperationEntryLine Function() create) {
    return ProviderOverride(
      origin: this,
      override: OperationEntryLineProvider._internal(
        () => create()..operationEntryHeaderId = operationEntryHeaderId,
        from: from,
        name: null,
        dependencies: null,
        allTransitiveDependencies: null,
        debugGetCreateSourceHash: null,
        operationEntryHeaderId: operationEntryHeaderId,
      ),
    );
  }

  @override
  AutoDisposeAsyncNotifierProviderElement<
    OperationEntryLine,
    List<OperationEntryLineDto>
  >
  createElement() {
    return _OperationEntryLineProviderElement(this);
  }

  @override
  bool operator ==(Object other) {
    return other is OperationEntryLineProvider &&
        other.operationEntryHeaderId == operationEntryHeaderId;
  }

  @override
  int get hashCode {
    var hash = _SystemHash.combine(0, runtimeType.hashCode);
    hash = _SystemHash.combine(hash, operationEntryHeaderId.hashCode);

    return _SystemHash.finish(hash);
  }
}

@Deprecated('Will be removed in 3.0. Use Ref instead')
// ignore: unused_element
mixin OperationEntryLineRef
    on AutoDisposeAsyncNotifierProviderRef<List<OperationEntryLineDto>> {
  /// The parameter `operationEntryHeaderId` of this provider.
  int get operationEntryHeaderId;
}

class _OperationEntryLineProviderElement
    extends
        AutoDisposeAsyncNotifierProviderElement<
          OperationEntryLine,
          List<OperationEntryLineDto>
        >
    with OperationEntryLineRef {
  _OperationEntryLineProviderElement(super.provider);

  @override
  int get operationEntryHeaderId =>
      (origin as OperationEntryLineProvider).operationEntryHeaderId;
}

// ignore_for_file: type=lint
// ignore_for_file: subtype_of_sealed_class, invalid_use_of_internal_member, invalid_use_of_visible_for_testing_member, deprecated_member_use_from_same_package
