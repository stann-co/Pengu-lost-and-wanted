// Common

typedef int int32;
typedef unsigned long long uint64;

// Partial declaration with no functions (so we can pass it along)
struct gmval_c {
    uint64 _v;
};

typedef gmval_c (*CronusFunc_c)(gmval_c self, gmval_c callee, int argc, gmval_c* args);

// Logging

extern "C" void Logger_Error(const char* msg);
extern "C" void Logger_Warning(const char* msg);
extern "C" void Logger_Debug(const char* msg);

// Shared Library

extern "C" void* SharedLibrary_Load(const char* fullpath);
extern "C" bool SharedLibrary_Release(void* handle);
extern "C" void* SharedLibrary_GetFunctionAddress(void* handle, const char* functionName);
extern "C" void SharedLibrary_FlushErrorLog();

// Event System

extern "C" void EventSystem_OnWADLoaded(void (*fn)());
extern "C" void EventSystem_OnGameStart(void (*fn)());
extern "C" void EventSystem_OnGameEnd(void (*fn)());
extern "C" void EventSystem_OnProcessExit(void (*fn)());

// GMVal Coerce

extern "C" double gmval_CoerceReal(gmval_c val);
extern "C" const char* gmval_CoerceCString(gmval_c val);;

// GMVal From

extern "C" gmval_c gmval_FromDouble(double d);
extern "C" gmval_c gmval_FromString(const char* s);

extern "C" gmval_c gmval_undefined();

// Extension Options

extern "C" const char* ExtensionOptions_GetValue(const char* extName, const char* optionName);

// RunnerInterface

extern "C" void RunnerInterface_AddFunction(const char* name, CronusFunc_c func, int argc);
extern "C" void RunnerInterface_AddConstant_Double(const char* name, double value);
extern "C" void RunnerInterface_AddConstant_String(const char* name, const char* value);
extern "C" void RunnerInterface_ArgCountError(const char* funcName, int argc, int expected);

#include "window_command_hook_Module_Stubs.h"
#include <string>
#include <cstddef>

// ${gmlib_injection_global_includes}


void* window_command_hook__window_command_hook_dll_libHandle{};
void* window_command_hook__window_command_hook_dll_funcPointers[17]{};

static void* ExtUtils_GetLibraryHandle(const std::string& filename)
{
    if (filename == "window_command_hook.dll") return window_command_hook__window_command_hook_dll_libHandle;
    return nullptr;
}

// Injected from gmlib_injection_global_before_stubs.cpp
static bool isInitialized = false;
// End of injected code (gmlib_injection_global_before_stubs.cpp)


extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_command_hook_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_command_hook_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_command_hook_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[0];
    if (window_command_hook_raw == nullptr) return gmval_undefined();
    double result = window_command_hook_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_command_unhook_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_command_unhook_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_command_unhook_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[1];
    if (window_command_unhook_raw == nullptr) return gmval_undefined();
    double result = window_command_unhook_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_command_check_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_command_check_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_command_check_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[2];
    if (window_command_check_raw == nullptr) return gmval_undefined();
    double result = window_command_check_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_command_run_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_command_run_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_command_run_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[3];
    if (window_command_run_raw == nullptr) return gmval_undefined();
    double result = window_command_run_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_command_get_active_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_command_get_active_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_command_get_active_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[4];
    if (window_command_get_active_raw == nullptr) return gmval_undefined();
    double result = window_command_get_active_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_command_set_active_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_command_set_active_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_command_set_active_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[5];
    if (window_command_set_active_raw == nullptr) return gmval_undefined();
    double result = window_command_set_active_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_get_background_redraw_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_get_background_redraw_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_get_background_redraw_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[6];
    if (window_get_background_redraw_raw == nullptr) return gmval_undefined();
    double result = window_get_background_redraw_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_set_background_redraw_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_set_background_redraw_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_set_background_redraw_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[7];
    if (window_set_background_redraw_raw == nullptr) return gmval_undefined();
    double result = window_set_background_redraw_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_get_topmost_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_get_topmost_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_get_topmost_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[8];
    if (window_get_topmost_raw == nullptr) return gmval_undefined();
    double result = window_get_topmost_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_set_topmost_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_set_topmost_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_set_topmost_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[9];
    if (window_set_topmost_raw == nullptr) return gmval_undefined();
    double result = window_set_topmost_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_get_taskbar_button_visible_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_get_taskbar_button_visible_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_get_taskbar_button_visible_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[10];
    if (window_get_taskbar_button_visible_raw == nullptr) return gmval_undefined();
    double result = window_get_taskbar_button_visible_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_set_taskbar_button_visible_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_set_taskbar_button_visible_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_set_taskbar_button_visible_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[11];
    if (window_set_taskbar_button_visible_raw == nullptr) return gmval_undefined();
    double result = window_set_taskbar_button_visible_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_get_clickthrough_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_get_clickthrough_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_get_clickthrough_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[12];
    if (window_get_clickthrough_raw == nullptr) return gmval_undefined();
    double result = window_get_clickthrough_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_set_clickthrough_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_set_clickthrough_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_set_clickthrough_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[13];
    if (window_set_clickthrough_raw == nullptr) return gmval_undefined();
    double result = window_set_clickthrough_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_get_noactivate_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_get_noactivate_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_get_noactivate_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[14];
    if (window_get_noactivate_raw == nullptr) return gmval_undefined();
    double result = window_get_noactivate_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_set_noactivate_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_set_noactivate_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_set_noactivate_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[15];
    if (window_set_noactivate_raw == nullptr) return gmval_undefined();
    double result = window_set_noactivate_raw(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__window_command_hook__window_set_visible_w_raw(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("window_set_visible_w_raw", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr window_set_visible_w_raw = (FunctionPtr)window_command_hook__window_command_hook_dll_funcPointers[16];
    if (window_set_visible_w_raw == nullptr) return gmval_undefined();
    double result = window_set_visible_w_raw(arg0, arg1);
    return gmval_FromDouble(result);
}

// Injected from gmlib_injection_global_after_stubs.cpp
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

// End of injected code (gmlib_injection_global_after_stubs.cpp)

static void Release_window_command_hook()
{
    
    // Injected from gmlib_injection_release_function.cpp

    if (isInitialized) Shutdown_window_command_hook();

// End of injected code (gmlib_injection_release_function.cpp)
    
    SharedLibrary_Release(window_command_hook__window_command_hook_dll_libHandle);
    for (auto& p : window_command_hook__window_command_hook_dll_funcPointers) p = nullptr;
    window_command_hook__window_command_hook_dll_libHandle = nullptr;
    SharedLibrary_FlushErrorLog();
    Logger_Debug("Finished releasing: window_command_hook!\n");
}
extern "C" void Setup_window_command_hook()
{
    window_command_hook__window_command_hook_dll_libHandle = SharedLibrary_Load("window_command_hook_x64.dll");
    if (window_command_hook__window_command_hook_dll_libHandle)
    {
        window_command_hook__window_command_hook_dll_funcPointers[0] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_command_hook_raw");
        window_command_hook__window_command_hook_dll_funcPointers[1] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_command_unhook_raw");
        window_command_hook__window_command_hook_dll_funcPointers[2] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_command_check_raw");
        window_command_hook__window_command_hook_dll_funcPointers[3] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_command_run_raw");
        window_command_hook__window_command_hook_dll_funcPointers[4] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_command_get_active_raw");
        window_command_hook__window_command_hook_dll_funcPointers[5] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_command_set_active_raw");
        window_command_hook__window_command_hook_dll_funcPointers[6] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_get_background_redraw_raw");
        window_command_hook__window_command_hook_dll_funcPointers[7] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_set_background_redraw_raw");
        window_command_hook__window_command_hook_dll_funcPointers[8] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_get_topmost_raw");
        window_command_hook__window_command_hook_dll_funcPointers[9] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_set_topmost_raw");
        window_command_hook__window_command_hook_dll_funcPointers[10] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_get_taskbar_button_visible_raw");
        window_command_hook__window_command_hook_dll_funcPointers[11] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_set_taskbar_button_visible_raw");
        window_command_hook__window_command_hook_dll_funcPointers[12] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_get_clickthrough_raw");
        window_command_hook__window_command_hook_dll_funcPointers[13] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_set_clickthrough_raw");
        window_command_hook__window_command_hook_dll_funcPointers[14] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_get_noactivate_raw");
        window_command_hook__window_command_hook_dll_funcPointers[15] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_set_noactivate_raw");
        window_command_hook__window_command_hook_dll_funcPointers[16] = SharedLibrary_GetFunctionAddress(window_command_hook__window_command_hook_dll_libHandle, "window_set_visible_w_raw");
    }
    SharedLibrary_FlushErrorLog();
    
    RunnerInterface_AddFunction("window_command_hook_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_command_hook_raw, 2);
    RunnerInterface_AddFunction("window_command_unhook_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_command_unhook_raw, 2);
    RunnerInterface_AddFunction("window_command_check_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_command_check_raw, 2);
    RunnerInterface_AddFunction("window_command_run_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_command_run_raw, 2);
    RunnerInterface_AddFunction("window_command_get_active_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_command_get_active_raw, 2);
    RunnerInterface_AddFunction("window_command_set_active_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_command_set_active_raw, 2);
    RunnerInterface_AddFunction("window_get_background_redraw_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_get_background_redraw_raw, 2);
    RunnerInterface_AddFunction("window_set_background_redraw_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_set_background_redraw_raw, 2);
    RunnerInterface_AddFunction("window_get_topmost_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_get_topmost_raw, 2);
    RunnerInterface_AddFunction("window_set_topmost_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_set_topmost_raw, 2);
    RunnerInterface_AddFunction("window_get_taskbar_button_visible_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_get_taskbar_button_visible_raw, 2);
    RunnerInterface_AddFunction("window_set_taskbar_button_visible_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_set_taskbar_button_visible_raw, 2);
    RunnerInterface_AddFunction("window_get_clickthrough_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_get_clickthrough_raw, 2);
    RunnerInterface_AddFunction("window_set_clickthrough_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_set_clickthrough_raw, 2);
    RunnerInterface_AddFunction("window_get_noactivate_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_get_noactivate_raw, 2);
    RunnerInterface_AddFunction("window_set_noactivate_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_set_noactivate_raw, 2);
    RunnerInterface_AddFunction("window_set_visible_w_raw", __GMLIBSTUB_GMVAL__window_command_hook__window_set_visible_w_raw, 2);
    
    // Injected from gmlib_injection_setup_function.cpp

    EventSystem_OnGameStart(&Initialize_window_command_hook);
    EventSystem_OnGameEnd(&Shutdown_window_command_hook);

// End of injected code (gmlib_injection_setup_function.cpp)
    
    EventSystem_OnProcessExit(&Release_window_command_hook);
}
