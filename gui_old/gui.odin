package gui

import "core:os"
import "core:fmt"
import "core:math"
import "core:mem"

import "shared:odin-imgui"
import "shared:odin-gl"
import "shared:odin-glfw"

State :: struct {
    ctx: ^imgui.Context,

    //Misc
    mouse_wheel_delta : i32,

    //Render
    main_program      : u32, // gl.Program,
    vbo_handle        : u32, // gl.VBO,
    ebo_handle        : u32, // gl.EBO,
}

Frame_State :: struct {
    deltatime     : f32,
    window_width  : int,
    window_height : int,
    window_focus  : bool,
    mouse_x       : int,
    mouse_y       : int,
    mouse_wheel   : int,
    left_mouse    : bool,
    right_mouse   : bool,
}


brew_style :: proc() {
    style := imgui.get_style();

    style.window_padding = imgui.Vec2{6, 6};
    style.window_rounding = 2;
    style.child_rounding = 2;
    style.frame_padding = imgui.Vec2{4 ,2};
    style.frame_rounding = 1;
    style.item_spacing = imgui.Vec2{8, 4};
    style.item_inner_spacing = imgui.Vec2{4, 4};
    style.touch_extra_padding = imgui.Vec2{0, 0};
    style.indent_spacing = 20;
    style.scrollbar_size = 12;
    style.scrollbar_rounding = 9;
    style.grab_min_size = 9;
    style.grab_rounding = 1;

    style.window_title_align = imgui.Vec2{0.48, 0.5};
    style.button_text_align = imgui.Vec2{0.5, 0.5};

    style.colors[imgui.Style_Color.Text]                  = imgui.Vec4{1.00, 1.00, 1.00, 1.00};
    style.colors[imgui.Style_Color.TextDisabled]          = imgui.Vec4{0.63, 0.63, 0.63, 1.00};
    style.colors[imgui.Style_Color.WindowBg]              = imgui.Vec4{0.23, 0.23, 0.23, 0.98};
    style.colors[imgui.Style_Color.ChildBg]               = imgui.Vec4{0.20, 0.20, 0.20, 1.00};
    style.colors[imgui.Style_Color.PopupBg]               = imgui.Vec4{0.25, 0.25, 0.25, 0.96};
    style.colors[imgui.Style_Color.Border]                = imgui.Vec4{0.18, 0.18, 0.18, 0.98};
    style.colors[imgui.Style_Color.BorderShadow]          = imgui.Vec4{0.00, 0.00, 0.00, 0.04};
    style.colors[imgui.Style_Color.FrameBg]               = imgui.Vec4{0.00, 0.00, 0.00, 0.29};
    style.colors[imgui.Style_Color.TitleBg]               = imgui.Vec4{0.25, 0.25, 0.25, 0.98};
    style.colors[imgui.Style_Color.TitleBgCollapsed]      = imgui.Vec4{0.12, 0.12, 0.12, 0.49};
    style.colors[imgui.Style_Color.TitleBgActive]         = imgui.Vec4{0.33, 0.33, 0.33, 0.98};
    style.colors[imgui.Style_Color.MenuBarBg]             = imgui.Vec4{0.11, 0.11, 0.11, 0.42};
    style.colors[imgui.Style_Color.ScrollbarBg]           = imgui.Vec4{0.00, 0.00, 0.00, 0.08};
    style.colors[imgui.Style_Color.ScrollbarGrab]         = imgui.Vec4{0.27, 0.27, 0.27, 1.00};
    style.colors[imgui.Style_Color.ScrollbarGrabHovered]  = imgui.Vec4{0.78, 0.78, 0.78, 0.40};
    style.colors[imgui.Style_Color.CheckMark]             = imgui.Vec4{0.78, 0.78, 0.78, 0.94};
    style.colors[imgui.Style_Color.SliderGrab]            = imgui.Vec4{0.78, 0.78, 0.78, 0.94};
    style.colors[imgui.Style_Color.Button]                = imgui.Vec4{0.42, 0.42, 0.42, 0.60};
    style.colors[imgui.Style_Color.ButtonHovered]         = imgui.Vec4{0.78, 0.78, 0.78, 0.40};
    style.colors[imgui.Style_Color.Header]                = imgui.Vec4{0.31, 0.31, 0.31, 0.98};
    style.colors[imgui.Style_Color.HeaderHovered]         = imgui.Vec4{0.78, 0.78, 0.78, 0.40};
    style.colors[imgui.Style_Color.HeaderActive]          = imgui.Vec4{0.80, 0.50, 0.50, 1.00};
    style.colors[imgui.Style_Color.TextSelectedBg]        = imgui.Vec4{0.65, 0.35, 0.35, 0.26};
    style.colors[imgui.Style_Color.ModalWindowDimBg]      = imgui.Vec4{0.20, 0.20, 0.20, 0.35}; 
}


