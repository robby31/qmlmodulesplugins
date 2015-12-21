import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import MyComponents 1.0

TableView {
    id: tableview
    width: 1000
    height: 600

    function createColumns() {
        var nbColumn = tableview.columnCount;
        for (var j=0; j<nbColumn; ++j)
            tableview.removeColumn(0)

        var dataModel = tableview.model
        if (dataModel != null)
        {
            for (var i = 0; i < dataModel.columnCount; ++i) {
                var str = 'import QtQuick 2.0; import QtQuick.Controls 1.1; TableViewColumn{ role: "'+ dataModel.role(i) +'"; title: "'+ dataModel.title(i) +'"; width: 100 }';
                var column = Qt.createQmlObject(str,tableview);
                if (column.Accessible.role === Accessible.ColumnHeader)
                    tableview.addColumn(column)
            }
        }
    }

    onModelChanged: createColumns()

}
