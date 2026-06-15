# Sensor Data Acquisition and Threshold Monitoring System using XADC on Spartan-7 FPGA

## Project Overview

This project implements a Sensor Data Acquisition and Threshold Monitoring System on the RealDigital Boolean Board using the Xilinx Spartan-7 FPGA. The system acquires sensor data from multiple sources, processes the acquired values using a moving average filter, stores the processed data in a FIFO buffer, and monitors the values against predefined threshold levels.

A visual indication is provided through on-board LEDs. Whenever the processed sensor value exceeds the threshold value, the corresponding LED blinks, indicating an alert condition.

---

## Key Features

* Real-time sensor data acquisition
* Four sensor channel selection using slide switches
* XADC-based temperature monitoring
* Moving average filtering
* FIFO-based temporary storage
* FSM-controlled FIFO write/read operations
* Threshold monitoring and alert generation
* LED-based indication for threshold violation
* Dual 4-digit seven-segment displays
* 10 kHz sampling frequency
* Spartan-7 FPGA implementation

---

## Hardware Used

* RealDigital Boolean Board
* Xilinx Spartan-7 FPGA
* On-chip XADC
* Four User LEDs
* Dual 4-Digit Seven Segment Displays
* Slide Switches
* Vivado Design Suite

---

## System Architecture

Sensor Inputs
↓
4×1 Multiplexer
↓
ADC Controller
↓
Processing Unit (Moving Average Filter)
↓
FIFO Buffer
↓
Threshold Comparator
↓
LED Alert Indication
↓
Seven Segment Displays

---

## Sensor Configuration

| Sensor   | Description               |
| -------- | ------------------------- |
| Sensor 0 | Temperature Sensor (XADC) |
| Sensor 1 | Simulated Sensor          |
| Sensor 2 | Simulated Sensor          |
| Sensor 3 | Simulated Sensor          |

---

## Sensor Selection

| Switches | Selected Sensor |
| -------- | --------------- |
| 00       | Sensor 0        |
| 01       | Sensor 1        |
| 10       | Sensor 2        |
| 11       | Sensor 3        |

---

## Processing Unit

A moving average filter is used to smooth the sensor data.

Processed Data = (Current Sample + Previous Sample) / 2

This helps reduce noise and provides a stable output.

---

## FIFO Buffer

The FIFO buffer temporarily stores processed sensor data before output processing.

Features:

* 16-word FIFO memory
* FSM-controlled write and read operations
* Temporary storage of sensor samples
* Data synchronization

---

## Threshold Monitoring

The processed sensor value is continuously compared against a predefined threshold value.

Threshold Value = 2000

Condition:

* Data < Threshold → LED OFF
* Data > Threshold → LED BLINKS

---

## LED Output Behaviour

| Switch Selection | Sensor Value | Threshold | LED Status |
| ---------------- | ------------ | --------- | ---------- |
| 00               | 1000         | 2000      | OFF        |
| 01               | 1500         | 2000      | OFF        |
| 10               | 2500         | 2000      | BLINKING   |
| 11               | 3500         | 2000      | BLINKING   |

---

## Seven Segment Displays

### Left Display

Displays Threshold Value

Example:

2000

### Right Display

Displays Current Sensor Value

Examples:

1000

1500

2500

3500

---

## Sampling Frequency

FPGA Clock = 100 MHz

Sample Tick = 10 kHz

A counter-based clock divider is used to generate the sampling tick.

---

## Files Included

rtl/
├── top_module.v
├── mux4x1.v
├── adc_controller.v
├── processing_unit.v
├── fifo_buffer.v
├── control_fsm.v
└── output_led.v

constraints/
└── boolean_board.xdc

tb/
└── top_module_tb.v

README.md

---

## Tools Used

* Verilog HDL
* Vivado 2022.2
* XADC Wizard IP
* Cadence Nclaunch

---

## Future Enhancements

* RGB Threshold Indication
* Potentiometer-Based Threshold Control
* PWM Brightness Control
* UART Communication
* IoT Monitoring
* OLED/LCD Interface

---

## Conclusion

The project successfully demonstrates sensor data acquisition, data processing, FIFO buffering, threshold monitoring, and visual indication using LEDs and seven-segment displays on the Spartan-7 FPGA platform. The design provides a practical framework for real-time monitoring applications in embedded and FPGA-based systems.