init :: proc(state : ^State, window : glfw.Window_Handle, style_proc : proc() = nil, custom_font := false) {
    state.ctx = imgui.create_context();
    io := imgui.get_io();
    when os.OS == "windows" {
        io.ime_window_handle = glfw.get_win32_window(window);
    }

    io.key_map[imgui.Key.Tab]        = i32(VirtualKey.Tab);
    io.key_map[imgui.Key.LeftArrow]  = i32(VirtualKey.Left);
    io.key_map[imgui.Key.RightArrow] = i32(VirtualKey.Right);
    io.key_map[imgui.Key.UpArrow]    = i32(VirtualKey.Up);
    io.key_map[imgui.Key.DownArrow]  = i32(VirtualKey.Down);
    io.key_map[imgui.Key.PageUp]     = i32(VirtualKey.Next);
    io.key_map[imgui.Key.PageDown]   = i32(VirtualKey.Prior);
    io.key_map[imgui.Key.Home]       = i32(VirtualKey.Home);
    io.key_map[imgui.Key.End]        = i32(VirtualKey.End);
    io.key_map[imgui.Key.Delete]     = i32(VirtualKey.Delete);
    io.key_map[imgui.Key.Backspace]  = i32(VirtualKey.Back);
    io.key_map[imgui.Key.Enter]      = i32(VirtualKey.Return);
    io.key_map[imgui.Key.Escape]     = i32(VirtualKey.Escape);
    io.key_map[imgui.Key.A]          = i32(VirtualKey.A);
    io.key_map[imgui.Key.C]          = i32(VirtualKey.C);
    io.key_map[imgui.Key.V]          = i32(VirtualKey.V);
    io.key_map[imgui.Key.X]          = i32(VirtualKey.X);
    io.key_map[imgui.Key.Y]          = i32(VirtualKey.Y);
    io.key_map[imgui.Key.Z]          = i32(VirtualKey.Z);

    vertexShaderString ::
        `#version 130
        uniform mat4 ProjMtx;
        in vec2 Position;
        in vec2 UV;
        in vec4 Color;
        out vec2 Frag_UV;
        out vec4 Frag_Color;
        void main()
        {
           Frag_UV = UV;
           Frag_Color = Color;
           gl_Position = ProjMtx * vec4(Position.xy,0,1);
        }`;

    fragmentShaderString :: 
        `#version 130
        uniform sampler2D Texture;
        in vec2 Frag_UV;
        in vec4 Frag_Color;
        out vec4 Out_Color;
        void main()
        {
           Out_Color = Frag_Color * texture( Texture, Frag_UV.st);
        }`;

    success := false;
    state.main_program, success = gl.load_shaders_source(
        vertexShaderString,
        fragmentShaderString);

    if (!success) {
        fmt.println("could not load imgui shader");
        assert(false, "could not load imgui shaders");
    }


    gl.GenBuffers(1, &state.vbo_handle);
    gl.GenBuffers(1, &state.ebo_handle);
    gl.BindBuffer(gl.ARRAY_BUFFER, state.vbo_handle);
    gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, state.ebo_handle);

    pixels : ^u8;
    width, height : i32;
    imgui.font_atlas_get_text_data_as_rgba32(io.fonts, &pixels, &width, &height);

    tex : u32;
    gl.GenTextures(1, &tex);

    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MIN_FILTER, gl.LINEAR);
    gl.TexParameteri(gl.TEXTURE_2D, gl.TEXTURE_MAG_FILTER, gl.LINEAR);
    gl.TexImage2D(gl.TEXTURE_2D, 0, gl.RGBA, width, height, 0, gl.RGBA, gl.UNSIGNED_BYTE, pixels);
    imgui.font_atlas_set_text_id(io.fonts, rawptr(uintptr(uint(tex))));

    if style_proc != nil do style_proc();
}

