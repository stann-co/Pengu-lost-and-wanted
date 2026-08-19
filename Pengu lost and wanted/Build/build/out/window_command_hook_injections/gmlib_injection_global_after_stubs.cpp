void Initialize_window_command_hook()
{
    if (isInitialized) return;
    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;
    libHandle = ExtUtils_GetLibraryHandle("window_command_hook.gml");
    if (libHandle)
    {
        fnHandle = (FunctionPointer)SharedLibrary_GetFunctionAddress(libHandle, "window_command_hook_init");
        if (fnHandle) fnHandle();
    }
    isInitialized = true;
}

void Shutdown_window_command_hook()
{
    if (!isInitialized) return;
    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;
    isInitialized = false;
}
