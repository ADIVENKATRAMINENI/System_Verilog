# ⚙️ SystemVerilog Concepts & Practice Repository  
#### 🧠 A Complete Hands-on Learning Journey for Design Verification Engineers

---

## 📘 Overview

This repository is a **curated collection of SystemVerilog concepts, examples, and practical testbench implementations** built as part of my Design Verification (DV) learning and practice.  

Each folder covers a fundamental **SystemVerilog feature** that forms the foundation for writing **UVM-based Verification Environments** — from basic procedural blocks to advanced topics like Assertions, Coverage, and Object-Oriented Programming.

---

## 🧩 Repository Structure

| 📂 Folder | 📝 Description |
|------------|----------------|
| **Assertions/** | Covers **Immediate & Concurrent Assertions**, properties, sequences, and ABV (Assertion-Based Verification). Includes practical examples for protocol checks and timing rules. |
| **Classes & OOPS/** | Demonstrates **OOP principles in SystemVerilog** (Encapsulation, Inheritance, Polymorphism, Virtual classes, Abstract methods) — crucial for understanding **UVM base class hierarchy**. |
| **Clocking_Blocks/** | Explains **clocking block synchronization** for DUT and testbench signal timing alignment. Includes examples of race-free testbenches. |
| **Conditionals & Procedural_Blocks/** | Contains examples on `if`, `case`, `always`, `initial`, and procedural flow control — basic constructs used in all TB and DUT designs. |
| **Coverage/** | Complete **Functional Coverage** module: covergroups, coverpoints, bins, transition bins, cross coverage, coverage options, and system tasks like `$get_coverage()` and `$coverage_save()`. |
| **Datatypes/** | Fundamental SystemVerilog data types — `logic`, `reg`, `bit`, arrays, queues, associative and dynamic data structures with examples. |
| **Digital Electronic Circuits/** | Hardware-level modeling (Flip-flops, Counters, FSMs, Registers) — to reinforce the link between **digital design** and its **verification** in SystemVerilog. |
| **Fork_Join/** | Demonstrates **parallel process control** (`fork-join`, `join_none`, `join_any`) for concurrent operations in testbenches. |
| **Interfaces/** | Core folder for **modular testbench connectivity** — includes modports, hierarchy understanding, and examples integrating drivers and monitors via interfaces. |
| **Interprocess_Communication/** | Examples using **mailboxes, semaphores, and events** — synchronization mechanisms for communication between parallel processes. |
| **Operators_SV/** | Practical examples of SystemVerilog operators: arithmetic, logical, bitwise, reduction, and shift operators. |
| **Program_Blocking/** | Explains **program blocks** and their role in eliminating race conditions between DUT and testbench. |
| **Randomization & Constraints/** | Covers **random stimulus generation**, constraint blocks, `randc`, `post_randomize()`, and inline constraint techniques used in UVM sequences. |
| **Tasks & Functions/** | Detailed examples on procedural reusability using `task`, `function`, `automatic`, `void`, and argument passing mechanisms. |

---

## 🧮 Learning Path Summary

The repository follows a **bottom-up learning path** used in professional verification training:

1. **Digital Foundations** → Logic, counters, FSMs  
2. **Language Core** → Datatypes, procedural blocks, operators  
3. **Concurrency & Communication** → fork/join, mailboxes, semaphores  
4. **Modularity** → Interfaces, clocking blocks, program blocks  
5. **Randomization & Constraints** → Intelligent test stimulus  
6. **Assertions** → Design correctness checks  
7. **Functional Coverage** → Verification completeness metrics  
8. **OOP & Classes** → Foundation for UVM environment design  

---

## 🧠 Key Takeaways for Design Verification

✔️ SystemVerilog’s class-based features enable **reusability and scalability** in testbenches.  
✔️ Functional Coverage ensures **verification completeness**.  
✔️ Assertions help catch **timing and protocol violations automatically**.  
✔️ Randomization with constraints leads to **intelligent test scenarios**.  
✔️ Communication constructs synchronize **driver-monitor-scoreboard** interactions.  
✔️ Interfaces and clocking blocks ensure **clean signal management** in SoC environments.

---

## 🧰 Tools Used

EDA Playground (online simulation for quick verification).
Mentor QuestaSim, ModelSim, Synopsys VCS, Cadence Xcelium (for advanced simulations).
VS Code / Sublime Text for code organization and Git integration.

---

## 🎯 Objective

This repository serves as:
A personal learning reference for advanced SystemVerilog concepts.
A foundation to transition into UVM (Universal Verification Methodology).
A showcase for recruiters/interviewers to demonstrate systematic skill-building in DV.

---

## 🧩 Next Phase

🚀 Transition to UVM testbench construction, leveraging:
Class inheritance & virtual interfaces.
Transaction-level communication.
Factory pattern & configuration DB.
Assertions + Coverage integration for closure.

---

💡 “Good verification is not just about finding bugs — it’s about proving there are none left.”

