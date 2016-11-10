import QtQuick 2.0
import MyComponents 1.0

Item {
    id: checkedListDelegate
    width: parent.width
    height: 20

    TickBox {
        id: tickBox
        ticked: checked
        height: parent.height*3/4
        width: parent.height*3/4
        anchors { left: parent.left;
                  verticalCenter: parent.verticalCenter;
                  rightMargin: 20;
                  leftMargin: 10
        }
        onTriggered: delegate.ListView.view.model.setDataByStringRole(index, !tickBox.ticked, "checked")
    }

    Text {
        width: parent.width
        height: parent.height*3/4
        anchors { left: tickBox.right;
                  top: tickBox.top;
                  verticalCenter: parent.verticalCenter;
                  leftMargin: 20;
                  rightMargin: 10
        }
        text: name
        font.pixelSize: parent.height/2
        verticalAlignment: Text.AlignVCenter
        elide: Text.Right
        clip: true
    }
}