deinit :: proc(state: ^State) {
    if (state != nil && state.ctx != nil) {
        imgui.destroy_context(state.ctx);
        state.ctx = nil;
    }
}

begin_new_frame :: proc(window: glfw.Window_Handle, new_state: ^Frame_State) {
    io := imgui.get_io();
    io.display_size.x = f32(new_state.window_width);
    io.display_size.y = f32(new_state.window_height);

    if new_state.window_focus {
        io.mouse_pos.x = f32(new_state.mouse_x);
        io.mouse_pos.y = f32(new_state.mouse_y);
        io.mouse_down[0] = new_state.left_mouse;
        io.mouse_down[1] = new_state.right_mouse;
        io.mouse_wheel   = f32(new_state.mouse_wheel);
        
        //io.mouse_wheel = f32(ctx.imgui_state.mouse_wheel_delta); 

        io.key_ctrl =  glfw.get_key(window, glfw.KEY_LEFT_CONTROL)   || glfw.get_key(window, glfw.KEY_RIGHT_CONTROL);
        io.key_shift = glfw.get_key(window, glfw.KEY_LEFT_SHIFT) || glfw.get_key(window, glfw.KEY_RIGHT_SHIFT);
        io.key_alt =   glfw.get_key(window, glfw.KEY_MENU);
        io.key_super = glfw.get_key(window, glfw.KEY_LEFT_SUPER)   || glfw.get_key(window, glfw.KEY_RIGHT_SUPER);

        //for i in glfw.Key(int(glfw.KEY_UNKNOWN)+1)..glfw.Key(int(glfw.KEY_LAST)-1) {
            //io.keys_down[i] = glfw.get_key(window, i);
        //}

    } else {
        io.mouse_pos = imgui.Vec2{-math.F32_MAX, -math.F32_MAX};

        io.mouse_down[0] = false;
        io.mouse_down[1] = false;
        io.mouse_wheel   = 0;
        io.key_ctrl  = false;  
        io.key_shift = false; 
        io.key_alt   = false;   
        io.key_super = false;

        for i in 0..255 do io.keys_down[i] = false;
    }
    
    // ctx.imgui_state.mouse_wheel_delta = 0;
    io.delta_time = new_state.deltatime;
    imgui.new_frame();
}

