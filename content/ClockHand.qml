import QtQuick 6.2

Item {
    property real item_width: 10
    property real item_height: 100

    Rectangle {
        id: container

        property real centerX: 200
        property real centerY: 200

        x: -200
        y: -200

        width: 400
        height: 400
        color: "transparent"

        MouseArea {
            anchors.fill: parent
            onReleased: (mouse) => {
                console.log("released");
                clock_hand.state = "idle";
            }
            onPositionChanged: (mouse) => {
                console.log("state: " + clock_hand.state);

                if (clock_hand.state === "dragged") {
                    var diffX = mouse.x - container.centerX;
                    var diffY = mouse.y - container.centerY;

                    if (diffX === 0 && diffY === 0) {
                        clock_hand.handAngle = 0;
                    } else if (diffX === 0) {
                        if (diffY > 0) {
                            clock_hand.handAngle = 0;
                        } else {
                            clock_hand.handAngle = 180;
                        }
                    } else if (diffY === 0) {
                        if (diffX > 0) {
                            clock_hand.handAngle = -90;
                        } else {
                            clock_hand.handAngle = 90;
                        }
                    } else {
                        if (diffY > 0) {
                            if (diffX > 0) {
                                clock_hand.angleCorrection = -90;
                            } else {
                                clock_hand.angleCorrection = 90;
                            }
                        } else {
                            if (diffX > 0) {
                                clock_hand.angleCorrection = -90;
                            } else {
                                clock_hand.angleCorrection = 90;
                            }
                        }

                        clock_hand.handAngle = Math.atan(diffY / diffX) * 180.0 / Math.PI + clock_hand.angleCorrection;
                        hand_rotation.angle = clock_hand.handAngle;
                    }
                }
            }
        }

        Rectangle {
            id: clock_hand

            property real handAngle: 0.0
            property real angleCorrection: 0.0


            x: 200 - width / 2
            y: 200

            color: "black"
            width: item_width
            height: item_height

            transform: Rotation {
                id: hand_rotation

                origin.x: item_width / 2
                origin.y: 0
                angle: 0
            }

            MouseArea {
                anchors.fill: parent
                propagateComposedEvents: true
                onPressed: (mouse) => {
                    console.log("pressed");
                    clock_hand.state = "dragged";
                    mouse.accepted = false;
                }
            }

            states: [
                State {
                    name: "idle"
                },
                State {
                    name: "dragged"
                }
            ]
        }
    }
}
