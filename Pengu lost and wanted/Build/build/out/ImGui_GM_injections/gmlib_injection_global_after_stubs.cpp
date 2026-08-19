void Initialize_ImGui_GM()
{
    if (isInitialized) return;
    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;
    isInitialized = true;
}

void Shutdown_ImGui_GM()
{
    if (!isInitialized) return;
    using FunctionPointer = void (*)();
    FunctionPointer fnHandle = nullptr;
    void* libHandle = nullptr;
    isInitialized = false;
}
