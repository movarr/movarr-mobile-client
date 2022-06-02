import 'dart:io';

enum BindingType { b, s, i, l, f, d }

class Binding {
  final String columnName;
  final String columnValue;
  final BindingType type;

  Binding(
      {required this.columnName,
      required this.columnValue,
      required this.type});
}

class ContentUtils {
// content insert --uri <URI> [--user <USER_ID>] --bind <BINDING> [--bind <BINDING>...]
//   <URI> a content provider URI.
//   <BINDING> binds a typed value to a column and is formatted:
//   <COLUMN_NAME>:<TYPE>:<COLUMN_VALUE> where:
//   <TYPE> specifies data type such as:
//   b - boolean, s - string, i - integer, l - long, f - float, d - double
//   Note: Omit the value for passing an empty string, e.g column:s:
//   Example:
//   # Add "new_setting" secure setting with value "new_value".
//   content insert --uri content://settings/secure --bind name:s:new_setting --bind value:s:new_value

  Future<void> insert(String uri, String userId, Binding binding, String type,
      String columnValue) async {
    Process.run(
      'content',
      [
        'insert',
        '--uri ',
        uri,
        '--user ',
        userId,
        "--bind ${binding.columnName}:${binding.type}:${binding.columnValue}",
      ],
    );
    return;
  }

// usage: content update --uri <URI> [--user <USER_ID>] [--where <WHERE>]
//   <WHERE> is a SQL style where clause in quotes (You have to escape single quotes - see example below).
//   Example:
//   # Change "new_setting" secure setting to "newer_value".
//   content update --uri content://settings/secure --bind value:s:newer_value --where "name='new_setting'"

// usage:   content delete --uri <URI> [--user <USER_ID>] --bind <BINDING> [--bind <BINDING>...] [--where <WHERE>]
//   Example:
//   # Remove "new_setting" secure setting.
//    content delete --uri content://settings/secure --where "name='new_setting'"

// usage:   content query --uri <URI> [--user <USER_ID>] [--projection <PROJECTION>] [--where <WHERE>] [--sort <SORT_ORDER>]
//   <PROJECTION> is a list of colon separated column names and is formatted:
//   <COLUMN_NAME>[:<COLUMN_NAME>...]
//   <SORT_ORDER> is the order in which rows in the result should be sorted.
//   Example:
//   # Select "name" and "value" columns from secure settings where "name" is equal to "new_setting" and sort the result by name in ascending order.
//     content query --uri content://settings/secure --projection name:value --where "name='new_setting'" --sort "name ASC"
  Future<String> query({required String uri, String? userID}) async {
    ProcessResult result = await Process.run(
        'content',
        [
          'query',
          '--uri',
          uri,
        ],
        runInShell: true);
    print(result.stderr);
    return result.stdout;
  }
// usage:   content call --uri <URI> --method <METHOD> [--arg <ARG>]
//        [--extra <BINDING> ...]
//   <METHOD> is the name of a provider-defined method
//   <ARG> is an optional string argument
//   <BINDING> is like --bind above, typed data of the form <KEY>:{b,s,i,l,f,d}:<VAL>

// usage:   content register --uri <URI> --type <TYPE> [--user <USER_ID>]
// usage:   content call --uri <URI> --method <METHOD> [--arg <ARG>]
//        [--extra <BINDING> ...]
//   <METHOD> is the name of a provider-defined method
//   <ARG> is an optional string argument
//   <BINDING> is like --bind above, typed data of the form <KEY>:{b,s,i,l,f,d}:<VAL>

// usage:   content read --uri <URI> [--user <USER_ID>]
//   Example:
//     'content read --uri content://settings/system/ringtone_cache' > host.ogg

// usage:   content write --uri <URI> [--user <USER_ID>]
//   Example:
//     'content write --uri content://settings/system/ringtone_cache' < host.ogg

// usage:   content gettype --uri <URI> [--user <USER_ID>]
//   Example:
//     content gettype --uri content://media/internal/audio/media

}