render_proc :: proc(state : ^State, render_to_screen : bool) {
    imgui.render();
    if !render_to_screen do return;

    data := imgui.get_draw_data();
    io := imgui.get_io();

    width  := i32(data.display_size.x * io.display_framebuffer_scale.x);
    height := i32(data.display_size.y * io.display_framebuffer_scale.y);
    if height == 0 || width == 0 do return;

    imgui.draw_data_scale_clip_rects(data, math.Vec2 { io.display_framebuffer_scale.x, io.display_framebuffer_scale.y });

    //@TODO(Hoej): BACKUP STATE!
    lastViewport : [4]i32;
    lastScissor  : [4]i32;

    cull : i32;
    gl.GetIntegerv(gl.CULL_FACE, &cull);

    depth : i32;
    gl.GetIntegerv(gl.DEPTH_TEST, &depth);

    scissor : i32;
    gl.GetIntegerv(gl.SCISSOR_TEST, &scissor);

    blend : i32;
    gl.GetIntegerv(gl.BLEND, &blend);

    current_vao : i32;
    gl.GetIntegerv(gl.VERTEX_ARRAY_BINDING, &current_vao);

    gl.GetIntegerv(gl.VIEWPORT, &lastViewport[0]);
    gl.GetIntegerv(gl.SCISSOR_BOX, &lastScissor[0]);

    gl.Enable(gl.BLEND);
    gl.BlendEquation(gl.FUNC_ADD);
    gl.BlendFunc(gl.SRC_ALPHA, gl.ONE_MINUS_SRC_ALPHA);
    gl.Disable(gl.CULL_FACE);
    gl.Disable(gl.DEPTH_TEST);
    gl.Enable(gl.SCISSOR_TEST);
    gl.PolygonMode(gl.FRONT_AND_BACK, gl.FILL);

    gl.Viewport(0, 0, width, height);
    L : f32 = data.display_pos.x;
    R : f32 = data.display_pos.x + data.display_size.x;
    T : f32 = data.display_pos.y;
    B : f32 = data.display_pos.y + data.display_size.y;
    ortho_projection := math.Mat4
    {
        { 2.0/(R-L),   0.0,          0.0, 0.0 },
        { 0.0,         2.0 / (T-B),  0.0, 0.0 },
        { 0.0,         0.0,         -1.0, 0.0 },
        { (R+L)/(L-R), (T+B)/(B-T),  0.0, 1.0 },
    };

    gl.UseProgram(state.main_program);
    gl.Uniform1i(gl.get_uniform_location(state.main_program, "Texture"), i32(0));
    gl.UniformMatrix4fv(gl.get_uniform_location(state.main_program, "ProjMtx"), 1, gl.FALSE, &ortho_projection[0][0]);

    vao_handle : u32 = ---;
    gl.GenVertexArrays(1, &vao_handle);
    gl.BindVertexArray(vao_handle);

    gl.BindBuffer(gl.ARRAY_BUFFER, state.vbo_handle);

    Position := u32(gl.GetAttribLocation(state.main_program, "Position"));
    UV := u32(gl.GetAttribLocation(state.main_program, "UV"));
    Color := u32(gl.GetAttribLocation(state.main_program, "Color"));

    gl.EnableVertexAttribArray(Position);
    gl.EnableVertexAttribArray(UV);
    gl.EnableVertexAttribArray(Color);

    gl.VertexAttribPointer(Position,   2, gl.FLOAT, gl.FALSE, size_of(imgui.DrawVert), rawptr(offset_of(imgui.DrawVert, pos)));
    gl.VertexAttribPointer(UV,         2, gl.FLOAT, gl.FALSE, size_of(imgui.DrawVert), rawptr(offset_of(imgui.DrawVert, uv)));
    gl.VertexAttribPointer(Color,      4, gl.UNSIGNED_BYTE, gl.TRUE,  size_of(imgui.DrawVert), rawptr(offset_of(imgui.DrawVert, col)));

    new_list := mem.slice_ptr(data.cmd_lists, int(data.cmd_lists_count));
    for list in new_list {
        idx_buffer_offset : ^imgui.DrawIdx = nil;

        gl.BindBuffer(gl.ARRAY_BUFFER, state.vbo_handle);

        gl.BufferData(gl.ARRAY_BUFFER,
                       int(list.vtx_buffer.size * size_of(imgui.DrawVert)), 
                       list.vtx_buffer.data, 
                       gl.STREAM_DRAW);

        gl.BindBuffer(gl.ELEMENT_ARRAY_BUFFER, state.ebo_handle);
        gl.BufferData(gl.ARRAY_BUFFER,
                      int(list.idx_buffer.size * size_of(imgui.DrawIdx)), 
                      &list.idx_buffer.data,
                      gl.STREAM_DRAW);


        pos := data.display_pos;
        cmds := mem.slice_ptr(list.cmd_buffer.data,  int(list.cmd_buffer.size));

        for cmd, idx in cmds {
            if cmd.user_callback != nil {
                cmd.user_callback(list, &cmds[idx]);
            } else {
                clip := imgui.Vec4{
                    cmd.clip_rect.x - pos.x,
                    cmd.clip_rect.y - pos.y,
                    cmd.clip_rect.z - pos.x,
                    cmd.clip_rect.w - pos.y,
                };

                if clip.x < f32(width) && clip.y < f32(height) && clip.z >= 0 && clip.w >= 0 {
                    //fmt.println("scissor ", i32(clip.x), height - i32(clip.w), i32(clip.z - clip.x), i32(clip.w - clip.y));
                    gl.Scissor(
                        i32(clip.x), 
                        height - i32(clip.w), 
                        i32(clip.z - clip.x), 
                        i32(clip.w - clip.y)
                    );
                    
                    //fmt.println("binding texture ", u32(uintptr(cmd.texture_id)));
                    gl.BindTexture(gl.TEXTURE_2D, u32(uintptr(cmd.texture_id)));

                    //fmt.println("glDrawElements(GL_TRIANGLES, elem_count=", i32(cmd.elem_count), "GL_UNSIGNED_SHORT, idx_buffer_offset=", idx_buffer_offset);
                    gl.DrawElements(gl.TRIANGLES, i32(cmd.elem_count), gl.UNSIGNED_SHORT, idx_buffer_offset);
                }
            }

            idx_buffer_offset = mem.ptr_offset(idx_buffer_offset, int(cmd.elem_count));
        }
    }

    gl.DeleteVertexArrays(1, &vao_handle);

    //TODO: Restore state
    if blend == 1 { gl.Enable(gl.BLEND); } else { gl.Disable(gl.BLEND); }
    if cull == 1 { gl.Enable(gl.CULL_FACE); } else { gl.Disable(gl.CULL_FACE); }
    if depth == 1 { gl.Enable(gl.DEPTH_TEST); } else { gl.Disable(gl.DEPTH_TEST); }
    if scissor == 1 { gl.Enable(gl.SCISSOR_TEST); } else { gl.Disable(gl.SCISSOR_TEST); }
    gl.Viewport(lastViewport[0], lastViewport[1], lastViewport[2], lastViewport[3]);
    gl.Scissor(lastScissor[0], lastScissor[1], lastScissor[2], lastScissor[3]);
    if current_vao >= 0 do gl.BindVertexArray(u32(current_vao));
}

