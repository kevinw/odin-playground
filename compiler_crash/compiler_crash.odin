package compiler_crash

import "core:fmt"

Flags :: distinct bit_set[Flag; u32];
Flag :: enum u32 {
	One = 0,
}

Flag_Holder :: struct {
	flags:                    Flags,
}

init_swapchain :: proc() {
    foo_2 := Flag_Holder {};
    fmt.println(foo_2);
}

main :: proc() {
    foo_1 := Flag_Holder {};
    fmt.println(foo_1);
}


