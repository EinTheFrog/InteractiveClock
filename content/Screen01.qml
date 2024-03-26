import QtQuick 6.2
import QtQml
import InteractiveClock

Rectangle {
    id: rectangle
    width: Constants.width
    height: Constants.height
    color: Constants.backgroundColor

    Clock {
        id: clock
        width: Constants.clockRadius * 2
        height: Constants.clockRadius * 2
        anchors.verticalCenter: parent.verticalCenter
        anchors.horizontalCenter: parent.horizontalCenter
    }
}
