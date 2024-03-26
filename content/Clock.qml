import QtQuick 6.2
import InteractiveClock

Item {

    Rectangle {
        id: circle

        readonly property real centerX: Constants.clockRadius;
        readonly property real centerY: Constants.clockRadius;

        width: Constants.clockRadius * 2
        height: Constants.clockRadius * 2
        color: Constants.clockBackgroundColor
        border.color: Constants.clockBorderColor
        border.width: Constants.clockBorderWidth
        radius: Constants.clockRadius

        Repeater {
            model: 12

            ClockSegment {
                x: circle.centerX
                y: circle.centerY
                itemRotation: index * 30
            }
        }

        Repeater {
            model: 12

            ClockText {
                x: circle.centerX
                y: circle.centerY
                hour: (index + 5) % 12 + 1
                itemRotation: index * 30
                clockRadius: Constants.clockRadius
                borderWidth: Constants.clockBorderWidth
                indent: 60
            }
        }

        InteractiveClockHands {
            x: circle.centerX
            y: circle.centerY
        }
    }

}
