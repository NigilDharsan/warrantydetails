import 'package:flutter/material.dart';

class ErrorHandler {
  // Method to handle HTTP errors or general exceptions
  static String handleError(dynamic err) {
    String errMsg = 'An unexpected error occurred.';

    try {
      // Checking if the error is of type Map (like an API response error)
      // if (err is Map) {
      // Handling error when the 'error' key exists
      // if (err.containsKey('errors') && err['errors'] != null) {
      //   var errorDetail = err['errors'];

      // Handle nested 'errors' object case
      if (err['errors'] != null && err['errors'] is Map) {
        List<String> errorMessages = [];
        for (var key in err['errors'].keys) {
          errorMessages.addAll(List<String>.from(err['errors'][key]));
        }
        errMsg = errorMessages.join(', ');
      }
      // Handle array of errors case
      else if (err['errors'] != null && err['errors'] is List) {
        var errorArray = List<Map<String, dynamic>>.from(err['errors']);
        var messages = errorArray
            .map((e) => e['message'] ?? e['code'] ?? '')
            .where((e) => e.isNotEmpty)
            .toList();
        errMsg = messages.join(', ') ??
            err['detail'] ??
            'An unexpected error occurred.';
      }
      // Handle the 'detail' case
      else if (err['detail'] != null) {
        errMsg = err['detail'];
      }
      // Handle the 'message' case
      else if (err['message'] != null) {
        errMsg = err['message'];
      } else if (err['error_description'] != null) {
        errMsg = err['error_description'];
      }
      // }
      // }
    } catch (e) {
      // In case something goes wrong during the error handling itself
      // errMsg = 'Error processing the error: $e';
    }

    print(errMsg);
    // Show the error message in the UI or log it
    // _showToast(errMsg);  // Call a function to display the error message in the UI
    return errMsg;
  }
}

// Global navigator key to use in any widget (for Snackbar or Toasts)
final GlobalKey<ScaffoldMessengerState> navigatorKey =
    GlobalKey<ScaffoldMessengerState>();
