package tinyobj

import "core:mem"
import "core:os"

when os.OS == "windows" do foreign import tinyobj "tinyobj_loader_c.lib"

Material :: struct #packed {
  name: cstring,

  ambient: [3]f32,
  diffuse: [3]f32,
  specular: [3]f32,
  transmittance: [3]f32,
  emission: [3]f32,
  shininess: f32,
  ior: f32,      /* index of refraction */
  dissolve: f32, /* 1 == opaque; 0 == fully transparent */
  illum: i32, /* illumination model (see http://www.fileformat.info/format/material/) */

  pad0: i32,

  ambient_texname: cstring,            /* map_Ka */
  diffuse_texname: cstring,            /* map_Kd */
  specular_texname: cstring,           /* map_Ks */
  specular_highlight_texname: cstring, /* map_Ns */
  bump_texname: cstring,               /* map_bump, bump */
  displacement_texname: cstring,       /* disp */
  alpha_texname: cstring,              /* map_d */
}

Shape :: struct #packed {
    name: cstring, /* group name or object name. */
    face_offset: u32,
    length: u32,
}

Vertex_Index :: struct #packed {
    v_idx, vt_idx, vn_idx: i32
}

_Attrib :: struct #packed {
  num_vertices,
  num_normals,
  num_texcoords,
  num_faces,
  num_face_num_verts: u32,

  pad0: u32,

  vertices: ^f32,
  normals: ^f32,
  texcoords: ^f32,
  faces: ^Vertex_Index,
  face_num_verts: ^i32,
  material_ids: ^i32,
}

Attrib :: struct {
  vertices: []f32,
  normals: []f32,
  texcoords: []f32,
  faces: []Vertex_Index,
  face_num_verts: []i32,
}

FLAG_TRIANGULATE :: u32(1 << 0);
SUCCESS :: 0;
ERROR_EMPTY :: -1;
ERROR_INVALID_PARAMETER :: -2;
ERROR_FILE_OPERATION :: -3;

@(default_calling_convention="c", link_prefix="tinyobj_")
foreign tinyobj {
    parse_obj :: proc(
        attrib: ^_Attrib,
        shapes: ^^Shape,
        num_shapes: ^uint,
        materials: ^^Material,
        num_materials: ^uint,
        buf: ^u8,
        len: uint,
        flags: u32) -> i32 ---;
}

parse :: proc(
    attrib: ^Attrib,
    shapes: ^[]Shape,
    materials: ^[]Material,
    buf: []u8,
    flags: u32)
    -> i32 
{
    shapes_ptr: ^Shape;
    materials_ptr: ^Material;
    num_shapes: uint;
    num_materials: uint;
    _attrib: _Attrib;

    res := parse_obj(&_attrib, &shapes_ptr, &num_shapes, &materials_ptr, &num_materials,
        &buf[0], cast(uint)len(buf), flags);

    if res == SUCCESS {
        shapes^ = mem.slice_ptr(shapes_ptr, cast(int)num_shapes);
        materials^ = mem.slice_ptr(materials_ptr, cast(int)num_materials);
        {
            using _attrib;
            attrib^ = Attrib {
                vertices = mem.slice_ptr(vertices, cast(int)num_vertices * 3),
                normals = mem.slice_ptr(normals, cast(int)num_normals * 3),
                texcoords = mem.slice_ptr(texcoords, cast(int)num_texcoords * 2),
                faces = mem.slice_ptr(faces, cast(int)num_faces),
                face_num_verts = mem.slice_ptr(face_num_verts, cast(int)num_face_num_verts),
            };
        }
    }

    return res;
}
