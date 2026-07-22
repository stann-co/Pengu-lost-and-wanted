void Initialize_Steamworks()
{
    if (isInitialized) return;
    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;
    libHandle = ExtUtils_GetLibraryHandle("Steamworks.ext");
    if (libHandle)
    {
        fnHandle = (FunctionPointer)SharedLibrary_GetFunctionAddress(libHandle, "steam_init");
        if (fnHandle) fnHandle();
    }
    isInitialized = true;
}

void Shutdown_Steamworks()
{
    if (!isInitialized) return;
    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;
    isInitialized = false;
}
