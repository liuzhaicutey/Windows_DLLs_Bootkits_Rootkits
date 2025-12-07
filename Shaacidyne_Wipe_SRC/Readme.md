This is a *basic* kawaii bootloader wiper. It also has many uwus hehe. Make sure to set boot options to legacy BIOS, or not. Up to you hehe.
1. FOR LEGACY Payload: nasm -f bin -o bootloader.bin bootloader.asm (assemble via NASM or use the already .bin file).
2. FOR UEFI Payload: You should convert it to a .efi file using EDK or MSYS2 with GNU-EFI and GCC Compiler.
3. Save the .bin or the .efi file in the same directory as the .py or .exe loader if you compiled it. Let the loader do its job.
4. Use it on a virtual machine for testing purposes (QEMU, VirtualBox, etc.) I HIGHLY RECOMMEND NOT TO TEST IT ON AN ACTUAL MACHINE •̀ω•́
