import QtQuick 2.0
import QtQuick.Controls 1.2
import QtQuick.Dialogs 1.1
import QtQuick.Layouts 1.0
import MyComponents 1.0

Item {
    id: pivotView

    property alias model: listView.model
    property alias delegate: listView.delegate
    property string textUnit: "M€"

    function filter() {
        filterDialog.isVisible = true
    }

    ColumnLayout {
        id: column
        width: parent.width
        height: parent.height
        spacing: 0

        Rectangle {
            id: titleArea
            Layout.fillWidth: true
            height: 30

            gradient: Gradient {
                GradientStop {position: 0; color: theme.gradientStartColor}
                GradientStop {position: 1; color: theme.gradientEndColor}
            }

            MyButton {
                anchors { left: parent.left; leftMargin: 5 }
                sourceComponent: Text { text: "< Back" }
                onButtonClicked: goBackView()
            }

            MyButton {
                id: total
                anchors {right: parent.right; rightMargin: 5}
                sourceComponent: Text {text: (listView.model !== null && listView.model.isFiltered ? "SubTotal: " : "Total: ")+Number(listView.model.total).toLocaleString(Qt.locale("fr_FR"))+" "+textUnit
                                       color: "blue" }
                hovered: true
                onButtonClicked: filter()
            }
        }

        ListView {
            id: listView
            Layout.fillHeight: true
            Layout.fillWidth: true
            clip: true

            focus: true
            highlightFollowsCurrentItem: false

            ScrollIndicator {
                id: scrollIndicator
                width: 10
                height: parent.height
                anchors {top: parent.top; right: parent.right}
                handleSize: listView.visibleArea.heightRatio * listView.height
                handlePosition: listView.visibleArea.yPosition * listView.height
                opacity: listView.moving? 1.0 : 0.0
            }
        }
    }

    FlippableDialog {
        id: filterDialog
        anchors.fill: parent
        dialogWidth: 600
        dialogHeight: 300

        item: FilteringDialog {
            id: checkedListItem

            columnModel: dbModel.columnsToFilter
            columnDataModel: dbModel.columnDataModel

            onOk: {
                filterDialog.isVisible = false
                dbModel.updateFilter()
            }

            onColumnSelected: dbModel.setColumnDataModel(name)
        }
    }
}
