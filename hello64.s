// ------------------------------------------------------------
// Assembler program to print "Hello, Pi 5!"
// to stdout using Linux system calls (AArch64 / 64-bit).
//
// Registers used for Linux syscalls on AArch64:
//   x0-x5 : arguments 1-6 (arg0-arg5)
//   x8    : system call number
// Return value comes back in x0
// ------------------------------------------------------------

.global _start              // Export the label _start so the linker can use it as entry point

.section .text              // Put the following instructions in the code (text) section

_start:                     // Program entry point (where execution begins)

    mov     x0, #1          // x0 = 1  -> file descriptor 1 (stdout / terminal)
    adr     x1, msg         // x1 = address of msg (pointer to the bytes we want to print)
    mov     x2, #14         // x2 = 14 -> number of bytes to write (length of "Hello, Pi 5!\n")
    mov     x8, #64         // x8 = 64 -> syscall number for write() on AArch64 Linux
    svc     #0              // Make the syscall: write(1, msg, 14)

    mov     x0, #0          // x0 = 0  -> exit status code 0 (success)
    mov     x8, #93         // x8 = 93 -> syscall number for exit() on AArch64 Linux
    svc     #0              // Make the syscall: exit(0)  (program ends here)

.section .rodata            // Put the following data in read-only memory (constants)

msg:                        // Label marking the address where the string begins
    .ascii  "Hello, Pi 5!\n" // Store the string bytes exactly (no automatic null terminator)
