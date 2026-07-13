### Summary of Lecture 1

This lecture serves as an introduction to the course on **Digital Design and Computer Architecture (DDCA)**, laying a foundational understanding of modern computer systems, their components, design principles, and the research landscape. The lecture also begins technical material focusing on **transistors and logic gates**, which are the fundamental building blocks of digital computers.

---


### Definitions and Concepts

| Term | Definition | Notes |
|-------|-------------|-------|
| **Instruction Set Architecture (ISA)** | The contract/interface between software and hardware, defining what the programmer assumes hardware will do. | Difficult to change because of software dependency. |
| **Microarchitecture** | The hardware implementation of an ISA; multiple microarchitectures can implement the same ISA differently. | Easier to innovate at this level. |
| **Computer Architecture** | The science and art of designing computing platforms, primarily focusing on ISA and microarchitecture, but also system software and programming models. | Combines engineering and intuition for future-proof design. |


### Types of Processing Units and Programming Models

| Processing Unit Type | Characteristics | Programming Model | Use Case |
|---------------------|-----------------|-------------------|----------|
| General Purpose Processor (CPU) | Flexible, easy to program, moderate performance and energy efficiency. | High-level languages, general software. | Widely used for diverse applications. |
| Special Purpose Processor (ASIC) | Highly efficient and performant for specific tasks but inflexible and hard to program. | Low-level, specialized languages or fixed-function hardware. | Video encoding, ML acceleration, genomic analysis. |
| GPUs | Initially special purpose (graphics), now more general purpose and heterogeneous. | SIMD (single instruction, multiple data), specialized programming models. | Parallel workloads, machine learning. |
| FPGA | Programmable hardware fabric, general purpose but requires hardware design expertise. | Hardware description languages (Verilog, VHDL). | Prototyping and specialized hardware design. |

- Analogy: Adjustable wrench (general purpose) vs. fixed-size wrench (special purpose).

---

### Technical Material: Transistors as Building Blocks

- All modern digital computers are built from **MOS (Metal-Oxide-Semiconductor) transistors**.
- Examples of transistor counts over time:
  - 1971 Intel 4004: ~2,300 transistors.
  - 2000 Pentium 4: 42 million transistors.
  - Recent Apple M2 Max: ~67 billion transistors.
- Transistor abstraction: behaves like a **switch** controlled by gate voltage.
- Two types of MOS transistors:
  - **N-type MOS (NMOS)**: conducts when gate voltage is high.
  - **P-type MOS (PMOS)**: conducts when gate voltage is low.
- Transistors can be combined to create **logic gates**, which perform Boolean functions.

---

### Transistor Operation Analogy: Wall Switch and Lamp Circuit

- Electron flow must form a **closed circuit** for the lamp to light.
- A transistor acts like a wall switch that can **open or close the circuit** based on gate voltage.
- NMOS transistor closes the circuit (acts like a wire) when gate is high voltage; otherwise, open circuit.
- PMOS transistor closes the circuit when gate is low voltage; otherwise, open circuit.
- Lower voltage operation saves energy but reduces noise margin and reliability.

---

### Logic Gates: CMOS Inverter (NOT Gate)

- CMOS = **Complementary MOS** technology uses both NMOS and PMOS transistors.
- Basic CMOS inverter circuit:
  - PMOS transistor connected to high voltage (3V), NMOS connected to low voltage (0V).
  - Input drives gates of both transistors.
- Operation:
  - Input low (0 V): PMOS conducts (closed), NMOS off → output connected to high voltage (logic 1).
  - Input high (3 V): NMOS conducts, PMOS off → output connected to low voltage (logic 0).
- The output is the **logical complement** of the input.
- Truth table for inverter:

| Input ($a$) | Output ($Y$) | PMOS | NMOS |
|-------------|--------------|-------|-------|
| 0           | 1            | On    | Off   |
| 1           | 0            | Off   | On    |

- This inverter is the **simplest CMOS logic gate** and the foundation for others.

---

### More Complex Logic Gates: NAND Gate

- CMOS NAND gate built from two PMOS in parallel (pull-up network) and two NMOS in series (pull-down network).
- Inputs: $A$ and $B$ drive the gates of the transistors.
- Operation:
  - If either $A=0$ or $B=0$, at least one PMOS transistor conducts → output is pulled high (logic 1).
  - Only when both $A=1$ and $B=1$, both NMOS transistors conduct → output pulled low (logic 0).
- Truth table for NAND gate:

| $A$ | $B$ | Output ($Y$) |
|-----|-----|--------------|
| 0   | 0   | 1            |
| 0   | 1   | 1            |
| 1   | 0   | 1            |
| 1   | 1   | 0            |

- NAND is a **universal gate** (all logic functions can be constructed from NAND gates).
- NAND gate is less expensive in terms of transistor count compared to AND gate.
- AND gate can be constructed by adding an inverter after a NAND gate.

---

### CMOS Logic Gate Design Principles

- CMOS gates consist of:
  - **Pull-up network** (PMOS transistors) connected to $V_{DD}$ (high voltage).
  - **Pull-down network** (NMOS transistors) connected to ground (0 V).
- Networks are complementary: when pull-up is on, pull-down is off, and vice versa.
- Transistors in series require all to conduct for the network to be on; transistors in parallel require at least one to conduct.
- PMOS transistors are better at pulling the output **up** (to high voltage).
- NMOS transistors are better at pulling the output **down** (to low voltage).

---

