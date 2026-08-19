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

#include "Steamworks_Module_Stubs.h"
#include <string>
#include <cstddef>

// ${gmlib_injection_global_includes}


void* Steamworks__Steamworks_ext_libHandle{};
void* Steamworks__Steamworks_ext_funcPointers[283]{};

static void* ExtUtils_GetLibraryHandle(const std::string& filename)
{
    if (filename == "Steamworks.ext") return Steamworks__Steamworks_ext_libHandle;
    return nullptr;
}

// Injected from gmlib_injection_global_before_stubs.cpp
static bool isInitialized = false;
// End of injected code (gmlib_injection_global_before_stubs.cpp)


extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_owns_dlc(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_user_owns_dlc", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_user_owns_dlc = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[0];
    if (steam_user_owns_dlc == nullptr) return gmval_undefined();
    double result = steam_user_owns_dlc(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_installed_dlc(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_user_installed_dlc", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_user_installed_dlc = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[1];
    if (steam_user_installed_dlc == nullptr) return gmval_undefined();
    double result = steam_user_installed_dlc(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_current_game_language(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_current_game_language", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_current_game_language = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[2];
    if (steam_current_game_language == nullptr) return gmval_undefined();
    const char* result = steam_current_game_language();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_available_languages(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_available_languages", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_available_languages = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[3];
    if (steam_available_languages == nullptr) return gmval_undefined();
    const char* result = steam_available_languages();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_activate_overlay", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_activate_overlay = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[4];
    if (steam_activate_overlay == nullptr) return gmval_undefined();
    double result = steam_activate_overlay(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_persona_name(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_persona_name", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_persona_name = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[5];
    if (steam_get_persona_name == nullptr) return gmval_undefined();
    const char* result = steam_get_persona_name();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_overlay_enabled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_overlay_enabled", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_overlay_enabled = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[6];
    if (steam_is_overlay_enabled == nullptr) return gmval_undefined();
    double result = steam_is_overlay_enabled();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_overlay_activated(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_overlay_activated", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_overlay_activated = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[7];
    if (steam_is_overlay_activated == nullptr) return gmval_undefined();
    double result = steam_is_overlay_activated();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay_browser(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_activate_overlay_browser", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_activate_overlay_browser = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[8];
    if (steam_activate_overlay_browser == nullptr) return gmval_undefined();
    double result = steam_activate_overlay_browser(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay_user(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_activate_overlay_user", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_activate_overlay_user = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[9];
    if (steam_activate_overlay_user == nullptr) return gmval_undefined();
    double result = steam_activate_overlay_user(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay_store(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_activate_overlay_store", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_activate_overlay_store = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[10];
    if (steam_activate_overlay_store == nullptr) return gmval_undefined();
    double result = steam_activate_overlay_store(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_persona_name(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_user_persona_name", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_get_user_persona_name = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[11];
    if (steam_get_user_persona_name == nullptr) return gmval_undefined();
    const char* result = steam_get_user_persona_name(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_cloud_enabled_for_app(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_cloud_enabled_for_app", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_cloud_enabled_for_app = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[12];
    if (steam_is_cloud_enabled_for_app == nullptr) return gmval_undefined();
    double result = steam_is_cloud_enabled_for_app();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_cloud_enabled_for_account(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_cloud_enabled_for_account", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_cloud_enabled_for_account = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[13];
    if (steam_is_cloud_enabled_for_account == nullptr) return gmval_undefined();
    double result = steam_is_cloud_enabled_for_account();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_persisted(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_file_persisted", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_persisted = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[14];
    if (steam_file_persisted == nullptr) return gmval_undefined();
    double result = steam_file_persisted(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_quota_total(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_quota_total", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_quota_total = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[15];
    if (steam_get_quota_total == nullptr) return gmval_undefined();
    double result = steam_get_quota_total();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_quota_free(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_quota_free", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_quota_free = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[16];
    if (steam_get_quota_free == nullptr) return gmval_undefined();
    double result = steam_get_quota_free();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_write(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_file_write", argc, 3);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_file_write = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[17];
    if (steam_file_write == nullptr) return gmval_undefined();
    double result = steam_file_write(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_write_file(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_file_write_file", argc, 2);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(const char*, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_write_file = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[18];
    if (steam_file_write_file == nullptr) return gmval_undefined();
    double result = steam_file_write_file(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_read(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_file_read", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_read = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[19];
    if (steam_file_read == nullptr) return gmval_undefined();
    const char* result = steam_file_read(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_delete(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_file_delete", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_delete = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[20];
    if (steam_file_delete == nullptr) return gmval_undefined();
    double result = steam_file_delete(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_exists(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_file_exists", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_exists = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[21];
    if (steam_file_exists == nullptr) return gmval_undefined();
    double result = steam_file_exists(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_file_size", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_size = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[22];
    if (steam_file_size == nullptr) return gmval_undefined();
    double result = steam_file_size(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_share(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_file_share", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_file_share = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[23];
    if (steam_file_share == nullptr) return gmval_undefined();
    double result = steam_file_share(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_screenshot_requested(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_screenshot_requested", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_screenshot_requested = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[24];
    if (steam_is_screenshot_requested == nullptr) return gmval_undefined();
    double result = steam_is_screenshot_requested();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_send_screenshot(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_send_screenshot", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_send_screenshot = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[25];
    if (steam_send_screenshot == nullptr) return gmval_undefined();
    double result = steam_send_screenshot(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_download(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_download", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_download = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[26];
    if (steam_ugc_download == nullptr) return gmval_undefined();
    double result = steam_ugc_download(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_create_item", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_create_item = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[27];
    if (steam_ugc_create_item == nullptr) return gmval_undefined();
    double result = steam_ugc_create_item(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_start_item_update(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_start_item_update", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_start_item_update = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[28];
    if (steam_ugc_start_item_update == nullptr) return gmval_undefined();
    double result = steam_ugc_start_item_update(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_submit_item_update(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_submit_item_update", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_submit_item_update = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[29];
    if (steam_ugc_submit_item_update == nullptr) return gmval_undefined();
    double result = steam_ugc_submit_item_update(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_title(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_set_item_title", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_title = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[30];
    if (steam_ugc_set_item_title == nullptr) return gmval_undefined();
    double result = steam_ugc_set_item_title(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_description(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_set_item_description", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_description = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[31];
    if (steam_ugc_set_item_description == nullptr) return gmval_undefined();
    double result = steam_ugc_set_item_description(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_visibility(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_set_item_visibility", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_visibility = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[32];
    if (steam_ugc_set_item_visibility == nullptr) return gmval_undefined();
    double result = steam_ugc_set_item_visibility(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_tags(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_set_item_tags", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_tags = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[33];
    if (steam_ugc_set_item_tags == nullptr) return gmval_undefined();
    double result = steam_ugc_set_item_tags(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_content(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_set_item_content", argc, 2);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(const char*, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_content = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[34];
    if (steam_ugc_set_item_content == nullptr) return gmval_undefined();
    double result = steam_ugc_set_item_content(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_preview(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_set_item_preview", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_preview = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[35];
    if (steam_ugc_set_item_preview == nullptr) return gmval_undefined();
    double result = steam_ugc_set_item_preview(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_item_update_progress(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_get_item_update_progress", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_get_item_update_progress = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[36];
    if (steam_ugc_get_item_update_progress == nullptr) return gmval_undefined();
    double result = steam_ugc_get_item_update_progress(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_subscribe_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_ugc_subscribe_item", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_subscribe_item = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[37];
    if (steam_ugc_subscribe_item == nullptr) return gmval_undefined();
    double result = steam_ugc_subscribe_item(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_unsubscribe_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_ugc_unsubscribe_item", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_unsubscribe_item = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[38];
    if (steam_ugc_unsubscribe_item == nullptr) return gmval_undefined();
    double result = steam_ugc_unsubscribe_item(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_num_subscribed_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_ugc_num_subscribed_items", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_ugc_num_subscribed_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[39];
    if (steam_ugc_num_subscribed_items == nullptr) return gmval_undefined();
    double result = steam_ugc_num_subscribed_items();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_subscribed_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_ugc_get_subscribed_items", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_get_subscribed_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[40];
    if (steam_ugc_get_subscribed_items == nullptr) return gmval_undefined();
    double result = steam_ugc_get_subscribed_items(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_item_install_info(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_get_item_install_info", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_get_item_install_info = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[41];
    if (steam_ugc_get_item_install_info == nullptr) return gmval_undefined();
    double result = steam_ugc_get_item_install_info(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_item_update_info(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_get_item_update_info", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_get_item_update_info = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[42];
    if (steam_ugc_get_item_update_info == nullptr) return gmval_undefined();
    double result = steam_ugc_get_item_update_info(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_request_item_details(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_request_item_details", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_request_item_details = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[43];
    if (steam_ugc_request_item_details == nullptr) return gmval_undefined();
    double result = steam_ugc_request_item_details(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_delete_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_ugc_delete_item", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_delete_item = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[44];
    if (steam_ugc_delete_item == nullptr) return gmval_undefined();
    double result = steam_ugc_delete_item(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_user(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 4)
        RunnerInterface_ArgCountError("steam_ugc_create_query_user", argc, 4);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    using FunctionPtr = double(*)(double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_create_query_user = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[45];
    if (steam_ugc_create_query_user == nullptr) return gmval_undefined();
    double result = steam_ugc_create_query_user(arg0, arg1, arg2, arg3);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_user_ex(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 7)
        RunnerInterface_ArgCountError("steam_ugc_create_query_user_ex", argc, 7);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    double arg6;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    arg5 = gmval_CoerceReal(args[5]);
    arg6 = gmval_CoerceReal(args[6]);
    using FunctionPtr = double(*)(double, double, double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_create_query_user_ex = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[46];
    if (steam_ugc_create_query_user_ex == nullptr) return gmval_undefined();
    double result = steam_ugc_create_query_user_ex(arg0, arg1, arg2, arg3, arg4, arg5, arg6);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_all(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_ugc_create_query_all", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_create_query_all = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[47];
    if (steam_ugc_create_query_all == nullptr) return gmval_undefined();
    double result = steam_ugc_create_query_all(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_all_ex(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 5)
        RunnerInterface_ArgCountError("steam_ugc_create_query_all_ex", argc, 5);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    using FunctionPtr = double(*)(double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_create_query_all_ex = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[48];
    if (steam_ugc_create_query_all_ex == nullptr) return gmval_undefined();
    double result = steam_ugc_create_query_all_ex(arg0, arg1, arg2, arg3, arg4);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_cloud_filename_filter(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_cloud_filename_filter", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_cloud_filename_filter = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[49];
    if (steam_ugc_query_set_cloud_filename_filter == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_cloud_filename_filter(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_match_any_tag(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_match_any_tag", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_match_any_tag = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[50];
    if (steam_ugc_query_set_match_any_tag == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_match_any_tag(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_search_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_search_text", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_search_text = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[51];
    if (steam_ugc_query_set_search_text == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_search_text(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_ranked_by_trend_days(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_ranked_by_trend_days", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_ranked_by_trend_days = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[52];
    if (steam_ugc_query_set_ranked_by_trend_days == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_ranked_by_trend_days(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_add_required_tag(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_add_required_tag", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_add_required_tag = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[53];
    if (steam_ugc_query_add_required_tag == nullptr) return gmval_undefined();
    double result = steam_ugc_query_add_required_tag(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_add_excluded_tag(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_add_excluded_tag", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_add_excluded_tag = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[54];
    if (steam_ugc_query_add_excluded_tag == nullptr) return gmval_undefined();
    double result = steam_ugc_query_add_excluded_tag(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_return_long_description(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_return_long_description", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = double(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_return_long_description = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[55];
    if (steam_ugc_query_set_return_long_description == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_return_long_description(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_return_total_only(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_return_total_only", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_return_total_only = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[56];
    if (steam_ugc_query_set_return_total_only == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_return_total_only(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_allow_cached_response(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_ugc_query_set_allow_cached_response", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_allow_cached_response = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[57];
    if (steam_ugc_query_set_allow_cached_response == nullptr) return gmval_undefined();
    double result = steam_ugc_query_set_allow_cached_response(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_send_query(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_ugc_send_query", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_ugc_send_query = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[58];
    if (steam_ugc_send_query == nullptr) return gmval_undefined();
    double result = steam_ugc_send_query(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_user_logged_on(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_user_logged_on", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_user_logged_on = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[59];
    if (steam_is_user_logged_on == nullptr) return gmval_undefined();
    double result = steam_is_user_logged_on();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_steam_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_user_steam_id", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_user_steam_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[60];
    if (steam_get_user_steam_id == nullptr) return gmval_undefined();
    double result = steam_get_user_steam_id();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_account_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_user_account_id", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_user_account_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[61];
    if (steam_get_user_account_id == nullptr) return gmval_undefined();
    double result = steam_get_user_account_id();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_app_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_app_id", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_app_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[62];
    if (steam_get_app_id == nullptr) return gmval_undefined();
    double result = steam_get_app_id();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_create_leaderboard(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_create_leaderboard", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_create_leaderboard = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[63];
    if (steam_create_leaderboard == nullptr) return gmval_undefined();
    double result = steam_create_leaderboard(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_upload_score", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_upload_score = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[64];
    if (steam_upload_score == nullptr) return gmval_undefined();
    double result = steam_upload_score(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score_ext(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_upload_score_ext", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_upload_score_ext = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[65];
    if (steam_upload_score_ext == nullptr) return gmval_undefined();
    double result = steam_upload_score_ext(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score_buffer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_upload_score_buffer", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_upload_score_buffer = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[66];
    if (steam_upload_score_buffer == nullptr) return gmval_undefined();
    double result = steam_upload_score_buffer(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score_buffer_ext(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 4)
        RunnerInterface_ArgCountError("steam_upload_score_buffer_ext", argc, 4);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    double arg3;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    using FunctionPtr = double(*)(const char*, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_upload_score_buffer_ext = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[67];
    if (steam_upload_score_buffer_ext == nullptr) return gmval_undefined();
    double result = steam_upload_score_buffer_ext(arg0, arg1, arg2, arg3);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_download_scores(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_download_scores", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_download_scores = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[68];
    if (steam_download_scores == nullptr) return gmval_undefined();
    double result = steam_download_scores(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_download_scores_around_user(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_download_scores_around_user", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_download_scores_around_user = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[69];
    if (steam_download_scores_around_user == nullptr) return gmval_undefined();
    double result = steam_download_scores_around_user(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_download_friends_scores(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_download_friends_scores", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_download_friends_scores = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[70];
    if (steam_download_friends_scores == nullptr) return gmval_undefined();
    double result = steam_download_friends_scores(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_achievement(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_set_achievement", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_set_achievement = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[71];
    if (steam_set_achievement == nullptr) return gmval_undefined();
    double result = steam_set_achievement(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_achievement", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_get_achievement = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[72];
    if (steam_get_achievement == nullptr) return gmval_undefined();
    double result = steam_get_achievement(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_clear_achievement(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_clear_achievement", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_clear_achievement = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[73];
    if (steam_clear_achievement == nullptr) return gmval_undefined();
    double result = steam_clear_achievement(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_stat_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_set_stat_int", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_set_stat_int = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[74];
    if (steam_set_stat_int == nullptr) return gmval_undefined();
    double result = steam_set_stat_int(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_stat_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_set_stat_float", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_set_stat_float = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[75];
    if (steam_set_stat_float == nullptr) return gmval_undefined();
    double result = steam_set_stat_float(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_stat_avg_rate(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_set_stat_avg_rate", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_set_stat_avg_rate = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[76];
    if (steam_set_stat_avg_rate == nullptr) return gmval_undefined();
    double result = steam_set_stat_avg_rate(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_stat_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_stat_int", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_get_stat_int = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[77];
    if (steam_get_stat_int == nullptr) return gmval_undefined();
    double result = steam_get_stat_int(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_stat_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_stat_float", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_get_stat_float = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[78];
    if (steam_get_stat_float == nullptr) return gmval_undefined();
    double result = steam_get_stat_float(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_stat_avg_rate(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_stat_avg_rate", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_get_stat_avg_rate = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[79];
    if (steam_get_stat_avg_rate == nullptr) return gmval_undefined();
    double result = steam_get_stat_avg_rate(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_reset_all_stats(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_reset_all_stats", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_reset_all_stats = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[80];
    if (steam_reset_all_stats == nullptr) return gmval_undefined();
    double result = steam_reset_all_stats();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_reset_all_stats_achievements(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_reset_all_stats_achievements", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_reset_all_stats_achievements = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[81];
    if (steam_reset_all_stats_achievements == nullptr) return gmval_undefined();
    double result = steam_reset_all_stats_achievements();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_stats_ready(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_stats_ready", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_stats_ready = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[82];
    if (steam_stats_ready == nullptr) return gmval_undefined();
    double result = steam_stats_ready();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_update(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_update", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_update = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[83];
    if (steam_update == nullptr) return gmval_undefined();
    double result = steam_update();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_init(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_init", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_init = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[84];
    if (steam_init == nullptr) return gmval_undefined();
    double result = steam_init();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_initialised(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_initialised", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_initialised = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[85];
    if (steam_initialised == nullptr) return gmval_undefined();
    double result = steam_initialised();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_shutdown(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_shutdown", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_shutdown = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[86];
    if (steam_shutdown == nullptr) return gmval_undefined();
    const char* result = steam_shutdown();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_is_subscribed(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_is_subscribed", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_is_subscribed = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[87];
    if (steam_is_subscribed == nullptr) return gmval_undefined();
    double result = steam_is_subscribed();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_warning_message_hook(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_set_warning_message_hook", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_set_warning_message_hook = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[88];
    if (steam_set_warning_message_hook == nullptr) return gmval_undefined();
    double result = steam_set_warning_message_hook();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_send_chat_message(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_send_chat_message", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = double(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_send_chat_message = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[89];
    if (steam_lobby_send_chat_message == nullptr) return gmval_undefined();
    double result = steam_lobby_send_chat_message(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_send_chat_message_buffer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_send_chat_message_buffer", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_send_chat_message_buffer = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[90];
    if (steam_lobby_send_chat_message_buffer == nullptr) return gmval_undefined();
    double result = steam_lobby_send_chat_message_buffer(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_chat_message_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_get_chat_message_text", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_chat_message_text = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[91];
    if (steam_lobby_get_chat_message_text == nullptr) return gmval_undefined();
    const char* result = steam_lobby_get_chat_message_text(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_chat_message_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_get_chat_message_size", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_chat_message_size = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[92];
    if (steam_lobby_get_chat_message_size == nullptr) return gmval_undefined();
    double result = steam_lobby_get_chat_message_size(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_chat_message_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_get_chat_message_data", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_chat_message_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[93];
    if (steam_lobby_get_chat_message_data == nullptr) return gmval_undefined();
    const char* result = steam_lobby_get_chat_message_data(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_lobby_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_get_lobby_id", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_lobby_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[94];
    if (steam_lobby_get_lobby_id == nullptr) return gmval_undefined();
    double result = steam_lobby_get_lobby_id();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_leave(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_leave", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_leave = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[95];
    if (steam_lobby_leave == nullptr) return gmval_undefined();
    const char* result = steam_lobby_leave();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_is_owner(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_is_owner", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_is_owner = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[96];
    if (steam_lobby_is_owner == nullptr) return gmval_undefined();
    double result = steam_lobby_is_owner();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_owner_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_get_owner_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_owner_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[97];
    if (steam_lobby_get_owner_id == nullptr) return gmval_undefined();
    const char* result = steam_lobby_get_owner_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_owner_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_set_owner_id", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_set_owner_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[98];
    if (steam_lobby_set_owner_id == nullptr) return gmval_undefined();
    const char* result = steam_lobby_set_owner_id(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_joinable(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_set_joinable", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_set_joinable = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[99];
    if (steam_lobby_set_joinable == nullptr) return gmval_undefined();
    const char* result = steam_lobby_set_joinable(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_member_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_get_member_count", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_member_count = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[100];
    if (steam_lobby_get_member_count == nullptr) return gmval_undefined();
    double result = steam_lobby_get_member_count();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_member_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_get_member_id", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_member_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[101];
    if (steam_lobby_get_member_id == nullptr) return gmval_undefined();
    double result = steam_lobby_get_member_id(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_activate_invite_overlay(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_activate_invite_overlay", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_activate_invite_overlay = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[102];
    if (steam_lobby_activate_invite_overlay == nullptr) return gmval_undefined();
    const char* result = steam_lobby_activate_invite_overlay();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_request(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_list_request", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_request = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[103];
    if (steam_lobby_list_request == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_request();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_string_filter(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_lobby_list_add_string_filter", argc, 3);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = const char*(*)(const char*, const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_add_string_filter = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[104];
    if (steam_lobby_list_add_string_filter == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_add_string_filter(arg0, arg1, arg2);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_numerical_filter(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_lobby_list_add_numerical_filter", argc, 3);
    // coerce arguments
    const char* arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = const char*(*)(const char*, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_add_numerical_filter = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[105];
    if (steam_lobby_list_add_numerical_filter == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_add_numerical_filter(arg0, arg1, arg2);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_near_filter(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_list_add_near_filter", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_add_near_filter = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[106];
    if (steam_lobby_list_add_near_filter == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_add_near_filter(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_distance_filter(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_list_add_distance_filter", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_add_distance_filter = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[107];
    if (steam_lobby_list_add_distance_filter == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_add_distance_filter(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_list_get_count", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_get_count = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[108];
    if (steam_lobby_list_get_count == nullptr) return gmval_undefined();
    double result = steam_lobby_list_get_count();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_list_get_data", argc, 2);
    // coerce arguments
    double arg0;
    const char* arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = const char*(*)(double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_get_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[109];
    if (steam_lobby_list_get_data == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_get_data(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_list_get_lobby_id", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_get_lobby_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[110];
    if (steam_lobby_list_get_lobby_id == nullptr) return gmval_undefined();
    double result = steam_lobby_list_get_lobby_id(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_owner_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_list_get_lobby_owner_id", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_get_lobby_owner_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[111];
    if (steam_lobby_list_get_lobby_owner_id == nullptr) return gmval_undefined();
    double result = steam_lobby_list_get_lobby_owner_id(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_member_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_list_get_lobby_member_count", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_get_lobby_member_count = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[112];
    if (steam_lobby_list_get_lobby_member_count == nullptr) return gmval_undefined();
    double result = steam_lobby_list_get_lobby_member_count(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_member_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_list_get_lobby_member_id", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_get_lobby_member_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[113];
    if (steam_lobby_list_get_lobby_member_id == nullptr) return gmval_undefined();
    double result = steam_lobby_list_get_lobby_member_id(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_join(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_list_join", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_join = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[114];
    if (steam_lobby_list_join == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_join(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_join_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_join_id", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_join_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[115];
    if (steam_lobby_join_id == nullptr) return gmval_undefined();
    const char* result = steam_lobby_join_id(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_create(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_create", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_create = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[116];
    if (steam_lobby_create == nullptr) return gmval_undefined();
    const char* result = steam_lobby_create(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_lobby_set_data", argc, 2);
    // coerce arguments
    const char* arg0;
    double arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_set_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[117];
    if (steam_lobby_set_data == nullptr) return gmval_undefined();
    const char* result = steam_lobby_set_data(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_get_data", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_get_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[118];
    if (steam_lobby_get_data == nullptr) return gmval_undefined();
    const char* result = steam_lobby_get_data(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_type(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_lobby_set_type", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_lobby_set_type = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[119];
    if (steam_lobby_set_type == nullptr) return gmval_undefined();
    const char* result = steam_lobby_set_type(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_is_loading(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_lobby_list_is_loading", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_lobby_list_is_loading = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[120];
    if (steam_lobby_list_is_loading == nullptr) return gmval_undefined();
    const char* result = steam_lobby_list_is_loading();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_set_auto_accept_p2p_sessions(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_net_set_auto_accept_p2p_sessions", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_net_set_auto_accept_p2p_sessions = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[121];
    if (steam_net_set_auto_accept_p2p_sessions == nullptr) return gmval_undefined();
    const char* result = steam_net_set_auto_accept_p2p_sessions(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_accept_p2p_session(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_net_accept_p2p_session", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_net_accept_p2p_session = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[122];
    if (steam_net_accept_p2p_session == nullptr) return gmval_undefined();
    const char* result = steam_net_accept_p2p_session(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_close_p2p_session(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_net_close_p2p_session", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_net_close_p2p_session = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[123];
    if (steam_net_close_p2p_session == nullptr) return gmval_undefined();
    const char* result = steam_net_close_p2p_session(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_set_type(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_net_packet_set_type", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_net_packet_set_type = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[124];
    if (steam_net_packet_set_type == nullptr) return gmval_undefined();
    const char* result = steam_net_packet_set_type(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_send(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_net_packet_send", argc, 3);
    // coerce arguments
    double arg0;
    const char* arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = const char*(*)(double, const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_net_packet_send = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[125];
    if (steam_net_packet_send == nullptr) return gmval_undefined();
    const char* result = steam_net_packet_send(arg0, arg1, arg2);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_receive(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_net_packet_receive", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_net_packet_receive = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[126];
    if (steam_net_packet_receive == nullptr) return gmval_undefined();
    double result = steam_net_packet_receive();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_get_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_net_packet_get_size", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_net_packet_get_size = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[127];
    if (steam_net_packet_get_size == nullptr) return gmval_undefined();
    double result = steam_net_packet_get_size();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_get_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_net_packet_get_data", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_net_packet_get_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[128];
    if (steam_net_packet_get_data == nullptr) return gmval_undefined();
    const char* result = steam_net_packet_get_data(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_get_sender_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_net_packet_get_sender_id", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_net_packet_get_sender_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[129];
    if (steam_net_packet_get_sender_id == nullptr) return gmval_undefined();
    double result = steam_net_packet_get_sender_id();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_set_played_with(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_user_set_played_with", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_user_set_played_with = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[130];
    if (steam_user_set_played_with == nullptr) return gmval_undefined();
    const char* result = steam_user_set_played_with(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_friends_game_info(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_friends_game_info", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_friends_game_info = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[131];
    if (steam_get_friends_game_info == nullptr) return gmval_undefined();
    const char* result = steam_get_friends_game_info();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_persona_name_sync(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_user_persona_name_sync", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_get_user_persona_name_sync = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[132];
    if (steam_get_user_persona_name_sync == nullptr) return gmval_undefined();
    const char* result = steam_get_user_persona_name_sync(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_rich_presence(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_set_rich_presence", argc, 2);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = const char*(*)(const char*, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_set_rich_presence = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[133];
    if (steam_set_rich_presence == nullptr) return gmval_undefined();
    const char* result = steam_set_rich_presence(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_clear_rich_presence(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_clear_rich_presence", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_clear_rich_presence = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[134];
    if (steam_clear_rich_presence == nullptr) return gmval_undefined();
    const char* result = steam_clear_rich_presence();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_avatar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_get_user_avatar", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_get_user_avatar = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[135];
    if (steam_get_user_avatar == nullptr) return gmval_undefined();
    double result = steam_get_user_avatar(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_image_get_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_image_get_size", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_image_get_size = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[136];
    if (steam_image_get_size == nullptr) return gmval_undefined();
    double result = steam_image_get_size(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_image_get_rgba(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_image_get_rgba", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_image_get_rgba = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[137];
    if (steam_image_get_rgba == nullptr) return gmval_undefined();
    double result = steam_image_get_rgba(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_image_get_bgra(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_image_get_bgra", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_image_get_bgra = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[138];
    if (steam_image_get_bgra == nullptr) return gmval_undefined();
    double result = steam_image_get_bgra(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_overlay_notification_position(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_set_overlay_notification_position", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_set_overlay_notification_position = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[139];
    if (steam_set_overlay_notification_position == nullptr) return gmval_undefined();
    const char* result = steam_set_overlay_notification_position(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_set_overlay_notification_inset(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_set_overlay_notification_inset", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_set_overlay_notification_inset = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[140];
    if (steam_set_overlay_notification_inset == nullptr) return gmval_undefined();
    const char* result = steam_set_overlay_notification_inset(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_app_ownership_ticket_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_get_app_ownership_ticket_data", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_get_app_ownership_ticket_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[141];
    if (steam_get_app_ownership_ticket_data == nullptr) return gmval_undefined();
    const char* result = steam_get_app_ownership_ticket_data(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_request_encrypted_app_ticket(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_user_request_encrypted_app_ticket", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_user_request_encrypted_app_ticket = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[142];
    if (steam_user_request_encrypted_app_ticket == nullptr) return gmval_undefined();
    const char* result = steam_user_request_encrypted_app_ticket(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_status(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_result_get_status", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_result_get_status = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[143];
    if (steam_inventory_result_get_status == nullptr) return gmval_undefined();
    const char* result = steam_inventory_result_get_status(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_unix_timestamp(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_result_get_unix_timestamp", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_result_get_unix_timestamp = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[144];
    if (steam_inventory_result_get_unix_timestamp == nullptr) return gmval_undefined();
    double result = steam_inventory_result_get_unix_timestamp(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_item_property(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_inventory_result_get_item_property", argc, 3);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    const char* arg2;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    arg2 = gmval_CoerceCString(args[2]);
    using FunctionPtr = const char*(*)(const char*, const char*, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_result_get_item_property = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[145];
    if (steam_inventory_result_get_item_property == nullptr) return gmval_undefined();
    const char* result = steam_inventory_result_get_item_property(arg0, arg1, arg2);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_result_get_items", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_result_get_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[146];
    if (steam_inventory_result_get_items == nullptr) return gmval_undefined();
    const char* result = steam_inventory_result_get_items(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_destroy(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_result_destroy", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_result_destroy = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[147];
    if (steam_inventory_result_destroy == nullptr) return gmval_undefined();
    const char* result = steam_inventory_result_destroy(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_trigger_item_drop(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_trigger_item_drop", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_trigger_item_drop = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[148];
    if (steam_inventory_trigger_item_drop == nullptr) return gmval_undefined();
    const char* result = steam_inventory_trigger_item_drop(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_add_promo_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_add_promo_item", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_add_promo_item = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[149];
    if (steam_inventory_add_promo_item == nullptr) return gmval_undefined();
    const char* result = steam_inventory_add_promo_item(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_add_promo_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_add_promo_items", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_add_promo_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[150];
    if (steam_inventory_add_promo_items == nullptr) return gmval_undefined();
    const char* result = steam_inventory_add_promo_items(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_consume_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_inventory_consume_item", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_consume_item = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[151];
    if (steam_inventory_consume_item == nullptr) return gmval_undefined();
    const char* result = steam_inventory_consume_item(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_exchange_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_inventory_exchange_items", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = const char*(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_exchange_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[152];
    if (steam_inventory_exchange_items == nullptr) return gmval_undefined();
    const char* result = steam_inventory_exchange_items(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_generate_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_generate_items", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_generate_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[153];
    if (steam_inventory_generate_items == nullptr) return gmval_undefined();
    const char* result = steam_inventory_generate_items(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_all_items(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_inventory_get_all_items", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_inventory_get_all_items = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[154];
    if (steam_inventory_get_all_items == nullptr) return gmval_undefined();
    const char* result = steam_inventory_get_all_items();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_start_purchase(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_start_purchase", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_start_purchase = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[155];
    if (steam_inventory_start_purchase == nullptr) return gmval_undefined();
    const char* result = steam_inventory_start_purchase(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_request_eligible_promo_item_defs(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_request_eligible_promo_item_defs", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_request_eligible_promo_item_defs = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[156];
    if (steam_inventory_request_eligible_promo_item_defs == nullptr) return gmval_undefined();
    const char* result = steam_inventory_request_eligible_promo_item_defs(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_items_by_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_get_items_by_id", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_get_items_by_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[157];
    if (steam_inventory_get_items_by_id == nullptr) return gmval_undefined();
    const char* result = steam_inventory_get_items_by_id(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_start_update_properties(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_start_update_properties", argc, 1);
    // coerce arguments
    const char* arg0;
    arg0 = gmval_CoerceCString(args[0]);
    using FunctionPtr = const char*(*)(const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_start_update_properties = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[158];
    if (steam_inventory_start_update_properties == nullptr) return gmval_undefined();
    const char* result = steam_inventory_start_update_properties(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_bool(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 4)
        RunnerInterface_ArgCountError("steam_inventory_set_property_bool", argc, 4);
    // coerce arguments
    double arg0;
    double arg1;
    const char* arg2;
    double arg3;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceCString(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    using FunctionPtr = const char*(*)(double, double, const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_set_property_bool = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[159];
    if (steam_inventory_set_property_bool == nullptr) return gmval_undefined();
    const char* result = steam_inventory_set_property_bool(arg0, arg1, arg2, arg3);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 4)
        RunnerInterface_ArgCountError("steam_inventory_set_property_float", argc, 4);
    // coerce arguments
    double arg0;
    double arg1;
    const char* arg2;
    double arg3;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceCString(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    using FunctionPtr = const char*(*)(double, double, const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_set_property_float = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[160];
    if (steam_inventory_set_property_float == nullptr) return gmval_undefined();
    const char* result = steam_inventory_set_property_float(arg0, arg1, arg2, arg3);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 4)
        RunnerInterface_ArgCountError("steam_inventory_set_property_int", argc, 4);
    // coerce arguments
    double arg0;
    double arg1;
    const char* arg2;
    double arg3;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceCString(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    using FunctionPtr = const char*(*)(double, double, const char*, double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_set_property_int = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[161];
    if (steam_inventory_set_property_int == nullptr) return gmval_undefined();
    const char* result = steam_inventory_set_property_int(arg0, arg1, arg2, arg3);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_string(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 4)
        RunnerInterface_ArgCountError("steam_inventory_set_property_string", argc, 4);
    // coerce arguments
    double arg0;
    double arg1;
    const char* arg2;
    const char* arg3;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceCString(args[2]);
    arg3 = gmval_CoerceCString(args[3]);
    using FunctionPtr = const char*(*)(double, double, const char*, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_set_property_string = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[162];
    if (steam_inventory_set_property_string == nullptr) return gmval_undefined();
    const char* result = steam_inventory_set_property_string(arg0, arg1, arg2, arg3);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_remove_property(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_inventory_remove_property", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    const char* arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceCString(args[2]);
    using FunctionPtr = const char*(*)(double, double, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_remove_property = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[163];
    if (steam_inventory_remove_property == nullptr) return gmval_undefined();
    const char* result = steam_inventory_remove_property(arg0, arg1, arg2);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_submit_update_properties(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_submit_update_properties", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = const char*(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_submit_update_properties = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[164];
    if (steam_inventory_submit_update_properties == nullptr) return gmval_undefined();
    const char* result = steam_inventory_submit_update_properties(arg0);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_load_item_definitions(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_inventory_load_item_definitions", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_inventory_load_item_definitions = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[165];
    if (steam_inventory_load_item_definitions == nullptr) return gmval_undefined();
    const char* result = steam_inventory_load_item_definitions();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_item_price(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_inventory_get_item_price", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_get_item_price = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[166];
    if (steam_inventory_get_item_price == nullptr) return gmval_undefined();
    double result = steam_inventory_get_item_price(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_items_with_prices(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_inventory_get_items_with_prices", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_inventory_get_items_with_prices = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[167];
    if (steam_inventory_get_items_with_prices == nullptr) return gmval_undefined();
    const char* result = steam_inventory_get_items_with_prices();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_request_prices(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_inventory_request_prices", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_inventory_request_prices = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[168];
    if (steam_inventory_request_prices == nullptr) return gmval_undefined();
    const char* result = steam_inventory_request_prices();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_transfer_item_quantity(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_inventory_transfer_item_quantity", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = const char*(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_inventory_transfer_item_quantity = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[169];
    if (steam_inventory_transfer_item_quantity == nullptr) return gmval_undefined();
    const char* result = steam_inventory_transfer_item_quantity(arg0, arg1, arg2);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_init(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_init", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_init = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[170];
    if (steam_input_init == nullptr) return gmval_undefined();
    double result = steam_input_init(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_shutdown(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_shutdown", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_shutdown = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[171];
    if (steam_input_shutdown == nullptr) return gmval_undefined();
    double result = steam_input_shutdown();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_set_input_action_manifest_file_path(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_set_input_action_manifest_file_path", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_set_input_action_manifest_file_path = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[172];
    if (steam_input_set_input_action_manifest_file_path == nullptr) return gmval_undefined();
    double result = steam_input_set_input_action_manifest_file_path(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_run_frame(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_run_frame", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_run_frame = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[173];
    if (steam_input_run_frame == nullptr) return gmval_undefined();
    double result = steam_input_run_frame();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_wait_for_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_wait_for_data", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_wait_for_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[174];
    if (steam_input_wait_for_data == nullptr) return gmval_undefined();
    double result = steam_input_wait_for_data(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_new_data_available(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_new_data_available", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_new_data_available = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[175];
    if (steam_input_new_data_available == nullptr) return gmval_undefined();
    double result = steam_input_new_data_available();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_connected_controllers(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_get_connected_controllers", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_get_connected_controllers = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[176];
    if (steam_input_get_connected_controllers == nullptr) return gmval_undefined();
    double result = steam_input_get_connected_controllers();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_enable_device_callbacks(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_enable_device_callbacks", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_enable_device_callbacks = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[177];
    if (steam_input_enable_device_callbacks == nullptr) return gmval_undefined();
    double result = steam_input_enable_device_callbacks();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_enable_action_event_callbacks(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_enable_action_event_callbacks", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_enable_action_event_callbacks = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[178];
    if (steam_input_enable_action_event_callbacks == nullptr) return gmval_undefined();
    double result = steam_input_enable_action_event_callbacks();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_action_set_handle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_action_set_handle", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_action_set_handle = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[179];
    if (steam_input_get_action_set_handle == nullptr) return gmval_undefined();
    double result = steam_input_get_action_set_handle(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_activate_action_set(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_activate_action_set", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_activate_action_set = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[180];
    if (steam_input_activate_action_set == nullptr) return gmval_undefined();
    double result = steam_input_activate_action_set(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_current_action_set(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_current_action_set", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_current_action_set = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[181];
    if (steam_input_get_current_action_set == nullptr) return gmval_undefined();
    double result = steam_input_get_current_action_set(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_activate_action_set_layer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_activate_action_set_layer", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_activate_action_set_layer = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[182];
    if (steam_input_activate_action_set_layer == nullptr) return gmval_undefined();
    double result = steam_input_activate_action_set_layer(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_deactivate_action_set_layer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_deactivate_action_set_layer", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_deactivate_action_set_layer = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[183];
    if (steam_input_deactivate_action_set_layer == nullptr) return gmval_undefined();
    double result = steam_input_deactivate_action_set_layer(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_deactivate_all_action_set_layers(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_deactivate_all_action_set_layers", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_deactivate_all_action_set_layers = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[184];
    if (steam_input_deactivate_all_action_set_layers == nullptr) return gmval_undefined();
    double result = steam_input_deactivate_all_action_set_layers(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_active_action_set_layers(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_active_action_set_layers", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_active_action_set_layers = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[185];
    if (steam_input_get_active_action_set_layers == nullptr) return gmval_undefined();
    double result = steam_input_get_active_action_set_layers(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_digital_action_handle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_digital_action_handle", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_digital_action_handle = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[186];
    if (steam_input_get_digital_action_handle == nullptr) return gmval_undefined();
    double result = steam_input_get_digital_action_handle(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_digital_action_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_get_digital_action_data", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_digital_action_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[187];
    if (steam_input_get_digital_action_data == nullptr) return gmval_undefined();
    double result = steam_input_get_digital_action_data(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_digital_action_origins(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_input_get_digital_action_origins", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_digital_action_origins = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[188];
    if (steam_input_get_digital_action_origins == nullptr) return gmval_undefined();
    double result = steam_input_get_digital_action_origins(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_digital_action_name(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_string_for_digital_action_name", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_string_for_digital_action_name = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[189];
    if (steam_input_get_string_for_digital_action_name == nullptr) return gmval_undefined();
    double result = steam_input_get_string_for_digital_action_name(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_analog_action_handle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_analog_action_handle", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_analog_action_handle = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[190];
    if (steam_input_get_analog_action_handle == nullptr) return gmval_undefined();
    double result = steam_input_get_analog_action_handle(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_analog_action_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_get_analog_action_data", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_analog_action_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[191];
    if (steam_input_get_analog_action_data == nullptr) return gmval_undefined();
    double result = steam_input_get_analog_action_data(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_analog_action_origins(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_input_get_analog_action_origins", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_analog_action_origins = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[192];
    if (steam_input_get_analog_action_origins == nullptr) return gmval_undefined();
    double result = steam_input_get_analog_action_origins(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_png_for_action_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_input_get_glyph_png_for_action_origin", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_glyph_png_for_action_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[193];
    if (steam_input_get_glyph_png_for_action_origin == nullptr) return gmval_undefined();
    double result = steam_input_get_glyph_png_for_action_origin(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_svg_for_action_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_get_glyph_svg_for_action_origin", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_glyph_svg_for_action_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[194];
    if (steam_input_get_glyph_svg_for_action_origin == nullptr) return gmval_undefined();
    double result = steam_input_get_glyph_svg_for_action_origin(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_for_action_origin_legacy(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_glyph_for_action_origin_legacy", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_glyph_for_action_origin_legacy = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[195];
    if (steam_input_get_glyph_for_action_origin_legacy == nullptr) return gmval_undefined();
    double result = steam_input_get_glyph_for_action_origin_legacy(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_action_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_string_for_action_origin", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_string_for_action_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[196];
    if (steam_input_get_string_for_action_origin == nullptr) return gmval_undefined();
    double result = steam_input_get_string_for_action_origin(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_analog_action_name(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_string_for_analog_action_name", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_string_for_analog_action_name = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[197];
    if (steam_input_get_string_for_analog_action_name == nullptr) return gmval_undefined();
    double result = steam_input_get_string_for_analog_action_name(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_stop_analog_action_momentum(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_stop_analog_action_momentum", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_stop_analog_action_momentum = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[198];
    if (steam_input_stop_analog_action_momentum == nullptr) return gmval_undefined();
    double result = steam_input_stop_analog_action_momentum(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_motion_data(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_motion_data", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_motion_data = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[199];
    if (steam_input_get_motion_data == nullptr) return gmval_undefined();
    double result = steam_input_get_motion_data(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_vibration(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_input_trigger_vibration", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_trigger_vibration = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[200];
    if (steam_input_trigger_vibration == nullptr) return gmval_undefined();
    double result = steam_input_trigger_vibration(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_vibration_extended(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 5)
        RunnerInterface_ArgCountError("steam_input_trigger_vibration_extended", argc, 5);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    using FunctionPtr = double(*)(double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_trigger_vibration_extended = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[201];
    if (steam_input_trigger_vibration_extended == nullptr) return gmval_undefined();
    double result = steam_input_trigger_vibration_extended(arg0, arg1, arg2, arg3, arg4);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_simple_haptic_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 6)
        RunnerInterface_ArgCountError("steam_input_trigger_simple_haptic_event", argc, 6);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    arg5 = gmval_CoerceReal(args[5]);
    using FunctionPtr = double(*)(double, double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_trigger_simple_haptic_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[202];
    if (steam_input_trigger_simple_haptic_event == nullptr) return gmval_undefined();
    double result = steam_input_trigger_simple_haptic_event(arg0, arg1, arg2, arg3, arg4, arg5);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_set_led_color(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_input_set_led_color", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_set_led_color = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[203];
    if (steam_input_set_led_color == nullptr) return gmval_undefined();
    double result = steam_input_set_led_color(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_haptic_pulse_legacy(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 3)
        RunnerInterface_ArgCountError("steam_input_trigger_haptic_pulse_legacy", argc, 3);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    using FunctionPtr = double(*)(double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_trigger_haptic_pulse_legacy = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[204];
    if (steam_input_trigger_haptic_pulse_legacy == nullptr) return gmval_undefined();
    double result = steam_input_trigger_haptic_pulse_legacy(arg0, arg1, arg2);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_repeated_haptic_pulse_legacy(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 6)
        RunnerInterface_ArgCountError("steam_input_trigger_repeated_haptic_pulse_legacy", argc, 6);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    double arg5;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    arg5 = gmval_CoerceReal(args[5]);
    using FunctionPtr = double(*)(double, double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_trigger_repeated_haptic_pulse_legacy = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[205];
    if (steam_input_trigger_repeated_haptic_pulse_legacy == nullptr) return gmval_undefined();
    double result = steam_input_trigger_repeated_haptic_pulse_legacy(arg0, arg1, arg2, arg3, arg4, arg5);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_show_binding_panel(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_show_binding_panel", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_show_binding_panel = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[206];
    if (steam_input_show_binding_panel == nullptr) return gmval_undefined();
    double result = steam_input_show_binding_panel(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_input_type_for_handle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_input_type_for_handle", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_input_type_for_handle = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[207];
    if (steam_input_get_input_type_for_handle == nullptr) return gmval_undefined();
    double result = steam_input_get_input_type_for_handle(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_controller_for_gamepad_index(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_controller_for_gamepad_index", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_controller_for_gamepad_index = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[208];
    if (steam_input_get_controller_for_gamepad_index == nullptr) return gmval_undefined();
    double result = steam_input_get_controller_for_gamepad_index(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_gamepad_index_for_controller(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_gamepad_index_for_controller", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_gamepad_index_for_controller = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[209];
    if (steam_input_get_gamepad_index_for_controller == nullptr) return gmval_undefined();
    double result = steam_input_get_gamepad_index_for_controller(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_xbox_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_string_for_xbox_origin", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_string_for_xbox_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[210];
    if (steam_input_get_string_for_xbox_origin == nullptr) return gmval_undefined();
    double result = steam_input_get_string_for_xbox_origin(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_for_xbox_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_glyph_for_xbox_origin", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_glyph_for_xbox_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[211];
    if (steam_input_get_glyph_for_xbox_origin == nullptr) return gmval_undefined();
    double result = steam_input_get_glyph_for_xbox_origin(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_action_origin_from_xbox_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_get_action_origin_from_xbox_origin", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_action_origin_from_xbox_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[212];
    if (steam_input_get_action_origin_from_xbox_origin == nullptr) return gmval_undefined();
    double result = steam_input_get_action_origin_from_xbox_origin(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_translate_action_origin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_translate_action_origin", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_translate_action_origin = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[213];
    if (steam_input_translate_action_origin == nullptr) return gmval_undefined();
    double result = steam_input_translate_action_origin(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_device_binding_revision(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_device_binding_revision", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_device_binding_revision = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[214];
    if (steam_input_get_device_binding_revision == nullptr) return gmval_undefined();
    double result = steam_input_get_device_binding_revision(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_remote_play_session_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 1)
        RunnerInterface_ArgCountError("steam_input_get_remote_play_session_id", argc, 1);
    // coerce arguments
    double arg0;
    arg0 = gmval_CoerceReal(args[0]);
    using FunctionPtr = double(*)(double);
    // fetch function pointer from group table
    FunctionPtr steam_input_get_remote_play_session_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[215];
    if (steam_input_get_remote_play_session_id == nullptr) return gmval_undefined();
    double result = steam_input_get_remote_play_session_id(arg0);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_session_input_configuration_settings(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_input_get_session_input_configuration_settings", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_input_get_session_input_configuration_settings = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[216];
    if (steam_input_get_session_input_configuration_settings == nullptr) return gmval_undefined();
    double result = steam_input_get_session_input_configuration_settings();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_input_set_dualsense_trigger_effect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_input_set_dualsense_trigger_effect", argc, 2);
    // coerce arguments
    double arg0;
    double arg1;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    using FunctionPtr = double(*)(double, double);
    // fetch function pointer from group table
    FunctionPtr steam_input_set_dualsense_trigger_effect = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[217];
    if (steam_input_set_dualsense_trigger_effect == nullptr) return gmval_undefined();
    double result = steam_input_set_dualsense_trigger_effect(arg0, arg1);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_show_floating_gamepad_text_input(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 5)
        RunnerInterface_ArgCountError("steam_show_floating_gamepad_text_input", argc, 5);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    using FunctionPtr = double(*)(double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_show_floating_gamepad_text_input = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[218];
    if (steam_show_floating_gamepad_text_input == nullptr) return gmval_undefined();
    double result = steam_show_floating_gamepad_text_input(arg0, arg1, arg2, arg3, arg4);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_show_gamepad_text_input(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 5)
        RunnerInterface_ArgCountError("steam_show_gamepad_text_input", argc, 5);
    // coerce arguments
    double arg0;
    double arg1;
    double arg2;
    double arg3;
    double arg4;
    arg0 = gmval_CoerceReal(args[0]);
    arg1 = gmval_CoerceReal(args[1]);
    arg2 = gmval_CoerceReal(args[2]);
    arg3 = gmval_CoerceReal(args[3]);
    arg4 = gmval_CoerceReal(args[4]);
    using FunctionPtr = double(*)(double, double, double, double, double);
    // fetch function pointer from group table
    FunctionPtr steam_show_gamepad_text_input = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[219];
    if (steam_show_gamepad_text_input == nullptr) return gmval_undefined();
    double result = steam_show_gamepad_text_input(arg0, arg1, arg2, arg3, arg4);
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_entered_gamepad_text_input(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_entered_gamepad_text_input", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_entered_gamepad_text_input = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[220];
    if (steam_get_entered_gamepad_text_input == nullptr) return gmval_undefined();
    double result = steam_get_entered_gamepad_text_input();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_utils_enable_callbacks(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_utils_enable_callbacks", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_utils_enable_callbacks = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[221];
    if (steam_utils_enable_callbacks == nullptr) return gmval_undefined();
    double result = steam_utils_enable_callbacks();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_utils_is_steam_running_on_steam_deck(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_utils_is_steam_running_on_steam_deck", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_utils_is_steam_running_on_steam_deck = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[222];
    if (steam_utils_is_steam_running_on_steam_deck == nullptr) return gmval_undefined();
    double result = steam_utils_is_steam_running_on_steam_deck();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_dismiss_floating_gamepad_text_input(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_dismiss_floating_gamepad_text_input", argc, 0);
    using FunctionPtr = double(*)();
    // fetch function pointer from group table
    FunctionPtr steam_dismiss_floating_gamepad_text_input = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[223];
    if (steam_dismiss_floating_gamepad_text_input == nullptr) return gmval_undefined();
    double result = steam_dismiss_floating_gamepad_text_input();
    return gmval_FromDouble(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_request_global_stats(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_request_global_stats", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_request_global_stats = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[224];
    if (steam_request_global_stats == nullptr) return gmval_undefined();
    const char* result = steam_request_global_stats();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_request_global_achievement_percentages(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_request_global_achievement_percentages", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_request_global_achievement_percentages = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[225];
    if (steam_request_global_achievement_percentages == nullptr) return gmval_undefined();
    const char* result = steam_request_global_achievement_percentages();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_real(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_global_stat_real", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_global_stat_real = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[226];
    if (steam_get_global_stat_real == nullptr) return gmval_undefined();
    const char* result = steam_get_global_stat_real();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_history_real(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_global_stat_history_real", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_global_stat_history_real = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[227];
    if (steam_get_global_stat_history_real == nullptr) return gmval_undefined();
    const char* result = steam_get_global_stat_history_real();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement_achieved_percent(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_achievement_achieved_percent", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_achievement_achieved_percent = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[228];
    if (steam_get_achievement_achieved_percent == nullptr) return gmval_undefined();
    const char* result = steam_get_achievement_achieved_percent();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_next_most_achieved_achievement_info(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_next_most_achieved_achievement_info", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_next_most_achieved_achievement_info = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[229];
    if (steam_get_next_most_achieved_achievement_info == nullptr) return gmval_undefined();
    const char* result = steam_get_next_most_achieved_achievement_info();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_most_achieved_achievement_info(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_most_achieved_achievement_info", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_most_achieved_achievement_info = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[230];
    if (steam_get_most_achieved_achievement_info == nullptr) return gmval_undefined();
    const char* result = steam_get_most_achieved_achievement_info();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_get_auth_session_ticket(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_user_get_auth_session_ticket", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_user_get_auth_session_ticket = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[231];
    if (steam_user_get_auth_session_ticket == nullptr) return gmval_undefined();
    const char* result = steam_user_get_auth_session_ticket();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_cancel_auth_ticket(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_user_cancel_auth_ticket", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_user_cancel_auth_ticket = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[232];
    if (steam_user_cancel_auth_ticket == nullptr) return gmval_undefined();
    const char* result = steam_user_cancel_auth_ticket();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_local_file_change_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_local_file_change_count", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_local_file_change_count = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[233];
    if (steam_get_local_file_change_count == nullptr) return gmval_undefined();
    const char* result = steam_get_local_file_change_count();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_local_file_change(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_local_file_change", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_local_file_change = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[234];
    if (steam_get_local_file_change == nullptr) return gmval_undefined();
    const char* result = steam_get_local_file_change();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_utils_is_steam_in_big_picture_mode(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_utils_is_steam_in_big_picture_mode", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_utils_is_steam_in_big_picture_mode = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[235];
    if (steam_utils_is_steam_in_big_picture_mode == nullptr) return gmval_undefined();
    const char* result = steam_utils_is_steam_in_big_picture_mode();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_utils_set_game_launcher_mode(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_utils_set_game_launcher_mode", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_utils_set_game_launcher_mode = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[236];
    if (steam_utils_set_game_launcher_mode == nullptr) return gmval_undefined();
    const char* result = steam_utils_set_game_launcher_mode();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_is_enabled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_is_enabled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_is_enabled = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[237];
    if (steam_music_is_enabled == nullptr) return gmval_undefined();
    const char* result = steam_music_is_enabled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_is_playing(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_is_playing", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_is_playing = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[238];
    if (steam_music_is_playing == nullptr) return gmval_undefined();
    const char* result = steam_music_is_playing();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_play(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_play", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_play = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[239];
    if (steam_music_play == nullptr) return gmval_undefined();
    const char* result = steam_music_play();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_play_previous(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_play_previous", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_play_previous = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[240];
    if (steam_music_play_previous == nullptr) return gmval_undefined();
    const char* result = steam_music_play_previous();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_play_next(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_play_next", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_play_next = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[241];
    if (steam_music_play_next == nullptr) return gmval_undefined();
    const char* result = steam_music_play_next();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_pause(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_pause", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_pause = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[242];
    if (steam_music_pause == nullptr) return gmval_undefined();
    const char* result = steam_music_pause();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_set_volume(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_set_volume", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_set_volume = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[243];
    if (steam_music_set_volume == nullptr) return gmval_undefined();
    const char* result = steam_music_set_volume();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_music_get_status(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_music_get_status", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_music_get_status = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[244];
    if (steam_music_get_status == nullptr) return gmval_undefined();
    const char* result = steam_music_get_status();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_leaderboard_entry_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_leaderboard_entry_count", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_leaderboard_entry_count = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[245];
    if (steam_get_leaderboard_entry_count == nullptr) return gmval_undefined();
    const char* result = steam_get_leaderboard_entry_count();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_leaderboard_display_type(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_leaderboard_display_type", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_leaderboard_display_type = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[246];
    if (steam_get_leaderboard_display_type == nullptr) return gmval_undefined();
    const char* result = steam_get_leaderboard_display_type();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_get_list(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_file_get_list", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_file_get_list = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[247];
    if (steam_file_get_list == nullptr) return gmval_undefined();
    const char* result = steam_file_get_list();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 2)
        RunnerInterface_ArgCountError("steam_get_global_stat_int", argc, 2);
    // coerce arguments
    const char* arg0;
    const char* arg1;
    arg0 = gmval_CoerceCString(args[0]);
    arg1 = gmval_CoerceCString(args[1]);
    using FunctionPtr = const char*(*)(const char*, const char*);
    // fetch function pointer from group table
    FunctionPtr steam_get_global_stat_int = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[248];
    if (steam_get_global_stat_int == nullptr) return gmval_undefined();
    const char* result = steam_get_global_stat_int(arg0, arg1);
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_history_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_global_stat_history_int", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_global_stat_history_int = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[249];
    if (steam_get_global_stat_history_int == nullptr) return gmval_undefined();
    const char* result = steam_get_global_stat_history_int();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_indicate_achievement_progress(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_indicate_achievement_progress", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_indicate_achievement_progress = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[250];
    if (steam_indicate_achievement_progress == nullptr) return gmval_undefined();
    const char* result = steam_indicate_achievement_progress();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_number_of_current_players(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_number_of_current_players", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_number_of_current_players = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[251];
    if (steam_get_number_of_current_players == nullptr) return gmval_undefined();
    const char* result = steam_get_number_of_current_players();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_request_friend_rich_presence(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_request_friend_rich_presence", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_request_friend_rich_presence = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[252];
    if (steam_request_friend_rich_presence == nullptr) return gmval_undefined();
    const char* result = steam_request_friend_rich_presence();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_friend_rich_presence(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_friend_rich_presence", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_friend_rich_presence = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[253];
    if (steam_get_friend_rich_presence == nullptr) return gmval_undefined();
    const char* result = steam_get_friend_rich_presence();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_friend_rich_presence_key_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_friend_rich_presence_key_count", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_friend_rich_presence_key_count = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[254];
    if (steam_get_friend_rich_presence_key_count == nullptr) return gmval_undefined();
    const char* result = steam_get_friend_rich_presence_key_count();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_friend_rich_presence_key_by_index(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_friend_rich_presence_key_by_index", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_friend_rich_presence_key_by_index = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[255];
    if (steam_get_friend_rich_presence_key_by_index == nullptr) return gmval_undefined();
    const char* result = steam_get_friend_rich_presence_key_by_index();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement_progress_limits_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_achievement_progress_limits_int", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_achievement_progress_limits_int = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[256];
    if (steam_get_achievement_progress_limits_int == nullptr) return gmval_undefined();
    const char* result = steam_get_achievement_progress_limits_int();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement_progress_limits_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_get_achievement_progress_limits_float", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_get_achievement_progress_limits_float = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[257];
    if (steam_get_achievement_progress_limits_float == nullptr) return gmval_undefined();
    const char* result = steam_get_achievement_progress_limits_float();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_utils_get_server_real_time(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_utils_get_server_real_time", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_utils_get_server_real_time = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[258];
    if (steam_utils_get_server_real_time == nullptr) return gmval_undefined();
    const char* result = steam_utils_get_server_real_time();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_read_buffer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_file_read_buffer", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_file_read_buffer = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[259];
    if (steam_file_read_buffer == nullptr) return gmval_undefined();
    const char* result = steam_file_read_buffer();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_file_write_buffer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_file_write_buffer", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_file_write_buffer = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[260];
    if (steam_file_write_buffer == nullptr) return gmval_undefined();
    const char* result = steam_file_write_buffer();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_user_get_auth_ticket_for_web_api(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_user_get_auth_ticket_for_web_api", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_user_get_auth_ticket_for_web_api = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[261];
    if (steam_user_get_auth_ticket_for_web_api == nullptr) return gmval_undefined();
    const char* result = steam_user_get_auth_ticket_for_web_api();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_utils_get_steam_ui_language(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_utils_get_steam_ui_language", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_utils_get_steam_ui_language = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[262];
    if (steam_utils_get_steam_ui_language == nullptr) return gmval_undefined();
    const char* result = steam_utils_get_steam_ui_language();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_set_state_description(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_set_state_description", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_set_state_description = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[263];
    if (steam_timeline_set_state_description == nullptr) return gmval_undefined();
    const char* result = steam_timeline_set_state_description();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_clear_state_description(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_clear_state_description", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_clear_state_description = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[264];
    if (steam_timeline_clear_state_description == nullptr) return gmval_undefined();
    const char* result = steam_timeline_clear_state_description();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_add_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_add_event", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_add_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[265];
    if (steam_timeline_add_event == nullptr) return gmval_undefined();
    const char* result = steam_timeline_add_event();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_set_game_mode(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_set_game_mode", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_set_game_mode = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[266];
    if (steam_timeline_set_game_mode == nullptr) return gmval_undefined();
    const char* result = steam_timeline_set_game_mode();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_add_instantaneous_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_add_instantaneous_event", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_add_instantaneous_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[267];
    if (steam_timeline_add_instantaneous_event == nullptr) return gmval_undefined();
    const char* result = steam_timeline_add_instantaneous_event();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_metadata(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_ugc_set_item_metadata", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_ugc_set_item_metadata = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[268];
    if (steam_ugc_set_item_metadata == nullptr) return gmval_undefined();
    const char* result = steam_ugc_set_item_metadata();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_return_metadata(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_ugc_query_set_return_metadata", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_ugc_query_set_return_metadata = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[269];
    if (steam_ugc_query_set_return_metadata == nullptr) return gmval_undefined();
    const char* result = steam_ugc_query_set_return_metadata();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_remove_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_remove_event", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_remove_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[270];
    if (steam_timeline_remove_event == nullptr) return gmval_undefined();
    const char* result = steam_timeline_remove_event();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_start_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_start_event", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_start_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[271];
    if (steam_timeline_start_event == nullptr) return gmval_undefined();
    const char* result = steam_timeline_start_event();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_update_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_update_event", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_update_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[272];
    if (steam_timeline_update_event == nullptr) return gmval_undefined();
    const char* result = steam_timeline_update_event();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_end_event(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_end_event", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_end_event = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[273];
    if (steam_timeline_end_event == nullptr) return gmval_undefined();
    const char* result = steam_timeline_end_event();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_event_recording_exists(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_event_recording_exists", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_event_recording_exists = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[274];
    if (steam_timeline_event_recording_exists == nullptr) return gmval_undefined();
    const char* result = steam_timeline_event_recording_exists();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_event_open_overlay(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_event_open_overlay", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_event_open_overlay = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[275];
    if (steam_timeline_event_open_overlay == nullptr) return gmval_undefined();
    const char* result = steam_timeline_event_open_overlay();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_start(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_start", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_start = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[276];
    if (steam_timeline_game_phase_start == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_start();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_end(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_end", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_end = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[277];
    if (steam_timeline_game_phase_end == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_end();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_add_tag(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_add_tag", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_add_tag = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[278];
    if (steam_timeline_game_phase_add_tag == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_add_tag();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_set_attribute(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_set_attribute", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_set_attribute = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[279];
    if (steam_timeline_game_phase_set_attribute == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_set_attribute();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_set_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_set_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_set_id = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[280];
    if (steam_timeline_game_phase_set_id == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_set_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_recording_exists(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_recording_exists", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_recording_exists = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[281];
    if (steam_timeline_game_phase_recording_exists == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_recording_exists();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_open_overlay(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("steam_timeline_game_phase_open_overlay", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr steam_timeline_game_phase_open_overlay = (FunctionPtr)Steamworks__Steamworks_ext_funcPointers[282];
    if (steam_timeline_game_phase_open_overlay == nullptr) return gmval_undefined();
    const char* result = steam_timeline_game_phase_open_overlay();
    return gmval_FromString(result);
}

// Injected from gmlib_injection_global_after_stubs.cpp
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

// End of injected code (gmlib_injection_global_after_stubs.cpp)

static void Release_Steamworks()
{
    
    // Injected from gmlib_injection_release_function.cpp

    if (isInitialized) Shutdown_Steamworks();

// End of injected code (gmlib_injection_release_function.cpp)
    
    SharedLibrary_Release(Steamworks__Steamworks_ext_libHandle);
    for (auto& p : Steamworks__Steamworks_ext_funcPointers) p = nullptr;
    Steamworks__Steamworks_ext_libHandle = nullptr;
    SharedLibrary_FlushErrorLog();
    Logger_Debug("Finished releasing: Steamworks!\n");
}
extern "C" void Setup_Steamworks()
{
    Steamworks__Steamworks_ext_libHandle = SharedLibrary_Load("Steamworks_x64.dll");
    if (Steamworks__Steamworks_ext_libHandle)
    {
        Steamworks__Steamworks_ext_funcPointers[0] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_owns_dlc");
        Steamworks__Steamworks_ext_funcPointers[1] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_installed_dlc");
        Steamworks__Steamworks_ext_funcPointers[2] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_current_game_language");
        Steamworks__Steamworks_ext_funcPointers[3] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_available_languages");
        Steamworks__Steamworks_ext_funcPointers[4] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_activate_overlay");
        Steamworks__Steamworks_ext_funcPointers[5] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_persona_name");
        Steamworks__Steamworks_ext_funcPointers[6] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_overlay_enabled");
        Steamworks__Steamworks_ext_funcPointers[7] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_overlay_activated");
        Steamworks__Steamworks_ext_funcPointers[8] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_activate_overlay_browser");
        Steamworks__Steamworks_ext_funcPointers[9] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_activate_overlay_user");
        Steamworks__Steamworks_ext_funcPointers[10] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_activate_overlay_store");
        Steamworks__Steamworks_ext_funcPointers[11] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_user_persona_name");
        Steamworks__Steamworks_ext_funcPointers[12] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_cloud_enabled_for_app");
        Steamworks__Steamworks_ext_funcPointers[13] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_cloud_enabled_for_account");
        Steamworks__Steamworks_ext_funcPointers[14] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_persisted");
        Steamworks__Steamworks_ext_funcPointers[15] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_quota_total");
        Steamworks__Steamworks_ext_funcPointers[16] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_quota_free");
        Steamworks__Steamworks_ext_funcPointers[17] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_write");
        Steamworks__Steamworks_ext_funcPointers[18] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_write_file");
        Steamworks__Steamworks_ext_funcPointers[19] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_read");
        Steamworks__Steamworks_ext_funcPointers[20] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_delete");
        Steamworks__Steamworks_ext_funcPointers[21] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_exists");
        Steamworks__Steamworks_ext_funcPointers[22] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_size");
        Steamworks__Steamworks_ext_funcPointers[23] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_share");
        Steamworks__Steamworks_ext_funcPointers[24] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_screenshot_requested");
        Steamworks__Steamworks_ext_funcPointers[25] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_send_screenshot");
        Steamworks__Steamworks_ext_funcPointers[26] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_download");
        Steamworks__Steamworks_ext_funcPointers[27] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_create_item");
        Steamworks__Steamworks_ext_funcPointers[28] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_start_item_update");
        Steamworks__Steamworks_ext_funcPointers[29] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_submit_item_update");
        Steamworks__Steamworks_ext_funcPointers[30] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_title");
        Steamworks__Steamworks_ext_funcPointers[31] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_description");
        Steamworks__Steamworks_ext_funcPointers[32] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_visibility");
        Steamworks__Steamworks_ext_funcPointers[33] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_tags");
        Steamworks__Steamworks_ext_funcPointers[34] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_content");
        Steamworks__Steamworks_ext_funcPointers[35] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_preview");
        Steamworks__Steamworks_ext_funcPointers[36] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_get_item_update_progress");
        Steamworks__Steamworks_ext_funcPointers[37] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_subscribe_item");
        Steamworks__Steamworks_ext_funcPointers[38] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_unsubscribe_item");
        Steamworks__Steamworks_ext_funcPointers[39] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_num_subscribed_items");
        Steamworks__Steamworks_ext_funcPointers[40] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_get_subscribed_items");
        Steamworks__Steamworks_ext_funcPointers[41] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_get_item_install_info");
        Steamworks__Steamworks_ext_funcPointers[42] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_get_item_update_info");
        Steamworks__Steamworks_ext_funcPointers[43] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_request_item_details");
        Steamworks__Steamworks_ext_funcPointers[44] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_delete_item");
        Steamworks__Steamworks_ext_funcPointers[45] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_create_query_user");
        Steamworks__Steamworks_ext_funcPointers[46] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_create_query_user_ex");
        Steamworks__Steamworks_ext_funcPointers[47] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_create_query_all");
        Steamworks__Steamworks_ext_funcPointers[48] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_create_query_all_ex");
        Steamworks__Steamworks_ext_funcPointers[49] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_cloud_filename_filter");
        Steamworks__Steamworks_ext_funcPointers[50] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_match_any_tag");
        Steamworks__Steamworks_ext_funcPointers[51] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_search_text");
        Steamworks__Steamworks_ext_funcPointers[52] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_ranked_by_trend_days");
        Steamworks__Steamworks_ext_funcPointers[53] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_add_required_tag");
        Steamworks__Steamworks_ext_funcPointers[54] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_add_excluded_tag");
        Steamworks__Steamworks_ext_funcPointers[55] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_return_long_description");
        Steamworks__Steamworks_ext_funcPointers[56] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_return_total_only");
        Steamworks__Steamworks_ext_funcPointers[57] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_allow_cached_response");
        Steamworks__Steamworks_ext_funcPointers[58] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_send_query");
        Steamworks__Steamworks_ext_funcPointers[59] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_user_logged_on");
        Steamworks__Steamworks_ext_funcPointers[60] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_user_steam_id");
        Steamworks__Steamworks_ext_funcPointers[61] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_user_account_id");
        Steamworks__Steamworks_ext_funcPointers[62] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_app_id");
        Steamworks__Steamworks_ext_funcPointers[63] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_create_leaderboard");
        Steamworks__Steamworks_ext_funcPointers[64] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_upload_score");
        Steamworks__Steamworks_ext_funcPointers[65] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_upload_score_ext");
        Steamworks__Steamworks_ext_funcPointers[66] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_upload_score_buffer");
        Steamworks__Steamworks_ext_funcPointers[67] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_upload_score_buffer_ext");
        Steamworks__Steamworks_ext_funcPointers[68] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_download_scores");
        Steamworks__Steamworks_ext_funcPointers[69] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_download_scores_around_user");
        Steamworks__Steamworks_ext_funcPointers[70] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_download_friends_scores");
        Steamworks__Steamworks_ext_funcPointers[71] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_achievement");
        Steamworks__Steamworks_ext_funcPointers[72] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_achievement");
        Steamworks__Steamworks_ext_funcPointers[73] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_clear_achievement");
        Steamworks__Steamworks_ext_funcPointers[74] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_stat_int");
        Steamworks__Steamworks_ext_funcPointers[75] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_stat_float");
        Steamworks__Steamworks_ext_funcPointers[76] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_stat_avg_rate");
        Steamworks__Steamworks_ext_funcPointers[77] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_stat_int");
        Steamworks__Steamworks_ext_funcPointers[78] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_stat_float");
        Steamworks__Steamworks_ext_funcPointers[79] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_stat_avg_rate");
        Steamworks__Steamworks_ext_funcPointers[80] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_reset_all_stats");
        Steamworks__Steamworks_ext_funcPointers[81] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_reset_all_stats_achievements");
        Steamworks__Steamworks_ext_funcPointers[82] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_stats_ready");
        Steamworks__Steamworks_ext_funcPointers[83] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_update");
        Steamworks__Steamworks_ext_funcPointers[84] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_init");
        Steamworks__Steamworks_ext_funcPointers[85] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_initialised");
        Steamworks__Steamworks_ext_funcPointers[86] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_shutdown");
        Steamworks__Steamworks_ext_funcPointers[87] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_is_subscribed");
        Steamworks__Steamworks_ext_funcPointers[88] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_warning_message_hook");
        Steamworks__Steamworks_ext_funcPointers[89] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_send_chat_message");
        Steamworks__Steamworks_ext_funcPointers[90] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_send_chat_message_buffer");
        Steamworks__Steamworks_ext_funcPointers[91] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_chat_message_text");
        Steamworks__Steamworks_ext_funcPointers[92] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_chat_message_size");
        Steamworks__Steamworks_ext_funcPointers[93] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_chat_message_data");
        Steamworks__Steamworks_ext_funcPointers[94] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_lobby_id");
        Steamworks__Steamworks_ext_funcPointers[95] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_leave");
        Steamworks__Steamworks_ext_funcPointers[96] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_is_owner");
        Steamworks__Steamworks_ext_funcPointers[97] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_owner_id");
        Steamworks__Steamworks_ext_funcPointers[98] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_set_owner_id");
        Steamworks__Steamworks_ext_funcPointers[99] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_set_joinable");
        Steamworks__Steamworks_ext_funcPointers[100] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_member_count");
        Steamworks__Steamworks_ext_funcPointers[101] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_member_id");
        Steamworks__Steamworks_ext_funcPointers[102] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_activate_invite_overlay");
        Steamworks__Steamworks_ext_funcPointers[103] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_request");
        Steamworks__Steamworks_ext_funcPointers[104] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_add_string_filter");
        Steamworks__Steamworks_ext_funcPointers[105] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_add_numerical_filter");
        Steamworks__Steamworks_ext_funcPointers[106] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_add_near_filter");
        Steamworks__Steamworks_ext_funcPointers[107] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_add_distance_filter");
        Steamworks__Steamworks_ext_funcPointers[108] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_get_count");
        Steamworks__Steamworks_ext_funcPointers[109] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_get_data");
        Steamworks__Steamworks_ext_funcPointers[110] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_get_lobby_id");
        Steamworks__Steamworks_ext_funcPointers[111] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_get_lobby_owner_id");
        Steamworks__Steamworks_ext_funcPointers[112] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_get_lobby_member_count");
        Steamworks__Steamworks_ext_funcPointers[113] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_get_lobby_member_id");
        Steamworks__Steamworks_ext_funcPointers[114] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_join");
        Steamworks__Steamworks_ext_funcPointers[115] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_join_id");
        Steamworks__Steamworks_ext_funcPointers[116] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_create");
        Steamworks__Steamworks_ext_funcPointers[117] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_set_data");
        Steamworks__Steamworks_ext_funcPointers[118] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_get_data");
        Steamworks__Steamworks_ext_funcPointers[119] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_set_type");
        Steamworks__Steamworks_ext_funcPointers[120] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_lobby_list_is_loading");
        Steamworks__Steamworks_ext_funcPointers[121] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_set_auto_accept_p2p_sessions");
        Steamworks__Steamworks_ext_funcPointers[122] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_accept_p2p_session");
        Steamworks__Steamworks_ext_funcPointers[123] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_close_p2p_session");
        Steamworks__Steamworks_ext_funcPointers[124] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_packet_set_type");
        Steamworks__Steamworks_ext_funcPointers[125] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_packet_send");
        Steamworks__Steamworks_ext_funcPointers[126] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_packet_receive");
        Steamworks__Steamworks_ext_funcPointers[127] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_packet_get_size");
        Steamworks__Steamworks_ext_funcPointers[128] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_packet_get_data");
        Steamworks__Steamworks_ext_funcPointers[129] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_net_packet_get_sender_id");
        Steamworks__Steamworks_ext_funcPointers[130] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_set_played_with");
        Steamworks__Steamworks_ext_funcPointers[131] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_friends_game_info");
        Steamworks__Steamworks_ext_funcPointers[132] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_user_persona_name_sync");
        Steamworks__Steamworks_ext_funcPointers[133] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_rich_presence");
        Steamworks__Steamworks_ext_funcPointers[134] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_clear_rich_presence");
        Steamworks__Steamworks_ext_funcPointers[135] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_user_avatar");
        Steamworks__Steamworks_ext_funcPointers[136] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_image_get_size");
        Steamworks__Steamworks_ext_funcPointers[137] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_image_get_rgba");
        Steamworks__Steamworks_ext_funcPointers[138] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_image_get_bgra");
        Steamworks__Steamworks_ext_funcPointers[139] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_overlay_notification_position");
        Steamworks__Steamworks_ext_funcPointers[140] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_set_overlay_notification_inset");
        Steamworks__Steamworks_ext_funcPointers[141] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_app_ownership_ticket_data");
        Steamworks__Steamworks_ext_funcPointers[142] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_request_encrypted_app_ticket");
        Steamworks__Steamworks_ext_funcPointers[143] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_result_get_status");
        Steamworks__Steamworks_ext_funcPointers[144] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_result_get_unix_timestamp");
        Steamworks__Steamworks_ext_funcPointers[145] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_result_get_item_property");
        Steamworks__Steamworks_ext_funcPointers[146] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_result_get_items");
        Steamworks__Steamworks_ext_funcPointers[147] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_result_destroy");
        Steamworks__Steamworks_ext_funcPointers[148] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_trigger_item_drop");
        Steamworks__Steamworks_ext_funcPointers[149] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_add_promo_item");
        Steamworks__Steamworks_ext_funcPointers[150] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_add_promo_items");
        Steamworks__Steamworks_ext_funcPointers[151] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_consume_item");
        Steamworks__Steamworks_ext_funcPointers[152] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_exchange_items");
        Steamworks__Steamworks_ext_funcPointers[153] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_generate_items");
        Steamworks__Steamworks_ext_funcPointers[154] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_get_all_items");
        Steamworks__Steamworks_ext_funcPointers[155] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_start_purchase");
        Steamworks__Steamworks_ext_funcPointers[156] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_request_eligible_promo_item_defs");
        Steamworks__Steamworks_ext_funcPointers[157] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_get_items_by_id");
        Steamworks__Steamworks_ext_funcPointers[158] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_start_update_properties");
        Steamworks__Steamworks_ext_funcPointers[159] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_set_property_bool");
        Steamworks__Steamworks_ext_funcPointers[160] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_set_property_float");
        Steamworks__Steamworks_ext_funcPointers[161] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_set_property_int");
        Steamworks__Steamworks_ext_funcPointers[162] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_set_property_string");
        Steamworks__Steamworks_ext_funcPointers[163] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_remove_property");
        Steamworks__Steamworks_ext_funcPointers[164] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_submit_update_properties");
        Steamworks__Steamworks_ext_funcPointers[165] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_load_item_definitions");
        Steamworks__Steamworks_ext_funcPointers[166] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_get_item_price");
        Steamworks__Steamworks_ext_funcPointers[167] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_get_items_with_prices");
        Steamworks__Steamworks_ext_funcPointers[168] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_request_prices");
        Steamworks__Steamworks_ext_funcPointers[169] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_inventory_transfer_item_quantity");
        Steamworks__Steamworks_ext_funcPointers[170] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_init");
        Steamworks__Steamworks_ext_funcPointers[171] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_shutdown");
        Steamworks__Steamworks_ext_funcPointers[172] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_set_input_action_manifest_file_path");
        Steamworks__Steamworks_ext_funcPointers[173] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_run_frame");
        Steamworks__Steamworks_ext_funcPointers[174] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_wait_for_data");
        Steamworks__Steamworks_ext_funcPointers[175] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_new_data_available");
        Steamworks__Steamworks_ext_funcPointers[176] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_connected_controllers");
        Steamworks__Steamworks_ext_funcPointers[177] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_enable_device_callbacks");
        Steamworks__Steamworks_ext_funcPointers[178] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_enable_action_event_callbacks");
        Steamworks__Steamworks_ext_funcPointers[179] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_action_set_handle");
        Steamworks__Steamworks_ext_funcPointers[180] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_activate_action_set");
        Steamworks__Steamworks_ext_funcPointers[181] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_current_action_set");
        Steamworks__Steamworks_ext_funcPointers[182] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_activate_action_set_layer");
        Steamworks__Steamworks_ext_funcPointers[183] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_deactivate_action_set_layer");
        Steamworks__Steamworks_ext_funcPointers[184] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_deactivate_all_action_set_layers");
        Steamworks__Steamworks_ext_funcPointers[185] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_active_action_set_layers");
        Steamworks__Steamworks_ext_funcPointers[186] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_digital_action_handle");
        Steamworks__Steamworks_ext_funcPointers[187] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_digital_action_data");
        Steamworks__Steamworks_ext_funcPointers[188] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_digital_action_origins");
        Steamworks__Steamworks_ext_funcPointers[189] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_string_for_digital_action_name");
        Steamworks__Steamworks_ext_funcPointers[190] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_analog_action_handle");
        Steamworks__Steamworks_ext_funcPointers[191] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_analog_action_data");
        Steamworks__Steamworks_ext_funcPointers[192] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_analog_action_origins");
        Steamworks__Steamworks_ext_funcPointers[193] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_glyph_png_for_action_origin");
        Steamworks__Steamworks_ext_funcPointers[194] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_glyph_svg_for_action_origin");
        Steamworks__Steamworks_ext_funcPointers[195] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_glyph_for_action_origin_legacy");
        Steamworks__Steamworks_ext_funcPointers[196] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_string_for_action_origin");
        Steamworks__Steamworks_ext_funcPointers[197] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_string_for_analog_action_name");
        Steamworks__Steamworks_ext_funcPointers[198] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_stop_analog_action_momentum");
        Steamworks__Steamworks_ext_funcPointers[199] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_motion_data");
        Steamworks__Steamworks_ext_funcPointers[200] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_trigger_vibration");
        Steamworks__Steamworks_ext_funcPointers[201] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_trigger_vibration_extended");
        Steamworks__Steamworks_ext_funcPointers[202] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_trigger_simple_haptic_event");
        Steamworks__Steamworks_ext_funcPointers[203] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_set_led_color");
        Steamworks__Steamworks_ext_funcPointers[204] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_trigger_haptic_pulse_legacy");
        Steamworks__Steamworks_ext_funcPointers[205] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_trigger_repeated_haptic_pulse_legacy");
        Steamworks__Steamworks_ext_funcPointers[206] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_show_binding_panel");
        Steamworks__Steamworks_ext_funcPointers[207] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_input_type_for_handle");
        Steamworks__Steamworks_ext_funcPointers[208] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_controller_for_gamepad_index");
        Steamworks__Steamworks_ext_funcPointers[209] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_gamepad_index_for_controller");
        Steamworks__Steamworks_ext_funcPointers[210] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_string_for_xbox_origin");
        Steamworks__Steamworks_ext_funcPointers[211] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_glyph_for_xbox_origin");
        Steamworks__Steamworks_ext_funcPointers[212] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_action_origin_from_xbox_origin");
        Steamworks__Steamworks_ext_funcPointers[213] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_translate_action_origin");
        Steamworks__Steamworks_ext_funcPointers[214] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_device_binding_revision");
        Steamworks__Steamworks_ext_funcPointers[215] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_remote_play_session_id");
        Steamworks__Steamworks_ext_funcPointers[216] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_get_session_input_configuration_settings");
        Steamworks__Steamworks_ext_funcPointers[217] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_input_set_dualsense_trigger_effect");
        Steamworks__Steamworks_ext_funcPointers[218] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_show_floating_gamepad_text_input");
        Steamworks__Steamworks_ext_funcPointers[219] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_show_gamepad_text_input");
        Steamworks__Steamworks_ext_funcPointers[220] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_entered_gamepad_text_input");
        Steamworks__Steamworks_ext_funcPointers[221] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_utils_enable_callbacks");
        Steamworks__Steamworks_ext_funcPointers[222] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_utils_is_steam_running_on_steam_deck");
        Steamworks__Steamworks_ext_funcPointers[223] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_dismiss_floating_gamepad_text_input");
        Steamworks__Steamworks_ext_funcPointers[224] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_request_global_stats");
        Steamworks__Steamworks_ext_funcPointers[225] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_request_global_achievement_percentages");
        Steamworks__Steamworks_ext_funcPointers[226] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_global_stat_real");
        Steamworks__Steamworks_ext_funcPointers[227] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_global_stat_history_real");
        Steamworks__Steamworks_ext_funcPointers[228] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_achievement_achieved_percent");
        Steamworks__Steamworks_ext_funcPointers[229] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_next_most_achieved_achievement_info");
        Steamworks__Steamworks_ext_funcPointers[230] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_most_achieved_achievement_info");
        Steamworks__Steamworks_ext_funcPointers[231] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_get_auth_session_ticket");
        Steamworks__Steamworks_ext_funcPointers[232] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_cancel_auth_ticket");
        Steamworks__Steamworks_ext_funcPointers[233] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_local_file_change_count");
        Steamworks__Steamworks_ext_funcPointers[234] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_local_file_change");
        Steamworks__Steamworks_ext_funcPointers[235] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_utils_is_steam_in_big_picture_mode");
        Steamworks__Steamworks_ext_funcPointers[236] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_utils_set_game_launcher_mode");
        Steamworks__Steamworks_ext_funcPointers[237] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_is_enabled");
        Steamworks__Steamworks_ext_funcPointers[238] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_is_playing");
        Steamworks__Steamworks_ext_funcPointers[239] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_play");
        Steamworks__Steamworks_ext_funcPointers[240] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_play_previous");
        Steamworks__Steamworks_ext_funcPointers[241] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_play_next");
        Steamworks__Steamworks_ext_funcPointers[242] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_pause");
        Steamworks__Steamworks_ext_funcPointers[243] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_set_volume");
        Steamworks__Steamworks_ext_funcPointers[244] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_music_get_status");
        Steamworks__Steamworks_ext_funcPointers[245] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_leaderboard_entry_count");
        Steamworks__Steamworks_ext_funcPointers[246] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_leaderboard_display_type");
        Steamworks__Steamworks_ext_funcPointers[247] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_get_list");
        Steamworks__Steamworks_ext_funcPointers[248] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_global_stat_int");
        Steamworks__Steamworks_ext_funcPointers[249] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_global_stat_history_int");
        Steamworks__Steamworks_ext_funcPointers[250] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_indicate_achievement_progress");
        Steamworks__Steamworks_ext_funcPointers[251] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_number_of_current_players");
        Steamworks__Steamworks_ext_funcPointers[252] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_request_friend_rich_presence");
        Steamworks__Steamworks_ext_funcPointers[253] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_friend_rich_presence");
        Steamworks__Steamworks_ext_funcPointers[254] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_friend_rich_presence_key_count");
        Steamworks__Steamworks_ext_funcPointers[255] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_friend_rich_presence_key_by_index");
        Steamworks__Steamworks_ext_funcPointers[256] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_achievement_progress_limits_int");
        Steamworks__Steamworks_ext_funcPointers[257] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_get_achievement_progress_limits_float");
        Steamworks__Steamworks_ext_funcPointers[258] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_utils_get_server_real_time");
        Steamworks__Steamworks_ext_funcPointers[259] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_read_buffer");
        Steamworks__Steamworks_ext_funcPointers[260] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_file_write_buffer");
        Steamworks__Steamworks_ext_funcPointers[261] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_user_get_auth_ticket_for_web_api");
        Steamworks__Steamworks_ext_funcPointers[262] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_utils_get_steam_ui_language");
        Steamworks__Steamworks_ext_funcPointers[263] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_set_state_description");
        Steamworks__Steamworks_ext_funcPointers[264] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_clear_state_description");
        Steamworks__Steamworks_ext_funcPointers[265] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_add_event");
        Steamworks__Steamworks_ext_funcPointers[266] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_set_game_mode");
        Steamworks__Steamworks_ext_funcPointers[267] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_add_instantaneous_event");
        Steamworks__Steamworks_ext_funcPointers[268] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_set_item_metadata");
        Steamworks__Steamworks_ext_funcPointers[269] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_ugc_query_set_return_metadata");
        Steamworks__Steamworks_ext_funcPointers[270] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_remove_event");
        Steamworks__Steamworks_ext_funcPointers[271] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_start_event");
        Steamworks__Steamworks_ext_funcPointers[272] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_update_event");
        Steamworks__Steamworks_ext_funcPointers[273] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_end_event");
        Steamworks__Steamworks_ext_funcPointers[274] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_event_recording_exists");
        Steamworks__Steamworks_ext_funcPointers[275] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_event_open_overlay");
        Steamworks__Steamworks_ext_funcPointers[276] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_start");
        Steamworks__Steamworks_ext_funcPointers[277] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_end");
        Steamworks__Steamworks_ext_funcPointers[278] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_add_tag");
        Steamworks__Steamworks_ext_funcPointers[279] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_set_attribute");
        Steamworks__Steamworks_ext_funcPointers[280] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_set_id");
        Steamworks__Steamworks_ext_funcPointers[281] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_recording_exists");
        Steamworks__Steamworks_ext_funcPointers[282] = SharedLibrary_GetFunctionAddress(Steamworks__Steamworks_ext_libHandle, "steam_timeline_game_phase_open_overlay");
    }
    SharedLibrary_FlushErrorLog();
    
    RunnerInterface_AddConstant_Double("ov_friends", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ov_community", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ov_players", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("ov_settings", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("ov_gamegroup", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("ov_achievements", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("lb_sort_none", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("lb_sort_ascending", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("lb_sort_descending", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("lb_disp_none", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("lb_disp_numeric", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("lb_disp_time_sec", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("lb_disp_time_ms", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("ugc_result_success", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_filetype_community", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ugc_filetype_microtrans", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_visibility_public", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ugc_visibility_friends_only", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_visibility_private", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByVote", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByPublicationDate", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_query_AcceptedForGameRankedByAcceptanceDate", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByTrend", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("ugc_query_FavoritedByFriendsRankedByPublicationDate", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("ugc_query_CreatedByFriendsRankedByPublicationDate", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByNumTimesReported", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("ugc_query_CreatedByFollowedUsersRankedByPublicationDate", static_cast<double>(7));
    RunnerInterface_AddConstant_Double("ugc_query_NotYetRated", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByTotalVotesAsc", static_cast<double>(9));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByVotesUp", static_cast<double>(10));
    RunnerInterface_AddConstant_Double("ugc_query_RankedByTextSearch", static_cast<double>(11));
    RunnerInterface_AddConstant_Double("ugc_sortorder_CreationOrderDesc", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ugc_sortorder_CreationOrderAsc", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_sortorder_TitleAsc", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("ugc_sortorder_LastUpdatedDesc", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("ugc_sortorder_SubscriptionDateDesc", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("ugc_sortorder_VoteScoreDesc", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("ugc_sortorder_ForModeration", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("ugc_list_Published", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ugc_list_VotedOn", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_list_VotedUp", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("ugc_list_VotedDown", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("ugc_list_WillVoteLater", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("ugc_list_Favorited", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("ugc_list_Subscribed", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("ugc_list_UsedOrPlayed", static_cast<double>(7));
    RunnerInterface_AddConstant_Double("ugc_list_Followed", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("ugc_match_Items", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("ugc_match_Items_Mtx", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("ugc_match_Items_ReadyToUse", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("ugc_match_Collections", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("ugc_match_Artwork", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("ugc_match_Videos", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("ugc_match_Screenshots", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("ugc_match_AllGuides", static_cast<double>(7));
    RunnerInterface_AddConstant_Double("ugc_match_WebGuides", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("ugc_match_IntegratedGuides", static_cast<double>(9));
    RunnerInterface_AddConstant_Double("ugc_match_UsableInGame", static_cast<double>(10));
    RunnerInterface_AddConstant_Double("ugc_match_ControllerBindings", static_cast<double>(11));
    RunnerInterface_AddConstant_Double("steam_net_version", static_cast<double>(1300));
    RunnerInterface_AddConstant_Double("steam_controller_unknown", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_controller_steam_controller", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_controller_xbox360", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_controller_xboxone", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_controller_generic_xinput", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_controller_ps4", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("steam_controller_apple_mfi", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("steam_controller_android", static_cast<double>(7));
    RunnerInterface_AddConstant_Double("steam_controller_switch_joycon_pair", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("steam_controller_switch_joycon_single", static_cast<double>(9));
    RunnerInterface_AddConstant_Double("steam_controller_switch_pro", static_cast<double>(10));
    RunnerInterface_AddConstant_Double("steam_controller_mobile_touch", static_cast<double>(11));
    RunnerInterface_AddConstant_Double("steam_controller_ps3", static_cast<double>(12));
    RunnerInterface_AddConstant_Double("steam_inventory_result_invalid", static_cast<double>(-1));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_invalid", static_cast<double>(-1));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_ok", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_fail", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_invalid_param", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_service_unavailable", static_cast<double>(20));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_pending", static_cast<double>(22));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_limit_exceeded", static_cast<double>(25));
    RunnerInterface_AddConstant_Double("steam_inventory_result_status_expired", static_cast<double>(27));
    RunnerInterface_AddConstant_Double("steam_lobby_max_chat_message_size", static_cast<double>(4096));
    RunnerInterface_AddConstant_Double("steam_lobby_member_change_entered", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_lobby_member_change_left", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_lobby_member_change_disconnected", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_lobby_member_change_kicked", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("steam_lobby_member_change_banned", static_cast<double>(16));
    RunnerInterface_AddConstant_Double("steam_lobby_list_filter_eq", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_lobby_list_filter_ne", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_lobby_list_filter_lt", static_cast<double>(-1));
    RunnerInterface_AddConstant_Double("steam_lobby_list_filter_gt", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_lobby_list_filter_le", static_cast<double>(-2));
    RunnerInterface_AddConstant_Double("steam_lobby_list_filter_ge", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_lobby_list_distance_filter_close", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_lobby_list_distance_filter_default", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_lobby_list_distance_filter_far", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_lobby_list_distance_filter_worldwide", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_lobby_type_private", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_lobby_type_friends_only", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_lobby_type_public", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_net_packet_type_unreliable", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_net_packet_type_unreliable_nodelay", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_net_packet_type_reliable", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_net_packet_type_reliable_buffer", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_user_avatar_size_small", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_user_avatar_size_medium", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_user_avatar_size_large", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_overlay_notification_position_top_left", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_overlay_notification_position_top_right", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_overlay_notification_position_bottom_left", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_overlay_notification_position_bottom_right", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_input_handle_all_controllers", static_cast<double>(-1));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_none", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_dpad", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_buttons", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_four_buttons", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_absolute_mouse", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_relative_mouse", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_joystick_move", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_joystick_mouse", static_cast<double>(7));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_joystick_camera", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_scroll_wheel", static_cast<double>(9));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_trigger", static_cast<double>(10));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_touch_menu", static_cast<double>(11));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_mouse_joystick", static_cast<double>(12));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_mouse_region", static_cast<double>(13));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_radial_menu", static_cast<double>(14));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_single_button", static_cast<double>(15));
    RunnerInterface_AddConstant_Double("steam_input_source_mode_switches", static_cast<double>(16));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_a", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_b", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_x", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_y", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_bumper", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_bumper", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_menu", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_view", static_cast<double>(7));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_trigger_pull", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_trigger_click", static_cast<double>(9));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_trigger_pull", static_cast<double>(10));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_trigger_click", static_cast<double>(11));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_stick_move", static_cast<double>(12));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_stick_click", static_cast<double>(13));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_stick_dpad_north", static_cast<double>(14));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_stick_dpad_south", static_cast<double>(15));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_stick_dpad_west", static_cast<double>(16));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_left_stick_dpad_east", static_cast<double>(17));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_stick_move", static_cast<double>(18));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_stick_click", static_cast<double>(19));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_stick_dpad_north", static_cast<double>(20));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_stick_dpad_south", static_cast<double>(21));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_stick_dpad_west", static_cast<double>(22));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_right_stick_dpad_east", static_cast<double>(23));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_dpad_north", static_cast<double>(24));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_dpad_south", static_cast<double>(25));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_dpad_west", static_cast<double>(26));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_dpad_east", static_cast<double>(27));
    RunnerInterface_AddConstant_Double("steam_input_xbox_origin_count", static_cast<double>(28));
    RunnerInterface_AddConstant_Double("steam_input_steam_controller_pad_left", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_steam_controller_pad_right", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_controller_haptic_location_left", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_controller_haptic_location_right", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_controller_haptic_location_both", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_input_controller_haptic_type_off", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_controller_haptic_type_tick", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_controller_haptic_type_click", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_type_unknown", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_type_generic_gamepad", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_input_type_count", static_cast<double>(15));
    RunnerInterface_AddConstant_Double("steam_input_type_maximum_possible_value", static_cast<double>(255));
    RunnerInterface_AddConstant_Double("steam_input_configuration_enable_type_none", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_configuration_enable_type_playstation", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_configuration_enable_type_xbox", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_configuration_enable_type_generic", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_input_configuration_enable_type_switch", static_cast<double>(8));
    RunnerInterface_AddConstant_Double("steam_input_led_flag_set_color", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_led_flag_restore_user_default", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_glyph_size_small", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_glyph_size_medium", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_glyph_size_large", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_glyph_size_count", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_input_glyph_style_knockout", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_glyph_style_light", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_glyph_style_dark", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_glyph_style_neutral_color_abxy", static_cast<double>(16));
    RunnerInterface_AddConstant_Double("steam_input_glyph_style_solid_abxy", static_cast<double>(32));
    RunnerInterface_AddConstant_Double("steam_input_action_event_type_digital_action", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_action_event_type_analog_action", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_action_origin_none", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_action_origin_maximum_possible_value", static_cast<double>(32767));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_off", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_feedback", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_weapon", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_vibration", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_multiple_position_feedback", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_slope_feedback", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_mode_multiple_position_vibration", static_cast<double>(6));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_trigger_mask_l2", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_trigger_mask_r2", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_param_index_for_l2", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_param_index_for_r2", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_trigger_num", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_input_sce_pad_trigger_effect_control_point_num", static_cast<double>(10));
    RunnerInterface_AddConstant_Double("steam_floating_gamepad_text_input_mode_single_line", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_floating_gamepad_text_input_mode_multiple_lines", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_floating_gamepad_text_input_mode_email", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_floating_gamepad_text_input_mode_numeric", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_gamepad_text_input_mode_normal", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_gamepad_text_input_mode_password", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_gamepad_text_input_line_mode_single_line", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_gamepad_text_input_line_mode_multiple_lines", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_local_file_path_type_invalid", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_local_file_path_type_absolute", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_local_file_path_type_api_filename", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_local_file_change_invalid", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_local_file_change_updated", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_local_file_change_deleted", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_music_playback_undefined", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_music_playback_playing", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_music_playback_paused", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_music_playback_idle", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_timeline_game_mode_invalid", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_timeline_game_mode_playing", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_timeline_game_mode_staging", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_timeline_game_mode_menus", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_timeline_game_mode_loading_screen", static_cast<double>(4));
    RunnerInterface_AddConstant_Double("steam_timeline_game_mode_max", static_cast<double>(5));
    RunnerInterface_AddConstant_Double("steam_timeline_clip_priority_invalid", static_cast<double>(0));
    RunnerInterface_AddConstant_Double("steam_timeline_clip_priority_none", static_cast<double>(1));
    RunnerInterface_AddConstant_Double("steam_timeline_clip_priority_standard", static_cast<double>(2));
    RunnerInterface_AddConstant_Double("steam_timeline_clip_priority_featured", static_cast<double>(3));
    RunnerInterface_AddConstant_Double("steam_timeline_max_timeline_priority", static_cast<double>(1000));
    RunnerInterface_AddConstant_Double("steam_timeline_max_timeline_event_duration", static_cast<double>(600.0));
    RunnerInterface_AddFunction("steam_user_owns_dlc", __GMLIBSTUB_GMVAL__Steamworks__steam_user_owns_dlc, 1);
    RunnerInterface_AddFunction("steam_user_installed_dlc", __GMLIBSTUB_GMVAL__Steamworks__steam_user_installed_dlc, 1);
    RunnerInterface_AddFunction("steam_current_game_language", __GMLIBSTUB_GMVAL__Steamworks__steam_current_game_language, 0);
    RunnerInterface_AddFunction("steam_available_languages", __GMLIBSTUB_GMVAL__Steamworks__steam_available_languages, 0);
    RunnerInterface_AddFunction("steam_activate_overlay", __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay, 1);
    RunnerInterface_AddFunction("steam_get_persona_name", __GMLIBSTUB_GMVAL__Steamworks__steam_get_persona_name, 0);
    RunnerInterface_AddFunction("steam_is_overlay_enabled", __GMLIBSTUB_GMVAL__Steamworks__steam_is_overlay_enabled, 0);
    RunnerInterface_AddFunction("steam_is_overlay_activated", __GMLIBSTUB_GMVAL__Steamworks__steam_is_overlay_activated, 0);
    RunnerInterface_AddFunction("steam_activate_overlay_browser", __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay_browser, 1);
    RunnerInterface_AddFunction("steam_activate_overlay_user", __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay_user, 2);
    RunnerInterface_AddFunction("steam_activate_overlay_store", __GMLIBSTUB_GMVAL__Steamworks__steam_activate_overlay_store, 1);
    RunnerInterface_AddFunction("steam_get_user_persona_name", __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_persona_name, 1);
    RunnerInterface_AddFunction("steam_is_cloud_enabled_for_app", __GMLIBSTUB_GMVAL__Steamworks__steam_is_cloud_enabled_for_app, 0);
    RunnerInterface_AddFunction("steam_is_cloud_enabled_for_account", __GMLIBSTUB_GMVAL__Steamworks__steam_is_cloud_enabled_for_account, 0);
    RunnerInterface_AddFunction("steam_file_persisted", __GMLIBSTUB_GMVAL__Steamworks__steam_file_persisted, 1);
    RunnerInterface_AddFunction("steam_get_quota_total", __GMLIBSTUB_GMVAL__Steamworks__steam_get_quota_total, 0);
    RunnerInterface_AddFunction("steam_get_quota_free", __GMLIBSTUB_GMVAL__Steamworks__steam_get_quota_free, 0);
    RunnerInterface_AddFunction("steam_file_write", __GMLIBSTUB_GMVAL__Steamworks__steam_file_write, 3);
    RunnerInterface_AddFunction("steam_file_write_file", __GMLIBSTUB_GMVAL__Steamworks__steam_file_write_file, 2);
    RunnerInterface_AddFunction("steam_file_read", __GMLIBSTUB_GMVAL__Steamworks__steam_file_read, 1);
    RunnerInterface_AddFunction("steam_file_delete", __GMLIBSTUB_GMVAL__Steamworks__steam_file_delete, 1);
    RunnerInterface_AddFunction("steam_file_exists", __GMLIBSTUB_GMVAL__Steamworks__steam_file_exists, 1);
    RunnerInterface_AddFunction("steam_file_size", __GMLIBSTUB_GMVAL__Steamworks__steam_file_size, 1);
    RunnerInterface_AddFunction("steam_file_share", __GMLIBSTUB_GMVAL__Steamworks__steam_file_share, 1);
    RunnerInterface_AddFunction("steam_is_screenshot_requested", __GMLIBSTUB_GMVAL__Steamworks__steam_is_screenshot_requested, 0);
    RunnerInterface_AddFunction("steam_send_screenshot", __GMLIBSTUB_GMVAL__Steamworks__steam_send_screenshot, 3);
    RunnerInterface_AddFunction("steam_ugc_download", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_download, 2);
    RunnerInterface_AddFunction("steam_ugc_create_item", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_item, 2);
    RunnerInterface_AddFunction("steam_ugc_start_item_update", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_start_item_update, 2);
    RunnerInterface_AddFunction("steam_ugc_submit_item_update", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_submit_item_update, 2);
    RunnerInterface_AddFunction("steam_ugc_set_item_title", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_title, 2);
    RunnerInterface_AddFunction("steam_ugc_set_item_description", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_description, 2);
    RunnerInterface_AddFunction("steam_ugc_set_item_visibility", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_visibility, 2);
    RunnerInterface_AddFunction("steam_ugc_set_item_tags", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_tags, 2);
    RunnerInterface_AddFunction("steam_ugc_set_item_content", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_content, 2);
    RunnerInterface_AddFunction("steam_ugc_set_item_preview", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_preview, 2);
    RunnerInterface_AddFunction("steam_ugc_get_item_update_progress", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_item_update_progress, 2);
    RunnerInterface_AddFunction("steam_ugc_subscribe_item", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_subscribe_item, 1);
    RunnerInterface_AddFunction("steam_ugc_unsubscribe_item", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_unsubscribe_item, 1);
    RunnerInterface_AddFunction("steam_ugc_num_subscribed_items", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_num_subscribed_items, 0);
    RunnerInterface_AddFunction("steam_ugc_get_subscribed_items", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_subscribed_items, 1);
    RunnerInterface_AddFunction("steam_ugc_get_item_install_info", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_item_install_info, 2);
    RunnerInterface_AddFunction("steam_ugc_get_item_update_info", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_get_item_update_info, 2);
    RunnerInterface_AddFunction("steam_ugc_request_item_details", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_request_item_details, 2);
    RunnerInterface_AddFunction("steam_ugc_delete_item", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_delete_item, 1);
    RunnerInterface_AddFunction("steam_ugc_create_query_user", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_user, 4);
    RunnerInterface_AddFunction("steam_ugc_create_query_user_ex", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_user_ex, 7);
    RunnerInterface_AddFunction("steam_ugc_create_query_all", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_all, 3);
    RunnerInterface_AddFunction("steam_ugc_create_query_all_ex", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_create_query_all_ex, 5);
    RunnerInterface_AddFunction("steam_ugc_query_set_cloud_filename_filter", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_cloud_filename_filter, 2);
    RunnerInterface_AddFunction("steam_ugc_query_set_match_any_tag", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_match_any_tag, 2);
    RunnerInterface_AddFunction("steam_ugc_query_set_search_text", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_search_text, 2);
    RunnerInterface_AddFunction("steam_ugc_query_set_ranked_by_trend_days", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_ranked_by_trend_days, 2);
    RunnerInterface_AddFunction("steam_ugc_query_add_required_tag", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_add_required_tag, 2);
    RunnerInterface_AddFunction("steam_ugc_query_add_excluded_tag", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_add_excluded_tag, 2);
    RunnerInterface_AddFunction("steam_ugc_query_set_return_long_description", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_return_long_description, 2);
    RunnerInterface_AddFunction("steam_ugc_query_set_return_total_only", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_return_total_only, 2);
    RunnerInterface_AddFunction("steam_ugc_query_set_allow_cached_response", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_allow_cached_response, 2);
    RunnerInterface_AddFunction("steam_ugc_send_query", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_send_query, 1);
    RunnerInterface_AddFunction("steam_is_user_logged_on", __GMLIBSTUB_GMVAL__Steamworks__steam_is_user_logged_on, 0);
    RunnerInterface_AddFunction("steam_get_user_steam_id", __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_steam_id, 0);
    RunnerInterface_AddFunction("steam_get_user_account_id", __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_account_id, 0);
    RunnerInterface_AddFunction("steam_get_app_id", __GMLIBSTUB_GMVAL__Steamworks__steam_get_app_id, 0);
    RunnerInterface_AddFunction("steam_create_leaderboard", __GMLIBSTUB_GMVAL__Steamworks__steam_create_leaderboard, 3);
    RunnerInterface_AddFunction("steam_upload_score", __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score, 2);
    RunnerInterface_AddFunction("steam_upload_score_ext", __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score_ext, 3);
    RunnerInterface_AddFunction("steam_upload_score_buffer", __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score_buffer, 3);
    RunnerInterface_AddFunction("steam_upload_score_buffer_ext", __GMLIBSTUB_GMVAL__Steamworks__steam_upload_score_buffer_ext, 4);
    RunnerInterface_AddFunction("steam_download_scores", __GMLIBSTUB_GMVAL__Steamworks__steam_download_scores, 3);
    RunnerInterface_AddFunction("steam_download_scores_around_user", __GMLIBSTUB_GMVAL__Steamworks__steam_download_scores_around_user, 3);
    RunnerInterface_AddFunction("steam_download_friends_scores", __GMLIBSTUB_GMVAL__Steamworks__steam_download_friends_scores, 1);
    RunnerInterface_AddFunction("steam_set_achievement", __GMLIBSTUB_GMVAL__Steamworks__steam_set_achievement, 1);
    RunnerInterface_AddFunction("steam_get_achievement", __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement, 1);
    RunnerInterface_AddFunction("steam_clear_achievement", __GMLIBSTUB_GMVAL__Steamworks__steam_clear_achievement, 1);
    RunnerInterface_AddFunction("steam_set_stat_int", __GMLIBSTUB_GMVAL__Steamworks__steam_set_stat_int, 2);
    RunnerInterface_AddFunction("steam_set_stat_float", __GMLIBSTUB_GMVAL__Steamworks__steam_set_stat_float, 2);
    RunnerInterface_AddFunction("steam_set_stat_avg_rate", __GMLIBSTUB_GMVAL__Steamworks__steam_set_stat_avg_rate, 3);
    RunnerInterface_AddFunction("steam_get_stat_int", __GMLIBSTUB_GMVAL__Steamworks__steam_get_stat_int, 1);
    RunnerInterface_AddFunction("steam_get_stat_float", __GMLIBSTUB_GMVAL__Steamworks__steam_get_stat_float, 1);
    RunnerInterface_AddFunction("steam_get_stat_avg_rate", __GMLIBSTUB_GMVAL__Steamworks__steam_get_stat_avg_rate, 1);
    RunnerInterface_AddFunction("steam_reset_all_stats", __GMLIBSTUB_GMVAL__Steamworks__steam_reset_all_stats, 0);
    RunnerInterface_AddFunction("steam_reset_all_stats_achievements", __GMLIBSTUB_GMVAL__Steamworks__steam_reset_all_stats_achievements, 0);
    RunnerInterface_AddFunction("steam_stats_ready", __GMLIBSTUB_GMVAL__Steamworks__steam_stats_ready, 0);
    RunnerInterface_AddFunction("steam_update", __GMLIBSTUB_GMVAL__Steamworks__steam_update, 0);
    RunnerInterface_AddFunction("steam_init", __GMLIBSTUB_GMVAL__Steamworks__steam_init, 0);
    RunnerInterface_AddFunction("steam_initialised", __GMLIBSTUB_GMVAL__Steamworks__steam_initialised, 0);
    RunnerInterface_AddFunction("steam_shutdown", __GMLIBSTUB_GMVAL__Steamworks__steam_shutdown, 0);
    RunnerInterface_AddFunction("steam_is_subscribed", __GMLIBSTUB_GMVAL__Steamworks__steam_is_subscribed, 0);
    RunnerInterface_AddFunction("steam_set_warning_message_hook", __GMLIBSTUB_GMVAL__Steamworks__steam_set_warning_message_hook, 0);
    RunnerInterface_AddFunction("steam_lobby_send_chat_message", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_send_chat_message, 1);
    RunnerInterface_AddFunction("steam_lobby_send_chat_message_buffer", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_send_chat_message_buffer, 2);
    RunnerInterface_AddFunction("steam_lobby_get_chat_message_text", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_chat_message_text, 1);
    RunnerInterface_AddFunction("steam_lobby_get_chat_message_size", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_chat_message_size, 1);
    RunnerInterface_AddFunction("steam_lobby_get_chat_message_data", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_chat_message_data, 2);
    RunnerInterface_AddFunction("steam_lobby_get_lobby_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_lobby_id, 0);
    RunnerInterface_AddFunction("steam_lobby_leave", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_leave, 0);
    RunnerInterface_AddFunction("steam_lobby_is_owner", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_is_owner, 0);
    RunnerInterface_AddFunction("steam_lobby_get_owner_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_owner_id, 0);
    RunnerInterface_AddFunction("steam_lobby_set_owner_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_owner_id, 1);
    RunnerInterface_AddFunction("steam_lobby_set_joinable", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_joinable, 1);
    RunnerInterface_AddFunction("steam_lobby_get_member_count", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_member_count, 0);
    RunnerInterface_AddFunction("steam_lobby_get_member_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_member_id, 1);
    RunnerInterface_AddFunction("steam_lobby_activate_invite_overlay", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_activate_invite_overlay, 0);
    RunnerInterface_AddFunction("steam_lobby_list_request", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_request, 0);
    RunnerInterface_AddFunction("steam_lobby_list_add_string_filter", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_string_filter, 3);
    RunnerInterface_AddFunction("steam_lobby_list_add_numerical_filter", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_numerical_filter, 3);
    RunnerInterface_AddFunction("steam_lobby_list_add_near_filter", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_near_filter, 2);
    RunnerInterface_AddFunction("steam_lobby_list_add_distance_filter", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_add_distance_filter, 1);
    RunnerInterface_AddFunction("steam_lobby_list_get_count", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_count, 0);
    RunnerInterface_AddFunction("steam_lobby_list_get_data", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_data, 2);
    RunnerInterface_AddFunction("steam_lobby_list_get_lobby_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_id, 1);
    RunnerInterface_AddFunction("steam_lobby_list_get_lobby_owner_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_owner_id, 1);
    RunnerInterface_AddFunction("steam_lobby_list_get_lobby_member_count", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_member_count, 1);
    RunnerInterface_AddFunction("steam_lobby_list_get_lobby_member_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_get_lobby_member_id, 2);
    RunnerInterface_AddFunction("steam_lobby_list_join", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_join, 1);
    RunnerInterface_AddFunction("steam_lobby_join_id", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_join_id, 1);
    RunnerInterface_AddFunction("steam_lobby_create", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_create, 2);
    RunnerInterface_AddFunction("steam_lobby_set_data", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_data, 2);
    RunnerInterface_AddFunction("steam_lobby_get_data", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_get_data, 1);
    RunnerInterface_AddFunction("steam_lobby_set_type", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_set_type, 1);
    RunnerInterface_AddFunction("steam_lobby_list_is_loading", __GMLIBSTUB_GMVAL__Steamworks__steam_lobby_list_is_loading, 0);
    RunnerInterface_AddFunction("steam_net_set_auto_accept_p2p_sessions", __GMLIBSTUB_GMVAL__Steamworks__steam_net_set_auto_accept_p2p_sessions, 1);
    RunnerInterface_AddFunction("steam_net_accept_p2p_session", __GMLIBSTUB_GMVAL__Steamworks__steam_net_accept_p2p_session, 1);
    RunnerInterface_AddFunction("steam_net_close_p2p_session", __GMLIBSTUB_GMVAL__Steamworks__steam_net_close_p2p_session, 1);
    RunnerInterface_AddFunction("steam_net_packet_set_type", __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_set_type, 1);
    RunnerInterface_AddFunction("steam_net_packet_send", __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_send, 3);
    RunnerInterface_AddFunction("steam_net_packet_receive", __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_receive, 0);
    RunnerInterface_AddFunction("steam_net_packet_get_size", __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_get_size, 0);
    RunnerInterface_AddFunction("steam_net_packet_get_data", __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_get_data, 1);
    RunnerInterface_AddFunction("steam_net_packet_get_sender_id", __GMLIBSTUB_GMVAL__Steamworks__steam_net_packet_get_sender_id, 0);
    RunnerInterface_AddFunction("steam_user_set_played_with", __GMLIBSTUB_GMVAL__Steamworks__steam_user_set_played_with, 1);
    RunnerInterface_AddFunction("steam_get_friends_game_info", __GMLIBSTUB_GMVAL__Steamworks__steam_get_friends_game_info, 0);
    RunnerInterface_AddFunction("steam_get_user_persona_name_sync", __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_persona_name_sync, 1);
    RunnerInterface_AddFunction("steam_set_rich_presence", __GMLIBSTUB_GMVAL__Steamworks__steam_set_rich_presence, 2);
    RunnerInterface_AddFunction("steam_clear_rich_presence", __GMLIBSTUB_GMVAL__Steamworks__steam_clear_rich_presence, 0);
    RunnerInterface_AddFunction("steam_get_user_avatar", __GMLIBSTUB_GMVAL__Steamworks__steam_get_user_avatar, 2);
    RunnerInterface_AddFunction("steam_image_get_size", __GMLIBSTUB_GMVAL__Steamworks__steam_image_get_size, 1);
    RunnerInterface_AddFunction("steam_image_get_rgba", __GMLIBSTUB_GMVAL__Steamworks__steam_image_get_rgba, 3);
    RunnerInterface_AddFunction("steam_image_get_bgra", __GMLIBSTUB_GMVAL__Steamworks__steam_image_get_bgra, 3);
    RunnerInterface_AddFunction("steam_set_overlay_notification_position", __GMLIBSTUB_GMVAL__Steamworks__steam_set_overlay_notification_position, 1);
    RunnerInterface_AddFunction("steam_set_overlay_notification_inset", __GMLIBSTUB_GMVAL__Steamworks__steam_set_overlay_notification_inset, 2);
    RunnerInterface_AddFunction("steam_get_app_ownership_ticket_data", __GMLIBSTUB_GMVAL__Steamworks__steam_get_app_ownership_ticket_data, 1);
    RunnerInterface_AddFunction("steam_user_request_encrypted_app_ticket", __GMLIBSTUB_GMVAL__Steamworks__steam_user_request_encrypted_app_ticket, 1);
    RunnerInterface_AddFunction("steam_inventory_result_get_status", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_status, 1);
    RunnerInterface_AddFunction("steam_inventory_result_get_unix_timestamp", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_unix_timestamp, 1);
    RunnerInterface_AddFunction("steam_inventory_result_get_item_property", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_item_property, 3);
    RunnerInterface_AddFunction("steam_inventory_result_get_items", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_get_items, 1);
    RunnerInterface_AddFunction("steam_inventory_result_destroy", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_result_destroy, 1);
    RunnerInterface_AddFunction("steam_inventory_trigger_item_drop", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_trigger_item_drop, 1);
    RunnerInterface_AddFunction("steam_inventory_add_promo_item", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_add_promo_item, 1);
    RunnerInterface_AddFunction("steam_inventory_add_promo_items", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_add_promo_items, 1);
    RunnerInterface_AddFunction("steam_inventory_consume_item", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_consume_item, 2);
    RunnerInterface_AddFunction("steam_inventory_exchange_items", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_exchange_items, 2);
    RunnerInterface_AddFunction("steam_inventory_generate_items", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_generate_items, 1);
    RunnerInterface_AddFunction("steam_inventory_get_all_items", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_all_items, 0);
    RunnerInterface_AddFunction("steam_inventory_start_purchase", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_start_purchase, 1);
    RunnerInterface_AddFunction("steam_inventory_request_eligible_promo_item_defs", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_request_eligible_promo_item_defs, 1);
    RunnerInterface_AddFunction("steam_inventory_get_items_by_id", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_items_by_id, 1);
    RunnerInterface_AddFunction("steam_inventory_start_update_properties", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_start_update_properties, 1);
    RunnerInterface_AddFunction("steam_inventory_set_property_bool", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_bool, 4);
    RunnerInterface_AddFunction("steam_inventory_set_property_float", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_float, 4);
    RunnerInterface_AddFunction("steam_inventory_set_property_int", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_int, 4);
    RunnerInterface_AddFunction("steam_inventory_set_property_string", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_set_property_string, 4);
    RunnerInterface_AddFunction("steam_inventory_remove_property", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_remove_property, 3);
    RunnerInterface_AddFunction("steam_inventory_submit_update_properties", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_submit_update_properties, 1);
    RunnerInterface_AddFunction("steam_inventory_load_item_definitions", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_load_item_definitions, 0);
    RunnerInterface_AddFunction("steam_inventory_get_item_price", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_item_price, 1);
    RunnerInterface_AddFunction("steam_inventory_get_items_with_prices", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_get_items_with_prices, 0);
    RunnerInterface_AddFunction("steam_inventory_request_prices", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_request_prices, 0);
    RunnerInterface_AddFunction("steam_inventory_transfer_item_quantity", __GMLIBSTUB_GMVAL__Steamworks__steam_inventory_transfer_item_quantity, 3);
    RunnerInterface_AddFunction("steam_input_init", __GMLIBSTUB_GMVAL__Steamworks__steam_input_init, 1);
    RunnerInterface_AddFunction("steam_input_shutdown", __GMLIBSTUB_GMVAL__Steamworks__steam_input_shutdown, 0);
    RunnerInterface_AddFunction("steam_input_set_input_action_manifest_file_path", __GMLIBSTUB_GMVAL__Steamworks__steam_input_set_input_action_manifest_file_path, 1);
    RunnerInterface_AddFunction("steam_input_run_frame", __GMLIBSTUB_GMVAL__Steamworks__steam_input_run_frame, 0);
    RunnerInterface_AddFunction("steam_input_wait_for_data", __GMLIBSTUB_GMVAL__Steamworks__steam_input_wait_for_data, 2);
    RunnerInterface_AddFunction("steam_input_new_data_available", __GMLIBSTUB_GMVAL__Steamworks__steam_input_new_data_available, 0);
    RunnerInterface_AddFunction("steam_input_get_connected_controllers", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_connected_controllers, 0);
    RunnerInterface_AddFunction("steam_input_enable_device_callbacks", __GMLIBSTUB_GMVAL__Steamworks__steam_input_enable_device_callbacks, 0);
    RunnerInterface_AddFunction("steam_input_enable_action_event_callbacks", __GMLIBSTUB_GMVAL__Steamworks__steam_input_enable_action_event_callbacks, 0);
    RunnerInterface_AddFunction("steam_input_get_action_set_handle", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_action_set_handle, 1);
    RunnerInterface_AddFunction("steam_input_activate_action_set", __GMLIBSTUB_GMVAL__Steamworks__steam_input_activate_action_set, 2);
    RunnerInterface_AddFunction("steam_input_get_current_action_set", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_current_action_set, 1);
    RunnerInterface_AddFunction("steam_input_activate_action_set_layer", __GMLIBSTUB_GMVAL__Steamworks__steam_input_activate_action_set_layer, 2);
    RunnerInterface_AddFunction("steam_input_deactivate_action_set_layer", __GMLIBSTUB_GMVAL__Steamworks__steam_input_deactivate_action_set_layer, 2);
    RunnerInterface_AddFunction("steam_input_deactivate_all_action_set_layers", __GMLIBSTUB_GMVAL__Steamworks__steam_input_deactivate_all_action_set_layers, 1);
    RunnerInterface_AddFunction("steam_input_get_active_action_set_layers", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_active_action_set_layers, 1);
    RunnerInterface_AddFunction("steam_input_get_digital_action_handle", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_digital_action_handle, 1);
    RunnerInterface_AddFunction("steam_input_get_digital_action_data", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_digital_action_data, 2);
    RunnerInterface_AddFunction("steam_input_get_digital_action_origins", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_digital_action_origins, 3);
    RunnerInterface_AddFunction("steam_input_get_string_for_digital_action_name", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_digital_action_name, 1);
    RunnerInterface_AddFunction("steam_input_get_analog_action_handle", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_analog_action_handle, 1);
    RunnerInterface_AddFunction("steam_input_get_analog_action_data", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_analog_action_data, 2);
    RunnerInterface_AddFunction("steam_input_get_analog_action_origins", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_analog_action_origins, 3);
    RunnerInterface_AddFunction("steam_input_get_glyph_png_for_action_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_png_for_action_origin, 3);
    RunnerInterface_AddFunction("steam_input_get_glyph_svg_for_action_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_svg_for_action_origin, 2);
    RunnerInterface_AddFunction("steam_input_get_glyph_for_action_origin_legacy", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_for_action_origin_legacy, 1);
    RunnerInterface_AddFunction("steam_input_get_string_for_action_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_action_origin, 1);
    RunnerInterface_AddFunction("steam_input_get_string_for_analog_action_name", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_analog_action_name, 1);
    RunnerInterface_AddFunction("steam_input_stop_analog_action_momentum", __GMLIBSTUB_GMVAL__Steamworks__steam_input_stop_analog_action_momentum, 2);
    RunnerInterface_AddFunction("steam_input_get_motion_data", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_motion_data, 1);
    RunnerInterface_AddFunction("steam_input_trigger_vibration", __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_vibration, 3);
    RunnerInterface_AddFunction("steam_input_trigger_vibration_extended", __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_vibration_extended, 5);
    RunnerInterface_AddFunction("steam_input_trigger_simple_haptic_event", __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_simple_haptic_event, 6);
    RunnerInterface_AddFunction("steam_input_set_led_color", __GMLIBSTUB_GMVAL__Steamworks__steam_input_set_led_color, 3);
    RunnerInterface_AddFunction("steam_input_trigger_haptic_pulse_legacy", __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_haptic_pulse_legacy, 3);
    RunnerInterface_AddFunction("steam_input_trigger_repeated_haptic_pulse_legacy", __GMLIBSTUB_GMVAL__Steamworks__steam_input_trigger_repeated_haptic_pulse_legacy, 6);
    RunnerInterface_AddFunction("steam_input_show_binding_panel", __GMLIBSTUB_GMVAL__Steamworks__steam_input_show_binding_panel, 1);
    RunnerInterface_AddFunction("steam_input_get_input_type_for_handle", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_input_type_for_handle, 1);
    RunnerInterface_AddFunction("steam_input_get_controller_for_gamepad_index", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_controller_for_gamepad_index, 1);
    RunnerInterface_AddFunction("steam_input_get_gamepad_index_for_controller", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_gamepad_index_for_controller, 1);
    RunnerInterface_AddFunction("steam_input_get_string_for_xbox_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_string_for_xbox_origin, 1);
    RunnerInterface_AddFunction("steam_input_get_glyph_for_xbox_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_glyph_for_xbox_origin, 1);
    RunnerInterface_AddFunction("steam_input_get_action_origin_from_xbox_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_action_origin_from_xbox_origin, 2);
    RunnerInterface_AddFunction("steam_input_translate_action_origin", __GMLIBSTUB_GMVAL__Steamworks__steam_input_translate_action_origin, 2);
    RunnerInterface_AddFunction("steam_input_get_device_binding_revision", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_device_binding_revision, 1);
    RunnerInterface_AddFunction("steam_input_get_remote_play_session_id", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_remote_play_session_id, 1);
    RunnerInterface_AddFunction("steam_input_get_session_input_configuration_settings", __GMLIBSTUB_GMVAL__Steamworks__steam_input_get_session_input_configuration_settings, 0);
    RunnerInterface_AddFunction("steam_input_set_dualsense_trigger_effect", __GMLIBSTUB_GMVAL__Steamworks__steam_input_set_dualsense_trigger_effect, 2);
    RunnerInterface_AddFunction("steam_show_floating_gamepad_text_input", __GMLIBSTUB_GMVAL__Steamworks__steam_show_floating_gamepad_text_input, 5);
    RunnerInterface_AddFunction("steam_show_gamepad_text_input", __GMLIBSTUB_GMVAL__Steamworks__steam_show_gamepad_text_input, 5);
    RunnerInterface_AddFunction("steam_get_entered_gamepad_text_input", __GMLIBSTUB_GMVAL__Steamworks__steam_get_entered_gamepad_text_input, 0);
    RunnerInterface_AddFunction("steam_utils_enable_callbacks", __GMLIBSTUB_GMVAL__Steamworks__steam_utils_enable_callbacks, 0);
    RunnerInterface_AddFunction("steam_utils_is_steam_running_on_steam_deck", __GMLIBSTUB_GMVAL__Steamworks__steam_utils_is_steam_running_on_steam_deck, 0);
    RunnerInterface_AddFunction("steam_dismiss_floating_gamepad_text_input", __GMLIBSTUB_GMVAL__Steamworks__steam_dismiss_floating_gamepad_text_input, 0);
    RunnerInterface_AddFunction("steam_request_global_stats", __GMLIBSTUB_GMVAL__Steamworks__steam_request_global_stats, 0);
    RunnerInterface_AddFunction("steam_request_global_achievement_percentages", __GMLIBSTUB_GMVAL__Steamworks__steam_request_global_achievement_percentages, 0);
    RunnerInterface_AddFunction("steam_get_global_stat_real", __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_real, 0);
    RunnerInterface_AddFunction("steam_get_global_stat_history_real", __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_history_real, 0);
    RunnerInterface_AddFunction("steam_get_achievement_achieved_percent", __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement_achieved_percent, 0);
    RunnerInterface_AddFunction("steam_get_next_most_achieved_achievement_info", __GMLIBSTUB_GMVAL__Steamworks__steam_get_next_most_achieved_achievement_info, 0);
    RunnerInterface_AddFunction("steam_get_most_achieved_achievement_info", __GMLIBSTUB_GMVAL__Steamworks__steam_get_most_achieved_achievement_info, 0);
    RunnerInterface_AddFunction("steam_user_get_auth_session_ticket", __GMLIBSTUB_GMVAL__Steamworks__steam_user_get_auth_session_ticket, 0);
    RunnerInterface_AddFunction("steam_user_cancel_auth_ticket", __GMLIBSTUB_GMVAL__Steamworks__steam_user_cancel_auth_ticket, 0);
    RunnerInterface_AddFunction("steam_get_local_file_change_count", __GMLIBSTUB_GMVAL__Steamworks__steam_get_local_file_change_count, 0);
    RunnerInterface_AddFunction("steam_get_local_file_change", __GMLIBSTUB_GMVAL__Steamworks__steam_get_local_file_change, 0);
    RunnerInterface_AddFunction("steam_utils_is_steam_in_big_picture_mode", __GMLIBSTUB_GMVAL__Steamworks__steam_utils_is_steam_in_big_picture_mode, 0);
    RunnerInterface_AddFunction("steam_utils_set_game_launcher_mode", __GMLIBSTUB_GMVAL__Steamworks__steam_utils_set_game_launcher_mode, 0);
    RunnerInterface_AddFunction("steam_music_is_enabled", __GMLIBSTUB_GMVAL__Steamworks__steam_music_is_enabled, 0);
    RunnerInterface_AddFunction("steam_music_is_playing", __GMLIBSTUB_GMVAL__Steamworks__steam_music_is_playing, 0);
    RunnerInterface_AddFunction("steam_music_play", __GMLIBSTUB_GMVAL__Steamworks__steam_music_play, 0);
    RunnerInterface_AddFunction("steam_music_play_previous", __GMLIBSTUB_GMVAL__Steamworks__steam_music_play_previous, 0);
    RunnerInterface_AddFunction("steam_music_play_next", __GMLIBSTUB_GMVAL__Steamworks__steam_music_play_next, 0);
    RunnerInterface_AddFunction("steam_music_pause", __GMLIBSTUB_GMVAL__Steamworks__steam_music_pause, 0);
    RunnerInterface_AddFunction("steam_music_set_volume", __GMLIBSTUB_GMVAL__Steamworks__steam_music_set_volume, 0);
    RunnerInterface_AddFunction("steam_music_get_status", __GMLIBSTUB_GMVAL__Steamworks__steam_music_get_status, 0);
    RunnerInterface_AddFunction("steam_get_leaderboard_entry_count", __GMLIBSTUB_GMVAL__Steamworks__steam_get_leaderboard_entry_count, 0);
    RunnerInterface_AddFunction("steam_get_leaderboard_display_type", __GMLIBSTUB_GMVAL__Steamworks__steam_get_leaderboard_display_type, 0);
    RunnerInterface_AddFunction("steam_file_get_list", __GMLIBSTUB_GMVAL__Steamworks__steam_file_get_list, 0);
    RunnerInterface_AddFunction("steam_get_global_stat_int", __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_int, 2);
    RunnerInterface_AddFunction("steam_get_global_stat_history_int", __GMLIBSTUB_GMVAL__Steamworks__steam_get_global_stat_history_int, 0);
    RunnerInterface_AddFunction("steam_indicate_achievement_progress", __GMLIBSTUB_GMVAL__Steamworks__steam_indicate_achievement_progress, 0);
    RunnerInterface_AddFunction("steam_get_number_of_current_players", __GMLIBSTUB_GMVAL__Steamworks__steam_get_number_of_current_players, 0);
    RunnerInterface_AddFunction("steam_request_friend_rich_presence", __GMLIBSTUB_GMVAL__Steamworks__steam_request_friend_rich_presence, 0);
    RunnerInterface_AddFunction("steam_get_friend_rich_presence", __GMLIBSTUB_GMVAL__Steamworks__steam_get_friend_rich_presence, 0);
    RunnerInterface_AddFunction("steam_get_friend_rich_presence_key_count", __GMLIBSTUB_GMVAL__Steamworks__steam_get_friend_rich_presence_key_count, 0);
    RunnerInterface_AddFunction("steam_get_friend_rich_presence_key_by_index", __GMLIBSTUB_GMVAL__Steamworks__steam_get_friend_rich_presence_key_by_index, 0);
    RunnerInterface_AddFunction("steam_get_achievement_progress_limits_int", __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement_progress_limits_int, 0);
    RunnerInterface_AddFunction("steam_get_achievement_progress_limits_float", __GMLIBSTUB_GMVAL__Steamworks__steam_get_achievement_progress_limits_float, 0);
    RunnerInterface_AddFunction("steam_utils_get_server_real_time", __GMLIBSTUB_GMVAL__Steamworks__steam_utils_get_server_real_time, 0);
    RunnerInterface_AddFunction("steam_file_read_buffer", __GMLIBSTUB_GMVAL__Steamworks__steam_file_read_buffer, 0);
    RunnerInterface_AddFunction("steam_file_write_buffer", __GMLIBSTUB_GMVAL__Steamworks__steam_file_write_buffer, 0);
    RunnerInterface_AddFunction("steam_user_get_auth_ticket_for_web_api", __GMLIBSTUB_GMVAL__Steamworks__steam_user_get_auth_ticket_for_web_api, 0);
    RunnerInterface_AddFunction("steam_utils_get_steam_ui_language", __GMLIBSTUB_GMVAL__Steamworks__steam_utils_get_steam_ui_language, 0);
    RunnerInterface_AddFunction("steam_timeline_set_state_description", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_set_state_description, 0);
    RunnerInterface_AddFunction("steam_timeline_clear_state_description", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_clear_state_description, 0);
    RunnerInterface_AddFunction("steam_timeline_add_event", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_add_event, 0);
    RunnerInterface_AddFunction("steam_timeline_set_game_mode", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_set_game_mode, 0);
    RunnerInterface_AddFunction("steam_timeline_add_instantaneous_event", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_add_instantaneous_event, 0);
    RunnerInterface_AddFunction("steam_ugc_set_item_metadata", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_set_item_metadata, 0);
    RunnerInterface_AddFunction("steam_ugc_query_set_return_metadata", __GMLIBSTUB_GMVAL__Steamworks__steam_ugc_query_set_return_metadata, 0);
    RunnerInterface_AddFunction("steam_timeline_remove_event", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_remove_event, 0);
    RunnerInterface_AddFunction("steam_timeline_start_event", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_start_event, 0);
    RunnerInterface_AddFunction("steam_timeline_update_event", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_update_event, 0);
    RunnerInterface_AddFunction("steam_timeline_end_event", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_end_event, 0);
    RunnerInterface_AddFunction("steam_timeline_event_recording_exists", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_event_recording_exists, 0);
    RunnerInterface_AddFunction("steam_timeline_event_open_overlay", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_event_open_overlay, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_start", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_start, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_end", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_end, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_add_tag", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_add_tag, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_set_attribute", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_set_attribute, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_set_id", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_set_id, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_recording_exists", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_recording_exists, 0);
    RunnerInterface_AddFunction("steam_timeline_game_phase_open_overlay", __GMLIBSTUB_GMVAL__Steamworks__steam_timeline_game_phase_open_overlay, 0);
    
    // Injected from gmlib_injection_setup_function.cpp

    EventSystem_OnGameStart(&Initialize_Steamworks);
    EventSystem_OnGameEnd(&Shutdown_Steamworks);

// End of injected code (gmlib_injection_setup_function.cpp)
    
    EventSystem_OnProcessExit(&Release_Steamworks);
}
