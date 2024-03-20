import QtQuick 6.2

Item {
    ClockTick {
        id: tick

        transform: Rotation {
            origin.x: 0
            origin.y: 0
            angle: 0
        }
    }

    Repeater {
        model: 4

        ClockTickThin {
            transform: Rotation {
                origin.x: 0
                origin.y: 0
                angle: (index + 1) * 6
            }
        }
    }
}
