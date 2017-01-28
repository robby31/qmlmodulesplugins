import QtQuick 2.0
import QtCharts 2.0
import MyComponents 1.0

Item {
    id: item

    property alias series: mapper.series

    property var model: sqlModel
    property alias connectionName: sqlModel.connectionName
    property alias query: sqlModel.query
    property string roleCategory: ""
    property var roleValue: []

    property alias firstBarSetColumn: mapper.firstBarSetColumn
    property alias lastBarSetColumn: mapper.lastBarSetColumn
    property alias firstRow: mapper.firstRow
    property alias rowCount: mapper.rowCount

    SqlListModel {
        id: sqlModel

        onQueryChanged: updateAxis()
    }

    VBarModelMapper {
        id: mapper

        model: sqlModel
    }

    function updateAxis() {
        if (series)
        {
            var data = []
            var xmin = -1
            var xmax = -1
            for (var i=firstRow;i<rowCount;++i) {
                data.push(sqlModel.get(i, roleCategory))

                for (var j=0;j<roleValue.length;++j)
                {
                    var value = sqlModel.get(i, roleValue[j])
                    if (xmin==-1)
                        xmin = value;
                    else if (value < xmin)
                        xmin = value;
                    if (xmax == -1)
                        xmax = value;
                    else if (value > xmax)
                        xmax = value;
                }
            }

            series.axisY.categories = data

            if (xmin < xmax) {
                series.axisX.min = xmin
                series.axisX.max = xmax
                series.axisX.applyNiceNumbers()
            }
        }
    }

    Component.onCompleted: {
        if (roleValue.length!=(lastBarSetColumn-firstBarSetColumn+1))
            console.log("invalid definition, roleValue inconsistent with firstBarSetColumn and lastBarSetColumn")
        if (!series)
            console.log("variable series is not set")
    }
}
