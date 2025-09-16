from PySide6.QtCore import QObject, Slot, Signal
import os

# Try to import RPi.GPIO, fall back to mock if not available (e.g., on Windows)
try:
    import RPi.GPIO as GPIO
    RASPBERRY_PI = True
except ImportError:
    RASPBERRY_PI = False
    print("RPi.GPIO not available - running in mock mode for development")

# Mock PWM class for development on non-Raspberry Pi systems
class MockPWM:
    def __init__(self):
        self.duty_cycle = 0
    
    def start(self, duty_cycle):
        self.duty_cycle = duty_cycle
        print(f"Mock PWM started with {duty_cycle}% duty cycle")
    
    def ChangeDutyCycle(self, duty_cycle):
        self.duty_cycle = duty_cycle
        print(f"Mock PWM duty cycle changed to {duty_cycle}%")
    
    def stop(self):
        print("Mock PWM stopped")

class VoltageController(QObject):

    voltageChanged = Signal(float)

    def __init__(self, gpio_pin=19):
        super().__init__()

        self.gpio_pin = gpio_pin
        self.current_voltage = 0.0

        if RASPBERRY_PI:
            GPIO.setmode(GPIO.BCM)
            GPIO.setup(self.gpio_pin, GPIO.OUT)
            self.pwm = GPIO.PWM(self.gpio_pin, 5000)  # 5 kHz
            self.pwm.start(0)  # Start with 0% duty
        else:
            # Mock PWM for development
            self.pwm = MockPWM()
            print(f"Mock PWM initialized for GPIO pin {gpio_pin}")

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
        if RASPBERRY_PI:
            GPIO.cleanup(self.gpio_pin)
            print(f"PWM stopped and GPIO{self.gpio_pin} cleaned up")
        else:
            print(f"Mock PWM stopped for GPIO{self.gpio_pin}")


standalone_run = False

if __name__ == "__main__":

    standalone_run = True

    pwmGenerator = VoltageController(19)
    pwmGenerator.set_voltage(1.5)
    pwmGenerator.cleanup()
