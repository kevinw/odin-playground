package struct_bug

import "core:fmt"

HandleType :: opaque u64;
MyHandle :: HandleType;

Flags :: bit_set[Flag];
Flag :: enum { Identity = 0 }

foo :: struct {
	flags: Flags,
	handle: MyHandle,
}

run_buggy :: proc() -> int {
    info := foo { handle = nil };
    fmt.println(info);
    assert(info.handle == nil, "handle should have been nil");
    return 0;
}

main :: proc() {
    run_buggy();
}
