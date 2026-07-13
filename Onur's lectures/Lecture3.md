### Summary of Lecture 3

This lecture covers foundational concepts in digital logic design, focusing on **combinational logic**, **sequential logic**, and the construction of **memory elements** and **finite state machines (FSMs)**. The discussion includes practical circuit examples, underlying principles, and design considerations essential for building meaningful digital systems such as processors and memory hierarchies.


### Key Topics Covered

#### 1. **Combinational Logic Recap and Components**

- **Combinational logic circuits** produce outputs solely based on current inputs, with no memory of past inputs.
- Components reviewed:
  - Basic logic gates (AND, OR, NOT, NAND, NOR, XOR)
  - Decoders and multiplexers, including their role in implementing sum-of-products logic forms.
  - Programmable Logic Arrays (PLAs) which implement arbitrary combinational functions by programming connections between decoders and OR gates.
  - Logical completeness:  
    - The set {AND, OR, NOT} gates is logically complete, meaning any combinational logic function can be constructed from them.  
    - NAND and NOR gates are each logically complete by themselves.

- **Equality comparator**:  
  - Checks if two $n$-bit inputs $A$ and $B$ are bitwise equal using bitwise XNOR gates followed by an AND gate across all bits.
  
- **Arithmetic Logic Unit (ALU)**:  
  - A modular unit performing arithmetic and logic operations on two $n$-bit inputs.  
  - Controlled by a function select input $F$ (typically 3 bits in the example), which determines the operation (e.g., AND, OR, ADD, SUBTRACT).  
  - Internally uses multiplexers, adders, and logic gates to select the desired operation based on $F$.

- Other combinational blocks mentioned but not detailed:
  - Multipliers, shifters, rotators, and dividers.
  - Comparator for greater/less than implemented via subtractor.

#### 2. **Tri-State Buffers and Shared Buses**

- **Tri-State buffer** acts as a switch controlled by an enable signal:  
  - When enable = 0, output is "floating" (high impedance), effectively disconnected.  
  - When enable = 1, input is connected to output.  
- Enables multiple components to share a single physical wire (bus) without signal collision.  
- Control logic ensures only one device drives the bus at any time to avoid electrical conflicts.

- Multiplexers can be implemented using tri-state buffers controlled by select lines.

- At the transistor level, tri-state buffers are implemented using pairs of transistors controlled by enable and its complement.

#### 3. **Boolean Algebra and Logic Simplification**

- **Logic simplification** reduces circuit complexity, area, power, and latency.  
- Tools and methods for simplification include Boolean algebra theorems (e.g., the **uniting theorem**), Karnaugh maps (*not covered in detail*), and design automation tools.  
- Example: Full adder sum and carry-out expressions simplified using XOR and majority functions.  
- Simplification may trade off minimal gate count for better technology mapping (power, latency).

#### 4. **Priority Circuits**

- Priority encoders grant bus access to the highest priority requester among multiple inputs.  
- Inputs $A_3, A_2, A_1, A_0$ represent requests; outputs $Y_3, Y_2, Y_1, Y_0$ grant the bus to one requester based on priority ordering.  
- Truth tables are often simplified using **don't care (X)** conditions to reduce implementation complexity.

---

### Sequential Logic and Memory Elements

#### 5. **Introduction to Sequential Logic**

- Unlike combinational logic, **sequential circuits produce outputs based on current inputs and past inputs (history)**, thus incorporating **memory**.  
- Memory elements store state information essential for computation, control, and data retention.

#### 6. **Cross-Coupled Inverters (Basic Storage Element)**

- Two inverters connected in a loop form a bistable circuit with two stable states:  
  - $Q = 1, \overline{Q} = 0$ or  
  - $Q = 0, \overline{Q} = 1$.  
- This forms the basic storage cell used in SRAM caches.

- There exists a **metastable state** where outputs oscillate before settling; usually avoided in design.

- However, this basic cell lacks external inputs for controlled setting/resetting of the stored bit.

#### 7. **RS Latch (Set-Reset Latch)**

- Constructed from two cross-coupled NAND gates with inputs $S$ (Set) and $R$ (Reset).  
- Inputs allow controlled setting or resetting of $Q$.  
- Truth table highlights forbidden condition:  
  - Both $S=0$ and $R=0$ is invalid (produces $Q = \overline{Q}$, violating Boolean logic).  
- Transitioning from this forbidden state can cause metastability (oscillation and uncertainty).

