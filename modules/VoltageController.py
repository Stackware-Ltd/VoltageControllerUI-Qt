from PySide6.QtCore import QObject, Slot, Signal
import RPi.GPIO as GPIO
import os

class VoltageController(QObject):

    voltageChanged = Signal(float)

    def __init__(self, gpio_pin=19):
        super().__init__()

        self.gpio_pin = gpio_pin
        self.current_voltage = 0.0

        GPIO.setmode(GPIO.BCM)
        GPIO.setup(self.gpio_pin, GPIO.OUT)

        self.pwm = GPIO.PWM(self.gpio_pin, 5000)  # 5 kHz
        self.pwm.start(0)  # Start with 0% duty

    @Slot(float)
    def set_voltage(self, voltage):

        if voltage == self.current_voltage:
            return

        try:
            self.current_voltage = voltage
            clamped_voltage = max(0.0, min(3.3, voltage))

            pwm_value = round((clamped_voltage / 3.3) * 100 , 1)
            self.pwm.ChangeDutyCycle(pwm_value)

            self.voltageChanged.emit(clamped_voltage)

            if standalone_run:
                print(f"Voltage set to: {clamped_voltage} V (PWM: {pwm_value})")

        except Exception as e:
            print(f"Error setting voltage: {e}")

    def cleanup(self):
        self.pwm.stop()
        GPIO.cleanup(self.gpio_pin)

        print(f"PWM stopped and GPIO{self.gpio_pin} cleaned up")


standalone_run = False

if __name__ == "__main__":

    standalone_run = True

    pwmGenerator = VoltageController(19)
    pwmGenerator.set_voltage(1.5)
    pwmGenerator.cleanup()
