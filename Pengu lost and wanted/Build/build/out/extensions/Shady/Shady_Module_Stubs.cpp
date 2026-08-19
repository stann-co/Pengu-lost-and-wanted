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

#include "Shady_Module_Stubs.h"
#include <string>
#include <cstddef>

// ${gmlib_injection_global_includes}


static void* ExtUtils_GetLibraryHandle(const std::string& filename)
{
    return nullptr;
}

// ${gmlib_injection_global_before_stubs}



// ${gmlib_injection_global_after_stubs}

static void Release_Shady()
{
    
    // ${gmlib_injection_release_function}
    
    Logger_Debug("Finished releasing: Shady!\n");
}
extern "C" void Setup_Shady()
{
    
    // ${gmlib_injection_setup_function}
    
    EventSystem_OnProcessExit(&Release_Shady);
}
