package glutil

import "shared:odin-gl"
import "core:fmt"

on_debug_message :: proc "c" (source : u32, type : u32, id: u32, severity: u32, length: i32, message: ^u8, userParam: rawptr) {
    fmt.printf("(%s) [%s] %s\n", log_severity_to_string(severity), log_source_to_string(source), cstring(message));
}

log_type_to_string :: proc(type:u32) -> string {
    switch (type) {
        case gl.DEBUG_TYPE_ERROR: return "Error";
        case gl.DEBUG_TYPE_DEPRECATED_BEHAVIOR: return "Deprecated behavior";
        case gl.DEBUG_TYPE_UNDEFINED_BEHAVIOR: return "Undefined behavior";
        case gl.DEBUG_TYPE_PORTABILITY: return "Portability issue";
        case gl.DEBUG_TYPE_PERFORMANCE: return "Performance issue";
        case gl.DEBUG_TYPE_MARKER: return "Stream annotation";
        case gl.DEBUG_TYPE_OTHER_ARB: return "Other";
        case:
              assert(false);
              return "";
    }
}

log_source_to_string :: proc(source:u32) -> string {
    switch (source) {
        case gl.DEBUG_SOURCE_API: return "API";
        case gl.DEBUG_SOURCE_WINDOW_SYSTEM: return "Window system";
        case gl.DEBUG_SOURCE_SHADER_COMPILER: return "Shader compiler";
        case gl.DEBUG_SOURCE_THIRD_PARTY: return "Third party";
        case gl.DEBUG_SOURCE_APPLICATION: return "Application";
        case gl.DEBUG_SOURCE_OTHER: return "Other";
        case:
            assert(false);
            return "";
    }
}

log_severity_to_string :: proc(severity:u32) -> string
{
    switch (severity) {
        case gl.DEBUG_SEVERITY_HIGH: return "High";
        case gl.DEBUG_SEVERITY_MEDIUM: return "Medium";
        case gl.DEBUG_SEVERITY_LOW: return "Low";
        case gl.DEBUG_SEVERITY_NOTIFICATION: return "Info";
        case:
            assert(false);
            return("");
    }
}

log_all_errors :: proc() {
    for {
        error := gl.GetError();
        if error == gl.NO_ERROR do break;

        switch (error) {
            case gl.INVALID_ENUM: fmt.println("Error: GL_INVALID_ENUM");
            case gl.INVALID_VALUE: fmt.println("Error: GL_INVALID_VALUE");
            case gl.INVALID_OPERATION: fmt.println("Error: GL_INVALID_OPERATION");
            case gl.INVALID_FRAMEBUFFER_OPERATION: fmt.println("Error: GL_INVALID_FRAMEBUFFER_OPERATION");
            case gl.OUT_OF_MEMORY: fmt.println("Error: GL_OUT_OF_MEMORY");
            case gl.STACK_UNDERFLOW: fmt.println("Error: GL_STACK_UNDERFLOW");
            case gl.STACK_OVERFLOW: fmt.println("Error: GL_STACK_OVERFLOW");
            case:
                assert(false);
        }
    }
}


