// 分页数据表

import 'package:flutter/material.dart';

class Paginated extends StatefulWidget {
  const Paginated({Key? key, this.title}) : super(key: key);
  final String? title;

  @override
  _MyHomePageState createState() => _MyHomePageState();
}

class _MyHomePageState extends State<Paginated> {
  int _rowsPerPage = PaginatedDataTable.defaultRowsPerPage;
  int _sortColumnIndex = 0;
  bool _sortAscending = true;

  final DessertDataSource _dessertsDataSource = DessertDataSource();

  void _sort<T>(
      Comparable<T> getField(Dessert d), int columnIndex, bool ascending) {
    _dessertsDataSource._sort<T>(getField, ascending);
    setState(() {
      _sortColumnIndex = columnIndex;
      _sortAscending = ascending;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        // appBar: AppBar(title: const Text('学生成绩表')),
        body: ListView(padding: const EdgeInsets.all(5.0), children: [
      PaginatedDataTable(
          //头部的布局
          header: const Text('期末考试成绩'),
          //一页多少个item
          rowsPerPage: _rowsPerPage,
          //翻页监听事件
          onRowsPerPageChanged: (value) {
            setState(() {
              _rowsPerPage = value!;
            });
          },
          //指定哪列数据的趋势
          sortColumnIndex: _sortColumnIndex,
          //是否对sortColumnIndex指定的列按升序排序
          sortAscending: _sortAscending,
          //全选监听
          // onSelectAll: _dessertsDataSource._selectAll,
          //每一列标题栏
          columns: <DataColumn>[
            DataColumn(
                //标题栏名称
                label: const Text('姓名'),
                //长按提示语
                tooltip: '学生姓名',
                //值是否是数字
                numeric: false,
                onSort: (int columnIndex, bool ascending) => _sort<String>(
                    (Dessert d) => d.name, columnIndex, ascending)),
            DataColumn(
                label: const Text('语文'),
                tooltip: '语文成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.chinese, columnIndex, ascending)),
            DataColumn(
                label: const Text('数学'),
                tooltip: '数学成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) =>
                    _sort<num>((Dessert d) => d.math, columnIndex, ascending)),
            DataColumn(
                label: const Text('英语'),
                tooltip: '英语成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.english, columnIndex, ascending)),
            DataColumn(
                label: const Text('物理'),
                tooltip: '物理成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.physical, columnIndex, ascending)),
            DataColumn(
                label: const Text('化学'),
                tooltip: '化学成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.chemical, columnIndex, ascending)),
            DataColumn(
                label: const Text('生物'),
                tooltip: '生物成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.biological, columnIndex, ascending)),
            DataColumn(
                label: const Text('体育'),
                tooltip: '体育成绩',
                numeric: true,
                onSort: (int columnIndex, bool ascending) => _sort<num>(
                    (Dessert d) => d.sports, columnIndex, ascending)),
          ],
          source: _dessertsDataSource)
    ]));
  }
}

class DessertDataSource extends DataTableSource {
  int _selectedCount = 0;
  final List<Dessert> _desserts = <Dessert>[
    Dessert('张三', 99, 95, 100, 89, 98, 96, 90),
    Dessert('李四', 95, 97, 99, 95, 96, 94, 90),
    Dessert('王五', 90, 95, 93, 85, 90, 91, 88),
    Dessert('赵六', 80, 95, 85, 93, 97, 84, 81),
    Dessert('孙七', 80, 85, 86, 87, 84, 83, 80),
    Dessert('周八', 80, 79, 83, 81, 88, 80, 82),
    Dessert('吴九', 78, 79, 74, 72, 76, 77, 78),
    Dessert('郑十', 79, 83, 75, 74, 76, 77, 72),
    Dessert('华仔', 80, 80, 80, 80, 80, 80, 80),
    Dessert('周星', 80, 87, 90, 84, 88, 82, 81),
    Dessert('龙哥', 86, 90, 79, 85, 87, 88, 89),
    Dessert('菲姐', 80, 87, 90, 84, 88, 82, 81),
    Dessert('莉莉', 86, 90, 79, 85, 87, 88, 89),
    Dessert('杰哥', 79, 83, 75, 74, 76, 77, 72),
    Dessert('小明', 54, 83, 75, 74, 76, 77, 72),
    Dessert('小花', 79, 62, 75, 74, 76, 77, 72),
    Dessert('小哥', 79, 62, 75, 71, 76, 77, 72),
    Dessert('小晨', 79, 62, 53, 74, 76, 77, 72),
    Dessert('晓晓', 79, 62, 75, 74, 76, 77, 72),
    Dessert('小爱', 79, 62, 75, 74, 76, 77, 72),
    Dessert('小冰', 79, 62, 75, 74, 76, 77, 72),
    Dessert('娜娜', 79, 62, 75, 74, 76, 77, 72),
    Dessert('小宝', 79, 62, 75, 74, 76, 77, 72),
    Dessert('笑笑', 79, 62, 75, 74, 76, 77, 72),
    Dessert('慧慧', 79, 62, 75, 74, 76, 77, 72),
    Dessert('窝窝', 79, 62, 75, 74, 76, 77, 72),
    Dessert('德德', 79, 62, 75, 74, 76, 77, 72),
    Dessert('安安', 79, 62, 75, 74, 76, 77, 72),
    Dessert('马德拉', 79, 62, 75, 74, 76, 77, 72),
    Dessert('莫再提', 79, 62, 75, 74, 76, 77, 72),
    Dessert('莫再问', 46, 62, 75, 74, 76, 77, 72),
    Dessert('琪琪', 79, 62, 75, 74, 76, 77, 72),
    Dessert('球球', 79, 62, 75, 74, 76, 77, 72),
    Dessert('妞妞', 79, 62, 75, 74, 76, 77, 72),
    Dessert('桂姐', 79, 62, 75, 74, 76, 77, 72),
    Dessert('思思', 79, 62, 75, 74, 76, 77, 72),
    Dessert('小念', 79, 62, 75, 74, 76, 77, 72),
    Dessert('青青', 79, 62, 75, 74, 76, 77, 72),
    Dessert('悠悠', 79, 62, 75, 74, 76, 77, 72),
    Dessert('油油', 79, 62, 75, 74, 76, 77, 72),
    Dessert('陌陌', 79, 62, 75, 74, 76, 77, 72),
    Dessert('仔仔', 79, 62, 75, 74, 76, 77, 72),
    Dessert('孜孜', 79, 62, 75, 74, 76, 77, 72),
    Dessert('哈哥', 79, 62, 75, 74, 76, 77, 72),
    Dessert('看看', 79, 62, 75, 74, 76, 77, 72),
    Dessert('YY', 79, 62, 75, 74, 76, 77, 72),
    Dessert('依依', 79, 62, 75, 74, 76, 77, 72),
    Dessert('翠翠', 79, 62, 75, 74, 76, 77, 72),
    Dessert('溜溜', 79, 62, 75, 74, 76, 77, 72),
    Dessert('辉辉', 79, 62, 75, 74, 76, 77, 72),
  ];

  void _sort<T>(Comparable<T> getField(Dessert d), bool ascending) {
    _desserts.sort((Dessert a, Dessert b) {
      if (!ascending) {
        final Dessert c = a;
        a = b;
        b = c;
      }
      final Comparable<T> aValue = getField(a);
      final Comparable<T> bValue = getField(b);
      return Comparable.compare(aValue, bValue);
    });
    notifyListeners();
  }

  void _selectAll(bool checked) {
    for (Dessert dessert in _desserts) {
      dessert.selected = checked;
    }
    _selectedCount = checked ? _desserts.length : 0;
    notifyListeners();
  }

  @override
  DataRow? getRow(int index) {
    assert(index >= 0);
    if (index >= _desserts.length) return null;
    final Dessert dessert = _desserts[index];
    return DataRow.byIndex(
        index: index,
        selected: dessert.selected,
        onSelectChanged: (value) {
          if (dessert.selected != value) {
            _selectedCount += value! ? 1 : -1;
            assert(_selectedCount >= 0);
            dessert.selected = value;
            notifyListeners();
          }
        },
        cells: <DataCell>[
          DataCell(Text(dessert.name)),
          DataCell(Text('${dessert.chinese}')),
          DataCell(Text('${dessert.math}')),
          DataCell(Text('${dessert.english}')),
          DataCell(Text('${dessert.physical}')),
          DataCell(Text('${dessert.chemical}')),
          DataCell(Text('${dessert.biological}')),
          DataCell(Text('${dessert.sports}')),
        ]);
  }

  @override
  bool get isRowCountApproximate => false;

  @override
  int get rowCount => _desserts.length;

  @override
  int get selectedRowCount => _selectedCount;
}

class Dessert {
  Dessert(this.name, this.chinese, this.math, this.english, this.physical,
      this.chemical, this.biological, this.sports);

  final String name;
  final int chinese;
  final int math;
  final int english;
  final int physical;
  final int chemical;
  final int biological;
  final int sports;

  bool selected = false;
}
