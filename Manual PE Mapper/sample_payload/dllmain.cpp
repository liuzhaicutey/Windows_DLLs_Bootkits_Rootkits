#include <pch.h>
#include <windows.h>


BOOL APIENTRY DllMain(HMODULE hModule, DWORD reason, LPVOID lpReserved) {
    if (reason == DLL_PROCESS_ATTACH) {
        MessageBoxA(NULL, "Payload DLL loaded successfully!", "Success", MB_OK);
    }
    return TRUE;
}