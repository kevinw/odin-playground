package meta

using import "core:odin/ast"
using import "core:odin/parser"
import "core:fmt"
import "core:os"
import "core:strings"
import "core:math"

MyVec :: struct {
    vec: math.Vec4,
}

my_thing :: struct {
    foo : int,
    bar : string,
    vec : MyVec,
}

Scope :: struct {
    parent: ^Scope,
    structs: map[string]^Struct_Type,
}


when os.OS == "windows" {
    import "core:sys/win32"
    exit :: proc (ret_code: int = -1) { win32.exit_process(cast(u32)ret_code); }
}

panic :: proc (message: string) {
    fmt.println_err(message);
    exit(-1);
}


write_serialize_func :: proc (struct_value: ^Struct_Type) {

    builder := strings.make_builder();
    defer strings.destroy_builder(&builder);

    strings.write_string(&builder, "serialize_struct :: proc() {\n");
    strings.write_string(&builder, "}\n");

    filename := "serialize_generated.odin";

    ok := os.write_entire_file(filename, builder.buf[:]);
    if !ok {
        panic("could not write file");
    }
    
}

handle_struct :: proc(scope: ^Scope, struct_name: string, struct_value: ^Struct_Type) {
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

                    if !scope_lookup(type.name, &lookup_struct) {
                    }
                }
        }
    }
}

struct_lookup :: proc(name: string, struct_type: ^Struct_Type) {
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

    scope : Scope;
    scope.structs = make(map[string]^Struct_Type);
    defer delete(scope.structs);

    // FIRST PASS: collect structs
    for stmt in file.decls {
        if stmt.derived.id != typeid_of(Value_Decl) do continue;
        value := cast(^Value_Decl)stmt;

        if value.is_mutable do continue;

        for name, index in value.names {
            value := value.values[index];
            if value.derived.id != typeid_of(Struct_Type) do continue;
            struct_value := cast(^Struct_Type)value;

            switch d in name.derived {
                case Ident:
                    fmt.println("STRUCT", d.name);
                    scope.structs[d.name] = struct_value;
                case:
                    fmt.println("unknown struct ident", name.derived);
            }
        }
    }


    // SECOND PASS: write struct functions
    for stmt in file.decls {
        if stmt.derived.id != typeid_of(Value_Decl) do continue;
        value := cast(^Value_Decl)stmt;

        if value.is_mutable do continue;

        for name, index in value.names {
            value := value.values[index];
            if value.derived.id != typeid_of(Struct_Type) do continue;
            struct_value := cast(^Struct_Type)value;

            struct_name: string;
            switch d in name.derived {
                case Ident:
                    fmt.println("STRUCT", d.name);
                    struct_name = d.name;
                case:
                    panic("unknown struct ident");
            }

            handle_struct(&scope, struct_name, struct_value);
        }
    }
}
