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

#include "ImGui_GM_Module_Stubs.h"
#include <string>
#include <cstddef>

// ${gmlib_injection_global_includes}


void* ImGui_GM__imgui_gm_dll_libHandle{};
void* ImGui_GM__imgui_gm_dll_funcPointers[367]{};

static void* ExtUtils_GetLibraryHandle(const std::string& filename)
{
    if (filename == "imgui_gm.dll") return ImGui_GM__imgui_gm_dll_libHandle;
    return nullptr;
}

// Injected from gmlib_injection_global_before_stubs.cpp
static bool isInitialized = false;
// End of injected code (gmlib_injection_global_before_stubs.cpp)


extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_initialize(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_initialize", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_initialize = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[0];
    if (__imgui_initialize == nullptr) return gmval_undefined();
    const char* result = __imgui_initialize();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_update(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_update", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_update = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[1];
    if (__imgui_update == nullptr) return gmval_undefined();
    const char* result = __imgui_update();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_render(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_render", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_render = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[2];
    if (__imgui_render == nullptr) return gmval_undefined();
    const char* result = __imgui_render();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_mouse(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_mouse", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_mouse = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[3];
    if (__imgui_mouse == nullptr) return gmval_undefined();
    const char* result = __imgui_mouse();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_key(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_key", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_key = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[4];
    if (__imgui_key == nullptr) return gmval_undefined();
    const char* result = __imgui_key();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_mouse_wheel(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_mouse_wheel", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_mouse_wheel = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[5];
    if (__imgui_mouse_wheel == nullptr) return gmval_undefined();
    const char* result = __imgui_mouse_wheel();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_mouse_cursor(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_mouse_cursor", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_mouse_cursor = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[6];
    if (__imgui_mouse_cursor == nullptr) return gmval_undefined();
    const char* result = __imgui_mouse_cursor();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[7];
    if (__imgui_input == nullptr) return gmval_undefined();
    const char* result = __imgui_input();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_create_context(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_create_context", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_create_context = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[8];
    if (__imgui_create_context == nullptr) return gmval_undefined();
    const char* result = __imgui_create_context();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_destroy_context(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_destroy_context", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_destroy_context = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[9];
    if (__imgui_destroy_context == nullptr) return gmval_undefined();
    const char* result = __imgui_destroy_context();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_current_context(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_current_context", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_current_context = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[10];
    if (__imgui_get_current_context == nullptr) return gmval_undefined();
    const char* result = __imgui_get_current_context();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_current_context(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_current_context", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_current_context = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[11];
    if (__imgui_set_current_context == nullptr) return gmval_undefined();
    const char* result = __imgui_set_current_context();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_demo_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_demo_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_demo_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[12];
    if (__imgui_show_demo_window == nullptr) return gmval_undefined();
    const char* result = __imgui_show_demo_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_metrics_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_metrics_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_metrics_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[13];
    if (__imgui_show_metrics_window == nullptr) return gmval_undefined();
    const char* result = __imgui_show_metrics_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_debug_log_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_debug_log_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_debug_log_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[14];
    if (__imgui_show_debug_log_window == nullptr) return gmval_undefined();
    const char* result = __imgui_show_debug_log_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_stack_tool_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_stack_tool_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_stack_tool_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[15];
    if (__imgui_show_stack_tool_window == nullptr) return gmval_undefined();
    const char* result = __imgui_show_stack_tool_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_about_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_about_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_about_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[16];
    if (__imgui_show_about_window == nullptr) return gmval_undefined();
    const char* result = __imgui_show_about_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_style_editor(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_style_editor", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_style_editor = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[17];
    if (__imgui_show_style_editor == nullptr) return gmval_undefined();
    const char* result = __imgui_show_style_editor();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_style_selector(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_style_selector", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_style_selector = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[18];
    if (__imgui_show_style_selector == nullptr) return gmval_undefined();
    const char* result = __imgui_show_style_selector();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_font_selector(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_font_selector", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_font_selector = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[19];
    if (__imgui_show_font_selector == nullptr) return gmval_undefined();
    const char* result = __imgui_show_font_selector();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_user_guide(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_show_user_guide", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_show_user_guide = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[20];
    if (__imgui_show_user_guide == nullptr) return gmval_undefined();
    const char* result = __imgui_show_user_guide();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_version(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_version", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_version = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[21];
    if (__imgui_get_version == nullptr) return gmval_undefined();
    const char* result = __imgui_get_version();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_id = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[22];
    if (__imgui_push_id == nullptr) return gmval_undefined();
    const char* result = __imgui_push_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_id = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[23];
    if (__imgui_pop_id == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_id = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[24];
    if (__imgui_get_id == nullptr) return gmval_undefined();
    const char* result = __imgui_get_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_disabled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_disabled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_disabled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[25];
    if (__imgui_begin_disabled == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_disabled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_disabled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_disabled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_disabled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[26];
    if (__imgui_end_disabled == nullptr) return gmval_undefined();
    const char* result = __imgui_end_disabled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_hovered(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_hovered", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_hovered = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[27];
    if (__imgui_is_item_hovered == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_hovered();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_active(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_active", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_active = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[28];
    if (__imgui_is_item_active == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_active();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_focused(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_focused", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_focused = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[29];
    if (__imgui_is_item_focused == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_focused();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_clicked(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_clicked", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_clicked = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[30];
    if (__imgui_is_item_clicked == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_clicked();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_visible(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_visible", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_visible = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[31];
    if (__imgui_is_item_visible == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_visible();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_edited(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_edited", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_edited = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[32];
    if (__imgui_is_item_edited == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_edited();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_activated(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_activated", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_activated = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[33];
    if (__imgui_is_item_activated == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_activated();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_deactivated(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_deactivated", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_deactivated = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[34];
    if (__imgui_is_item_deactivated == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_deactivated();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_deactivated_after_edit(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_deactivated_after_edit", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_deactivated_after_edit = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[35];
    if (__imgui_is_item_deactivated_after_edit == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_deactivated_after_edit();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_toggled_open(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_item_toggled_open", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_item_toggled_open = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[36];
    if (__imgui_is_item_toggled_open == nullptr) return gmval_undefined();
    const char* result = __imgui_is_item_toggled_open();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_any_item_hovered(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_any_item_hovered", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_any_item_hovered = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[37];
    if (__imgui_is_any_item_hovered == nullptr) return gmval_undefined();
    const char* result = __imgui_is_any_item_hovered();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_any_item_active(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_any_item_active", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_any_item_active = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[38];
    if (__imgui_is_any_item_active == nullptr) return gmval_undefined();
    const char* result = __imgui_is_any_item_active();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_any_item_focused(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_any_item_focused", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_any_item_focused = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[39];
    if (__imgui_is_any_item_focused == nullptr) return gmval_undefined();
    const char* result = __imgui_is_any_item_focused();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_id = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[40];
    if (__imgui_get_item_id == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_min_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_rect_min_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_rect_min_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[41];
    if (__imgui_get_item_rect_min_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_rect_min_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_min_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_rect_min_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_rect_min_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[42];
    if (__imgui_get_item_rect_min_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_rect_min_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_max_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_rect_max_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_rect_max_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[43];
    if (__imgui_get_item_rect_max_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_rect_max_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_max_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_rect_max_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_rect_max_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[44];
    if (__imgui_get_item_rect_max_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_rect_max_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_size_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_rect_size_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_rect_size_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[45];
    if (__imgui_get_item_rect_size_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_rect_size_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_size_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_item_rect_size_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_item_rect_size_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[46];
    if (__imgui_get_item_rect_size_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_item_rect_size_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_item_allow_overlap(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_item_allow_overlap", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_item_allow_overlap = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[47];
    if (__imgui_set_item_allow_overlap == nullptr) return gmval_undefined();
    const char* result = __imgui_set_item_allow_overlap();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_rect_visible(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_rect_visible", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_rect_visible = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[48];
    if (__imgui_is_rect_visible == nullptr) return gmval_undefined();
    const char* result = __imgui_is_rect_visible();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_time(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_time", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_time = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[49];
    if (__imgui_get_time == nullptr) return gmval_undefined();
    const char* result = __imgui_get_time();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_frame_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_frame_count", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_frame_count = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[50];
    if (__imgui_get_frame_count == nullptr) return gmval_undefined();
    const char* result = __imgui_get_frame_count();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_calc_text_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_calc_text_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_calc_text_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[51];
    if (__imgui_calc_text_width == nullptr) return gmval_undefined();
    const char* result = __imgui_calc_text_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_calc_text_height(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_calc_text_height", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_calc_text_height = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[52];
    if (__imgui_calc_text_height == nullptr) return gmval_undefined();
    const char* result = __imgui_calc_text_height();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_allow_keyboard_focus(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_allow_keyboard_focus", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_allow_keyboard_focus = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[53];
    if (__imgui_push_allow_keyboard_focus == nullptr) return gmval_undefined();
    const char* result = __imgui_push_allow_keyboard_focus();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_allow_keyboard_focus(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_allow_keyboard_focus", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_allow_keyboard_focus = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[54];
    if (__imgui_pop_allow_keyboard_focus == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_allow_keyboard_focus();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_keyboard_focus_here(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_keyboard_focus_here", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_keyboard_focus_here = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[55];
    if (__imgui_set_keyboard_focus_here == nullptr) return gmval_undefined();
    const char* result = __imgui_set_keyboard_focus_here();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_button_repeat(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_button_repeat", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_button_repeat = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[56];
    if (__imgui_push_button_repeat == nullptr) return gmval_undefined();
    const char* result = __imgui_push_button_repeat();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_button_repeat(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_button_repeat", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_button_repeat = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[57];
    if (__imgui_pop_button_repeat == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_button_repeat();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_item_default_focus(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_item_default_focus", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_item_default_focus = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[58];
    if (__imgui_set_item_default_focus == nullptr) return gmval_undefined();
    const char* result = __imgui_set_item_default_focus();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_config_flags_get(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_config_flags_get", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_config_flags_get = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[59];
    if (__imgui_config_flags_get == nullptr) return gmval_undefined();
    const char* result = __imgui_config_flags_get();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_config_flags_set(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_config_flags_set", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_config_flags_set = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[60];
    if (__imgui_config_flags_set == nullptr) return gmval_undefined();
    const char* result = __imgui_config_flags_set();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_config_flag_toggle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_config_flag_toggle", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_config_flag_toggle = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[61];
    if (__imgui_config_flag_toggle == nullptr) return gmval_undefined();
    const char* result = __imgui_config_flag_toggle();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_main_viewport(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_main_viewport", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_main_viewport = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[62];
    if (__imgui_get_main_viewport == nullptr) return gmval_undefined();
    const char* result = __imgui_get_main_viewport();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_log_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_log_text", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_log_text = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[63];
    if (__imgui_log_text == nullptr) return gmval_undefined();
    const char* result = __imgui_log_text();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_keyboard_capture(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_want_keyboard_capture", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_want_keyboard_capture = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[64];
    if (__imgui_want_keyboard_capture == nullptr) return gmval_undefined();
    const char* result = __imgui_want_keyboard_capture();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_mouse_capture(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_want_mouse_capture", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_want_mouse_capture = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[65];
    if (__imgui_want_mouse_capture == nullptr) return gmval_undefined();
    const char* result = __imgui_want_mouse_capture();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_text_input(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_want_text_input", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_want_text_input = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[66];
    if (__imgui_want_text_input == nullptr) return gmval_undefined();
    const char* result = __imgui_want_text_input();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_mouse_unless_popup_close(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_want_mouse_unless_popup_close", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_want_mouse_unless_popup_close = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[67];
    if (__imgui_want_mouse_unless_popup_close == nullptr) return gmval_undefined();
    const char* result = __imgui_want_mouse_unless_popup_close();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_edit3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_color_edit3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_color_edit3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[68];
    if (__imgui_color_edit3 == nullptr) return gmval_undefined();
    const char* result = __imgui_color_edit3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_picker3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_color_picker3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_color_picker3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[69];
    if (__imgui_color_picker3 == nullptr) return gmval_undefined();
    const char* result = __imgui_color_picker3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_edit4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_color_edit4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_color_edit4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[70];
    if (__imgui_color_edit4 == nullptr) return gmval_undefined();
    const char* result = __imgui_color_edit4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_picker4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_color_picker4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_color_picker4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[71];
    if (__imgui_color_picker4 == nullptr) return gmval_undefined();
    const char* result = __imgui_color_picker4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_color_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_color_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[72];
    if (__imgui_color_button == nullptr) return gmval_undefined();
    const char* result = __imgui_color_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_color_edit_options(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_color_edit_options", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_color_edit_options = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[73];
    if (__imgui_set_color_edit_options == nullptr) return gmval_undefined();
    const char* result = __imgui_set_color_edit_options();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_combo(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_combo", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_combo = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[74];
    if (__imgui_begin_combo == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_combo();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_combo(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_combo", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_combo = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[75];
    if (__imgui_end_combo == nullptr) return gmval_undefined();
    const char* result = __imgui_end_combo();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_combo(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_combo", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_combo = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[76];
    if (__imgui_combo == nullptr) return gmval_undefined();
    const char* result = __imgui_combo();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dock_space(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dock_space", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dock_space = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[77];
    if (__imgui_dock_space == nullptr) return gmval_undefined();
    const char* result = __imgui_dock_space();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dock_space_over_viewport(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dock_space_over_viewport", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dock_space_over_viewport = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[78];
    if (__imgui_dock_space_over_viewport == nullptr) return gmval_undefined();
    const char* result = __imgui_dock_space_over_viewport();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_dock_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_dock_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_dock_id = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[79];
    if (__imgui_set_next_window_dock_id == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_dock_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_class(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_class", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_class = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[80];
    if (__imgui_set_next_window_class == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_class();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_dock_id(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_dock_id", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_dock_id = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[81];
    if (__imgui_get_window_dock_id == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_dock_id();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_docked(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_window_docked", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_window_docked = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[82];
    if (__imgui_is_window_docked == nullptr) return gmval_undefined();
    const char* result = __imgui_is_window_docked();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_dock_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_dock_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_dock_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[83];
    if (__imgui_dockbuilder_dock_window == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_dock_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_get_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_get_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_get_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[84];
    if (__imgui_dockbuilder_get_node == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_get_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_get_central_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_get_central_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_get_central_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[85];
    if (__imgui_dockbuilder_get_central_node == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_get_central_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_add_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_add_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_add_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[86];
    if (__imgui_dockbuilder_add_node == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_add_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_remove_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_remove_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_remove_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[87];
    if (__imgui_dockbuilder_remove_node == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_remove_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_remove_node_docked_windows(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_remove_node_docked_windows", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_remove_node_docked_windows = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[88];
    if (__imgui_dockbuilder_remove_node_docked_windows == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_remove_node_docked_windows();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_remove_node_child_nodes(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_remove_node_child_nodes", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_remove_node_child_nodes = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[89];
    if (__imgui_dockbuilder_remove_node_child_nodes == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_remove_node_child_nodes();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_set_node_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_set_node_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_set_node_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[90];
    if (__imgui_dockbuilder_set_node_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_set_node_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_set_node_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_set_node_size", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_set_node_size = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[91];
    if (__imgui_dockbuilder_set_node_size == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_set_node_size();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_split_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_split_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_split_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[92];
    if (__imgui_dockbuilder_split_node == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_split_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_copy_dock_space(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_copy_dock_space", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_copy_dock_space = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[93];
    if (__imgui_dockbuilder_copy_dock_space == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_copy_dock_space();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_copy_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_copy_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_copy_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[94];
    if (__imgui_dockbuilder_copy_node == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_copy_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_copy_window_settings(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_copy_window_settings", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_copy_window_settings = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[95];
    if (__imgui_dockbuilder_copy_window_settings == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_copy_window_settings();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_finish(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dockbuilder_finish", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dockbuilder_finish = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[96];
    if (__imgui_dockbuilder_finish == nullptr) return gmval_undefined();
    const char* result = __imgui_dockbuilder_finish();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_float", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_float = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[97];
    if (__imgui_drag_float == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_float();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_float2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_float2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[98];
    if (__imgui_drag_float2 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_float2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_float3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_float3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[99];
    if (__imgui_drag_float3 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_float3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_float4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_float4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[100];
    if (__imgui_drag_float4 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_float4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_floatn(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_floatn", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_floatn = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[101];
    if (__imgui_drag_floatn == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_floatn();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float_range2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_float_range2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_float_range2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[102];
    if (__imgui_drag_float_range2 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_float_range2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_int", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_int = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[103];
    if (__imgui_drag_int == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_int();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_int2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_int2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[104];
    if (__imgui_drag_int2 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_int2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_int3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_int3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[105];
    if (__imgui_drag_int3 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_int3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_int4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_int4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[106];
    if (__imgui_drag_int4 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_int4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_intn(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_intn", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_intn = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[107];
    if (__imgui_drag_intn == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_intn();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int_range2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drag_int_range2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drag_int_range2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[108];
    if (__imgui_drag_int_range2 == nullptr) return gmval_undefined();
    const char* result = __imgui_drag_int_range2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_background_drawlist(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_background_drawlist", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_background_drawlist = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[109];
    if (__imgui_get_background_drawlist == nullptr) return gmval_undefined();
    const char* result = __imgui_get_background_drawlist();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_foreground_drawlist(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_foreground_drawlist", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_foreground_drawlist = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[110];
    if (__imgui_get_foreground_drawlist == nullptr) return gmval_undefined();
    const char* result = __imgui_get_foreground_drawlist();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_drawlist(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_drawlist", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_drawlist = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[111];
    if (__imgui_get_window_drawlist == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_drawlist();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_line(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_line", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_line = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[112];
    if (__imgui_drawlist_add_line == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_line();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_rect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_rect", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_rect = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[113];
    if (__imgui_drawlist_add_rect == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_rect();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_rect_filled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_rect_filled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_rect_filled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[114];
    if (__imgui_drawlist_add_rect_filled == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_rect_filled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_rect_filled_multicolor(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_rect_filled_multicolor", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_rect_filled_multicolor = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[115];
    if (__imgui_drawlist_add_rect_filled_multicolor == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_rect_filled_multicolor();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_quad(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_quad", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_quad = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[116];
    if (__imgui_drawlist_add_quad == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_quad();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_quad_filled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_quad_filled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_quad_filled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[117];
    if (__imgui_drawlist_add_quad_filled == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_quad_filled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_triangle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_triangle", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_triangle = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[118];
    if (__imgui_drawlist_add_triangle == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_triangle();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_triangle_filled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_triangle_filled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_triangle_filled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[119];
    if (__imgui_drawlist_add_triangle_filled == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_triangle_filled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_circle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_circle", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_circle = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[120];
    if (__imgui_drawlist_add_circle == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_circle();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_circle_filled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_circle_filled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_circle_filled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[121];
    if (__imgui_drawlist_add_circle_filled == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_circle_filled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_ngon(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_ngon", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_ngon = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[122];
    if (__imgui_drawlist_add_ngon == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_ngon();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_ngon_filled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_ngon_filled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_ngon_filled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[123];
    if (__imgui_drawlist_add_ngon_filled == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_ngon_filled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_text", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_text = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[124];
    if (__imgui_drawlist_add_text == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_text();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_text_font(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_text_font", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_text_font = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[125];
    if (__imgui_drawlist_add_text_font == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_text_font();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_polyline(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_polyline", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_polyline = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[126];
    if (__imgui_drawlist_add_polyline == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_polyline();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_convex_poly_filled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_convex_poly_filled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_convex_poly_filled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[127];
    if (__imgui_drawlist_add_convex_poly_filled == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_convex_poly_filled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_bezier_cubic(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_bezier_cubic", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_bezier_cubic = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[128];
    if (__imgui_drawlist_add_bezier_cubic == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_bezier_cubic();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_bezier_quadratic(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_bezier_quadratic", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_bezier_quadratic = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[129];
    if (__imgui_drawlist_add_bezier_quadratic == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_bezier_quadratic();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_fill_convex(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_fill_convex", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_fill_convex = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[130];
    if (__imgui_drawlist_path_fill_convex == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_fill_convex();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_stroke(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_stroke", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_stroke = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[131];
    if (__imgui_drawlist_path_stroke == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_stroke();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_clear(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_clear", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_clear = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[132];
    if (__imgui_drawlist_path_clear == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_clear();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_line_to(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_line_to", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_line_to = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[133];
    if (__imgui_drawlist_path_line_to == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_line_to();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_line_to_merge_duplicate(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_line_to_merge_duplicate", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_line_to_merge_duplicate = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[134];
    if (__imgui_drawlist_path_line_to_merge_duplicate == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_line_to_merge_duplicate();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_arc_to(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_arc_to", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_arc_to = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[135];
    if (__imgui_drawlist_path_arc_to == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_arc_to();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_arc_to_fast(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_arc_to_fast", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_arc_to_fast = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[136];
    if (__imgui_drawlist_path_arc_to_fast == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_arc_to_fast();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_bezier_cubic_curve_to(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_bezier_cubic_curve_to", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_bezier_cubic_curve_to = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[137];
    if (__imgui_drawlist_path_bezier_cubic_curve_to == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_bezier_cubic_curve_to();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_bezier_quadratic_curve_to(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_bezier_quadratic_curve_to", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_bezier_quadratic_curve_to = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[138];
    if (__imgui_drawlist_path_bezier_quadratic_curve_to == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_bezier_quadratic_curve_to();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_rect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_path_rect", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_path_rect = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[139];
    if (__imgui_drawlist_path_rect == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_path_rect();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_image(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_image", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_image = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[140];
    if (__imgui_drawlist_add_image == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_image();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_image_rounded(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_add_image_rounded", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_add_image_rounded = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[141];
    if (__imgui_drawlist_add_image_rounded == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_add_image_rounded();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_push_clip_rect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_push_clip_rect", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_push_clip_rect = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[142];
    if (__imgui_drawlist_push_clip_rect == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_push_clip_rect();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_push_clip_rect_fullscreen(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_push_clip_rect_fullscreen", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_push_clip_rect_fullscreen = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[143];
    if (__imgui_drawlist_push_clip_rect_fullscreen == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_push_clip_rect_fullscreen();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_pop_clip_rect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_pop_clip_rect", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_pop_clip_rect = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[144];
    if (__imgui_drawlist_pop_clip_rect == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_pop_clip_rect();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_push_textureid(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_push_textureid", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_push_textureid = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[145];
    if (__imgui_drawlist_push_textureid == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_push_textureid();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_pop_textureid(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_pop_textureid", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_pop_textureid = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[146];
    if (__imgui_drawlist_pop_textureid == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_pop_textureid();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_flags_get(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_flags_get", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_flags_get = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[147];
    if (__imgui_drawlist_flags_get == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_flags_get();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_flags_set(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_flags_set", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_flags_set = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[148];
    if (__imgui_drawlist_flags_set == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_flags_set();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_flag_toggle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_drawlist_flag_toggle", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_drawlist_flag_toggle = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[149];
    if (__imgui_drawlist_flag_toggle == nullptr) return gmval_undefined();
    const char* result = __imgui_drawlist_flag_toggle();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_memory_editor_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_memory_editor_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_memory_editor_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[150];
    if (__imgui_memory_editor_window == nullptr) return gmval_undefined();
    const char* result = __imgui_memory_editor_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_memory_editor_contents(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_memory_editor_contents", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_memory_editor_contents = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[151];
    if (__imgui_memory_editor_contents == nullptr) return gmval_undefined();
    const char* result = __imgui_memory_editor_contents();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_font(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_font", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_font = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[152];
    if (__imgui_get_font == nullptr) return gmval_undefined();
    const char* result = __imgui_get_font();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_font_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_font_size", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_font_size = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[153];
    if (__imgui_get_font_size == nullptr) return gmval_undefined();
    const char* result = __imgui_get_font_size();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_font(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_font", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_font = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[154];
    if (__imgui_push_font == nullptr) return gmval_undefined();
    const char* result = __imgui_push_font();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_font(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_font", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_font = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[155];
    if (__imgui_pop_font == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_font();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_add_font_from_file(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_add_font_from_file", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_add_font_from_file = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[156];
    if (__imgui_add_font_from_file == nullptr) return gmval_undefined();
    const char* result = __imgui_add_font_from_file();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_add_font_default(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_add_font_default", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_add_font_default = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[157];
    if (__imgui_add_font_default == nullptr) return gmval_undefined();
    const char* result = __imgui_add_font_default();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_native(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imguigm_native", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imguigm_native = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[158];
    if (__imguigm_native == nullptr) return gmval_undefined();
    const char* result = __imguigm_native();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_command_buffer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imguigm_command_buffer", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imguigm_command_buffer = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[159];
    if (__imguigm_command_buffer == nullptr) return gmval_undefined();
    const char* result = __imguigm_command_buffer();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_font_buffer(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imguigm_font_buffer", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imguigm_font_buffer = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[160];
    if (__imguigm_font_buffer == nullptr) return gmval_undefined();
    const char* result = __imguigm_font_buffer();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_keepalive(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imguigm_keepalive", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imguigm_keepalive = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[161];
    if (__imguigm_keepalive == nullptr) return gmval_undefined();
    const char* result = __imguigm_keepalive();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_text", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_text = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[162];
    if (__imgui_input_text == nullptr) return gmval_undefined();
    const char* result = __imgui_input_text();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_textmultiline(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_textmultiline", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_textmultiline = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[163];
    if (__imgui_input_textmultiline == nullptr) return gmval_undefined();
    const char* result = __imgui_input_textmultiline();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_textwithhint(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_textwithhint", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_textwithhint = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[164];
    if (__imgui_input_textwithhint == nullptr) return gmval_undefined();
    const char* result = __imgui_input_textwithhint();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_float", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_float = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[165];
    if (__imgui_input_float == nullptr) return gmval_undefined();
    const char* result = __imgui_input_float();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_float2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_float2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[166];
    if (__imgui_input_float2 == nullptr) return gmval_undefined();
    const char* result = __imgui_input_float2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_float3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_float3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[167];
    if (__imgui_input_float3 == nullptr) return gmval_undefined();
    const char* result = __imgui_input_float3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_float4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_float4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[168];
    if (__imgui_input_float4 == nullptr) return gmval_undefined();
    const char* result = __imgui_input_float4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_floatn(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_floatn", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_floatn = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[169];
    if (__imgui_input_floatn == nullptr) return gmval_undefined();
    const char* result = __imgui_input_floatn();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_int", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_int = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[170];
    if (__imgui_input_int == nullptr) return gmval_undefined();
    const char* result = __imgui_input_int();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_int2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_int2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[171];
    if (__imgui_input_int2 == nullptr) return gmval_undefined();
    const char* result = __imgui_input_int2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_int3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_int3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[172];
    if (__imgui_input_int3 == nullptr) return gmval_undefined();
    const char* result = __imgui_input_int3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_int4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_int4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[173];
    if (__imgui_input_int4 == nullptr) return gmval_undefined();
    const char* result = __imgui_input_int4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_intn(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_intn", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_intn = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[174];
    if (__imgui_input_intn == nullptr) return gmval_undefined();
    const char* result = __imgui_input_intn();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_double(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_input_double", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_input_double = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[175];
    if (__imgui_input_double == nullptr) return gmval_undefined();
    const char* result = __imgui_input_double();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_spacing(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_spacing", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_spacing = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[176];
    if (__imgui_spacing == nullptr) return gmval_undefined();
    const char* result = __imgui_spacing();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dummy(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_dummy", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_dummy = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[177];
    if (__imgui_dummy == nullptr) return gmval_undefined();
    const char* result = __imgui_dummy();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_newline(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_newline", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_newline = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[178];
    if (__imgui_newline == nullptr) return gmval_undefined();
    const char* result = __imgui_newline();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_align_text_to_frame_padding(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_align_text_to_frame_padding", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_align_text_to_frame_padding = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[179];
    if (__imgui_align_text_to_frame_padding == nullptr) return gmval_undefined();
    const char* result = __imgui_align_text_to_frame_padding();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_separator(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_separator", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_separator = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[180];
    if (__imgui_separator == nullptr) return gmval_undefined();
    const char* result = __imgui_separator();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_indent(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_indent", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_indent = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[181];
    if (__imgui_indent == nullptr) return gmval_undefined();
    const char* result = __imgui_indent();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_unindent(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_unindent", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_unindent = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[182];
    if (__imgui_unindent == nullptr) return gmval_undefined();
    const char* result = __imgui_unindent();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_sameline(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_sameline", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_sameline = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[183];
    if (__imgui_sameline == nullptr) return gmval_undefined();
    const char* result = __imgui_sameline();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_group(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_group", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_group = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[184];
    if (__imgui_begin_group == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_group();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_group(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_group", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_group = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[185];
    if (__imgui_end_group == nullptr) return gmval_undefined();
    const char* result = __imgui_end_group();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_pos_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_cursor_pos_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_cursor_pos_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[186];
    if (__imgui_get_cursor_pos_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_cursor_pos_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_pos_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_cursor_pos_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_cursor_pos_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[187];
    if (__imgui_get_cursor_pos_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_cursor_pos_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_start_pos_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_cursor_start_pos_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_cursor_start_pos_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[188];
    if (__imgui_get_cursor_start_pos_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_cursor_start_pos_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_start_pos_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_cursor_start_pos_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_cursor_start_pos_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[189];
    if (__imgui_get_cursor_start_pos_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_cursor_start_pos_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_screen_pos_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_cursor_screen_pos_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_cursor_screen_pos_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[190];
    if (__imgui_get_cursor_screen_pos_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_cursor_screen_pos_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_screen_pos_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_cursor_screen_pos_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_cursor_screen_pos_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[191];
    if (__imgui_get_cursor_screen_pos_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_cursor_screen_pos_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_screen_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_cursor_screen_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_cursor_screen_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[192];
    if (__imgui_set_cursor_screen_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_set_cursor_screen_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_cursor_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_cursor_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[193];
    if (__imgui_set_cursor_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_set_cursor_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_pos_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_cursor_pos_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_cursor_pos_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[194];
    if (__imgui_set_cursor_pos_x == nullptr) return gmval_undefined();
    const char* result = __imgui_set_cursor_pos_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_pos_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_cursor_pos_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_cursor_pos_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[195];
    if (__imgui_set_cursor_pos_y == nullptr) return gmval_undefined();
    const char* result = __imgui_set_cursor_pos_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_text_line_height(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_text_line_height", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_text_line_height = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[196];
    if (__imgui_get_text_line_height == nullptr) return gmval_undefined();
    const char* result = __imgui_get_text_line_height();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_text_line_height_with_spacing(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_text_line_height_with_spacing", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_text_line_height_with_spacing = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[197];
    if (__imgui_get_text_line_height_with_spacing == nullptr) return gmval_undefined();
    const char* result = __imgui_get_text_line_height_with_spacing();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_frame_height(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_frame_height", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_frame_height = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[198];
    if (__imgui_get_frame_height == nullptr) return gmval_undefined();
    const char* result = __imgui_get_frame_height();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_frame_height_with_spacing(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_frame_height_with_spacing", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_frame_height_with_spacing = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[199];
    if (__imgui_get_frame_height_with_spacing == nullptr) return gmval_undefined();
    const char* result = __imgui_get_frame_height_with_spacing();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_avail_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_content_region_avail_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_content_region_avail_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[200];
    if (__imgui_get_content_region_avail_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_content_region_avail_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_avail_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_content_region_avail_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_content_region_avail_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[201];
    if (__imgui_get_content_region_avail_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_content_region_avail_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_max_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_content_region_max_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_content_region_max_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[202];
    if (__imgui_get_content_region_max_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_content_region_max_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_max_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_content_region_max_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_content_region_max_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[203];
    if (__imgui_get_content_region_max_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_content_region_max_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_min_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_content_region_min_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_content_region_min_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[204];
    if (__imgui_get_window_content_region_min_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_content_region_min_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_min_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_content_region_min_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_content_region_min_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[205];
    if (__imgui_get_window_content_region_min_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_content_region_min_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_max_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_content_region_max_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_content_region_max_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[206];
    if (__imgui_get_window_content_region_max_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_content_region_max_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_max_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_content_region_max_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_content_region_max_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[207];
    if (__imgui_get_window_content_region_max_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_content_region_max_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_item_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_item_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_item_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[208];
    if (__imgui_push_item_width == nullptr) return gmval_undefined();
    const char* result = __imgui_push_item_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_item_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_item_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_item_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[209];
    if (__imgui_pop_item_width == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_item_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_item_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_item_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_item_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[210];
    if (__imgui_set_next_item_width == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_item_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_calc_item_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_calc_item_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_calc_item_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[211];
    if (__imgui_calc_item_width == nullptr) return gmval_undefined();
    const char* result = __imgui_calc_item_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_text_wrap_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_text_wrap_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_text_wrap_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[212];
    if (__imgui_push_text_wrap_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_push_text_wrap_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_text_wrap_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_text_wrap_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_text_wrap_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[213];
    if (__imgui_pop_text_wrap_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_text_wrap_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_clip_rect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_clip_rect", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_clip_rect = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[214];
    if (__imgui_push_clip_rect == nullptr) return gmval_undefined();
    const char* result = __imgui_push_clip_rect();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_clip_rect(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_clip_rect", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_clip_rect = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[215];
    if (__imgui_pop_clip_rect == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_clip_rect();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_listbox(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_listbox", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_listbox = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[216];
    if (__imgui_begin_listbox == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_listbox();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_listbox(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_listbox", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_listbox = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[217];
    if (__imgui_end_listbox == nullptr) return gmval_undefined();
    const char* result = __imgui_end_listbox();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_listbox(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_listbox", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_listbox = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[218];
    if (__imgui_listbox == nullptr) return gmval_undefined();
    const char* result = __imgui_listbox();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_menubar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_menubar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_menubar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[219];
    if (__imgui_begin_menubar == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_menubar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_menubar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_menubar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_menubar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[220];
    if (__imgui_end_menubar == nullptr) return gmval_undefined();
    const char* result = __imgui_end_menubar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_mainmenubar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_mainmenubar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_mainmenubar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[221];
    if (__imgui_begin_mainmenubar == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_mainmenubar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_mainmenubar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_mainmenubar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_mainmenubar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[222];
    if (__imgui_end_mainmenubar == nullptr) return gmval_undefined();
    const char* result = __imgui_end_mainmenubar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_menu(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_menu", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_menu = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[223];
    if (__imgui_begin_menu == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_menu();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_menu(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_menu", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_menu = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[224];
    if (__imgui_end_menu == nullptr) return gmval_undefined();
    const char* result = __imgui_end_menu();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_menu_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_menu_item", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_menu_item = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[225];
    if (__imgui_menu_item == nullptr) return gmval_undefined();
    const char* result = __imgui_menu_item();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_drag_drop_source(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_drag_drop_source", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_drag_drop_source = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[226];
    if (__imgui_begin_drag_drop_source == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_drag_drop_source();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_drag_drop_source(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_drag_drop_source", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_drag_drop_source = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[227];
    if (__imgui_end_drag_drop_source == nullptr) return gmval_undefined();
    const char* result = __imgui_end_drag_drop_source();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_drag_drop_target(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_drag_drop_target", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_drag_drop_target = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[228];
    if (__imgui_begin_drag_drop_target == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_drag_drop_target();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_drag_drop_target(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_drag_drop_target", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_drag_drop_target = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[229];
    if (__imgui_end_drag_drop_target == nullptr) return gmval_undefined();
    const char* result = __imgui_end_drag_drop_target();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_drag_drop_payload(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_drag_drop_payload", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_drag_drop_payload = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[230];
    if (__imgui_set_drag_drop_payload == nullptr) return gmval_undefined();
    const char* result = __imgui_set_drag_drop_payload();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_accept_drag_drop_payload(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_accept_drag_drop_payload", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_accept_drag_drop_payload = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[231];
    if (__imgui_accept_drag_drop_payload == nullptr) return gmval_undefined();
    const char* result = __imgui_accept_drag_drop_payload();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_drag_drop_payload(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_drag_drop_payload", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_drag_drop_payload = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[232];
    if (__imgui_get_drag_drop_payload == nullptr) return gmval_undefined();
    const char* result = __imgui_get_drag_drop_payload();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_payload_type(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_payload_type", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_payload_type = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[233];
    if (__imgui_get_payload_type == nullptr) return gmval_undefined();
    const char* result = __imgui_get_payload_type();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_plot_lines(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_plot_lines", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_plot_lines = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[234];
    if (__imgui_plot_lines == nullptr) return gmval_undefined();
    const char* result = __imgui_plot_lines();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_plot_histogram(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_plot_histogram", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_plot_histogram = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[235];
    if (__imgui_plot_histogram == nullptr) return gmval_undefined();
    const char* result = __imgui_plot_histogram();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_popup", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_popup = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[236];
    if (__imgui_begin_popup == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_popup();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_modal(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_popup_modal", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_popup_modal = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[237];
    if (__imgui_begin_popup_modal == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_popup_modal();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_popup(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_popup", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_popup = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[238];
    if (__imgui_end_popup == nullptr) return gmval_undefined();
    const char* result = __imgui_end_popup();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_open_popup(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_open_popup", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_open_popup = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[239];
    if (__imgui_open_popup == nullptr) return gmval_undefined();
    const char* result = __imgui_open_popup();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_open_popup_on_item_click(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_open_popup_on_item_click", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_open_popup_on_item_click = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[240];
    if (__imgui_open_popup_on_item_click == nullptr) return gmval_undefined();
    const char* result = __imgui_open_popup_on_item_click();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_close_current_popup(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_close_current_popup", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_close_current_popup = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[241];
    if (__imgui_close_current_popup == nullptr) return gmval_undefined();
    const char* result = __imgui_close_current_popup();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_context_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_popup_context_item", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_popup_context_item = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[242];
    if (__imgui_begin_popup_context_item == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_popup_context_item();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_context_window(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_popup_context_window", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_popup_context_window = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[243];
    if (__imgui_begin_popup_context_window == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_popup_context_window();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_context_void(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_popup_context_void", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_popup_context_void = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[244];
    if (__imgui_begin_popup_context_void == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_popup_context_void();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_popup_open(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_popup_open", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_popup_open = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[245];
    if (__imgui_is_popup_open == nullptr) return gmval_undefined();
    const char* result = __imgui_is_popup_open();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_selectable(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_selectable", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_selectable = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[246];
    if (__imgui_selectable == nullptr) return gmval_undefined();
    const char* result = __imgui_selectable();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_float", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_float = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[247];
    if (__imgui_slider_float == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_float();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_float2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_float2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[248];
    if (__imgui_slider_float2 == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_float2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_float3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_float3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[249];
    if (__imgui_slider_float3 == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_float3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_float4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_float4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[250];
    if (__imgui_slider_float4 == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_float4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_floatn(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_floatn", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_floatn = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[251];
    if (__imgui_slider_floatn == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_floatn();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_int", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_int = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[252];
    if (__imgui_slider_int == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_int();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int2(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_int2", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_int2 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[253];
    if (__imgui_slider_int2 == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_int2();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int3(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_int3", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_int3 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[254];
    if (__imgui_slider_int3 == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_int3();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int4(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_int4", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_int4 = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[255];
    if (__imgui_slider_int4 == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_int4();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_intn(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_intn", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_intn = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[256];
    if (__imgui_slider_intn == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_intn();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_vslider_float(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_vslider_float", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_vslider_float = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[257];
    if (__imgui_vslider_float == nullptr) return gmval_undefined();
    const char* result = __imgui_vslider_float();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_vslider_int(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_vslider_int", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_vslider_int = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[258];
    if (__imgui_vslider_int == nullptr) return gmval_undefined();
    const char* result = __imgui_vslider_int();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_angle(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_slider_angle", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_slider_angle = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[259];
    if (__imgui_slider_angle == nullptr) return gmval_undefined();
    const char* result = __imgui_slider_angle();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_style_colors_dark(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_style_colors_dark", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_style_colors_dark = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[260];
    if (__imgui_style_colors_dark == nullptr) return gmval_undefined();
    const char* result = __imgui_style_colors_dark();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_style_colors_light(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_style_colors_light", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_style_colors_light = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[261];
    if (__imgui_style_colors_light == nullptr) return gmval_undefined();
    const char* result = __imgui_style_colors_light();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_style_colors_classic(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_style_colors_classic", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_style_colors_classic = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[262];
    if (__imgui_style_colors_classic == nullptr) return gmval_undefined();
    const char* result = __imgui_style_colors_classic();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_style_color(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_style_color", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_style_color = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[263];
    if (__imgui_push_style_color == nullptr) return gmval_undefined();
    const char* result = __imgui_push_style_color();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_style_color(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_style_color", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_style_color = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[264];
    if (__imgui_pop_style_color == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_style_color();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_style_var(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_push_style_var", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_push_style_var = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[265];
    if (__imgui_push_style_var == nullptr) return gmval_undefined();
    const char* result = __imgui_push_style_var();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_style_var(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_pop_style_var", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_pop_style_var = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[266];
    if (__imgui_pop_style_var == nullptr) return gmval_undefined();
    const char* result = __imgui_pop_style_var();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_style_color(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_style_color", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_style_color = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[267];
    if (__imgui_get_style_color == nullptr) return gmval_undefined();
    const char* result = __imgui_get_style_color();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_style_color_name(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_style_color_name", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_style_color_name = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[268];
    if (__imgui_get_style_color_name == nullptr) return gmval_undefined();
    const char* result = __imgui_get_style_color_name();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_table(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_table", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_table = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[269];
    if (__imgui_begin_table == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_table();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_table(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_table", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_table = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[270];
    if (__imgui_end_table == nullptr) return gmval_undefined();
    const char* result = __imgui_end_table();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_next_row(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_next_row", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_next_row = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[271];
    if (__imgui_table_next_row == nullptr) return gmval_undefined();
    const char* result = __imgui_table_next_row();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_next_column(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_next_column", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_next_column = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[272];
    if (__imgui_table_next_column == nullptr) return gmval_undefined();
    const char* result = __imgui_table_next_column();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_set_column_index(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_set_column_index", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_set_column_index = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[273];
    if (__imgui_table_set_column_index == nullptr) return gmval_undefined();
    const char* result = __imgui_table_set_column_index();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_setup_column(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_setup_column", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_setup_column = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[274];
    if (__imgui_table_setup_column == nullptr) return gmval_undefined();
    const char* result = __imgui_table_setup_column();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_setup_scroll_freeze(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_setup_scroll_freeze", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_setup_scroll_freeze = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[275];
    if (__imgui_table_setup_scroll_freeze == nullptr) return gmval_undefined();
    const char* result = __imgui_table_setup_scroll_freeze();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_headers_row(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_headers_row", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_headers_row = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[276];
    if (__imgui_table_headers_row == nullptr) return gmval_undefined();
    const char* result = __imgui_table_headers_row();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_header(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_header", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_header = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[277];
    if (__imgui_table_header == nullptr) return gmval_undefined();
    const char* result = __imgui_table_header();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_get_column_count", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_get_column_count = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[278];
    if (__imgui_table_get_column_count == nullptr) return gmval_undefined();
    const char* result = __imgui_table_get_column_count();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_index(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_get_column_index", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_get_column_index = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[279];
    if (__imgui_table_get_column_index == nullptr) return gmval_undefined();
    const char* result = __imgui_table_get_column_index();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_name(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_get_column_name", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_get_column_name = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[280];
    if (__imgui_table_get_column_name == nullptr) return gmval_undefined();
    const char* result = __imgui_table_get_column_name();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_flags(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_get_column_flags", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_get_column_flags = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[281];
    if (__imgui_table_get_column_flags == nullptr) return gmval_undefined();
    const char* result = __imgui_table_get_column_flags();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_row_index(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_get_row_index", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_get_row_index = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[282];
    if (__imgui_table_get_row_index == nullptr) return gmval_undefined();
    const char* result = __imgui_table_get_row_index();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_set_column_enabled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_set_column_enabled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_set_column_enabled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[283];
    if (__imgui_table_set_column_enabled == nullptr) return gmval_undefined();
    const char* result = __imgui_table_set_column_enabled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_set_bg_color(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_table_set_bg_color", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_table_set_bg_color = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[284];
    if (__imgui_table_set_bg_color == nullptr) return gmval_undefined();
    const char* result = __imgui_table_set_bg_color();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_columns(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_columns", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_columns = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[285];
    if (__imgui_columns == nullptr) return gmval_undefined();
    const char* result = __imgui_columns();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_next_column(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_next_column", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_next_column = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[286];
    if (__imgui_next_column == nullptr) return gmval_undefined();
    const char* result = __imgui_next_column();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_column_index(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_column_index", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_column_index = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[287];
    if (__imgui_get_column_index == nullptr) return gmval_undefined();
    const char* result = __imgui_get_column_index();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_column_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_column_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_column_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[288];
    if (__imgui_get_column_width == nullptr) return gmval_undefined();
    const char* result = __imgui_get_column_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_column_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_column_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_column_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[289];
    if (__imgui_set_column_width == nullptr) return gmval_undefined();
    const char* result = __imgui_set_column_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_column_offset(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_column_offset", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_column_offset = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[290];
    if (__imgui_get_column_offset == nullptr) return gmval_undefined();
    const char* result = __imgui_get_column_offset();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_column_offset(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_column_offset", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_column_offset = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[291];
    if (__imgui_set_column_offset == nullptr) return gmval_undefined();
    const char* result = __imgui_set_column_offset();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_columns_count(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_columns_count", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_columns_count = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[292];
    if (__imgui_get_columns_count == nullptr) return gmval_undefined();
    const char* result = __imgui_get_columns_count();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_tab_bar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_tab_bar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_tab_bar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[293];
    if (__imgui_begin_tab_bar == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_tab_bar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_tab_bar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_tab_bar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_tab_bar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[294];
    if (__imgui_end_tab_bar == nullptr) return gmval_undefined();
    const char* result = __imgui_end_tab_bar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_tab_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_tab_item", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_tab_item = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[295];
    if (__imgui_begin_tab_item == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_tab_item();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_tab_item(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_tab_item", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_tab_item = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[296];
    if (__imgui_end_tab_item == nullptr) return gmval_undefined();
    const char* result = __imgui_end_tab_item();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tab_item_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_tab_item_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_tab_item_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[297];
    if (__imgui_tab_item_button == nullptr) return gmval_undefined();
    const char* result = __imgui_tab_item_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_tab_item_closed(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_tab_item_closed", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_tab_item_closed = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[298];
    if (__imgui_set_tab_item_closed == nullptr) return gmval_undefined();
    const char* result = __imgui_set_tab_item_closed();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_unformatted(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_text_unformatted", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_text_unformatted = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[299];
    if (__imgui_text_unformatted == nullptr) return gmval_undefined();
    const char* result = __imgui_text_unformatted();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_text", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_text = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[300];
    if (__imgui_text == nullptr) return gmval_undefined();
    const char* result = __imgui_text();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_colored(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_text_colored", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_text_colored = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[301];
    if (__imgui_text_colored == nullptr) return gmval_undefined();
    const char* result = __imgui_text_colored();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_disabled(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_text_disabled", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_text_disabled = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[302];
    if (__imgui_text_disabled == nullptr) return gmval_undefined();
    const char* result = __imgui_text_disabled();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_wrapped(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_text_wrapped", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_text_wrapped = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[303];
    if (__imgui_text_wrapped == nullptr) return gmval_undefined();
    const char* result = __imgui_text_wrapped();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_label_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_label_text", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_label_text = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[304];
    if (__imgui_label_text == nullptr) return gmval_undefined();
    const char* result = __imgui_label_text();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_bullet_text(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_bullet_text", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_bullet_text = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[305];
    if (__imgui_bullet_text == nullptr) return gmval_undefined();
    const char* result = __imgui_bullet_text();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_value(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_value", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_value = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[306];
    if (__imgui_value == nullptr) return gmval_undefined();
    const char* result = __imgui_value();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_tooltip(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_tooltip", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_tooltip = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[307];
    if (__imgui_begin_tooltip == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_tooltip();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_tooltip(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_tooltip", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_tooltip = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[308];
    if (__imgui_end_tooltip == nullptr) return gmval_undefined();
    const char* result = __imgui_end_tooltip();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_tooltip(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_tooltip", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_tooltip = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[309];
    if (__imgui_set_tooltip == nullptr) return gmval_undefined();
    const char* result = __imgui_set_tooltip();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_node(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_tree_node", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_tree_node = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[310];
    if (__imgui_tree_node == nullptr) return gmval_undefined();
    const char* result = __imgui_tree_node();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_node_ex(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_tree_node_ex", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_tree_node_ex = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[311];
    if (__imgui_tree_node_ex == nullptr) return gmval_undefined();
    const char* result = __imgui_tree_node_ex();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_push(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_tree_push", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_tree_push = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[312];
    if (__imgui_tree_push == nullptr) return gmval_undefined();
    const char* result = __imgui_tree_push();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_pop(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_tree_pop", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_tree_pop = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[313];
    if (__imgui_tree_pop == nullptr) return gmval_undefined();
    const char* result = __imgui_tree_pop();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_tree_node_to_label_spacing(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_tree_node_to_label_spacing", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_tree_node_to_label_spacing = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[314];
    if (__imgui_get_tree_node_to_label_spacing == nullptr) return gmval_undefined();
    const char* result = __imgui_get_tree_node_to_label_spacing();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_item_open(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_item_open", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_item_open = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[315];
    if (__imgui_set_next_item_open == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_item_open();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_collapsing_header(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_collapsing_header", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_collapsing_header = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[316];
    if (__imgui_collapsing_header == nullptr) return gmval_undefined();
    const char* result = __imgui_collapsing_header();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[317];
    if (__imgui_button == nullptr) return gmval_undefined();
    const char* result = __imgui_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_small_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_small_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_small_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[318];
    if (__imgui_small_button == nullptr) return gmval_undefined();
    const char* result = __imgui_small_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_invisible_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_invisible_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_invisible_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[319];
    if (__imgui_invisible_button == nullptr) return gmval_undefined();
    const char* result = __imgui_invisible_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_arrow_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_arrow_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_arrow_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[320];
    if (__imgui_arrow_button == nullptr) return gmval_undefined();
    const char* result = __imgui_arrow_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_image(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_image", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_image = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[321];
    if (__imgui_image == nullptr) return gmval_undefined();
    const char* result = __imgui_image();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_image_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_image_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_image_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[322];
    if (__imgui_image_button == nullptr) return gmval_undefined();
    const char* result = __imgui_image_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_surface(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_surface", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_surface = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[323];
    if (__imgui_surface == nullptr) return gmval_undefined();
    const char* result = __imgui_surface();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_checkbox(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_checkbox", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_checkbox = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[324];
    if (__imgui_checkbox == nullptr) return gmval_undefined();
    const char* result = __imgui_checkbox();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_checkbox_flags(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_checkbox_flags", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_checkbox_flags = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[325];
    if (__imgui_checkbox_flags == nullptr) return gmval_undefined();
    const char* result = __imgui_checkbox_flags();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_radio_button(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_radio_button", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_radio_button = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[326];
    if (__imgui_radio_button == nullptr) return gmval_undefined();
    const char* result = __imgui_radio_button();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_progressbar(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_progressbar", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_progressbar = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[327];
    if (__imgui_progressbar == nullptr) return gmval_undefined();
    const char* result = __imgui_progressbar();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_bullet(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_bullet", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_bullet = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[328];
    if (__imgui_bullet == nullptr) return gmval_undefined();
    const char* result = __imgui_bullet();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[329];
    if (__imgui_begin == nullptr) return gmval_undefined();
    const char* result = __imgui_begin();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[330];
    if (__imgui_end == nullptr) return gmval_undefined();
    const char* result = __imgui_end();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_endframe(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_endframe", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_endframe = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[331];
    if (__imgui_endframe == nullptr) return gmval_undefined();
    const char* result = __imgui_endframe();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_child(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_child", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_child = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[332];
    if (__imgui_begin_child == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_child();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_child(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_child", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_child = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[333];
    if (__imgui_end_child == nullptr) return gmval_undefined();
    const char* result = __imgui_end_child();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_child_frame(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_begin_child_frame", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_begin_child_frame = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[334];
    if (__imgui_begin_child_frame == nullptr) return gmval_undefined();
    const char* result = __imgui_begin_child_frame();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_child_frame(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_end_child_frame", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_end_child_frame = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[335];
    if (__imgui_end_child_frame == nullptr) return gmval_undefined();
    const char* result = __imgui_end_child_frame();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_appearing(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_window_appearing", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_window_appearing = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[336];
    if (__imgui_is_window_appearing == nullptr) return gmval_undefined();
    const char* result = __imgui_is_window_appearing();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_collapsed(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_window_collapsed", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_window_collapsed = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[337];
    if (__imgui_is_window_collapsed == nullptr) return gmval_undefined();
    const char* result = __imgui_is_window_collapsed();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_focused(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_window_focused", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_window_focused = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[338];
    if (__imgui_is_window_focused == nullptr) return gmval_undefined();
    const char* result = __imgui_is_window_focused();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_hovered(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_is_window_hovered", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_is_window_hovered = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[339];
    if (__imgui_is_window_hovered == nullptr) return gmval_undefined();
    const char* result = __imgui_is_window_hovered();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_dpi_scale(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_dpi_scale", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_dpi_scale = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[340];
    if (__imgui_get_window_dpi_scale == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_dpi_scale();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[341];
    if (__imgui_get_window_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[342];
    if (__imgui_get_window_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_width(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_width", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_width = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[343];
    if (__imgui_get_window_width == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_width();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_height(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_window_height", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_window_height = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[344];
    if (__imgui_get_window_height == nullptr) return gmval_undefined();
    const char* result = __imgui_get_window_height();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[345];
    if (__imgui_set_next_window_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_size", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_size = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[346];
    if (__imgui_set_next_window_size == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_size();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_size_constraints(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_size_constraints", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_size_constraints = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[347];
    if (__imgui_set_next_window_size_constraints == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_size_constraints();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_content_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_content_size", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_content_size = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[348];
    if (__imgui_set_next_window_content_size == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_content_size();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_collapsed(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_collapsed", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_collapsed = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[349];
    if (__imgui_set_next_window_collapsed == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_collapsed();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_focus(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_focus", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_focus = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[350];
    if (__imgui_set_next_window_focus == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_focus();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_scroll(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_scroll", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_scroll = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[351];
    if (__imgui_set_next_window_scroll == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_scroll();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_bgalpha(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_next_window_bgalpha", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_next_window_bgalpha = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[352];
    if (__imgui_set_next_window_bgalpha == nullptr) return gmval_undefined();
    const char* result = __imgui_set_next_window_bgalpha();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_scroll_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_scroll_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[353];
    if (__imgui_get_scroll_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_scroll_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_scroll_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_scroll_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[354];
    if (__imgui_get_scroll_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_scroll_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_scroll_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_scroll_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[355];
    if (__imgui_set_scroll_x == nullptr) return gmval_undefined();
    const char* result = __imgui_set_scroll_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_scroll_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_scroll_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[356];
    if (__imgui_set_scroll_y == nullptr) return gmval_undefined();
    const char* result = __imgui_set_scroll_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_max_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_scroll_max_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_scroll_max_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[357];
    if (__imgui_get_scroll_max_x == nullptr) return gmval_undefined();
    const char* result = __imgui_get_scroll_max_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_max_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_get_scroll_max_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_get_scroll_max_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[358];
    if (__imgui_get_scroll_max_y == nullptr) return gmval_undefined();
    const char* result = __imgui_get_scroll_max_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_here_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_scroll_here_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_scroll_here_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[359];
    if (__imgui_set_scroll_here_x == nullptr) return gmval_undefined();
    const char* result = __imgui_set_scroll_here_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_here_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_scroll_here_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_scroll_here_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[360];
    if (__imgui_set_scroll_here_y == nullptr) return gmval_undefined();
    const char* result = __imgui_set_scroll_here_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_from_pos_x(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_scroll_from_pos_x", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_scroll_from_pos_x = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[361];
    if (__imgui_set_scroll_from_pos_x == nullptr) return gmval_undefined();
    const char* result = __imgui_set_scroll_from_pos_x();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_from_pos_y(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_scroll_from_pos_y", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_scroll_from_pos_y = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[362];
    if (__imgui_set_scroll_from_pos_y == nullptr) return gmval_undefined();
    const char* result = __imgui_set_scroll_from_pos_y();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_pos(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_window_pos", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_window_pos = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[363];
    if (__imgui_set_window_pos == nullptr) return gmval_undefined();
    const char* result = __imgui_set_window_pos();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_size(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_window_size", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_window_size = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[364];
    if (__imgui_set_window_size == nullptr) return gmval_undefined();
    const char* result = __imgui_set_window_size();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_collapsed(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_window_collapsed", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_window_collapsed = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[365];
    if (__imgui_set_window_collapsed == nullptr) return gmval_undefined();
    const char* result = __imgui_set_window_collapsed();
    return gmval_FromString(result);
}
extern "C" gmval_c __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_focus(gmval_c self, gmval_c callee, int argc, gmval_c* args)
{
    if (argc < 0)
        RunnerInterface_ArgCountError("__imgui_set_window_focus", argc, 0);
    using FunctionPtr = const char*(*)();
    // fetch function pointer from group table
    FunctionPtr __imgui_set_window_focus = (FunctionPtr)ImGui_GM__imgui_gm_dll_funcPointers[366];
    if (__imgui_set_window_focus == nullptr) return gmval_undefined();
    const char* result = __imgui_set_window_focus();
    return gmval_FromString(result);
}

// Injected from gmlib_injection_global_after_stubs.cpp
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

// End of injected code (gmlib_injection_global_after_stubs.cpp)

static void Release_ImGui_GM()
{
    
    // Injected from gmlib_injection_release_function.cpp

    if (isInitialized) Shutdown_ImGui_GM();

// End of injected code (gmlib_injection_release_function.cpp)
    
    SharedLibrary_Release(ImGui_GM__imgui_gm_dll_libHandle);
    for (auto& p : ImGui_GM__imgui_gm_dll_funcPointers) p = nullptr;
    ImGui_GM__imgui_gm_dll_libHandle = nullptr;
    SharedLibrary_FlushErrorLog();
    Logger_Debug("Finished releasing: ImGui_GM!\n");
}
extern "C" void Setup_ImGui_GM()
{
    ImGui_GM__imgui_gm_dll_libHandle = SharedLibrary_Load("imgui_gm.dll");
    if (ImGui_GM__imgui_gm_dll_libHandle)
    {
        ImGui_GM__imgui_gm_dll_funcPointers[0] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_initialize");
        ImGui_GM__imgui_gm_dll_funcPointers[1] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_update");
        ImGui_GM__imgui_gm_dll_funcPointers[2] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_render");
        ImGui_GM__imgui_gm_dll_funcPointers[3] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_mouse");
        ImGui_GM__imgui_gm_dll_funcPointers[4] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_key");
        ImGui_GM__imgui_gm_dll_funcPointers[5] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_mouse_wheel");
        ImGui_GM__imgui_gm_dll_funcPointers[6] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_mouse_cursor");
        ImGui_GM__imgui_gm_dll_funcPointers[7] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input");
        ImGui_GM__imgui_gm_dll_funcPointers[8] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_create_context");
        ImGui_GM__imgui_gm_dll_funcPointers[9] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_destroy_context");
        ImGui_GM__imgui_gm_dll_funcPointers[10] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_current_context");
        ImGui_GM__imgui_gm_dll_funcPointers[11] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_current_context");
        ImGui_GM__imgui_gm_dll_funcPointers[12] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_demo_window");
        ImGui_GM__imgui_gm_dll_funcPointers[13] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_metrics_window");
        ImGui_GM__imgui_gm_dll_funcPointers[14] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_debug_log_window");
        ImGui_GM__imgui_gm_dll_funcPointers[15] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_stack_tool_window");
        ImGui_GM__imgui_gm_dll_funcPointers[16] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_about_window");
        ImGui_GM__imgui_gm_dll_funcPointers[17] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_style_editor");
        ImGui_GM__imgui_gm_dll_funcPointers[18] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_style_selector");
        ImGui_GM__imgui_gm_dll_funcPointers[19] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_font_selector");
        ImGui_GM__imgui_gm_dll_funcPointers[20] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_show_user_guide");
        ImGui_GM__imgui_gm_dll_funcPointers[21] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_version");
        ImGui_GM__imgui_gm_dll_funcPointers[22] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_id");
        ImGui_GM__imgui_gm_dll_funcPointers[23] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_id");
        ImGui_GM__imgui_gm_dll_funcPointers[24] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_id");
        ImGui_GM__imgui_gm_dll_funcPointers[25] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_disabled");
        ImGui_GM__imgui_gm_dll_funcPointers[26] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_disabled");
        ImGui_GM__imgui_gm_dll_funcPointers[27] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_hovered");
        ImGui_GM__imgui_gm_dll_funcPointers[28] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_active");
        ImGui_GM__imgui_gm_dll_funcPointers[29] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_focused");
        ImGui_GM__imgui_gm_dll_funcPointers[30] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_clicked");
        ImGui_GM__imgui_gm_dll_funcPointers[31] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_visible");
        ImGui_GM__imgui_gm_dll_funcPointers[32] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_edited");
        ImGui_GM__imgui_gm_dll_funcPointers[33] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_activated");
        ImGui_GM__imgui_gm_dll_funcPointers[34] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_deactivated");
        ImGui_GM__imgui_gm_dll_funcPointers[35] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_deactivated_after_edit");
        ImGui_GM__imgui_gm_dll_funcPointers[36] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_item_toggled_open");
        ImGui_GM__imgui_gm_dll_funcPointers[37] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_any_item_hovered");
        ImGui_GM__imgui_gm_dll_funcPointers[38] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_any_item_active");
        ImGui_GM__imgui_gm_dll_funcPointers[39] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_any_item_focused");
        ImGui_GM__imgui_gm_dll_funcPointers[40] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_id");
        ImGui_GM__imgui_gm_dll_funcPointers[41] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_rect_min_x");
        ImGui_GM__imgui_gm_dll_funcPointers[42] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_rect_min_y");
        ImGui_GM__imgui_gm_dll_funcPointers[43] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_rect_max_x");
        ImGui_GM__imgui_gm_dll_funcPointers[44] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_rect_max_y");
        ImGui_GM__imgui_gm_dll_funcPointers[45] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_rect_size_x");
        ImGui_GM__imgui_gm_dll_funcPointers[46] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_item_rect_size_y");
        ImGui_GM__imgui_gm_dll_funcPointers[47] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_item_allow_overlap");
        ImGui_GM__imgui_gm_dll_funcPointers[48] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_rect_visible");
        ImGui_GM__imgui_gm_dll_funcPointers[49] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_time");
        ImGui_GM__imgui_gm_dll_funcPointers[50] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_frame_count");
        ImGui_GM__imgui_gm_dll_funcPointers[51] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_calc_text_width");
        ImGui_GM__imgui_gm_dll_funcPointers[52] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_calc_text_height");
        ImGui_GM__imgui_gm_dll_funcPointers[53] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_allow_keyboard_focus");
        ImGui_GM__imgui_gm_dll_funcPointers[54] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_allow_keyboard_focus");
        ImGui_GM__imgui_gm_dll_funcPointers[55] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_keyboard_focus_here");
        ImGui_GM__imgui_gm_dll_funcPointers[56] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_button_repeat");
        ImGui_GM__imgui_gm_dll_funcPointers[57] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_button_repeat");
        ImGui_GM__imgui_gm_dll_funcPointers[58] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_item_default_focus");
        ImGui_GM__imgui_gm_dll_funcPointers[59] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_config_flags_get");
        ImGui_GM__imgui_gm_dll_funcPointers[60] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_config_flags_set");
        ImGui_GM__imgui_gm_dll_funcPointers[61] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_config_flag_toggle");
        ImGui_GM__imgui_gm_dll_funcPointers[62] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_main_viewport");
        ImGui_GM__imgui_gm_dll_funcPointers[63] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_log_text");
        ImGui_GM__imgui_gm_dll_funcPointers[64] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_want_keyboard_capture");
        ImGui_GM__imgui_gm_dll_funcPointers[65] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_want_mouse_capture");
        ImGui_GM__imgui_gm_dll_funcPointers[66] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_want_text_input");
        ImGui_GM__imgui_gm_dll_funcPointers[67] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_want_mouse_unless_popup_close");
        ImGui_GM__imgui_gm_dll_funcPointers[68] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_color_edit3");
        ImGui_GM__imgui_gm_dll_funcPointers[69] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_color_picker3");
        ImGui_GM__imgui_gm_dll_funcPointers[70] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_color_edit4");
        ImGui_GM__imgui_gm_dll_funcPointers[71] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_color_picker4");
        ImGui_GM__imgui_gm_dll_funcPointers[72] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_color_button");
        ImGui_GM__imgui_gm_dll_funcPointers[73] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_color_edit_options");
        ImGui_GM__imgui_gm_dll_funcPointers[74] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_combo");
        ImGui_GM__imgui_gm_dll_funcPointers[75] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_combo");
        ImGui_GM__imgui_gm_dll_funcPointers[76] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_combo");
        ImGui_GM__imgui_gm_dll_funcPointers[77] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dock_space");
        ImGui_GM__imgui_gm_dll_funcPointers[78] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dock_space_over_viewport");
        ImGui_GM__imgui_gm_dll_funcPointers[79] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_dock_id");
        ImGui_GM__imgui_gm_dll_funcPointers[80] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_class");
        ImGui_GM__imgui_gm_dll_funcPointers[81] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_dock_id");
        ImGui_GM__imgui_gm_dll_funcPointers[82] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_window_docked");
        ImGui_GM__imgui_gm_dll_funcPointers[83] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_dock_window");
        ImGui_GM__imgui_gm_dll_funcPointers[84] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_get_node");
        ImGui_GM__imgui_gm_dll_funcPointers[85] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_get_central_node");
        ImGui_GM__imgui_gm_dll_funcPointers[86] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_add_node");
        ImGui_GM__imgui_gm_dll_funcPointers[87] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_remove_node");
        ImGui_GM__imgui_gm_dll_funcPointers[88] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_remove_node_docked_windows");
        ImGui_GM__imgui_gm_dll_funcPointers[89] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_remove_node_child_nodes");
        ImGui_GM__imgui_gm_dll_funcPointers[90] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_set_node_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[91] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_set_node_size");
        ImGui_GM__imgui_gm_dll_funcPointers[92] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_split_node");
        ImGui_GM__imgui_gm_dll_funcPointers[93] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_copy_dock_space");
        ImGui_GM__imgui_gm_dll_funcPointers[94] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_copy_node");
        ImGui_GM__imgui_gm_dll_funcPointers[95] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_copy_window_settings");
        ImGui_GM__imgui_gm_dll_funcPointers[96] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dockbuilder_finish");
        ImGui_GM__imgui_gm_dll_funcPointers[97] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_float");
        ImGui_GM__imgui_gm_dll_funcPointers[98] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_float2");
        ImGui_GM__imgui_gm_dll_funcPointers[99] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_float3");
        ImGui_GM__imgui_gm_dll_funcPointers[100] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_float4");
        ImGui_GM__imgui_gm_dll_funcPointers[101] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_floatn");
        ImGui_GM__imgui_gm_dll_funcPointers[102] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_float_range2");
        ImGui_GM__imgui_gm_dll_funcPointers[103] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_int");
        ImGui_GM__imgui_gm_dll_funcPointers[104] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_int2");
        ImGui_GM__imgui_gm_dll_funcPointers[105] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_int3");
        ImGui_GM__imgui_gm_dll_funcPointers[106] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_int4");
        ImGui_GM__imgui_gm_dll_funcPointers[107] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_intn");
        ImGui_GM__imgui_gm_dll_funcPointers[108] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drag_int_range2");
        ImGui_GM__imgui_gm_dll_funcPointers[109] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_background_drawlist");
        ImGui_GM__imgui_gm_dll_funcPointers[110] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_foreground_drawlist");
        ImGui_GM__imgui_gm_dll_funcPointers[111] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_drawlist");
        ImGui_GM__imgui_gm_dll_funcPointers[112] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_line");
        ImGui_GM__imgui_gm_dll_funcPointers[113] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_rect");
        ImGui_GM__imgui_gm_dll_funcPointers[114] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_rect_filled");
        ImGui_GM__imgui_gm_dll_funcPointers[115] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_rect_filled_multicolor");
        ImGui_GM__imgui_gm_dll_funcPointers[116] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_quad");
        ImGui_GM__imgui_gm_dll_funcPointers[117] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_quad_filled");
        ImGui_GM__imgui_gm_dll_funcPointers[118] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_triangle");
        ImGui_GM__imgui_gm_dll_funcPointers[119] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_triangle_filled");
        ImGui_GM__imgui_gm_dll_funcPointers[120] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_circle");
        ImGui_GM__imgui_gm_dll_funcPointers[121] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_circle_filled");
        ImGui_GM__imgui_gm_dll_funcPointers[122] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_ngon");
        ImGui_GM__imgui_gm_dll_funcPointers[123] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_ngon_filled");
        ImGui_GM__imgui_gm_dll_funcPointers[124] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_text");
        ImGui_GM__imgui_gm_dll_funcPointers[125] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_text_font");
        ImGui_GM__imgui_gm_dll_funcPointers[126] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_polyline");
        ImGui_GM__imgui_gm_dll_funcPointers[127] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_convex_poly_filled");
        ImGui_GM__imgui_gm_dll_funcPointers[128] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_bezier_cubic");
        ImGui_GM__imgui_gm_dll_funcPointers[129] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_bezier_quadratic");
        ImGui_GM__imgui_gm_dll_funcPointers[130] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_fill_convex");
        ImGui_GM__imgui_gm_dll_funcPointers[131] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_stroke");
        ImGui_GM__imgui_gm_dll_funcPointers[132] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_clear");
        ImGui_GM__imgui_gm_dll_funcPointers[133] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_line_to");
        ImGui_GM__imgui_gm_dll_funcPointers[134] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_line_to_merge_duplicate");
        ImGui_GM__imgui_gm_dll_funcPointers[135] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_arc_to");
        ImGui_GM__imgui_gm_dll_funcPointers[136] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_arc_to_fast");
        ImGui_GM__imgui_gm_dll_funcPointers[137] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_bezier_cubic_curve_to");
        ImGui_GM__imgui_gm_dll_funcPointers[138] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_bezier_quadratic_curve_to");
        ImGui_GM__imgui_gm_dll_funcPointers[139] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_path_rect");
        ImGui_GM__imgui_gm_dll_funcPointers[140] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_image");
        ImGui_GM__imgui_gm_dll_funcPointers[141] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_add_image_rounded");
        ImGui_GM__imgui_gm_dll_funcPointers[142] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_push_clip_rect");
        ImGui_GM__imgui_gm_dll_funcPointers[143] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_push_clip_rect_fullscreen");
        ImGui_GM__imgui_gm_dll_funcPointers[144] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_pop_clip_rect");
        ImGui_GM__imgui_gm_dll_funcPointers[145] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_push_textureid");
        ImGui_GM__imgui_gm_dll_funcPointers[146] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_pop_textureid");
        ImGui_GM__imgui_gm_dll_funcPointers[147] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_flags_get");
        ImGui_GM__imgui_gm_dll_funcPointers[148] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_flags_set");
        ImGui_GM__imgui_gm_dll_funcPointers[149] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_drawlist_flag_toggle");
        ImGui_GM__imgui_gm_dll_funcPointers[150] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_memory_editor_window");
        ImGui_GM__imgui_gm_dll_funcPointers[151] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_memory_editor_contents");
        ImGui_GM__imgui_gm_dll_funcPointers[152] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_font");
        ImGui_GM__imgui_gm_dll_funcPointers[153] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_font_size");
        ImGui_GM__imgui_gm_dll_funcPointers[154] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_font");
        ImGui_GM__imgui_gm_dll_funcPointers[155] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_font");
        ImGui_GM__imgui_gm_dll_funcPointers[156] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_add_font_from_file");
        ImGui_GM__imgui_gm_dll_funcPointers[157] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_add_font_default");
        ImGui_GM__imgui_gm_dll_funcPointers[158] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imguigm_native");
        ImGui_GM__imgui_gm_dll_funcPointers[159] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imguigm_command_buffer");
        ImGui_GM__imgui_gm_dll_funcPointers[160] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imguigm_font_buffer");
        ImGui_GM__imgui_gm_dll_funcPointers[161] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imguigm_keepalive");
        ImGui_GM__imgui_gm_dll_funcPointers[162] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_text");
        ImGui_GM__imgui_gm_dll_funcPointers[163] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_textmultiline");
        ImGui_GM__imgui_gm_dll_funcPointers[164] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_textwithhint");
        ImGui_GM__imgui_gm_dll_funcPointers[165] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_float");
        ImGui_GM__imgui_gm_dll_funcPointers[166] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_float2");
        ImGui_GM__imgui_gm_dll_funcPointers[167] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_float3");
        ImGui_GM__imgui_gm_dll_funcPointers[168] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_float4");
        ImGui_GM__imgui_gm_dll_funcPointers[169] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_floatn");
        ImGui_GM__imgui_gm_dll_funcPointers[170] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_int");
        ImGui_GM__imgui_gm_dll_funcPointers[171] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_int2");
        ImGui_GM__imgui_gm_dll_funcPointers[172] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_int3");
        ImGui_GM__imgui_gm_dll_funcPointers[173] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_int4");
        ImGui_GM__imgui_gm_dll_funcPointers[174] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_intn");
        ImGui_GM__imgui_gm_dll_funcPointers[175] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_input_double");
        ImGui_GM__imgui_gm_dll_funcPointers[176] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_spacing");
        ImGui_GM__imgui_gm_dll_funcPointers[177] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_dummy");
        ImGui_GM__imgui_gm_dll_funcPointers[178] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_newline");
        ImGui_GM__imgui_gm_dll_funcPointers[179] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_align_text_to_frame_padding");
        ImGui_GM__imgui_gm_dll_funcPointers[180] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_separator");
        ImGui_GM__imgui_gm_dll_funcPointers[181] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_indent");
        ImGui_GM__imgui_gm_dll_funcPointers[182] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_unindent");
        ImGui_GM__imgui_gm_dll_funcPointers[183] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_sameline");
        ImGui_GM__imgui_gm_dll_funcPointers[184] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_group");
        ImGui_GM__imgui_gm_dll_funcPointers[185] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_group");
        ImGui_GM__imgui_gm_dll_funcPointers[186] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_cursor_pos_x");
        ImGui_GM__imgui_gm_dll_funcPointers[187] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_cursor_pos_y");
        ImGui_GM__imgui_gm_dll_funcPointers[188] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_cursor_start_pos_x");
        ImGui_GM__imgui_gm_dll_funcPointers[189] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_cursor_start_pos_y");
        ImGui_GM__imgui_gm_dll_funcPointers[190] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_cursor_screen_pos_x");
        ImGui_GM__imgui_gm_dll_funcPointers[191] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_cursor_screen_pos_y");
        ImGui_GM__imgui_gm_dll_funcPointers[192] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_cursor_screen_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[193] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_cursor_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[194] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_cursor_pos_x");
        ImGui_GM__imgui_gm_dll_funcPointers[195] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_cursor_pos_y");
        ImGui_GM__imgui_gm_dll_funcPointers[196] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_text_line_height");
        ImGui_GM__imgui_gm_dll_funcPointers[197] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_text_line_height_with_spacing");
        ImGui_GM__imgui_gm_dll_funcPointers[198] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_frame_height");
        ImGui_GM__imgui_gm_dll_funcPointers[199] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_frame_height_with_spacing");
        ImGui_GM__imgui_gm_dll_funcPointers[200] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_content_region_avail_x");
        ImGui_GM__imgui_gm_dll_funcPointers[201] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_content_region_avail_y");
        ImGui_GM__imgui_gm_dll_funcPointers[202] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_content_region_max_x");
        ImGui_GM__imgui_gm_dll_funcPointers[203] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_content_region_max_y");
        ImGui_GM__imgui_gm_dll_funcPointers[204] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_content_region_min_x");
        ImGui_GM__imgui_gm_dll_funcPointers[205] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_content_region_min_y");
        ImGui_GM__imgui_gm_dll_funcPointers[206] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_content_region_max_x");
        ImGui_GM__imgui_gm_dll_funcPointers[207] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_content_region_max_y");
        ImGui_GM__imgui_gm_dll_funcPointers[208] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_item_width");
        ImGui_GM__imgui_gm_dll_funcPointers[209] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_item_width");
        ImGui_GM__imgui_gm_dll_funcPointers[210] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_item_width");
        ImGui_GM__imgui_gm_dll_funcPointers[211] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_calc_item_width");
        ImGui_GM__imgui_gm_dll_funcPointers[212] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_text_wrap_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[213] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_text_wrap_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[214] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_clip_rect");
        ImGui_GM__imgui_gm_dll_funcPointers[215] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_clip_rect");
        ImGui_GM__imgui_gm_dll_funcPointers[216] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_listbox");
        ImGui_GM__imgui_gm_dll_funcPointers[217] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_listbox");
        ImGui_GM__imgui_gm_dll_funcPointers[218] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_listbox");
        ImGui_GM__imgui_gm_dll_funcPointers[219] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_menubar");
        ImGui_GM__imgui_gm_dll_funcPointers[220] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_menubar");
        ImGui_GM__imgui_gm_dll_funcPointers[221] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_mainmenubar");
        ImGui_GM__imgui_gm_dll_funcPointers[222] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_mainmenubar");
        ImGui_GM__imgui_gm_dll_funcPointers[223] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_menu");
        ImGui_GM__imgui_gm_dll_funcPointers[224] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_menu");
        ImGui_GM__imgui_gm_dll_funcPointers[225] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_menu_item");
        ImGui_GM__imgui_gm_dll_funcPointers[226] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_drag_drop_source");
        ImGui_GM__imgui_gm_dll_funcPointers[227] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_drag_drop_source");
        ImGui_GM__imgui_gm_dll_funcPointers[228] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_drag_drop_target");
        ImGui_GM__imgui_gm_dll_funcPointers[229] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_drag_drop_target");
        ImGui_GM__imgui_gm_dll_funcPointers[230] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_drag_drop_payload");
        ImGui_GM__imgui_gm_dll_funcPointers[231] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_accept_drag_drop_payload");
        ImGui_GM__imgui_gm_dll_funcPointers[232] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_drag_drop_payload");
        ImGui_GM__imgui_gm_dll_funcPointers[233] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_payload_type");
        ImGui_GM__imgui_gm_dll_funcPointers[234] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_plot_lines");
        ImGui_GM__imgui_gm_dll_funcPointers[235] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_plot_histogram");
        ImGui_GM__imgui_gm_dll_funcPointers[236] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_popup");
        ImGui_GM__imgui_gm_dll_funcPointers[237] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_popup_modal");
        ImGui_GM__imgui_gm_dll_funcPointers[238] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_popup");
        ImGui_GM__imgui_gm_dll_funcPointers[239] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_open_popup");
        ImGui_GM__imgui_gm_dll_funcPointers[240] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_open_popup_on_item_click");
        ImGui_GM__imgui_gm_dll_funcPointers[241] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_close_current_popup");
        ImGui_GM__imgui_gm_dll_funcPointers[242] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_popup_context_item");
        ImGui_GM__imgui_gm_dll_funcPointers[243] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_popup_context_window");
        ImGui_GM__imgui_gm_dll_funcPointers[244] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_popup_context_void");
        ImGui_GM__imgui_gm_dll_funcPointers[245] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_popup_open");
        ImGui_GM__imgui_gm_dll_funcPointers[246] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_selectable");
        ImGui_GM__imgui_gm_dll_funcPointers[247] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_float");
        ImGui_GM__imgui_gm_dll_funcPointers[248] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_float2");
        ImGui_GM__imgui_gm_dll_funcPointers[249] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_float3");
        ImGui_GM__imgui_gm_dll_funcPointers[250] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_float4");
        ImGui_GM__imgui_gm_dll_funcPointers[251] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_floatn");
        ImGui_GM__imgui_gm_dll_funcPointers[252] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_int");
        ImGui_GM__imgui_gm_dll_funcPointers[253] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_int2");
        ImGui_GM__imgui_gm_dll_funcPointers[254] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_int3");
        ImGui_GM__imgui_gm_dll_funcPointers[255] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_int4");
        ImGui_GM__imgui_gm_dll_funcPointers[256] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_intn");
        ImGui_GM__imgui_gm_dll_funcPointers[257] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_vslider_float");
        ImGui_GM__imgui_gm_dll_funcPointers[258] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_vslider_int");
        ImGui_GM__imgui_gm_dll_funcPointers[259] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_slider_angle");
        ImGui_GM__imgui_gm_dll_funcPointers[260] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_style_colors_dark");
        ImGui_GM__imgui_gm_dll_funcPointers[261] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_style_colors_light");
        ImGui_GM__imgui_gm_dll_funcPointers[262] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_style_colors_classic");
        ImGui_GM__imgui_gm_dll_funcPointers[263] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_style_color");
        ImGui_GM__imgui_gm_dll_funcPointers[264] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_style_color");
        ImGui_GM__imgui_gm_dll_funcPointers[265] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_push_style_var");
        ImGui_GM__imgui_gm_dll_funcPointers[266] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_pop_style_var");
        ImGui_GM__imgui_gm_dll_funcPointers[267] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_style_color");
        ImGui_GM__imgui_gm_dll_funcPointers[268] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_style_color_name");
        ImGui_GM__imgui_gm_dll_funcPointers[269] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_table");
        ImGui_GM__imgui_gm_dll_funcPointers[270] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_table");
        ImGui_GM__imgui_gm_dll_funcPointers[271] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_next_row");
        ImGui_GM__imgui_gm_dll_funcPointers[272] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_next_column");
        ImGui_GM__imgui_gm_dll_funcPointers[273] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_set_column_index");
        ImGui_GM__imgui_gm_dll_funcPointers[274] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_setup_column");
        ImGui_GM__imgui_gm_dll_funcPointers[275] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_setup_scroll_freeze");
        ImGui_GM__imgui_gm_dll_funcPointers[276] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_headers_row");
        ImGui_GM__imgui_gm_dll_funcPointers[277] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_header");
        ImGui_GM__imgui_gm_dll_funcPointers[278] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_get_column_count");
        ImGui_GM__imgui_gm_dll_funcPointers[279] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_get_column_index");
        ImGui_GM__imgui_gm_dll_funcPointers[280] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_get_column_name");
        ImGui_GM__imgui_gm_dll_funcPointers[281] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_get_column_flags");
        ImGui_GM__imgui_gm_dll_funcPointers[282] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_get_row_index");
        ImGui_GM__imgui_gm_dll_funcPointers[283] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_set_column_enabled");
        ImGui_GM__imgui_gm_dll_funcPointers[284] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_table_set_bg_color");
        ImGui_GM__imgui_gm_dll_funcPointers[285] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_columns");
        ImGui_GM__imgui_gm_dll_funcPointers[286] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_next_column");
        ImGui_GM__imgui_gm_dll_funcPointers[287] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_column_index");
        ImGui_GM__imgui_gm_dll_funcPointers[288] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_column_width");
        ImGui_GM__imgui_gm_dll_funcPointers[289] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_column_width");
        ImGui_GM__imgui_gm_dll_funcPointers[290] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_column_offset");
        ImGui_GM__imgui_gm_dll_funcPointers[291] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_column_offset");
        ImGui_GM__imgui_gm_dll_funcPointers[292] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_columns_count");
        ImGui_GM__imgui_gm_dll_funcPointers[293] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_tab_bar");
        ImGui_GM__imgui_gm_dll_funcPointers[294] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_tab_bar");
        ImGui_GM__imgui_gm_dll_funcPointers[295] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_tab_item");
        ImGui_GM__imgui_gm_dll_funcPointers[296] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_tab_item");
        ImGui_GM__imgui_gm_dll_funcPointers[297] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_tab_item_button");
        ImGui_GM__imgui_gm_dll_funcPointers[298] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_tab_item_closed");
        ImGui_GM__imgui_gm_dll_funcPointers[299] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_text_unformatted");
        ImGui_GM__imgui_gm_dll_funcPointers[300] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_text");
        ImGui_GM__imgui_gm_dll_funcPointers[301] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_text_colored");
        ImGui_GM__imgui_gm_dll_funcPointers[302] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_text_disabled");
        ImGui_GM__imgui_gm_dll_funcPointers[303] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_text_wrapped");
        ImGui_GM__imgui_gm_dll_funcPointers[304] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_label_text");
        ImGui_GM__imgui_gm_dll_funcPointers[305] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_bullet_text");
        ImGui_GM__imgui_gm_dll_funcPointers[306] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_value");
        ImGui_GM__imgui_gm_dll_funcPointers[307] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_tooltip");
        ImGui_GM__imgui_gm_dll_funcPointers[308] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_tooltip");
        ImGui_GM__imgui_gm_dll_funcPointers[309] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_tooltip");
        ImGui_GM__imgui_gm_dll_funcPointers[310] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_tree_node");
        ImGui_GM__imgui_gm_dll_funcPointers[311] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_tree_node_ex");
        ImGui_GM__imgui_gm_dll_funcPointers[312] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_tree_push");
        ImGui_GM__imgui_gm_dll_funcPointers[313] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_tree_pop");
        ImGui_GM__imgui_gm_dll_funcPointers[314] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_tree_node_to_label_spacing");
        ImGui_GM__imgui_gm_dll_funcPointers[315] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_item_open");
        ImGui_GM__imgui_gm_dll_funcPointers[316] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_collapsing_header");
        ImGui_GM__imgui_gm_dll_funcPointers[317] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_button");
        ImGui_GM__imgui_gm_dll_funcPointers[318] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_small_button");
        ImGui_GM__imgui_gm_dll_funcPointers[319] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_invisible_button");
        ImGui_GM__imgui_gm_dll_funcPointers[320] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_arrow_button");
        ImGui_GM__imgui_gm_dll_funcPointers[321] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_image");
        ImGui_GM__imgui_gm_dll_funcPointers[322] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_image_button");
        ImGui_GM__imgui_gm_dll_funcPointers[323] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_surface");
        ImGui_GM__imgui_gm_dll_funcPointers[324] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_checkbox");
        ImGui_GM__imgui_gm_dll_funcPointers[325] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_checkbox_flags");
        ImGui_GM__imgui_gm_dll_funcPointers[326] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_radio_button");
        ImGui_GM__imgui_gm_dll_funcPointers[327] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_progressbar");
        ImGui_GM__imgui_gm_dll_funcPointers[328] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_bullet");
        ImGui_GM__imgui_gm_dll_funcPointers[329] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin");
        ImGui_GM__imgui_gm_dll_funcPointers[330] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end");
        ImGui_GM__imgui_gm_dll_funcPointers[331] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_endframe");
        ImGui_GM__imgui_gm_dll_funcPointers[332] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_child");
        ImGui_GM__imgui_gm_dll_funcPointers[333] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_child");
        ImGui_GM__imgui_gm_dll_funcPointers[334] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_begin_child_frame");
        ImGui_GM__imgui_gm_dll_funcPointers[335] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_end_child_frame");
        ImGui_GM__imgui_gm_dll_funcPointers[336] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_window_appearing");
        ImGui_GM__imgui_gm_dll_funcPointers[337] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_window_collapsed");
        ImGui_GM__imgui_gm_dll_funcPointers[338] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_window_focused");
        ImGui_GM__imgui_gm_dll_funcPointers[339] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_is_window_hovered");
        ImGui_GM__imgui_gm_dll_funcPointers[340] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_dpi_scale");
        ImGui_GM__imgui_gm_dll_funcPointers[341] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_x");
        ImGui_GM__imgui_gm_dll_funcPointers[342] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_y");
        ImGui_GM__imgui_gm_dll_funcPointers[343] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_width");
        ImGui_GM__imgui_gm_dll_funcPointers[344] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_window_height");
        ImGui_GM__imgui_gm_dll_funcPointers[345] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[346] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_size");
        ImGui_GM__imgui_gm_dll_funcPointers[347] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_size_constraints");
        ImGui_GM__imgui_gm_dll_funcPointers[348] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_content_size");
        ImGui_GM__imgui_gm_dll_funcPointers[349] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_collapsed");
        ImGui_GM__imgui_gm_dll_funcPointers[350] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_focus");
        ImGui_GM__imgui_gm_dll_funcPointers[351] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_scroll");
        ImGui_GM__imgui_gm_dll_funcPointers[352] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_next_window_bgalpha");
        ImGui_GM__imgui_gm_dll_funcPointers[353] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_scroll_x");
        ImGui_GM__imgui_gm_dll_funcPointers[354] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_scroll_y");
        ImGui_GM__imgui_gm_dll_funcPointers[355] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_scroll_x");
        ImGui_GM__imgui_gm_dll_funcPointers[356] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_scroll_y");
        ImGui_GM__imgui_gm_dll_funcPointers[357] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_scroll_max_x");
        ImGui_GM__imgui_gm_dll_funcPointers[358] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_get_scroll_max_y");
        ImGui_GM__imgui_gm_dll_funcPointers[359] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_scroll_here_x");
        ImGui_GM__imgui_gm_dll_funcPointers[360] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_scroll_here_y");
        ImGui_GM__imgui_gm_dll_funcPointers[361] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_scroll_from_pos_x");
        ImGui_GM__imgui_gm_dll_funcPointers[362] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_scroll_from_pos_y");
        ImGui_GM__imgui_gm_dll_funcPointers[363] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_window_pos");
        ImGui_GM__imgui_gm_dll_funcPointers[364] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_window_size");
        ImGui_GM__imgui_gm_dll_funcPointers[365] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_window_collapsed");
        ImGui_GM__imgui_gm_dll_funcPointers[366] = SharedLibrary_GetFunctionAddress(ImGui_GM__imgui_gm_dll_libHandle, "__imgui_set_window_focus");
    }
    SharedLibrary_FlushErrorLog();
    
    RunnerInterface_AddConstant_String("IMGUI_GM_VERSION", static_cast<const char*>("1.0.17"));
    RunnerInterface_AddFunction("__imgui_initialize", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_initialize, 0);
    RunnerInterface_AddFunction("__imgui_update", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_update, 0);
    RunnerInterface_AddFunction("__imgui_render", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_render, 0);
    RunnerInterface_AddFunction("__imgui_mouse", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_mouse, 0);
    RunnerInterface_AddFunction("__imgui_key", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_key, 0);
    RunnerInterface_AddFunction("__imgui_mouse_wheel", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_mouse_wheel, 0);
    RunnerInterface_AddFunction("__imgui_mouse_cursor", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_mouse_cursor, 0);
    RunnerInterface_AddFunction("__imgui_input", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input, 0);
    RunnerInterface_AddFunction("__imgui_create_context", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_create_context, 0);
    RunnerInterface_AddFunction("__imgui_destroy_context", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_destroy_context, 0);
    RunnerInterface_AddFunction("__imgui_get_current_context", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_current_context, 0);
    RunnerInterface_AddFunction("__imgui_set_current_context", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_current_context, 0);
    RunnerInterface_AddFunction("__imgui_show_demo_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_demo_window, 0);
    RunnerInterface_AddFunction("__imgui_show_metrics_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_metrics_window, 0);
    RunnerInterface_AddFunction("__imgui_show_debug_log_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_debug_log_window, 0);
    RunnerInterface_AddFunction("__imgui_show_stack_tool_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_stack_tool_window, 0);
    RunnerInterface_AddFunction("__imgui_show_about_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_about_window, 0);
    RunnerInterface_AddFunction("__imgui_show_style_editor", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_style_editor, 0);
    RunnerInterface_AddFunction("__imgui_show_style_selector", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_style_selector, 0);
    RunnerInterface_AddFunction("__imgui_show_font_selector", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_font_selector, 0);
    RunnerInterface_AddFunction("__imgui_show_user_guide", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_show_user_guide, 0);
    RunnerInterface_AddFunction("__imgui_get_version", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_version, 0);
    RunnerInterface_AddFunction("__imgui_push_id", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_id, 0);
    RunnerInterface_AddFunction("__imgui_pop_id", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_id, 0);
    RunnerInterface_AddFunction("__imgui_get_id", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_id, 0);
    RunnerInterface_AddFunction("__imgui_begin_disabled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_disabled, 0);
    RunnerInterface_AddFunction("__imgui_end_disabled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_disabled, 0);
    RunnerInterface_AddFunction("__imgui_is_item_hovered", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_hovered, 0);
    RunnerInterface_AddFunction("__imgui_is_item_active", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_active, 0);
    RunnerInterface_AddFunction("__imgui_is_item_focused", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_focused, 0);
    RunnerInterface_AddFunction("__imgui_is_item_clicked", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_clicked, 0);
    RunnerInterface_AddFunction("__imgui_is_item_visible", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_visible, 0);
    RunnerInterface_AddFunction("__imgui_is_item_edited", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_edited, 0);
    RunnerInterface_AddFunction("__imgui_is_item_activated", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_activated, 0);
    RunnerInterface_AddFunction("__imgui_is_item_deactivated", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_deactivated, 0);
    RunnerInterface_AddFunction("__imgui_is_item_deactivated_after_edit", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_deactivated_after_edit, 0);
    RunnerInterface_AddFunction("__imgui_is_item_toggled_open", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_item_toggled_open, 0);
    RunnerInterface_AddFunction("__imgui_is_any_item_hovered", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_any_item_hovered, 0);
    RunnerInterface_AddFunction("__imgui_is_any_item_active", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_any_item_active, 0);
    RunnerInterface_AddFunction("__imgui_is_any_item_focused", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_any_item_focused, 0);
    RunnerInterface_AddFunction("__imgui_get_item_id", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_id, 0);
    RunnerInterface_AddFunction("__imgui_get_item_rect_min_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_min_x, 0);
    RunnerInterface_AddFunction("__imgui_get_item_rect_min_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_min_y, 0);
    RunnerInterface_AddFunction("__imgui_get_item_rect_max_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_max_x, 0);
    RunnerInterface_AddFunction("__imgui_get_item_rect_max_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_max_y, 0);
    RunnerInterface_AddFunction("__imgui_get_item_rect_size_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_size_x, 0);
    RunnerInterface_AddFunction("__imgui_get_item_rect_size_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_item_rect_size_y, 0);
    RunnerInterface_AddFunction("__imgui_set_item_allow_overlap", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_item_allow_overlap, 0);
    RunnerInterface_AddFunction("__imgui_is_rect_visible", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_rect_visible, 0);
    RunnerInterface_AddFunction("__imgui_get_time", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_time, 0);
    RunnerInterface_AddFunction("__imgui_get_frame_count", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_frame_count, 0);
    RunnerInterface_AddFunction("__imgui_calc_text_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_calc_text_width, 0);
    RunnerInterface_AddFunction("__imgui_calc_text_height", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_calc_text_height, 0);
    RunnerInterface_AddFunction("__imgui_push_allow_keyboard_focus", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_allow_keyboard_focus, 0);
    RunnerInterface_AddFunction("__imgui_pop_allow_keyboard_focus", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_allow_keyboard_focus, 0);
    RunnerInterface_AddFunction("__imgui_set_keyboard_focus_here", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_keyboard_focus_here, 0);
    RunnerInterface_AddFunction("__imgui_push_button_repeat", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_button_repeat, 0);
    RunnerInterface_AddFunction("__imgui_pop_button_repeat", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_button_repeat, 0);
    RunnerInterface_AddFunction("__imgui_set_item_default_focus", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_item_default_focus, 0);
    RunnerInterface_AddFunction("__imgui_config_flags_get", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_config_flags_get, 0);
    RunnerInterface_AddFunction("__imgui_config_flags_set", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_config_flags_set, 0);
    RunnerInterface_AddFunction("__imgui_config_flag_toggle", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_config_flag_toggle, 0);
    RunnerInterface_AddFunction("__imgui_get_main_viewport", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_main_viewport, 0);
    RunnerInterface_AddFunction("__imgui_log_text", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_log_text, 0);
    RunnerInterface_AddFunction("__imgui_want_keyboard_capture", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_keyboard_capture, 0);
    RunnerInterface_AddFunction("__imgui_want_mouse_capture", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_mouse_capture, 0);
    RunnerInterface_AddFunction("__imgui_want_text_input", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_text_input, 0);
    RunnerInterface_AddFunction("__imgui_want_mouse_unless_popup_close", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_want_mouse_unless_popup_close, 0);
    RunnerInterface_AddFunction("__imgui_color_edit3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_edit3, 0);
    RunnerInterface_AddFunction("__imgui_color_picker3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_picker3, 0);
    RunnerInterface_AddFunction("__imgui_color_edit4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_edit4, 0);
    RunnerInterface_AddFunction("__imgui_color_picker4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_picker4, 0);
    RunnerInterface_AddFunction("__imgui_color_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_color_button, 0);
    RunnerInterface_AddFunction("__imgui_set_color_edit_options", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_color_edit_options, 0);
    RunnerInterface_AddFunction("__imgui_begin_combo", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_combo, 0);
    RunnerInterface_AddFunction("__imgui_end_combo", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_combo, 0);
    RunnerInterface_AddFunction("__imgui_combo", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_combo, 0);
    RunnerInterface_AddFunction("__imgui_dock_space", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dock_space, 0);
    RunnerInterface_AddFunction("__imgui_dock_space_over_viewport", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dock_space_over_viewport, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_dock_id", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_dock_id, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_class", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_class, 0);
    RunnerInterface_AddFunction("__imgui_get_window_dock_id", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_dock_id, 0);
    RunnerInterface_AddFunction("__imgui_is_window_docked", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_docked, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_dock_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_dock_window, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_get_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_get_node, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_get_central_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_get_central_node, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_add_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_add_node, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_remove_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_remove_node, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_remove_node_docked_windows", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_remove_node_docked_windows, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_remove_node_child_nodes", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_remove_node_child_nodes, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_set_node_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_set_node_pos, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_set_node_size", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_set_node_size, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_split_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_split_node, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_copy_dock_space", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_copy_dock_space, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_copy_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_copy_node, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_copy_window_settings", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_copy_window_settings, 0);
    RunnerInterface_AddFunction("__imgui_dockbuilder_finish", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dockbuilder_finish, 0);
    RunnerInterface_AddFunction("__imgui_drag_float", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float, 0);
    RunnerInterface_AddFunction("__imgui_drag_float2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float2, 0);
    RunnerInterface_AddFunction("__imgui_drag_float3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float3, 0);
    RunnerInterface_AddFunction("__imgui_drag_float4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float4, 0);
    RunnerInterface_AddFunction("__imgui_drag_floatn", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_floatn, 0);
    RunnerInterface_AddFunction("__imgui_drag_float_range2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_float_range2, 0);
    RunnerInterface_AddFunction("__imgui_drag_int", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int, 0);
    RunnerInterface_AddFunction("__imgui_drag_int2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int2, 0);
    RunnerInterface_AddFunction("__imgui_drag_int3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int3, 0);
    RunnerInterface_AddFunction("__imgui_drag_int4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int4, 0);
    RunnerInterface_AddFunction("__imgui_drag_intn", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_intn, 0);
    RunnerInterface_AddFunction("__imgui_drag_int_range2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drag_int_range2, 0);
    RunnerInterface_AddFunction("__imgui_get_background_drawlist", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_background_drawlist, 0);
    RunnerInterface_AddFunction("__imgui_get_foreground_drawlist", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_foreground_drawlist, 0);
    RunnerInterface_AddFunction("__imgui_get_window_drawlist", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_drawlist, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_line", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_line, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_rect", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_rect, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_rect_filled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_rect_filled, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_rect_filled_multicolor", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_rect_filled_multicolor, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_quad", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_quad, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_quad_filled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_quad_filled, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_triangle", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_triangle, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_triangle_filled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_triangle_filled, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_circle", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_circle, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_circle_filled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_circle_filled, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_ngon", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_ngon, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_ngon_filled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_ngon_filled, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_text", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_text, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_text_font", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_text_font, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_polyline", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_polyline, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_convex_poly_filled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_convex_poly_filled, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_bezier_cubic", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_bezier_cubic, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_bezier_quadratic", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_bezier_quadratic, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_fill_convex", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_fill_convex, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_stroke", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_stroke, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_clear", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_clear, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_line_to", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_line_to, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_line_to_merge_duplicate", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_line_to_merge_duplicate, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_arc_to", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_arc_to, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_arc_to_fast", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_arc_to_fast, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_bezier_cubic_curve_to", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_bezier_cubic_curve_to, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_bezier_quadratic_curve_to", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_bezier_quadratic_curve_to, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_path_rect", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_path_rect, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_image", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_image, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_add_image_rounded", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_add_image_rounded, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_push_clip_rect", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_push_clip_rect, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_push_clip_rect_fullscreen", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_push_clip_rect_fullscreen, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_pop_clip_rect", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_pop_clip_rect, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_push_textureid", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_push_textureid, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_pop_textureid", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_pop_textureid, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_flags_get", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_flags_get, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_flags_set", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_flags_set, 0);
    RunnerInterface_AddFunction("__imgui_drawlist_flag_toggle", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_drawlist_flag_toggle, 0);
    RunnerInterface_AddFunction("__imgui_memory_editor_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_memory_editor_window, 0);
    RunnerInterface_AddFunction("__imgui_memory_editor_contents", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_memory_editor_contents, 0);
    RunnerInterface_AddFunction("__imgui_get_font", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_font, 0);
    RunnerInterface_AddFunction("__imgui_get_font_size", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_font_size, 0);
    RunnerInterface_AddFunction("__imgui_push_font", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_font, 0);
    RunnerInterface_AddFunction("__imgui_pop_font", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_font, 0);
    RunnerInterface_AddFunction("__imgui_add_font_from_file", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_add_font_from_file, 0);
    RunnerInterface_AddFunction("__imgui_add_font_default", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_add_font_default, 0);
    RunnerInterface_AddFunction("__imguigm_native", __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_native, 0);
    RunnerInterface_AddFunction("__imguigm_command_buffer", __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_command_buffer, 0);
    RunnerInterface_AddFunction("__imguigm_font_buffer", __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_font_buffer, 0);
    RunnerInterface_AddFunction("__imguigm_keepalive", __GMLIBSTUB_GMVAL__ImGui_GM____imguigm_keepalive, 0);
    RunnerInterface_AddFunction("__imgui_input_text", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_text, 0);
    RunnerInterface_AddFunction("__imgui_input_textmultiline", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_textmultiline, 0);
    RunnerInterface_AddFunction("__imgui_input_textwithhint", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_textwithhint, 0);
    RunnerInterface_AddFunction("__imgui_input_float", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float, 0);
    RunnerInterface_AddFunction("__imgui_input_float2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float2, 0);
    RunnerInterface_AddFunction("__imgui_input_float3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float3, 0);
    RunnerInterface_AddFunction("__imgui_input_float4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_float4, 0);
    RunnerInterface_AddFunction("__imgui_input_floatn", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_floatn, 0);
    RunnerInterface_AddFunction("__imgui_input_int", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int, 0);
    RunnerInterface_AddFunction("__imgui_input_int2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int2, 0);
    RunnerInterface_AddFunction("__imgui_input_int3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int3, 0);
    RunnerInterface_AddFunction("__imgui_input_int4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_int4, 0);
    RunnerInterface_AddFunction("__imgui_input_intn", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_intn, 0);
    RunnerInterface_AddFunction("__imgui_input_double", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_input_double, 0);
    RunnerInterface_AddFunction("__imgui_spacing", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_spacing, 0);
    RunnerInterface_AddFunction("__imgui_dummy", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_dummy, 0);
    RunnerInterface_AddFunction("__imgui_newline", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_newline, 0);
    RunnerInterface_AddFunction("__imgui_align_text_to_frame_padding", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_align_text_to_frame_padding, 0);
    RunnerInterface_AddFunction("__imgui_separator", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_separator, 0);
    RunnerInterface_AddFunction("__imgui_indent", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_indent, 0);
    RunnerInterface_AddFunction("__imgui_unindent", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_unindent, 0);
    RunnerInterface_AddFunction("__imgui_sameline", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_sameline, 0);
    RunnerInterface_AddFunction("__imgui_begin_group", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_group, 0);
    RunnerInterface_AddFunction("__imgui_end_group", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_group, 0);
    RunnerInterface_AddFunction("__imgui_get_cursor_pos_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_pos_x, 0);
    RunnerInterface_AddFunction("__imgui_get_cursor_pos_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_pos_y, 0);
    RunnerInterface_AddFunction("__imgui_get_cursor_start_pos_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_start_pos_x, 0);
    RunnerInterface_AddFunction("__imgui_get_cursor_start_pos_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_start_pos_y, 0);
    RunnerInterface_AddFunction("__imgui_get_cursor_screen_pos_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_screen_pos_x, 0);
    RunnerInterface_AddFunction("__imgui_get_cursor_screen_pos_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_cursor_screen_pos_y, 0);
    RunnerInterface_AddFunction("__imgui_set_cursor_screen_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_screen_pos, 0);
    RunnerInterface_AddFunction("__imgui_set_cursor_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_pos, 0);
    RunnerInterface_AddFunction("__imgui_set_cursor_pos_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_pos_x, 0);
    RunnerInterface_AddFunction("__imgui_set_cursor_pos_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_cursor_pos_y, 0);
    RunnerInterface_AddFunction("__imgui_get_text_line_height", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_text_line_height, 0);
    RunnerInterface_AddFunction("__imgui_get_text_line_height_with_spacing", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_text_line_height_with_spacing, 0);
    RunnerInterface_AddFunction("__imgui_get_frame_height", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_frame_height, 0);
    RunnerInterface_AddFunction("__imgui_get_frame_height_with_spacing", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_frame_height_with_spacing, 0);
    RunnerInterface_AddFunction("__imgui_get_content_region_avail_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_avail_x, 0);
    RunnerInterface_AddFunction("__imgui_get_content_region_avail_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_avail_y, 0);
    RunnerInterface_AddFunction("__imgui_get_content_region_max_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_max_x, 0);
    RunnerInterface_AddFunction("__imgui_get_content_region_max_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_content_region_max_y, 0);
    RunnerInterface_AddFunction("__imgui_get_window_content_region_min_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_min_x, 0);
    RunnerInterface_AddFunction("__imgui_get_window_content_region_min_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_min_y, 0);
    RunnerInterface_AddFunction("__imgui_get_window_content_region_max_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_max_x, 0);
    RunnerInterface_AddFunction("__imgui_get_window_content_region_max_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_content_region_max_y, 0);
    RunnerInterface_AddFunction("__imgui_push_item_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_item_width, 0);
    RunnerInterface_AddFunction("__imgui_pop_item_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_item_width, 0);
    RunnerInterface_AddFunction("__imgui_set_next_item_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_item_width, 0);
    RunnerInterface_AddFunction("__imgui_calc_item_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_calc_item_width, 0);
    RunnerInterface_AddFunction("__imgui_push_text_wrap_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_text_wrap_pos, 0);
    RunnerInterface_AddFunction("__imgui_pop_text_wrap_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_text_wrap_pos, 0);
    RunnerInterface_AddFunction("__imgui_push_clip_rect", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_clip_rect, 0);
    RunnerInterface_AddFunction("__imgui_pop_clip_rect", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_clip_rect, 0);
    RunnerInterface_AddFunction("__imgui_begin_listbox", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_listbox, 0);
    RunnerInterface_AddFunction("__imgui_end_listbox", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_listbox, 0);
    RunnerInterface_AddFunction("__imgui_listbox", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_listbox, 0);
    RunnerInterface_AddFunction("__imgui_begin_menubar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_menubar, 0);
    RunnerInterface_AddFunction("__imgui_end_menubar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_menubar, 0);
    RunnerInterface_AddFunction("__imgui_begin_mainmenubar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_mainmenubar, 0);
    RunnerInterface_AddFunction("__imgui_end_mainmenubar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_mainmenubar, 0);
    RunnerInterface_AddFunction("__imgui_begin_menu", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_menu, 0);
    RunnerInterface_AddFunction("__imgui_end_menu", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_menu, 0);
    RunnerInterface_AddFunction("__imgui_menu_item", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_menu_item, 0);
    RunnerInterface_AddFunction("__imgui_begin_drag_drop_source", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_drag_drop_source, 0);
    RunnerInterface_AddFunction("__imgui_end_drag_drop_source", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_drag_drop_source, 0);
    RunnerInterface_AddFunction("__imgui_begin_drag_drop_target", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_drag_drop_target, 0);
    RunnerInterface_AddFunction("__imgui_end_drag_drop_target", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_drag_drop_target, 0);
    RunnerInterface_AddFunction("__imgui_set_drag_drop_payload", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_drag_drop_payload, 0);
    RunnerInterface_AddFunction("__imgui_accept_drag_drop_payload", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_accept_drag_drop_payload, 0);
    RunnerInterface_AddFunction("__imgui_get_drag_drop_payload", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_drag_drop_payload, 0);
    RunnerInterface_AddFunction("__imgui_get_payload_type", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_payload_type, 0);
    RunnerInterface_AddFunction("__imgui_plot_lines", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_plot_lines, 0);
    RunnerInterface_AddFunction("__imgui_plot_histogram", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_plot_histogram, 0);
    RunnerInterface_AddFunction("__imgui_begin_popup", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup, 0);
    RunnerInterface_AddFunction("__imgui_begin_popup_modal", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_modal, 0);
    RunnerInterface_AddFunction("__imgui_end_popup", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_popup, 0);
    RunnerInterface_AddFunction("__imgui_open_popup", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_open_popup, 0);
    RunnerInterface_AddFunction("__imgui_open_popup_on_item_click", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_open_popup_on_item_click, 0);
    RunnerInterface_AddFunction("__imgui_close_current_popup", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_close_current_popup, 0);
    RunnerInterface_AddFunction("__imgui_begin_popup_context_item", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_context_item, 0);
    RunnerInterface_AddFunction("__imgui_begin_popup_context_window", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_context_window, 0);
    RunnerInterface_AddFunction("__imgui_begin_popup_context_void", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_popup_context_void, 0);
    RunnerInterface_AddFunction("__imgui_is_popup_open", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_popup_open, 0);
    RunnerInterface_AddFunction("__imgui_selectable", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_selectable, 0);
    RunnerInterface_AddFunction("__imgui_slider_float", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float, 0);
    RunnerInterface_AddFunction("__imgui_slider_float2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float2, 0);
    RunnerInterface_AddFunction("__imgui_slider_float3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float3, 0);
    RunnerInterface_AddFunction("__imgui_slider_float4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_float4, 0);
    RunnerInterface_AddFunction("__imgui_slider_floatn", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_floatn, 0);
    RunnerInterface_AddFunction("__imgui_slider_int", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int, 0);
    RunnerInterface_AddFunction("__imgui_slider_int2", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int2, 0);
    RunnerInterface_AddFunction("__imgui_slider_int3", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int3, 0);
    RunnerInterface_AddFunction("__imgui_slider_int4", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_int4, 0);
    RunnerInterface_AddFunction("__imgui_slider_intn", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_intn, 0);
    RunnerInterface_AddFunction("__imgui_vslider_float", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_vslider_float, 0);
    RunnerInterface_AddFunction("__imgui_vslider_int", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_vslider_int, 0);
    RunnerInterface_AddFunction("__imgui_slider_angle", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_slider_angle, 0);
    RunnerInterface_AddFunction("__imgui_style_colors_dark", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_style_colors_dark, 0);
    RunnerInterface_AddFunction("__imgui_style_colors_light", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_style_colors_light, 0);
    RunnerInterface_AddFunction("__imgui_style_colors_classic", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_style_colors_classic, 0);
    RunnerInterface_AddFunction("__imgui_push_style_color", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_style_color, 0);
    RunnerInterface_AddFunction("__imgui_pop_style_color", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_style_color, 0);
    RunnerInterface_AddFunction("__imgui_push_style_var", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_push_style_var, 0);
    RunnerInterface_AddFunction("__imgui_pop_style_var", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_pop_style_var, 0);
    RunnerInterface_AddFunction("__imgui_get_style_color", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_style_color, 0);
    RunnerInterface_AddFunction("__imgui_get_style_color_name", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_style_color_name, 0);
    RunnerInterface_AddFunction("__imgui_begin_table", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_table, 0);
    RunnerInterface_AddFunction("__imgui_end_table", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_table, 0);
    RunnerInterface_AddFunction("__imgui_table_next_row", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_next_row, 0);
    RunnerInterface_AddFunction("__imgui_table_next_column", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_next_column, 0);
    RunnerInterface_AddFunction("__imgui_table_set_column_index", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_set_column_index, 0);
    RunnerInterface_AddFunction("__imgui_table_setup_column", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_setup_column, 0);
    RunnerInterface_AddFunction("__imgui_table_setup_scroll_freeze", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_setup_scroll_freeze, 0);
    RunnerInterface_AddFunction("__imgui_table_headers_row", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_headers_row, 0);
    RunnerInterface_AddFunction("__imgui_table_header", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_header, 0);
    RunnerInterface_AddFunction("__imgui_table_get_column_count", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_count, 0);
    RunnerInterface_AddFunction("__imgui_table_get_column_index", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_index, 0);
    RunnerInterface_AddFunction("__imgui_table_get_column_name", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_name, 0);
    RunnerInterface_AddFunction("__imgui_table_get_column_flags", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_column_flags, 0);
    RunnerInterface_AddFunction("__imgui_table_get_row_index", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_get_row_index, 0);
    RunnerInterface_AddFunction("__imgui_table_set_column_enabled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_set_column_enabled, 0);
    RunnerInterface_AddFunction("__imgui_table_set_bg_color", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_table_set_bg_color, 0);
    RunnerInterface_AddFunction("__imgui_columns", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_columns, 0);
    RunnerInterface_AddFunction("__imgui_next_column", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_next_column, 0);
    RunnerInterface_AddFunction("__imgui_get_column_index", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_column_index, 0);
    RunnerInterface_AddFunction("__imgui_get_column_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_column_width, 0);
    RunnerInterface_AddFunction("__imgui_set_column_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_column_width, 0);
    RunnerInterface_AddFunction("__imgui_get_column_offset", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_column_offset, 0);
    RunnerInterface_AddFunction("__imgui_set_column_offset", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_column_offset, 0);
    RunnerInterface_AddFunction("__imgui_get_columns_count", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_columns_count, 0);
    RunnerInterface_AddFunction("__imgui_begin_tab_bar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_tab_bar, 0);
    RunnerInterface_AddFunction("__imgui_end_tab_bar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_tab_bar, 0);
    RunnerInterface_AddFunction("__imgui_begin_tab_item", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_tab_item, 0);
    RunnerInterface_AddFunction("__imgui_end_tab_item", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_tab_item, 0);
    RunnerInterface_AddFunction("__imgui_tab_item_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tab_item_button, 0);
    RunnerInterface_AddFunction("__imgui_set_tab_item_closed", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_tab_item_closed, 0);
    RunnerInterface_AddFunction("__imgui_text_unformatted", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_unformatted, 0);
    RunnerInterface_AddFunction("__imgui_text", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text, 0);
    RunnerInterface_AddFunction("__imgui_text_colored", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_colored, 0);
    RunnerInterface_AddFunction("__imgui_text_disabled", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_disabled, 0);
    RunnerInterface_AddFunction("__imgui_text_wrapped", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_text_wrapped, 0);
    RunnerInterface_AddFunction("__imgui_label_text", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_label_text, 0);
    RunnerInterface_AddFunction("__imgui_bullet_text", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_bullet_text, 0);
    RunnerInterface_AddFunction("__imgui_value", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_value, 0);
    RunnerInterface_AddFunction("__imgui_begin_tooltip", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_tooltip, 0);
    RunnerInterface_AddFunction("__imgui_end_tooltip", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_tooltip, 0);
    RunnerInterface_AddFunction("__imgui_set_tooltip", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_tooltip, 0);
    RunnerInterface_AddFunction("__imgui_tree_node", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_node, 0);
    RunnerInterface_AddFunction("__imgui_tree_node_ex", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_node_ex, 0);
    RunnerInterface_AddFunction("__imgui_tree_push", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_push, 0);
    RunnerInterface_AddFunction("__imgui_tree_pop", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_tree_pop, 0);
    RunnerInterface_AddFunction("__imgui_get_tree_node_to_label_spacing", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_tree_node_to_label_spacing, 0);
    RunnerInterface_AddFunction("__imgui_set_next_item_open", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_item_open, 0);
    RunnerInterface_AddFunction("__imgui_collapsing_header", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_collapsing_header, 0);
    RunnerInterface_AddFunction("__imgui_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_button, 0);
    RunnerInterface_AddFunction("__imgui_small_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_small_button, 0);
    RunnerInterface_AddFunction("__imgui_invisible_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_invisible_button, 0);
    RunnerInterface_AddFunction("__imgui_arrow_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_arrow_button, 0);
    RunnerInterface_AddFunction("__imgui_image", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_image, 0);
    RunnerInterface_AddFunction("__imgui_image_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_image_button, 0);
    RunnerInterface_AddFunction("__imgui_surface", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_surface, 0);
    RunnerInterface_AddFunction("__imgui_checkbox", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_checkbox, 0);
    RunnerInterface_AddFunction("__imgui_checkbox_flags", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_checkbox_flags, 0);
    RunnerInterface_AddFunction("__imgui_radio_button", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_radio_button, 0);
    RunnerInterface_AddFunction("__imgui_progressbar", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_progressbar, 0);
    RunnerInterface_AddFunction("__imgui_bullet", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_bullet, 0);
    RunnerInterface_AddFunction("__imgui_begin", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin, 0);
    RunnerInterface_AddFunction("__imgui_end", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end, 0);
    RunnerInterface_AddFunction("__imgui_endframe", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_endframe, 0);
    RunnerInterface_AddFunction("__imgui_begin_child", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_child, 0);
    RunnerInterface_AddFunction("__imgui_end_child", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_child, 0);
    RunnerInterface_AddFunction("__imgui_begin_child_frame", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_begin_child_frame, 0);
    RunnerInterface_AddFunction("__imgui_end_child_frame", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_end_child_frame, 0);
    RunnerInterface_AddFunction("__imgui_is_window_appearing", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_appearing, 0);
    RunnerInterface_AddFunction("__imgui_is_window_collapsed", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_collapsed, 0);
    RunnerInterface_AddFunction("__imgui_is_window_focused", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_focused, 0);
    RunnerInterface_AddFunction("__imgui_is_window_hovered", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_is_window_hovered, 0);
    RunnerInterface_AddFunction("__imgui_get_window_dpi_scale", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_dpi_scale, 0);
    RunnerInterface_AddFunction("__imgui_get_window_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_x, 0);
    RunnerInterface_AddFunction("__imgui_get_window_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_y, 0);
    RunnerInterface_AddFunction("__imgui_get_window_width", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_width, 0);
    RunnerInterface_AddFunction("__imgui_get_window_height", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_window_height, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_pos, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_size", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_size, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_size_constraints", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_size_constraints, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_content_size", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_content_size, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_collapsed", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_collapsed, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_focus", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_focus, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_scroll", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_scroll, 0);
    RunnerInterface_AddFunction("__imgui_set_next_window_bgalpha", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_next_window_bgalpha, 0);
    RunnerInterface_AddFunction("__imgui_get_scroll_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_x, 0);
    RunnerInterface_AddFunction("__imgui_get_scroll_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_y, 0);
    RunnerInterface_AddFunction("__imgui_set_scroll_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_x, 0);
    RunnerInterface_AddFunction("__imgui_set_scroll_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_y, 0);
    RunnerInterface_AddFunction("__imgui_get_scroll_max_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_max_x, 0);
    RunnerInterface_AddFunction("__imgui_get_scroll_max_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_get_scroll_max_y, 0);
    RunnerInterface_AddFunction("__imgui_set_scroll_here_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_here_x, 0);
    RunnerInterface_AddFunction("__imgui_set_scroll_here_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_here_y, 0);
    RunnerInterface_AddFunction("__imgui_set_scroll_from_pos_x", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_from_pos_x, 0);
    RunnerInterface_AddFunction("__imgui_set_scroll_from_pos_y", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_scroll_from_pos_y, 0);
    RunnerInterface_AddFunction("__imgui_set_window_pos", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_pos, 0);
    RunnerInterface_AddFunction("__imgui_set_window_size", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_size, 0);
    RunnerInterface_AddFunction("__imgui_set_window_collapsed", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_collapsed, 0);
    RunnerInterface_AddFunction("__imgui_set_window_focus", __GMLIBSTUB_GMVAL__ImGui_GM____imgui_set_window_focus, 0);
    
    // Injected from gmlib_injection_setup_function.cpp

    EventSystem_OnGameStart(&Initialize_ImGui_GM);
    EventSystem_OnGameEnd(&Shutdown_ImGui_GM);

// End of injected code (gmlib_injection_setup_function.cpp)
    
    EventSystem_OnProcessExit(&Release_ImGui_GM);
}
