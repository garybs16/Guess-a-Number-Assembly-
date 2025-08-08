# 🎯 Guessing Game — x86 Assembly (Irvine32)

An interactive **menu-based number guessing game** written in **x86 Assembly** using the **Irvine32** library.  
This project was created as part of the **CMPR-154 Final Project** by *Team Whatever*.

---

## 📜 Project Overview

The game simulates a credit-based guessing challenge where the player can:
1. **View their credit balance**
2. **Add credits** (up to $20)
3. **Play the guessing game**
4. **View gameplay statistics**
5. **Exit the game**

It uses **procedures, branching, loops, random number generation, and console I/O** to create a functional, user-friendly program entirely in assembly.

---

## 👥 Team Members

- **Annalucia Martinez** – Applied function calls, Case 2 (add credits), UI coloring
- **Gary Samuel** – Case 3–4 logic (gameplay & stats)
- **Jairo Villanos** – Menu display, Case 1 (view balance)

---

## 🖥 Features

- **Main Menu Navigation** with input validation
- **Credit System**
  - Start with $0
  - Max balance: $20
- **Guessing Game**
  - Costs $1 per play
  - Guess a number between **1 and 10**
  - Correct guess wins **$2**
  - Displays the correct number each round
- **Statistics Display**
  - Available credit
  - Total games played
  - Correct guesses & missed guesses
  - Money won & money lost
- **Name Entry**
  - Required before viewing statistics
- **Colored UI** for ASCII art title and sections

---



---

## 🛠 Requirements

- **Assembler:** MASM (Microsoft Macro Assembler)
- **Irvine32 Library:** From Kip Irvine’s *Assembly Language for x86 Processors*
- **OS:** Windows (32-bit environment or 64-bit with WOW64)
- **Tools:** Visual Studio or MASM32 SDK

---

## ▶️ How to Run

1. **Ensure Irvine32 Library is Installed**  
   Place `Irvine32.inc`, `Irvine32.lib`, and `Irvine32.dll` in the correct MASM/Visual Studio directories.

2. **Assemble and Link**
   ```bash
   ml /c /coff GuessingGame.asm
   link /subsystem:console GuessingGame.obj Irvine32.lib

