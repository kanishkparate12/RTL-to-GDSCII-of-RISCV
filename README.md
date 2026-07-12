# RTL-to-GDSII Implementation of a Single-Cycle RV32I RISC-V Processor

*A complete ASIC implementation flow — from Verilog RTL to GDSII layout.*

</div>

---

## Overview

This repository documents the end-to-end implementation of a **32-bit single-cycle RV32I RISC-V processor** through the ASIC design flow — starting with RTL design and logic synthesis, and progressing through physical design, timing signoff, and final GDSII generation.

## Implementation Flow

| Stage | Tool | Status |
|---|---|:---:|
| RTL Design | Verilog HDL | Complete |
| Logic Synthesis | Cadence Genus | Complete |
| Physical Design | Cadence Innovus | Planned |
| Timing Signoff | Cadence Tempus | Planned |
| GDSII Generation | Cadence Innovus | Planned |

---

## Stage 1 — Logic Synthesis

### Overview

The first stage of the ASIC implementation flow converts the synthesizable RTL into a technology-mapped gate-level netlist using **Cadence Genus**. During this stage, the design is optimized to satisfy timing constraints while minimizing area and power.

The synthesis flow includes:

- RTL elaboration
- Library linking
- Multi-Mode Multi-Corner (MMMC) setup
- Timing constraint application
- Logic optimization
- Technology mapping
- Automatic clock gating
- Gate-level netlist generation
- Report generation

### Implementation Environment

| Parameter | Value |
|---|---|
| Synthesis Tool | Cadence Genus 21.14 |
| Technology Library | Generic 45 nm Standard Cell Library |
| Timing Constraints | Synopsys Design Constraints (SDC) |
| Timing Analysis | Multi-Mode Multi-Corner (MMMC) |
| Design | Single-Cycle RV32I RISC-V Processor |

### Synthesis Files

| File | Description |
|---|---|
| [`genus_script.tcl`](./genus_script.tcl) | Main synthesis script automating the complete logic synthesis flow: reads RTL sources, loads technology libraries and MMMC configuration, applies timing constraints, runs synthesis and optimization, inserts clock gating, generates the synthesized netlist, and exports reports. |
| [`constraints.sdc`](./constraints.sdc) | Design timing constraints — clock definition and period, input/output delay, driving cell, output loading, and clock uncertainty. Guides Genus in optimizing the design to meet the target operating frequency. |
| [`mmmc.tcl`](./mmmc.tcl) | Multi-Mode Multi-Corner analysis environment — library sets, RC corners, delay corners, constraint modes, and analysis views. Enables timing verification under the specified implementation corner. |

---

## Synthesis Results

### Design Summary

| Metric | Result |
|---|---:|
| Leaf Cell Count | **4,892** |
| Sequential Cells | **1,055** |
| Combinational Cells | **3,837** |
| Cell Area | **13,331.160 µm²** |

> **Observation:** The synthesized processor maps to fewer than 5,000 standard cells while maintaining a compact silicon area. The majority of the logic consists of combinational circuitry, with sequential elements primarily coming from the register file and processor state.

### Timing Analysis

| Metric | Result |
|---|---:|
| Total Negative Slack | **0 ns** |
| Violating Paths | **0** |
| Worst Slack | **Positive** |

> **Observation:** The design successfully meets all specified timing constraints. Zero violating paths and positive slack indicate that the processor is capable of operating at the target frequency without setup timing violations.

### Power Analysis

| Component | Result |
|---|---:|
| Leakage Power | **638.346 nW** |
| Dynamic Power | **84.462 µW** |
| Total Power | **85.100 µW** |

> **Observation:** Leakage power is extremely low, while dynamic power dominates overall consumption — expected for a synchronous processor. Automatic optimization and clock gating help reduce unnecessary switching activity.

### Clock Gating

| Metric | Result |
|---|---:|
| Clock Gating Cells | **31** |
| Total Flip-Flops | **1,024** |
| Clock-Gated Flip-Flops | **992 (96.88%)** |
| Ungated Flip-Flops | **32 (3.12%)** |
| Estimated Toggle Saving | **99.87%** |

> **Observation:** Cadence Genus successfully inserted clock-gating cells, gating nearly all sequential elements. This significantly reduces dynamic power without affecting functionality. The remaining ungated flip-flops correspond primarily to always-active registers such as the program counter.

---

## Quality of Results (QoR)

- Successful technology mapping
- Positive timing slack
- Zero timing violations
- Optimized standard-cell area
- Automatic clock-gating insertion
- Gate-level netlist generation ready for physical design

---

## Cadence Genus GUI

Screenshots from the Cadence Genus GUI showing the synthesized design, implementation statistics, and generated reports:

<p align="center">
  <img src="Synthesis/Reports/gui_show.png" alt="Cadence Genus GUI showing synthesis results" width="800">
</p>

---

## Next Stage

The next implementation milestone is **Physical Design** using Cadence Innovus, which will cover:

- Floorplanning
- Power Planning
- Placement
- Clock Tree Synthesis (CTS)
- Routing
- Physical Verification
- Post-route Optimization

Future updates to this repository will document each stage through final GDSII layout generation.

---

## Repository Structure
