# Sensor Data Acquisition and Threshold Monitoring System using XADC on Spartan-7 FPGA

## Project Overview

This project implements a real-time Sensor Data Acquisition and Threshold Monitoring System on the RealDigital Boolean Board using the Xilinx Spartan-7 FPGA. The system acquires sensor data from multiple sources, processes the acquired values using a moving average filter, stores the processed data in a FIFO buffer, and monitors the values against predefined threshold levels.

Visual indication is provided through on-board LEDs. Whenever the processed sensor value exceeds the threshold value, the corresponding LED blinks, indicating an alert condition. The threshold value and sensor value are displayed on dual seven-segment displays for real-time monitoring.

In addition to FPGA implementation, the design flow was further explored through ASIC physical design concepts using Cadence Innovus, including floorplanning, power planning, and placement analysis.

---

## Key Features

* Real-time sensor data acquisition
* Four sensor channel selection using slide switches
* XADC-based temperature monitoring
* Moving average filtering
* FIFO-based temporary storage
* FSM-controlled FIFO operations
* Threshold monitoring and alert generation
* LED-based indication
* Dual seven-segment displays
* 10 kHz sampling frequency
* Spartan-7 FPGA implementation
* Physical design exploration using Cadence Innovus

---

## Hardware and Software Used

| Category             | Tool / Hardware            |
| -------------------- | -------------------------- |
| FPGA Board           | RealDigital Boolean Board  |
| FPGA Device          | Xilinx Spartan-7           |
| ADC                  | On-Chip XADC               |
| Display              | Dual 4-Digit Seven Segment |
| Indicators           | User LEDs                  |
| HDL                  | Verilog HDL                |
| FPGA Tool            | Vivado 2022.2              |
| Physical Design Tool | Cadence Innovus            |

---

## System Architecture

```text
Sensor Inputs
      │
      ▼
   4×1 MUX
      │
      ▼
 ADC Controller
      │
      ▼
 Processing Unit
(Moving Average)
      │
      ▼
   FIFO Buffer
      │
      ▼
 Threshold Comparator
      │
      ├────────► LED Alert
      │
      ▼
 Seven Segment Displays
```

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

A moving average filter is used to smooth the acquired sensor data.

```text
Processed Data =
(Current Sample + Previous Sample)/2
```

This reduces noise and improves output stability.

---

## FIFO Buffer

The FIFO buffer temporarily stores processed sensor data before output processing.

Features:

* 16-word FIFO memory
* Write and read control through FSM
* Temporary storage of sensor samples
* Data synchronization

---

## Threshold Monitoring

The processed sensor value is continuously compared against a predefined threshold value.

Threshold Value:

```text
2000
```

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

```text
2000
```

### Right Display

Displays Current Sensor Value

Examples:

```text
1000
1500
2500
3500
```

---

## Sampling Frequency

FPGA Clock:

```text
100 MHz
```

Sampling Tick:

```text
10 kHz
```

Generated using a counter-based clock divider.

---

## FPGA Implementation Results

Successfully implemented and verified on Spartan-7 FPGA:

* Sensor Selection using Switches
* Data Acquisition
* Moving Average Processing
* FIFO Storage
* FSM Control
* Threshold Detection
* LED Alert Indication
* Seven Segment Display Monitoring

---

## Physical Design Exploration using Cadence Innovus

To gain exposure to ASIC backend design methodologies, the synthesized design flow was further studied using Cadence Innovus.

### Stages Explored

* Floorplanning
* Power Planning
* Standard Cell Placement
* Congestion Analysis
* Utilization Analysis

### Placement Result

The design was successfully taken through the placement stage in Cadence Innovus.
<img width="602" height="321" alt="image" src="https://github.com/user-attachments/assets/6873cbfe-c78a-42c4-8d0d-a0a05a10d886" />


### Concepts Learned

* ASIC Physical Design Flow
* Core Utilization Analysis
* Power Distribution Planning
* Standard Cell Placement
* Congestion-Aware Design
* Backend VLSI Design Methodology

---

## Repository Structure

```text
Sensor-Data-Acquisition-System/
│
├── rtl/
│   ├── top_module.v
│   ├── mux4x1.v
│   ├── adc_controller.v
│   ├── processing_unit.v
│   ├── fifo_buffer.v
│   ├── control_fsm.v
│   └── output_led.v
│
├── constraints/
│   └── boolean_board.xdc
│
├── tb/
│   └── top_module_tb.v
│
├── docs/
│   └── placement_result.png
│
└── README.md
```

---

## Future Enhancements

* RGB LED Threshold Indication
* Potentiometer-Based Threshold Control
* PWM Brightness Control
* UART Communication
* IoT Monitoring
* OLED/LCD Interface
* Complete ASIC Physical Design Flow (CTS, Routing and Signoff)

---

## Conclusion

This project successfully demonstrates real-time sensor acquisition, XADC-based monitoring, moving average filtering, FIFO buffering, threshold detection, LED-based alert indication, and seven-segment display visualization on a Spartan-7 FPGA. Additionally, exposure to Cadence Innovus enabled understanding of ASIC physical design concepts such as floorplanning, power planning, and placement, providing a comprehensive view of both FPGA and VLSI implementation methodologies.
