import 'package:flutter/material.dart';
import 'package:freezed_annotation/freezed_annotation.dart';

enum EamWorkflowStatus {
  @JsonValue(0) notSubmitted,
  @JsonValue(1) submitted,
  @JsonValue(2) approved,
  @JsonValue(3) rejected,
  @JsonValue(4) pendingApproval,
  @JsonValue(5) cancel,
  @JsonValue(6) accepted,
  @JsonValue(7) requestChange;

  @override
  String toString() {
    switch (this) {
      case EamWorkflowStatus.notSubmitted:
        return 'Not Submitted';
      case EamWorkflowStatus.submitted:
        return 'Submitted';
      case EamWorkflowStatus.approved:
        return 'Approved';
      case EamWorkflowStatus.rejected:
        return 'Rejected';
      case EamWorkflowStatus.pendingApproval:
        return 'Pending Approval';
      case EamWorkflowStatus.cancel:
        return 'Cancel';
      case EamWorkflowStatus.accepted:
        return 'Accepted';
      case EamWorkflowStatus.requestChange:
        return 'Request Change';
    }
  }

  Color get color {
    switch (this) {
      case EamWorkflowStatus.notSubmitted:
        return Colors.grey;
      case EamWorkflowStatus.submitted:
        return Colors.blue;
      case EamWorkflowStatus.approved:
        return Colors.green;
      case EamWorkflowStatus.rejected:
        return Colors.red;
      case EamWorkflowStatus.pendingApproval:
        return Colors.yellow;
      case EamWorkflowStatus.cancel:
        return Colors.grey.shade400;
      case EamWorkflowStatus.accepted:
        return Colors.green;
      case EamWorkflowStatus.requestChange:
        return Colors.orange;
    }
  }
}