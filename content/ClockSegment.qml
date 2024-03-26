import QtQuick 6.2

Item {
    property real itemRotation: 0.0

    transform: Rotation {
        origin.x: 0
        origin.y: 0
        angle: itemRotation
    }

    ClockTick {
        itemWidth: 8
        itemHeight: 24

        transform: Rotation {
            origin.x: 0
            origin.y: 0

            angle: 0
        }
    }

    Repeater {
        model: 4

        ClockTick {
            itemWidth: 4
            itemHeight: 16

            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: (index + 1) * 6
            }
        }
    }
}
