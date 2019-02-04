package meta

using import "core:odin/ast"
using import "core:odin/parser"
import "core:fmt"
import "core:os"

MyVec :: struct {
}

my_thing :: struct {
    foo : int,
    bar : string
}

when os.OS == "windows" {
    import "core:sys/win32"
    exit :: proc (ret_code: int = -1) { win32.exit_process(cast(u32)ret_code); }
}

panic :: proc (message: string) {
    fmt.println_err(message);
    exit(-1);
}

handle_struct :: proc(struct_value: ^Struct_Type) {
    for field in struct_value.fields.list {
        for name_decl in field.names {
            switch ident in name_decl.derived {
                case Ident:
                    fmt.println("name", ident.name);
                case:
                    panic("unknown name_decl type");
            }
        }
        switch type in field.type.derived {
            case Ident:
                if type.name == "int" {
                    fmt.println("          <builtin int>");

                } else if type.name == "string" {
                    fmt.println("          <builtin string>");

                }
                else {
                    fmt.println("unknown ident type", type.name);
                }
        }
    }
}

main :: proc() {
    // read this source file
    filename :: #file;
    //fmt.println("file is", filename);
    file_contents, ok := os.read_entire_file(filename);
    if !ok {
        fmt.println_err("Could not read", filename);
        return;
    }

    // parse it
    parser := Parser {};
    file := ast.File {
        src = file_contents,
        fullpath = filename,
    };
    parse_file(&parser, &file);

    for stmt in file.decls {
        if stmt.derived.id != typeid_of(Value_Decl) do continue;
        value := cast(^Value_Decl)stmt;

        if !value.is_mutable {
            //fmt.println(s);
            for name, index in value.names {
                value := value.values[index];
                if value.derived.id != typeid_of(Struct_Type) do continue;
                struct_value := cast(^Struct_Type)value;

                switch d in name.derived {
                    case Ident:
                        fmt.println("STRUCT", d.name);
                }

                handle_struct(struct_value);
            }
        }
    }
}
