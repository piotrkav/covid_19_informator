import 'package:covid_19_informator/model/covid-info.dart';
import 'package:flutter/material.dart';

class CovidPaginatedDataTableSource extends DataTableSource {
  final List<CovidCountryInfo> _results;

  CovidPaginatedDataTableSource(this._results);

  void _sort<T>(Comparable<T> getField(CovidCountryInfo d), bool ascending) {
    _results.sort((CovidCountryInfo a, CovidCountryInfo b) {
      if (!ascending) {
        final CovidCountryInfo c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  int _selectedCount = 0;

  @override
  DataRow getRow(int index) {
    assert(index >= 0);
    if (index >= _results.length) return null;
    final CovidCountryInfo result = _results[index];
    return DataRow.byIndex(
        index: index,
        selected: result.selected,
        onSelectChanged: (bool value) {
          if (result.selected != value) {
            _selectedCount += value ? 1 : -1;
            assert(_selectedCount >= 0);
            result.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text('${result.country}')),
          DataCell(Text('${result.cases}')),
          DataCell(Text('${result.todayCases}')),
          DataCell(Text('${result.deaths}')),
          DataCell(Text('${result.todayDeaths}')),
          DataCell(Text('${result.recovered}')),
          DataCell(Text('${result.active}')),
          DataCell(Text('${result.critical}')),
          DataCell(Text('${result.casesPerOneMillion}')),
          DataCell(Text('${result.deathsPerOneMillion}')),
        ]);
  }

  @override
  int get rowCount => _results.length;

  @override
  bool get isRowCountApproximate => false;

  @override
  int get selectedRowCount => _selectedCount;

  void _selectAll(bool checked) {
    for (CovidCountryInfo result in _results) {
      result.selected = checked;
    }
    _selectedCount = checked ? _results.length : 0;
    notifyListeners();
  }
}
