import QtQuick 6.2
import InteractiveClock

Item {
    property real itemWidth: 10
    property real itemHeight: 30
    property real clockRadius: Constants.clockRadius
    property real borderWidth: Constants.clockBorderWidth

    Rectangle {
        id: rectangle

        width: itemWidth
        height: itemHeight
        color: Constants.clockBorderColor

        x: -width/2
        y: clockRadius - borderWidth - height
    }
}
