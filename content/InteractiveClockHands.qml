import QtQuick 6.2
import InteractiveClock

Item {
    property real clockRadius: Constants.clockRadius

    Rectangle {
        id: container

        readonly property real centerX: clockRadius
        readonly property real centerY: clockRadius

        x: -clockRadius
        y: -clockRadius

        width: 400
        height: 400
        color: "transparent"




        Timer {
            id: timer
            interval: 1000; running: true; repeat: true
            onTriggered: timer.moveMinuteHand()

            function moveMinuteHand() {
                if (hour_hand.state === "dragged" || minute_hand.state === "dragged") {
                    return;
                }

                var minuteAngleDiff = 6.0;
                var hourAngleDiff = minuteAngleDiff / 12;

                var hourHandAngle = container.normalizeAngle(hour_hand.handAngle + hourAngleDiff);
                var minuteHandAngle = container.normalizeAngle(minute_hand.handAngle + minuteAngleDiff);

                var hourTimeAngle = container.handAngleToTimeAngle(hourHandAngle);
                var minuteTimeAngle = container.handAngleToTimeAngle(minuteHandAngle);

                var hours = container.timeAngleToHours(hourTimeAngle);
                var minutes = container.timeAngleToMinutes(minuteTimeAngle);

                var hourOldTimeAngle = container.handAngleToTimeAngle(hour_hand.handAngle);
                var hourCompleteRotation = container.hasHandMadeRotation(hourTimeAngle, hourOldTimeAngle);

                container.updateClockHands(hourHandAngle, minuteHandAngle);
                container.updateClockText(hours, minutes, hourCompleteRotation);
            }
        }

        MouseArea {
            id: mouse_area

            anchors.fill: parent
            propagateComposedEvents: true
            onReleased: (mouse) => {
                var clock_hand = hour_hand.state === "dragged" ? hour_hand : minute_hand;

                clock_hand.state = "idle";
                mouse.accepted = false;
            }
            onPositionChanged: (mouse) => {
                var dragged = hour_hand.state === "dragged" || minute_hand.state === "dragged";

                if (dragged) {
                    mouse_area.handleHandDrag(mouse);
                }
            }

            function handleHandDrag(mouse) {
                var clock_hand = hour_hand.state === "dragged" ? hour_hand : minute_hand;

                var diffX = mouse.x - container.centerX;
                var diffY = mouse.y - container.centerY;

                var angleCorrection = mouse_area.calculateHandAngleCorrection(diffX, diffY);
                var handAngle = mouse_area.calculateHandAngle(diffX, diffY, angleCorrection);
                var oldHandAngle = clock_hand.handAngle;
                var angleDiff = mouse_area.calculateAngleDiff(handAngle, oldHandAngle);

                var hourHandIsDragged = hour_hand.state === "dragged";
                var hourHandAngle = mouse_area.calculateHourHandAngle(hourHandIsDragged, hour_hand.handAngle, angleDiff);
                var minuteHandIsDragged = minute_hand.state === "dragged";
                var minuteHandAngle = mouse_area.calculateMinuteHandAngle(minuteHandIsDragged, minute_hand.handAngle, angleDiff);

                var hourTimeAngle = container.handAngleToTimeAngle(hourHandAngle);
                var minuteTimeAngle = container.handAngleToTimeAngle(minuteHandAngle);

                var hours = container.timeAngleToHours(hourTimeAngle);
                var minutes = container.timeAngleToMinutes(minuteTimeAngle);

                var hourOldTimeAngle = container.handAngleToTimeAngle(hour_hand.handAngle);
                var hourCompleteRotation = container.hasHandMadeRotation(hourTimeAngle, hourOldTimeAngle);

                container.updateClockHands(hourHandAngle, minuteHandAngle);
                container.updateClockText(hours, minutes, hourCompleteRotation);

                mouse.accepted = false;
            }

            function calculateHandAngleCorrection(diffX, diffY) {
                if (diffY > 0) {
                    if (diffX > 0) {
                        return -90.0;
                    } else {
                        return 90.0;
                    }
                } else {
                    if (diffX > 0) {
                        return -90.0;
                    } else {
                        return 90.0;
                    }
                }
            }

            function calculateHandAngle(diffX, diffY, angleCorrection) {
                if (diffX === 0 && diffY === 0) {
                    return 0;
                } else if (diffX === 0) {
                    if (diffY > 0) {
                        return 0;
                    } else {
                        return 180.0;
                    }
                } else if (diffY === 0) {
                    if (diffX > 0) {
                        return -90.0;
                    } else {
                        return 90.0;
                    }
                } else {
                    return Math.atan(diffY / diffX) * 180.0 / Math.PI + angleCorrection;
                }
            }

            function calculateAngleDiff(newAngle, oldAngle) {
                /*
                    Angle difference can be calculated from 2 sides: clock-wise and counter clock-wise.
                    So, 2 variables were created for that: angleDiff1 and angleDiff2.
                */
                var angleDiff1 = (newAngle - oldAngle) % 360;
                var angleDiff2 = angleDiff1 > 0 ? angleDiff1 - 360.0 : angleDiff1 + 360.0;
                var completeRotation = Math.abs(angleDiff1) > Math.abs(angleDiff2);
                var angleDiff = completeRotation ? angleDiff2 : angleDiff1;
                return angleDiff;
            }

            function calculateHourHandAngle(hourHandIsDragged, oldHourAngle, draggedHandAngleDiff) {
                var hourHandAngleDiff =  hourHandIsDragged ? draggedHandAngleDiff : draggedHandAngleDiff / 12;
                var hourHandAngle = oldHourAngle + hourHandAngleDiff;
                hourHandAngle = container.normalizeAngle(hourHandAngle);
                return hourHandAngle;
            }

            function calculateMinuteHandAngle(minuteHandIsDragged, oldMinuteAngle, draggedHandAngleDiff) {
                var minuteHandAngleDiff = minuteHandIsDragged ? draggedHandAngleDiff : draggedHandAngleDiff * 12;
                var minuteHandAngle = oldMinuteAngle + minuteHandAngleDiff;
                minuteHandAngle = container.normalizeAngle(minuteHandAngle);
                return minuteHandAngle;
            }
        }

        function hasHandMadeRotation(newAngle, oldAngle) {
            var angleDiff1 = (newAngle - oldAngle) % 360;
            var angleDiff2 = angleDiff1 > 0 ? angleDiff1 - 360.0 : angleDiff1 + 360.0;
            var completeRotation = Math.abs(angleDiff1) > Math.abs(angleDiff2);
            return completeRotation;
        }

        function normalizeAngle(angle) {
            var normilizedAngle = angle % 360;
            normilizedAngle = normilizedAngle >= 0 ? normilizedAngle : normilizedAngle + 360.0;
            return normilizedAngle;
        }

        function handAngleToTimeAngle(handAngle) {
            var timeAngle = handAngle - 180.0;
            timeAngle = timeAngle >= 0 ? timeAngle : timeAngle + 360.0;
            return timeAngle;
        }

        function timeAngleToHours(hourTimeAngle) {
            var hours =  Math.floor(hourTimeAngle / 30);
            hours = hours == 0 ? 12 : hours;
            return hours;
        }

        function timeAngleToMinutes(minuteTimeAngle) {
            return Math.floor(minuteTimeAngle / 6);
        }

        function updateClockHands(hourHandAngle, minuteHandAngle) {
            hour_hand.handAngle = hourHandAngle;
            minute_hand.handAngle = minuteHandAngle;
        }

        function updateClockText(hours, minutes, hourCompleteRotation) {
            time_text.hours = hours;
            time_text.minutes = minutes;
            time_text.am = hourCompleteRotation ? !time_text.am : time_text.am;
        }

        Rectangle {
            x: container.centerX - width / 2
            y: container.centerX - height / 2

            width: 12
            height: 12
            radius: 6
            color: Constants.clockBorderColor
        }

        ClockHand {
            id: hour_hand

            itemX: container.centerX
            itemY: container.centerY
            itemWidth: 10
            itemHeight: 100
        }

        ClockHand {
            id: minute_hand

            itemX: container.centerX
            itemY: container.centerY
            itemWidth: 8
            itemHeight: 150
        }

        TimeText {
            id: time_text

            x: container.centerX
            y: container.centerY

            hours: 12
            minutes: 0
        }
    }
}
