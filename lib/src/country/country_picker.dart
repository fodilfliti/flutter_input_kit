import 'package:flutter/material.dart';
import 'package:flutter_input_kit/src/country/country.dart';
import 'package:flutter_input_kit/src/fields/search_field.dart';
import 'package:flutter_page_kit/flutter_page_kit.dart' show FieldText;
import 'package:flutter_scale_kit/flutter_scale_kit.dart';

/// Opens a searchable country bottom sheet. Returns the pick or `null`.
///
/// Strings are app-supplied ([searchHint], [emptyText]); localized names via
/// [nameOf] (defaults to English). [favorites] (ISO codes) are pinned on top.
Future<Country?> showCountryPicker(
  BuildContext context, {
  Iterable<Country>? countries,
  List<String> favorites = const [],
  String? selected,
  String? searchHint,
  String? emptyText,
  String Function(Country)? nameOf,
  bool showDialCode = true,
  double heightFactor = 0.85,
}) {
  return showModalBottomSheet<Country>(
    context: context,
    isScrollControlled: true,
    useSafeArea: true,
    showDragHandle: true,
    clipBehavior: Clip.antiAlias,
    constraints: const BoxConstraints(maxWidth: 640),
    builder: (sheetContext) => FractionallySizedBox(
      heightFactor: heightFactor,
      child: CountryPickerList(
        countries: countries,
        favorites: favorites,
        selected: selected,
        searchHint: searchHint,
        emptyText: emptyText,
        nameOf: nameOf,
        showDialCode: showDialCode,
        onSelected: (c) => Navigator.of(sheetContext).pop(c),
      ),
    ),
  );
}

/// Searchable country list. Embed in a sheet, dialog, or page;
/// [showCountryPicker] wraps it in a bottom sheet.
class CountryPickerList extends StatefulWidget {
  const CountryPickerList({
    required this.onSelected,
    super.key,
    this.countries,
    this.favorites = const [],
    this.selected,
    this.searchHint,
    this.emptyText,
    this.nameOf,
    this.showDialCode = true,
    this.autofocus = false,
  });

  final ValueChanged<Country> onSelected;
  final Iterable<Country>? countries;
  final List<String> favorites;
  final String? selected;
  final String? searchHint;
  final String? emptyText;
  final String Function(Country)? nameOf;
  final bool showDialCode;
  final bool autofocus;

  @override
  State<CountryPickerList> createState() => _CountryPickerListState();
}

class _CountryPickerListState extends State<CountryPickerList> {
  final _query = TextEditingController();
  late final FieldText _search = FieldText(_query, validators: const []);
  late List<Country> _sorted;
  String _text = '';

  @override
  void initState() {
    super.initState();
    _sorted = _sortedSource();
  }

  @override
  void didUpdateWidget(covariant CountryPickerList oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.countries != widget.countries ||
        oldWidget.favorites != widget.favorites ||
        oldWidget.nameOf != widget.nameOf) {
      _sorted = _sortedSource();
    }
  }

  @override
  void dispose() {
    _query.dispose();
    super.dispose();
  }

  String _name(Country c) => widget.nameOf?.call(c) ?? c.name;

  List<Country> _sortedSource() {
    final source = List.of(widget.countries ?? Countries.all)
      ..sort(
        (a, b) => _name(a).toLowerCase().compareTo(_name(b).toLowerCase()),
      );
    final pinned = widget.favorites
        .map(Countries.byIso)
        .whereType<Country>()
        .where(source.contains)
        .toList();
    return [
      ...pinned,
      ...source.where((c) => !pinned.contains(c)),
    ];
  }

  @override
  Widget build(BuildContext context) {
    final visible = _text.isEmpty
        ? _sorted
        : Countries.search(_text, from: _sorted, nameOf: widget.nameOf);
    final selected = widget.selected?.toUpperCase();

    return Column(
      children: [
        Padding(
          padding: EdgeInsets.fromLTRB(16.w, 0, 16.w, 8.h),
          child: SearchField(
            _search,
            hint: widget.searchHint,
            autofocus: widget.autofocus,
            onChanged: (v) => setState(() => _text = v),
          ),
        ),
        Expanded(
          child: visible.isEmpty
              ? Center(child: Text(widget.emptyText ?? ''))
              : ListView.builder(
                  itemCount: visible.length,
                  itemBuilder: (context, i) {
                    final c = visible[i];
                    return ListTile(
                      key: ValueKey('country-${c.iso2}'),
                      leading: Text(c.flag, style: TextStyle(fontSize: 24.sp)),
                      title: Text(_name(c)),
                      trailing: widget.showDialCode
                          ? Text(c.dialCodeWithPlus)
                          : null,
                      selected: c.iso2 == selected,
                      onTap: () => widget.onSelected(c),
                    );
                  },
                ),
        ),
      ],
    );
  }
}
