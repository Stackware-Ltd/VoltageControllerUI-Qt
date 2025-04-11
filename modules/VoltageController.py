from PySide6.QtCore import QObject, Slot, Signal
from gpiozero import PWMLED
import os

class VoltageController(QObject):

    voltageChanged = Signal(float)

    def __init__(self, gpio_pin=19):
        super().__init__()
        self.led = PWMLED(gpio_pin)
        self.current_voltage = 0.0

    @Slot(float)
    def set_voltage(self, voltage):
        try:
            clamped_voltage = max(0.0, min(3.3, voltage))

            if abs(clamped_voltage - self.current_voltage) < 0.001:
                print(f"No voltage change: {clamped_voltage}V")
                return

            self.current_voltage = clamped_voltage

            pwm_value = round(clamped_voltage / 3.3 , 1)
            self.led.value = pwm_value

            print(f"Voltage set to: {clamped_voltage} V (PWM: {pwm_value})")

            # send signal voltage changed
            self.voltageChanged.emit(clamped_voltage)

        except Exception as e:
            print(f"Error setting voltage: {e}")