when os.OS == "windows" {
    VirtualKey :: enum {
        LMouse     = 0x01,
        RMouse     = 0x02,
        Cancel     = 0x03,
        MMouse     = 0x04,
        Back       = 0x08,
        Tab        = 0x09,
        Clear      = 0x0C,
        Return     = 0x0D,

        Shift      = 0x10,
        Control    = 0x11,
        Alt        = 0x12,
        Pause      = 0x13,
        Capital    = 0x14,
        Escape     = 0x1B,
        Convert    = 0x1C,
        NonConvert = 0x1D,
        Accept     = 0x1E,
        ModeChange = 0x1F,
        Space      = 0x20,
        Prior      = 0x21,
        Next       = 0x22,
        End        = 0x23,
        Home       = 0x24,
        Left       = 0x25,
        Up         = 0x26,
        Right      = 0x27,
        Down       = 0x28,
        Select     = 0x29,
        Print      = 0x2A,
        Execute    = 0x2B,
        Snapshot   = 0x2C,
        Insert     = 0x2D,
        Delete     = 0x2E,
        Help       = 0x2F,

        Num0 = '0',
        Num1 = '1',
        Num2 = '2',
        Num3 = '3',
        Num4 = '4',
        Num5 = '5',
        Num6 = '6',
        Num7 = '7',
        Num8 = '8',
        Num9 = '9',
        A = 'A',
        B = 'B',
        C = 'C',
        D = 'D',
        E = 'E',
        F = 'F',
        G = 'G',
        H = 'H',
        I = 'I',
        J = 'J',
        K = 'K',
        L = 'L',
        M = 'M',
        N = 'N',
        O = 'O',
        P = 'P',
        Q = 'Q',
        R = 'R',
        S = 'S',
        T = 'T',
        U = 'U',
        V = 'V',
        W = 'W',
        X = 'X',
        Y = 'Y',
        Z = 'Z',

        Lwin       = 0x5B,
        Rwin       = 0x5C,
        Apps       = 0x5D,

        Numpad0    = 0x60,
        Numpad1    = 0x61,
        Numpad2    = 0x62,
        Numpad3    = 0x63,
        Numpad4    = 0x64,
        Numpad5    = 0x65,
        Numpad6    = 0x66,
        Numpad7    = 0x67,
        Numpad8    = 0x68,
        Numpad9    = 0x69,
        Multiply   = 0x6A,
        Add        = 0x6B,
        Separator  = 0x6C,
        Subtract   = 0x6D,
        Decimal    = 0x6E,
        Divide     = 0x6F,

        F1         = 0x70,
        F2         = 0x71,
        F3         = 0x72,
        F4         = 0x73,
        F5         = 0x74,
        F6         = 0x75,
        F7         = 0x76,
        F8         = 0x77,
        F9         = 0x78,
        F10        = 0x79,
        F11        = 0x7A,
        F12        = 0x7B,
        F13        = 0x7C,
        F14        = 0x7D,
        F15        = 0x7E,
        F16        = 0x7F,
        F17        = 0x80,
        F18        = 0x81,
        F19        = 0x82,
        F20        = 0x83,
        F21        = 0x84,
        F22        = 0x85,
        F23        = 0x86,
        F24        = 0x87,

        Numlock    = 0x90,
        Scroll     = 0x91,
        Lshift     = 0xA0,
        Rshift     = 0xA1,
        Lcontrol   = 0xA2,
        Rcontrol   = 0xA3,
        Lalt       = 0xA4,
        Ralt       = 0xA5,
    }
}
