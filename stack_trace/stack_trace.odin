package stack_trace

import "core:fmt"
using import "core:sys/win32"


IMAGE_FILE_MACHINE_I386 :: u32(0x014c);
IMAGE_FILE_MACHINE_IA64 :: u32(0x0200);
IMAGE_FILE_MACHINE_AMD64 :: u32(0x8664);

foreign import "system:kernel32.lib"
@(default_calling_convention = "std")
foreign kernel32 {
    @(link_name="RtlCaptureContext") rtl_capture_context :: proc(ctx: ^CONTEXT) ---;
    @(link_name="GetCurrentThread") get_current_thread :: proc() -> Handle ---;
    @(link_name="GetModuleFileNameA") get_module_filename_a :: proc(module: Hmodule, filename: cstring, size: u32) -> u32 ---;
}

foreign import "system:dbghelp.lib"
@(default_calling_convention = "std")
foreign dbghelp {
    @(link_name="SymInitialize") sym_initialize :: proc(process: Handle, user_search_path: cstring, invade_process: Bool) -> Bool ---;
    @(link_name="SymSetOptions") sym_set_options :: proc(options: u32) -> u32 ---;
    @(link_name="StackWalk64") stack_walk :: proc(
        machine_type: u32,
        process: Handle,
        thread: Handle,
        stack_frame: ^STACKFRAME,
        context_record: rawptr,
        read_memory_routine: rawptr,
        function_table_access_routine: rawptr,
        get_module_base_routine: rawptr,
        translate_address: rawptr
    ) -> Bool ---;
    @(link_name="SymFunctionTableAccess") sym_function_table_access :: proc(process: Handle, addr_base: u32) -> rawptr ---;
    @(link_name="SymGetModuleBase") sym_get_module_base :: proc(process: Handle, addr: u32) -> rawptr ---;

}

SYMOPT_LOAD_LINES:u32 = 0x00000010; // TODO make this an enum bit_set pair

ARM64_NT_NEON128 :: struct { D: [2]f64 }

ARM64_MAX_BREAKPOINTS :: 8;
ARM64_MAX_WATCHPOINTS :: 2;

DWORD64 :: u64;
DWORD :: u32;
WORD :: u16;

M128A :: struct #packed {
    low: DWORD64,
    high: DWORD64,
}

CONTEXT :: struct {
  P1Home: DWORD64,
  P2Home: DWORD64,
  P3Home: DWORD64,
  P4Home: DWORD64,
  P5Home: DWORD64,
  P6Home: DWORD64,
  ContextFlags: DWORD,
  MxCsr: DWORD,
  SegCs: WORD,
  SegDs: WORD,
  SegEs: WORD,
  SegFs: WORD,
  SegGs: WORD,
  SegSs: WORD,
  EFlags: DWORD,
  Dr0: DWORD64,
  Dr1: DWORD64,
  Dr2: DWORD64,
  Dr3: DWORD64,
  Dr6: DWORD64,
  Dr7: DWORD64,
  Rax: DWORD64,
  Rcx: DWORD64,
  Rdx: DWORD64,
  Rbx: DWORD64,
  Rsp: DWORD64,
  Rbp: DWORD64,
  Rsi: DWORD64,
  Rdi: DWORD64,
  R8: DWORD64,
  R9: DWORD64,
  R10: DWORD64,
  R11: DWORD64,
  R12: DWORD64,
  R13: DWORD64,
  R14: DWORD64,
  R15: DWORD64,
  Rip: DWORD64,
  /*
  union {
    XMM_SAVE_AREA32 FltSave;
    NEON128         Q[16];
    ULONGLONG       D[32];
    struct {
      M128A Header[2];
      M128A Legacy[8];
      M128A Xmm0;
      M128A Xmm1;
      M128A Xmm2;
      M128A Xmm3;
      M128A Xmm4;
      M128A Xmm5;
      M128A Xmm6;
      M128A Xmm7;
      M128A Xmm8;
      M128A Xmm9;
      M128A Xmm10;
      M128A Xmm11;
      M128A Xmm12;
      M128A Xmm13;
      M128A Xmm14;
      M128A Xmm15;
    } DUMMYSTRUCTNAME;
    DWORD           S[32];
  } DUMMYUNIONNAME;
  */
  S: [32]DWORD,
  VectorRegister: [26]M128A,
  VectorControl: DWORD64,
  DebugControl: DWORD64,
  LastBranchToRip: DWORD64,
  LastBranchFromRip: DWORD64,
  LastExceptionToRip: DWORD64,
  LastExceptionFromRip: DWORD64,
}

ADDRESS :: struct #packed {
    offset: u32,
    segment: u16,
    mode: u32, // TODO: should be an enum. is u32 the right size?????
}

KDHELP :: struct {
    thread: u32,
    th_callback_stack: u32,
    next_callback: u32,
    frame_pointer: u32,
    ki_callUser_mode: u32,
    ke_user_callback_dispatcher: u32,
    system_range_start: u32,
    th_callback_b_store: u32,
    ki_user_exception_dispatcher: u32,
    stack_base: u32,
    stack_limit: u32,
    reserved: [5]u32,
}

STACKFRAME :: struct #packed {
    addr_pc: ADDRESS,
    addr_return: ADDRESS,
    addr_frame: ADDRESS,
    addr_stack: ADDRESS,
    func_table_entry: rawptr,
    params: [4]u32,
    far: Bool,
    virtual: Bool,
    reserved: [3]u32,
    kd_help: KDHELP,
    addr_b_store: ADDRESS,
}

AddrModeFlat :: 3;

stack_trace :: proc()
{

    a : i64 = -1;
    process : Handle = transmute(Handle)a;

    thread: Handle = get_current_thread();

    fmt.println("current thread:", thread);

    res := sym_initialize(process, nil, Bool(false));

    if res == Bool(false) {
        fmt.println_err("sym_initialize failed");
        return;
    }

    sym_set_options(SYMOPT_LOAD_LINES);

    ctx : CONTEXT = ---;
    rtl_capture_context(&ctx);
    machine := IMAGE_FILE_MACHINE_AMD64; // TODO 32/64 bit
    frame: STACKFRAME = {
        addr_pc = {
            offset = auto_cast ctx.Rip,
            mode = AddrModeFlat,
        },
        addr_frame = {
            offset = auto_cast ctx.Rsp,
            mode = AddrModeFlat,
        },
        addr_stack = {
            offset = auto_cast ctx.Rsp,
            mode = AddrModeFlat,
        },
    };

    for stack_walk(machine, process, thread, &frame, &ctx, nil, cast(rawptr)sym_function_table_access, cast(rawptr)sym_get_module_base, nil) {
        fmt.println("frame");

        module_buf: [MAX_PATH]u8;
        fmt.println(frame);
        module_base := sym_get_module_base(process, frame.addr_pc.offset);
        if module_base == nil {
            fmt.println("module_base was nil");
        } else {
            if get_module_filename_a(cast(Hmodule)module_base, cstring(&module_buf[0]), MAX_PATH) > 0 {
                fmt.println(cstring(&module_buf[0]));
            }
        }
    }

}

main :: proc() {
    stack_trace();
}