#### 8. **Gated D Latch**

- Controls when $Q$ is updated using a **write enable** signal.  
- When write enable = 1, input $D$ is stored to $Q$.  
- When write enable = 0, $Q$ holds its previous value.  
- Eliminates forbidden RS latch conditions and reduces metastability risk.

#### 9. **Registers**

- Multiple D latches arranged in parallel form a **register** to store multi-bit values.  
- Single write enable controls simultaneous writing to all bits.

#### 10. **Memory Arrays**

- Memory composed of multiple registers indexed by an **address**.  
- An **address decoder** selects which register to read or write.  
- A **multiplexer** selects the appropriate register output for reading.  
- Example:  
  - 2-location memory with 3-bit words (i.e., two 3-bit registers).  
  - Uses a 1-bit address to select which register is enabled for read/write.

- Scaling to more locations (e.g., 4 locations) requires larger decoders (e.g., 2-bit address) and multiplexers.

#### 11. **Memory as Logic Implementers (Lookup Tables)**

- Memory arrays can implement arbitrary combinational functions by storing truth table outputs at addresses corresponding to input combinations.  
- Used in FPGA lookup tables (LUTs).  
- Provides programmable logic but with higher hardware cost compared to fixed logic gates.

---

### Finite State Machines (FSMs) and Synchronous Circuits

#### 12. **Concept of State and FSMs**

- State: A snapshot of all relevant system elements at a given time.  
- FSMs model systems with a finite number of states and transitions triggered by inputs.  
- Example: Sequential lock which unlocks after a specific sequence of inputs, modeled as transitions through states $A \to B \to C \to D$.  
- Another example: Traffic light controller with states representing light colors.

#### 13. **Asynchronous vs. Synchronous FSMs**

- **Asynchronous FSMs**: State transitions occur immediately when inputs change, without a clock.  
  - Difficult to design due to race conditions and timing hazards.  
- **Synchronous FSMs**: State transitions occur only at clock edges, simplifying design and improving reliability.  
  - Clock divides time into discrete intervals; transitions occur only at clock edges.

#### 14. **Clock and Timing**

- Clock is a periodic signal oscillating between 0 and 1 used to synchronize state changes.  
- Ensures outputs are stable during a clock cycle, allowing combinational logic to compute next state.  
- Clock cycle duration must accommodate maximum combinational delay.

#### 15. **State Register Implementation**

- State stored in **flip-flops**, which are edge-triggered memory elements capturing data only on clock edges.  
- Basic **D latch** is level sensitive and transparent when enabled, which is problematic for synchronous design because outputs may change mid-cycle.  
- **D flip-flop** constructed by connecting two D latches in series with complementary clock enables:  
  - First latch transparent when clock is low (capturing input).  
  - Second latch transparent when clock is high (holding output stable).  
- Result: Flip-flop captures input at rising clock edge and holds output constant during the rest of the cycle.

- Multi-bit state registers constructed from parallel D flip-flops.

---

### Core Concepts and Definitions

| Term                    | Definition/Explanation                                                                                           |
|-------------------------|------------------------------------------------------------------------------------------------------------------|
| Combinational Logic     | Circuit output depends only on current inputs, no memory                                                         |
| Sequential Logic        | Circuit output depends on current inputs and past inputs (has memory)                                            |
| Logical Completeness    | A set of gates can implement any Boolean function; NAND and NOR gates alone are logically complete                |
| Tri-State Buffer        | A logic gate with an enable control that allows output to be disconnected (high impedance)                        |
| Priority Circuit        | Logic that grants access to one requester based on priority among multiple requests                                |
| RS Latch                | A basic memory element with Set (S) and Reset (R) inputs, storing one bit                                         |
| Metastable State        | Unstable oscillation state in storage elements that can occur due to forbidden input conditions                   |
| D Latch                 | Level-sensitive latch that transparently passes input to output when enabled                                      |
| D Flip-Flop             | Edge-triggered memory element capturing input only at clock edges, holding output stable throughout clock cycle  |
| Register                | Group of latches or flip-flops storing multiple bits                                                              |
| Decoder                 | Circuit that activates one output line based on input address bits                                                |
| Multiplexer             | Circuit that selects one of many inputs to pass to output based on select lines                                   |
| Finite State Machine    | Model of system with finite number of states and defined transitions between them                                 |
| Clock                   | Periodic signal used to synchronize state transitions in sequential circuits                                      |

---


