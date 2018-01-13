import QtQuick 2.5
import QtQuick.Controls 2.1

SwipeDelegate {
    id: delegate
    width: parent ? parent.width : 0
    height: 30

    onFocusChanged: swipe.close()
    onClicked: delegate.ListView.view.currentIndex = index

    background: Item {
        implicitWidth: delegate.width
        implicitHeight: delegate.height

        Rectangle {
            id: highlitedRectangle
            anchors.fill: parent

            gradient: Gradient {
                GradientStop { position: 0.0; color: theme.highlightGradientStart }
                GradientStop { position: 1.0; color: theme.highlightGradientEnd }
            }

            visible: delegate.down || delegate.ListView.isCurrentItem
        }

        Rectangle {
            id: backgroundRectangle
            anchors.fill: parent
            color: "white"
            visible: !highlitedRectangle.visible
        }

        Rectangle {
            id: separatorBottom
            width: parent.width
            height: 1
            anchors { left: parent.left; bottom: parent.bottom }
            color: theme.separatorColor
        }
    }
}


