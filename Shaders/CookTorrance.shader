Shader "Custom/CookTorrance" {
Properties {
 _Color ("Main Color", Color) = (1,1,1,1)
 _SpecColor ("Specular Color", Color) = (0.5,0.5,0.5,1)
 _Shininess ("Shininess", Range(0.03,1)) = 0.078125
 _RMS ("BDF RMS (Specular spread)", Range(0.001,1)) = 0.707107
 _MainTex ("Base (RGB) Gloss (A)", 2D) = "white" {}
 _BumpMap ("Normalmap", 2D) = "bump" {}
}
SubShader { 
 LOD 600
 Tags { "RenderType"="Opaque" }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardBase" "RenderType"="Opaque" }
Program "vp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_SHAr]
Vector 17 [unity_SHAg]
Vector 18 [unity_SHAb]
Vector 19 [unity_SHBr]
Vector 20 [unity_SHBg]
Vector 21 [unity_SHBb]
Vector 22 [unity_SHC]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 44 ALU
PARAM c[25] = { { 1 },
		state.matrix.mvp,
		program.local[5..24] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[13].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[18];
DP4 R2.y, R0, c[17];
DP4 R2.x, R0, c[16];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[21];
DP4 R3.y, R1, c[20];
DP4 R3.x, R1, c[19];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[22];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[24].xyxy, c[24];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[23], c[23].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 44 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_SHAr]
Vector 16 [unity_SHAg]
Vector 17 [unity_SHAb]
Vector 18 [unity_SHBr]
Vector 19 [unity_SHBg]
Vector 20 [unity_SHBb]
Vector 21 [unity_SHC]
Vector 22 [_MainTex_ST]
Vector 23 [_BumpMap_ST]
"vs_3_0
; 47 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c24, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c12.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c24.x
dp4 r2.z, r0, c17
dp4 r2.y, r0, c16
dp4 r2.x, r0, c15
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c20
dp4 r3.y, r1, c19
dp4 r3.x, r1, c18
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c21
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
mov r1.w, c24.x
mov r1.xyz, c13
dp4 r4.y, c14, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c12.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c23.xyxy, c23
mad o1.xy, v3, c22, c22.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 20 ALU
PARAM c[19] = { { 1 },
		state.matrix.mvp,
		program.local[5..18] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R1.xyz, R0, vertex.attrib[14].w;
MOV R0.xyz, c[14];
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[18].xyxy, c[18];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[17], c[17].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[16], c[16].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 20 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [unity_LightmapST]
Vector 15 [_MainTex_ST]
Vector 16 [_BumpMap_ST]
"vs_3_0
; 21 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c17, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r1.xyz, r0, v1.w
mov r0.xyz, c13
mov r0.w, c17.x
dp4 r2.z, r0, c10
dp4 r2.x, r0, c8
dp4 r2.y, r0, c9
mad r0.xyz, r2, c12.w, -v0
dp3 o2.y, r0, r1
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
mad o1.zw, v3.xyxy, c16.xyxy, c16
mad o1.xy, v3, c15, c15.zwzw
mad o3.xy, v4, c14, c14.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 49 ALU
PARAM c[26] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MUL R1.xyz, vertex.normal, c[14].w;
DP3 R2.w, R1, c[6];
DP3 R0.x, R1, c[5];
DP3 R0.z, R1, c[7];
MOV R0.y, R2.w;
MUL R1, R0.xyzz, R0.yzzx;
MOV R0.w, c[0].x;
DP4 R2.z, R0, c[19];
DP4 R2.y, R0, c[18];
DP4 R2.x, R0, c[17];
MUL R0.y, R2.w, R2.w;
DP4 R3.z, R1, c[22];
DP4 R3.y, R1, c[21];
DP4 R3.x, R1, c[20];
ADD R2.xyz, R2, R3;
MAD R0.x, R0, R0, -R0.y;
MUL R3.xyz, R0.x, c[23];
MOV R1.xyz, vertex.attrib[14];
MUL R0.xyz, vertex.normal.zxyw, R1.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R1.zxyw, -R0;
ADD result.texcoord[3].xyz, R2, R3;
MOV R0.w, c[0].x;
MOV R0.xyz, c[15];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[14].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[16];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
END
# 49 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_SHAr]
Vector 18 [unity_SHAg]
Vector 19 [unity_SHAb]
Vector 20 [unity_SHBr]
Vector 21 [unity_SHBg]
Vector 22 [unity_SHBb]
Vector 23 [unity_SHC]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"vs_3_0
; 52 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c26, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r1.xyz, v2, c14.w
dp3 r2.w, r1, c5
dp3 r0.x, r1, c4
dp3 r0.z, r1, c6
mov r0.y, r2.w
mul r1, r0.xyzz, r0.yzzx
mov r0.w, c26.x
dp4 r2.z, r0, c19
dp4 r2.y, r0, c18
dp4 r2.x, r0, c17
mul r0.y, r2.w, r2.w
dp4 r3.z, r1, c22
dp4 r3.y, r1, c21
dp4 r3.x, r1, c20
add r1.xyz, r2, r3
mad r0.x, r0, r0, -r0.y
mul r2.xyz, r0.x, c23
add o4.xyz, r1, r2
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
mov r1.w, c26.x
mov r1.xyz, c15
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c26.y
mul r1.y, r1, c12.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c25.xyxy, c25
mad o1.xy, v3, c24, c24.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" ATTR14
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 17 [unity_LightmapST]
Vector 18 [_MainTex_ST]
Vector 19 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 25 ALU
PARAM c[20] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..19] };
TEMP R0;
TEMP R1;
TEMP R2;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R0.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MUL R0.xyz, R0, vertex.attrib[14].w;
MOV R1.xyz, c[15];
MOV R1.w, c[0].x;
DP4 R0.w, vertex.position, c[4];
DP4 R2.z, R1, c[11];
DP4 R2.x, R1, c[9];
DP4 R2.y, R1, c[10];
MAD R2.xyz, R2, c[14].w, -vertex.position;
DP3 result.texcoord[1].y, R2, R0;
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[1].z, vertex.normal, R2;
DP3 result.texcoord[1].x, R2, vertex.attrib[14];
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[19].xyxy, c[19];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[18], c[18].zwzw;
MAD result.texcoord[2].xy, vertex.texcoord[1], c[17], c[17].zwzw;
END
# 25 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "texcoord1" TexCoord1
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [unity_LightmapST]
Vector 17 [_MainTex_ST]
Vector 18 [_BumpMap_ST]
"vs_3_0
; 26 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c19, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
dcl_texcoord1 v4
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r0.xyz, r0, v1.w
mov r1.xyz, c15
mov r1.w, c19.x
dp4 r0.w, v0, c3
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
dp3 o2.y, r2, r0
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c19.y
mul r1.y, r1, c12.x
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
mad o4.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c18.xyxy, c18
mad o1.xy, v3, c17, c17.zwzw
mad o3.xy, v4, c16, c16.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [unity_Scale]
Vector 14 [_WorldSpaceCameraPos]
Vector 15 [_WorldSpaceLightPos0]
Vector 16 [unity_4LightPosX0]
Vector 17 [unity_4LightPosY0]
Vector 18 [unity_4LightPosZ0]
Vector 19 [unity_4LightAtten0]
Vector 20 [unity_LightColor0]
Vector 21 [unity_LightColor1]
Vector 22 [unity_LightColor2]
Vector 23 [unity_LightColor3]
Vector 24 [unity_SHAr]
Vector 25 [unity_SHAg]
Vector 26 [unity_SHAb]
Vector 27 [unity_SHBr]
Vector 28 [unity_SHBg]
Vector 29 [unity_SHBb]
Vector 30 [unity_SHC]
Vector 31 [_MainTex_ST]
Vector 32 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 75 ALU
PARAM c[33] = { { 1, 0 },
		state.matrix.mvp,
		program.local[5..32] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[13].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[17];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[16];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[18];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[19];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[21];
MAD R1.xyz, R0.x, c[20], R1;
MAD R0.xyz, R0.z, c[22], R1;
MAD R1.xyz, R0.w, c[23], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[29];
DP4 R3.y, R0, c[28];
DP4 R3.x, R0, c[27];
MUL R1.w, R3, R3;
MAD R0.x, R4, R4, -R1.w;
MOV R0.w, c[0].x;
DP4 R2.z, R4, c[26];
DP4 R2.y, R4, c[25];
DP4 R2.x, R4, c[24];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[30];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[3].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[14];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[13].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[15];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[32].xyxy, c[32];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[31], c[31].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 75 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [unity_Scale]
Vector 13 [_WorldSpaceCameraPos]
Vector 14 [_WorldSpaceLightPos0]
Vector 15 [unity_4LightPosX0]
Vector 16 [unity_4LightPosY0]
Vector 17 [unity_4LightPosZ0]
Vector 18 [unity_4LightAtten0]
Vector 19 [unity_LightColor0]
Vector 20 [unity_LightColor1]
Vector 21 [unity_LightColor2]
Vector 22 [unity_LightColor3]
Vector 23 [unity_SHAr]
Vector 24 [unity_SHAg]
Vector 25 [unity_SHAb]
Vector 26 [unity_SHBr]
Vector 27 [unity_SHBg]
Vector 28 [unity_SHBb]
Vector 29 [unity_SHC]
Vector 30 [_MainTex_ST]
Vector 31 [_BumpMap_ST]
"vs_3_0
; 78 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c32, 1.00000000, 0.00000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c12.w
dp4 r0.x, v0, c5
add r1, -r0.x, c16
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c15
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c32.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c17
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c18
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c32.x
dp4 r2.z, r4, c25
dp4 r2.y, r4, c24
dp4 r2.x, r4, c23
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c32.y
mul r0, r0, r1
mul r1.xyz, r0.y, c20
mad r1.xyz, r0.x, c19, r1
mad r0.xyz, r0.z, c21, r1
mad r1.xyz, r0.w, c22, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c28
dp4 r3.y, r0, c27
dp4 r3.x, r0, c26
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c29
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c14, r0
mov r0, c9
mov r1.w, c32.x
mov r1.xyz, c13
dp4 r4.y, c14, r0
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c12.w, -v0
mov r1, c8
dp4 r4.x, c14, r1
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o1.zw, v3.xyxy, c31.xyxy, c31
mad o1.xy, v3, c30, c30.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Vector 13 [_ProjectionParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 80 ALU
PARAM c[34] = { { 1, 0, 0.5 },
		state.matrix.mvp,
		program.local[5..33] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
MUL R3.xyz, vertex.normal, c[14].w;
DP4 R0.x, vertex.position, c[6];
ADD R1, -R0.x, c[18];
DP3 R3.w, R3, c[6];
DP3 R4.x, R3, c[5];
DP3 R3.x, R3, c[7];
MUL R2, R3.w, R1;
DP4 R0.x, vertex.position, c[5];
ADD R0, -R0.x, c[17];
MUL R1, R1, R1;
MOV R4.z, R3.x;
MAD R2, R4.x, R0, R2;
MOV R4.w, c[0].x;
DP4 R4.y, vertex.position, c[7];
MAD R1, R0, R0, R1;
ADD R0, -R4.y, c[19];
MAD R1, R0, R0, R1;
MAD R0, R3.x, R0, R2;
MUL R2, R1, c[20];
MOV R4.y, R3.w;
RSQ R1.x, R1.x;
RSQ R1.y, R1.y;
RSQ R1.w, R1.w;
RSQ R1.z, R1.z;
MUL R0, R0, R1;
ADD R1, R2, c[0].x;
RCP R1.x, R1.x;
RCP R1.y, R1.y;
RCP R1.w, R1.w;
RCP R1.z, R1.z;
MAX R0, R0, c[0].y;
MUL R0, R0, R1;
MUL R1.xyz, R0.y, c[22];
MAD R1.xyz, R0.x, c[21], R1;
MAD R0.xyz, R0.z, c[23], R1;
MAD R1.xyz, R0.w, c[24], R0;
MUL R0, R4.xyzz, R4.yzzx;
DP4 R3.z, R0, c[30];
DP4 R3.y, R0, c[29];
DP4 R3.x, R0, c[28];
MUL R1.w, R3, R3;
MOV R0.w, c[0].x;
MAD R0.x, R4, R4, -R1.w;
DP4 R2.z, R4, c[27];
DP4 R2.y, R4, c[26];
DP4 R2.x, R4, c[25];
ADD R2.xyz, R2, R3;
MUL R3.xyz, R0.x, c[31];
ADD R3.xyz, R2, R3;
MOV R0.xyz, vertex.attrib[14];
MUL R2.xyz, vertex.normal.zxyw, R0.yzxw;
ADD result.texcoord[3].xyz, R3, R1;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R2;
MOV R0.xyz, c[15];
DP4 R2.z, R0, c[11];
DP4 R2.x, R0, c[9];
DP4 R2.y, R0, c[10];
MAD R0.xyz, R2, c[14].w, -vertex.position;
MUL R2.xyz, R1, vertex.attrib[14].w;
MOV R1, c[16];
DP4 R3.z, R1, c[11];
DP4 R3.x, R1, c[9];
DP4 R3.y, R1, c[10];
DP3 result.texcoord[1].y, R0, R2;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
MUL R1.xyz, R0.xyww, c[0].z;
MUL R1.y, R1, c[13].x;
DP3 result.texcoord[2].y, R2, R3;
DP3 result.texcoord[2].z, vertex.normal, R3;
DP3 result.texcoord[2].x, vertex.attrib[14], R3;
ADD result.texcoord[4].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[33].xyxy, c[33];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[32], c[32].zwzw;
END
# 80 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" "VERTEXLIGHT_ON" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Vector 12 [_ProjectionParams]
Vector 13 [_ScreenParams]
Vector 14 [unity_Scale]
Vector 15 [_WorldSpaceCameraPos]
Vector 16 [_WorldSpaceLightPos0]
Vector 17 [unity_4LightPosX0]
Vector 18 [unity_4LightPosY0]
Vector 19 [unity_4LightPosZ0]
Vector 20 [unity_4LightAtten0]
Vector 21 [unity_LightColor0]
Vector 22 [unity_LightColor1]
Vector 23 [unity_LightColor2]
Vector 24 [unity_LightColor3]
Vector 25 [unity_SHAr]
Vector 26 [unity_SHAg]
Vector 27 [unity_SHAb]
Vector 28 [unity_SHBr]
Vector 29 [unity_SHBg]
Vector 30 [unity_SHBb]
Vector 31 [unity_SHC]
Vector 32 [_MainTex_ST]
Vector 33 [_BumpMap_ST]
"vs_3_0
; 83 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c34, 1.00000000, 0.00000000, 0.50000000, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mul r3.xyz, v2, c14.w
dp4 r0.x, v0, c5
add r1, -r0.x, c18
dp3 r3.w, r3, c5
dp3 r4.x, r3, c4
dp3 r3.x, r3, c6
mul r2, r3.w, r1
dp4 r0.x, v0, c4
add r0, -r0.x, c17
mul r1, r1, r1
mov r4.z, r3.x
mad r2, r4.x, r0, r2
mov r4.w, c34.x
dp4 r4.y, v0, c6
mad r1, r0, r0, r1
add r0, -r4.y, c19
mad r1, r0, r0, r1
mad r0, r3.x, r0, r2
mul r2, r1, c20
mov r4.y, r3.w
rsq r1.x, r1.x
rsq r1.y, r1.y
rsq r1.w, r1.w
rsq r1.z, r1.z
mul r0, r0, r1
add r1, r2, c34.x
dp4 r2.z, r4, c27
dp4 r2.y, r4, c26
dp4 r2.x, r4, c25
rcp r1.x, r1.x
rcp r1.y, r1.y
rcp r1.w, r1.w
rcp r1.z, r1.z
max r0, r0, c34.y
mul r0, r0, r1
mul r1.xyz, r0.y, c22
mad r1.xyz, r0.x, c21, r1
mad r0.xyz, r0.z, c23, r1
mad r1.xyz, r0.w, c24, r0
mul r0, r4.xyzz, r4.yzzx
mul r1.w, r3, r3
dp4 r3.z, r0, c30
dp4 r3.y, r0, c29
dp4 r3.x, r0, c28
mad r1.w, r4.x, r4.x, -r1
mul r0.xyz, r1.w, c31
add r2.xyz, r2, r3
add r2.xyz, r2, r0
add o4.xyz, r2, r1
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r0.xyz, v2.yzxw, r0.zxyw, -r1
mul r3.xyz, r0, v1.w
mov r0, c10
dp4 r4.z, c16, r0
mov r0, c9
dp4 r4.y, c16, r0
mov r1.w, c34.x
mov r1.xyz, c15
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r2.z, r1, c10
dp4 r2.x, r1, c8
dp4 r2.y, r1, c9
mad r2.xyz, r2, c14.w, -v0
mov r1, c8
dp4 r4.x, c16, r1
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c34.z
mul r1.y, r1, c12.x
dp3 o2.y, r2, r3
dp3 o3.y, r3, r4
dp3 o2.z, v2, r2
dp3 o2.x, r2, v1
dp3 o3.z, v2, r4
dp3 o3.x, v1, r4
mad o5.xy, r1.z, c13.zwzw, r1
mov o0, r0
mov o5.zw, r0
mad o1.zw, v3.xyxy, c33.xyxy, c33
mad o1.xy, v3, c32, c32.zwzw
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 76 ALU, 2 TEX
PARAM c[8] = { program.local[0..4],
		{ 2, 1, 0, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R2.xy, R0.wyzw, c[5].x, -c[5].y;
MUL R0.y, R2, R2;
MAD R0.w, -R2.x, R2.x, -R0.y;
ADD R1.x, R0.w, c[5].y;
RSQ R1.x, R1.x;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, fragment.texcoord[2], R3;
DP3 R0.w, R0, R0;
RCP R2.z, R1.x;
DP3 R3.w, R3, R2;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
DP3 R2.w, R4, R2;
ABS R0.x, R2.w;
ADD R0.z, -R0.x, c[5].y;
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R2.w, c[5].z;
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5].x, R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].y;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].y;
ADD R1.x, R0, -c[3];
ADD R0.w, -R2, c[5].y;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R1.x;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R1.x, R0, R0.w;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R4.w, R0, R1.x;
RCP R5.x, R3.w;
MUL_SAT R4.w, R4, R5.x;
DP3 R5.x, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[2];
MOV R1, c[1];
MUL R1.xyz, R1, c[0];
MUL R2.xyz, R0, c[0];
MUL R1.xyz, R1, R4.w;
MAX R5.y, R5.x, c[5].z;
MAD R1.xyz, R2, R5.y, R1;
DP3 R2.y, R4, R3;
RCP R2.y, R2.y;
MUL R2.x, R2.w, R3.w;
MUL R2.x, R2, R2.y;
MUL R2.z, R2.w, R5.x;
MUL R2.z, R2.y, R2;
MUL R2.y, R2.z, c[5].x;
MUL R2.x, R2, c[5];
MIN_SAT R2.x, R2, R2.y;
MUL R1.xyz, R2.x, R1;
MUL R1.xyz, R1, c[5].x;
MAD result.color.xyz, R0, fragment.texcoord[3], R1;
MUL R0.x, R1.w, c[0].w;
MUL R0.y, R0.w, c[2].w;
MUL R0.x, R4.w, R0;
MAD result.color.w, R2.x, R0.x, R0.y;
END
# 76 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
"ps_3_0
; 90 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.y, r1, r1
mad_pp r0.w, -r1.x, r1.x, -r0.y
add_pp r1.z, r0.w, c5.w
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, v2, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.x, c4, c4
mul r0.y, r2.w, r4.x
mul r0.y, r2.w, r0
mov r3.w, r0.x
mul r0.x, r0.y, c8.z
add r4.x, -r1.w, c5.w
rcp r2.w, r0.x
pow r0, r4.x, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r3.w, r2.w
dp3_pp r2.w, r2, r1
rcp r4.w, r2.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul r3.w, r0, r3
mul_sat r3.w, r3, r4
dp3_pp r4.w, v2, r1
mul_pp r0.xyz, r0, c2
dp3_pp r2.x, r3, r2
mov_pp r4.xyz, c0
mul_pp r4.xyz, c1, r4
mul_pp r1.xyz, r0, c0
mul r2.y, r1.w, r4.w
mul r2.w, r1, r2
rcp r1.w, r2.x
mul r2.x, r1.w, r2.y
mul r1.w, r2, r1
mul r2.x, r2, c5
mul r1.w, r1, c5.x
min_sat r1.w, r1, r2.x
mul r4.xyz, r4, r3.w
max_pp r5.x, r4.w, c5.z
mad r1.xyz, r1, r5.x, r4
mul r1.xyz, r1.w, r1
mul r2.xyz, r1, c5.x
mad_pp oC0.xyz, r0, v3, r2
mov_pp r1.x, c0.w
mul_pp r0.x, c1.w, r1
mul_pp r0.y, r0.w, c2.w
mul r0.x, r3.w, r0
mad oC0.w, r1, r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 7 ALU, 2 TEX
PARAM c[2] = { program.local[0],
		{ 8 } };
TEMP R0;
TEMP R1;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0];
TEX R1, fragment.texcoord[2], texture[2], 2D;
MUL R1.xyz, R1.w, R1;
MUL R0.xyz, R1, R0;
MUL result.color.xyz, R0, c[1].x;
MOV result.color.w, R0;
END
# 7 instructions, 2 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [unity_Lightmap] 2D
"ps_3_0
; 5 ALU, 2 TEX
dcl_2d s0
dcl_2d s2
def c1, 8.00000000, 0, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
texld r0, v0, s0
mul_pp r0, r0, c0
texld r1, v1, s2
mul_pp r1.xyz, r1.w, r1
mul_pp r0.xyz, r1, r0
mul_pp oC0.xyz, r0, c1.x
mov_pp oC0.w, r0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 79 ALU, 3 TEX
PARAM c[8] = { program.local[0..4],
		{ 2, 1, 0, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R2.xy, R0.wyzw, c[5].x, -c[5].y;
MUL R0.y, R2, R2;
MAD R0.w, -R2.x, R2.x, -R0.y;
ADD R1.x, R0.w, c[5].y;
RSQ R1.x, R1.x;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
MUL R3.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, fragment.texcoord[2], R3;
DP3 R0.w, R0, R0;
RCP R2.z, R1.x;
DP3 R3.w, R3, R2;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
DP3 R2.w, R4, R2;
ABS R0.x, R2.w;
ADD R0.z, -R0.x, c[5].y;
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R2.w, c[5].z;
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5].x, R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].y;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].y;
ADD R1.x, R0, -c[3];
ADD R0.w, -R2, c[5].y;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R1.x;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R1.x, R0, R0.w;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R4.w, R0, R1.x;
MOV R1, c[1];
RCP R5.x, R3.w;
MUL_SAT R4.w, R4, R5.x;
DP3 R5.x, fragment.texcoord[2], R2;
MUL R0.xyz, R0, c[2];
MUL R1.xyz, R1, c[0];
MUL R2.xyz, R0, c[0];
MUL R1.xyz, R1, R4.w;
MAX R5.y, R5.x, c[5].z;
MAD R1.xyz, R2, R5.y, R1;
DP3 R2.y, R4, R3;
RCP R2.y, R2.y;
MUL R2.x, R2.w, R3.w;
MUL R2.z, R2.w, R5.x;
MUL R2.z, R2.y, R2;
MUL R2.x, R2, R2.y;
MUL R2.y, R2.x, c[5].x;
MUL R2.z, R2, c[5].x;
MIN_SAT R2.y, R2, R2.z;
TXP R2.x, fragment.texcoord[4], texture[2], 2D;
MUL R2.z, R2.y, R2.x;
MUL R1.xyz, R2.z, R1;
MUL R1.xyz, R1, c[5].x;
MAD result.color.xyz, R0, fragment.texcoord[3], R1;
MUL R1.w, R1, c[0];
MUL R0.x, R4.w, R1.w;
MUL R0.y, R0.w, c[2].w;
MUL R0.x, R2.y, R0;
MAD result.color.w, R2.x, R0.x, R0.y;
END
# 79 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 92 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.y, r1, r1
mad_pp r0.w, -r1.x, r1.x, -r0.y
add_pp r1.z, r0.w, c5.w
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, v2, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.x, c4, c4
mul r0.y, r2.w, r4.x
mul r0.y, r2.w, r0
mov r3.w, r0.x
mul r0.x, r0.y, c8.z
add r4.x, -r1.w, c5.w
rcp r2.w, r0.x
pow r0, r4.x, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r3.w, r2.w
dp3_pp r2.w, r2, r1
dp3_pp r2.y, r3, r2
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mov_pp r4.xyz, c0
mul_pp r0.xyz, r0, c2
mul r2.x, r1.w, r2.w
rcp r2.y, r2.y
rcp r4.w, r2.w
mul r3.w, r0, r3
mul_sat r3.w, r3, r4
dp3_pp r4.w, v2, r1
mul r2.z, r1.w, r4.w
mul r1.w, r2.x, r2.y
mul r2.x, r2.y, r2.z
mul r2.y, r2.x, c5.x
mul_pp r4.xyz, c1, r4
mul r1.w, r1, c5.x
mul_pp r1.xyz, r0, c0
min_sat r1.w, r1, r2.y
texldp r2.x, v4, s2
mul r2.y, r1.w, r2.x
mul r4.xyz, r4, r3.w
max_pp r5.x, r4.w, c5.z
mad r1.xyz, r1, r5.x, r4
mul r1.xyz, r2.y, r1
mov_pp r2.y, c0.w
mul r1.xyz, r1, c5.x
mad_pp oC0.xyz, r0, v3, r1
mul_pp r2.y, c1.w, r2
mul r0.x, r3.w, r2.y
mul_pp r0.y, r0.w, c2.w
mul r0.x, r1.w, r0
mad oC0.w, r2.x, r0.x, r0.y
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 13 ALU, 3 TEX
PARAM c[2] = { program.local[0],
		{ 8, 2 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEX R0, fragment.texcoord[2], texture[3], 2D;
TXP R2.x, fragment.texcoord[3], texture[2], 2D;
MUL R1.xyz, R0, R2.x;
MUL R0.xyz, R0.w, R0;
MUL R0.xyz, R0, c[1].x;
MUL R1.xyz, R1, c[1].y;
MIN R1.xyz, R0, R1;
MUL R2.xyz, R0, R2.x;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0, R0, c[0];
MAX R1.xyz, R1, R2;
MUL result.color.xyz, R0, R1;
MOV result.color.w, R0;
END
# 13 instructions, 3 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" }
Vector 0 [_Color]
SetTexture 0 [_MainTex] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [unity_Lightmap] 2D
"ps_3_0
; 10 ALU, 3 TEX
dcl_2d s0
dcl_2d s2
dcl_2d s3
def c1, 8.00000000, 2.00000000, 0, 0
dcl_texcoord0 v0.xy
dcl_texcoord2 v1.xy
dcl_texcoord3 v2
texld r0, v1, s3
texldp r2.x, v2, s2
mul_pp r1.xyz, r0, r2.x
mul_pp r0.xyz, r0.w, r0
mul_pp r0.xyz, r0, c1.x
mul_pp r1.xyz, r1, c1.y
min_pp r1.xyz, r0, r1
mul_pp r2.xyz, r0, r2.x
texld r0, v0, s0
mul_pp r0, r0, c0
max_pp r1.xyz, r1, r2
mul_pp oC0.xyz, r0, r1
mov_pp oC0.w, r0
"
}
}
 }
 Pass {
  Name "FORWARD"
  Tags { "LIGHTMODE"="ForwardAdd" "RenderType"="Opaque" }
  ZWrite Off
  Fog {
   Color (0,0,0,0)
  }
  Blend One One
Program "vp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [unity_Scale]
Vector 10 [_WorldSpaceCameraPos]
Vector 11 [_WorldSpaceLightPos0]
Vector 12 [_MainTex_ST]
Vector 13 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 26 ALU
PARAM c[14] = { { 1 },
		state.matrix.mvp,
		program.local[5..13] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[10];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[9].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[11];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[13].xyxy, c[13];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[12], c[12].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 26 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [unity_Scale]
Vector 9 [_WorldSpaceCameraPos]
Vector 10 [_WorldSpaceLightPos0]
Vector 11 [_MainTex_ST]
Vector 12 [_BumpMap_ST]
"vs_3_0
; 29 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
def c13, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c13.x
mov r0.xyz, c9
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c8.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c10, r0
mov r0, c5
mov r1, c4
dp4 r4.y, c10, r0
dp4 r4.x, c10, r1
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mad o1.zw, v3.xyxy, c12.xyxy, c12
mad o1.xy, v3, c11, c11.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[16];
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c15
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 34 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 34 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 37 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 32 ALU
PARAM c[22] = { { 1 },
		state.matrix.mvp,
		program.local[5..21] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[8];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[21].xyxy, c[21];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[20], c[20].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 32 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_MainTex_ST]
Vector 20 [_BumpMap_ST]
"vs_3_0
; 35 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c21, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c21.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
dp4 r0.w, v0, c7
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
mad o1.zw, v3.xyxy, c20.xyxy, c20
mad o1.xy, v3, c19, c19.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [unity_World2Shadow]
Matrix 17 [_LightMatrix0]
Vector 21 [unity_Scale]
Vector 22 [_WorldSpaceCameraPos]
Vector 23 [_WorldSpaceLightPos0]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 39 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[22];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[21].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[23];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[21].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[20];
DP4 result.texcoord[3].z, R0, c[19];
DP4 result.texcoord[3].y, R0, c[18];
DP4 result.texcoord[3].x, R0, c[17];
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_World2Object]
Vector 9 [_ProjectionParams]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 31 ALU
PARAM c[15] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..14] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[11];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[7];
DP4 R2.y, R1, c[6];
DP4 R2.x, R1, c[5];
MAD R2.xyz, R2, c[10].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[12];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[7];
DP4 R3.y, R0, c[6];
DP4 R3.x, R0, c[5];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[9].x;
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
ADD result.texcoord[3].xy, R1, R1.z;
MOV result.position, R0;
MOV result.texcoord[3].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[14].xyxy, c[14];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[13], c[13].zwzw;
END
# 31 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_World2Object]
Vector 8 [_ProjectionParams]
Vector 9 [_ScreenParams]
Vector 10 [unity_Scale]
Vector 11 [_WorldSpaceCameraPos]
Vector 12 [_WorldSpaceLightPos0]
Vector 13 [_MainTex_ST]
Vector 14 [_BumpMap_ST]
"vs_3_0
; 34 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
def c15, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c15.x
mov r0.xyz, c11
dp4 r1.z, r0, c6
dp4 r1.y, r0, c5
dp4 r1.x, r0, c4
mad r3.xyz, r1, c10.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c6
dp4 r4.z, c12, r0
mov r0, c5
dp4 r4.y, c12, r0
mov r1, c4
dp4 r4.x, c12, r1
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c15.y
mul r1.y, r1, c8.x
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mad o4.xy, r1.z, c9.zwzw, r1
mov o0, r0
mov o4.zw, r0
mad o1.zw, v3.xyxy, c14.xyxy, c14
mad o1.xy, v3, c13, c13.zwzw
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [_ProjectionParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 37 ALU
PARAM c[23] = { { 1, 0.5 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.w, c[0].x;
MOV R1.xyz, c[19];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[18].w, -vertex.position;
MOV R0.xyz, vertex.attrib[14];
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[20];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.y, R0, c[10];
DP4 R3.x, R0, c[9];
DP4 R0.w, vertex.position, c[4];
DP4 R0.z, vertex.position, c[3];
DP4 R0.x, vertex.position, c[1];
DP4 R0.y, vertex.position, c[2];
DP4 R1.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R3, R1;
DP3 result.texcoord[2].y, R1, R2;
MUL R1.xyz, R0.xyww, c[0].y;
MUL R1.y, R1, c[17].x;
ADD result.texcoord[4].xy, R1, R1.z;
DP4 R1.z, vertex.position, c[7];
DP4 R1.x, vertex.position, c[5];
DP4 R1.y, vertex.position, c[6];
DP3 result.texcoord[1].z, vertex.normal, R3;
DP3 result.texcoord[1].x, R3, vertex.attrib[14];
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
MOV result.position, R0;
DP4 result.texcoord[3].y, R1, c[14];
DP4 result.texcoord[3].x, R1, c[13];
MOV result.texcoord[4].zw, R0;
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
END
# 37 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [_ProjectionParams]
Vector 17 [_ScreenParams]
Vector 18 [unity_Scale]
Vector 19 [_WorldSpaceCameraPos]
Vector 20 [_WorldSpaceLightPos0]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"vs_3_0
; 40 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c23, 1.00000000, 0.50000000, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c23.x
mov r0.xyz, c19
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c18.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r1, c8
dp4 r4.x, c20, r1
mov r0, c10
dp4 r4.z, c20, r0
mov r0, c9
dp4 r4.y, c20, r0
dp4 r0.w, v0, c3
dp4 r0.z, v0, c2
dp4 r0.x, v0, c0
dp4 r0.y, v0, c1
mul r1.xyz, r0.xyww, c23.y
mul r1.y, r1, c16.x
mad o5.xy, r1.z, c17.zwzw, r1
dp4 r1.w, v0, c7
dp4 r1.z, v0, c6
dp4 r1.x, v0, c4
dp4 r1.y, v0, c5
dp3 o2.y, r4, r2
dp3 o3.y, r2, r3
dp3 o2.z, v2, r4
dp3 o2.x, r4, v1
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
mov o0, r0
dp4 o4.y, r1, c13
dp4 o4.x, r1, c12
mov o5.zw, r0
mad o1.zw, v3.xyxy, c22.xyxy, c22
mad o1.xy, v3, c21, c21.zwzw
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [unity_World2Shadow]
Matrix 17 [_LightMatrix0]
Vector 21 [unity_Scale]
Vector 22 [_WorldSpaceCameraPos]
Vector 23 [_WorldSpaceLightPos0]
Vector 24 [_MainTex_ST]
Vector 25 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 39 ALU
PARAM c[26] = { { 1 },
		state.matrix.mvp,
		program.local[5..25] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[22];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[21].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[23];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[21].w, -vertex.position;
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].w, R0, c[20];
DP4 result.texcoord[3].z, R0, c[19];
DP4 result.texcoord[3].y, R0, c[18];
DP4 result.texcoord[3].x, R0, c[17];
DP4 result.texcoord[4].w, R0, c[16];
DP4 result.texcoord[4].z, R0, c[15];
DP4 result.texcoord[4].y, R0, c[14];
DP4 result.texcoord[4].x, R0, c[13];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[25].xyxy, c[25];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[24], c[24].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 39 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [unity_World2Shadow]
Matrix 16 [_LightMatrix0]
Vector 20 [unity_Scale]
Vector 21 [_WorldSpaceCameraPos]
Vector 22 [_WorldSpaceLightPos0]
Vector 23 [_MainTex_ST]
Vector 24 [_BumpMap_ST]
"vs_3_0
; 42 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c25, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c25.x
mov r0.xyz, c21
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c20.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c22, r0
mov r0, c9
dp4 r4.y, c22, r0
mov r1, c8
dp4 r4.x, c22, r1
mad r0.xyz, r4, c20.w, -v0
dp4 r0.w, v0, c7
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.w, r0, c19
dp4 o4.z, r0, c18
dp4 o4.y, r0, c17
dp4 o4.x, r0, c16
dp4 o5.w, r0, c15
dp4 o5.z, r0, c14
dp4 o5.y, r0, c13
dp4 o5.x, r0, c12
mad o1.zw, v3.xyxy, c24.xyxy, c24
mad o1.xy, v3, c23, c23.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" ATTR14
Matrix 5 [_Object2World]
Matrix 9 [_World2Object]
Matrix 13 [_LightMatrix0]
Vector 17 [unity_Scale]
Vector 18 [_WorldSpaceCameraPos]
Vector 19 [_WorldSpaceLightPos0]
Vector 20 [_LightPositionRange]
Vector 21 [_MainTex_ST]
Vector 22 [_BumpMap_ST]
"3.0-!!ARBvp1.0
# 35 ALU
PARAM c[23] = { { 1 },
		state.matrix.mvp,
		program.local[5..22] };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
MOV R1.xyz, c[18];
MOV R1.w, c[0].x;
MOV R0.xyz, vertex.attrib[14];
DP4 R2.z, R1, c[11];
DP4 R2.y, R1, c[10];
DP4 R2.x, R1, c[9];
MAD R2.xyz, R2, c[17].w, -vertex.position;
MUL R1.xyz, vertex.normal.zxyw, R0.yzxw;
MAD R1.xyz, vertex.normal.yzxw, R0.zxyw, -R1;
MOV R0, c[19];
MUL R1.xyz, R1, vertex.attrib[14].w;
DP4 R3.z, R0, c[11];
DP4 R3.x, R0, c[9];
DP4 R3.y, R0, c[10];
MAD R0.xyz, R3, c[17].w, -vertex.position;
DP3 result.texcoord[1].y, R0, R1;
DP3 result.texcoord[1].z, vertex.normal, R0;
DP3 result.texcoord[1].x, R0, vertex.attrib[14];
DP4 R0.z, vertex.position, c[7];
DP4 R0.x, vertex.position, c[5];
DP4 R0.y, vertex.position, c[6];
DP4 R0.w, vertex.position, c[8];
DP3 result.texcoord[2].y, R1, R2;
DP3 result.texcoord[2].z, vertex.normal, R2;
DP3 result.texcoord[2].x, vertex.attrib[14], R2;
DP4 result.texcoord[3].z, R0, c[15];
DP4 result.texcoord[3].y, R0, c[14];
DP4 result.texcoord[3].x, R0, c[13];
ADD result.texcoord[4].xyz, R0, -c[20];
MAD result.texcoord[0].zw, vertex.texcoord[0].xyxy, c[22].xyxy, c[22];
MAD result.texcoord[0].xy, vertex.texcoord[0], c[21], c[21].zwzw;
DP4 result.position.w, vertex.position, c[4];
DP4 result.position.z, vertex.position, c[3];
DP4 result.position.y, vertex.position, c[2];
DP4 result.position.x, vertex.position, c[1];
END
# 35 instructions, 4 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Bind "vertex" Vertex
Bind "normal" Normal
Bind "texcoord" TexCoord0
Bind "tangent" TexCoord2
Matrix 0 [glstate_matrix_mvp]
Matrix 4 [_Object2World]
Matrix 8 [_World2Object]
Matrix 12 [_LightMatrix0]
Vector 16 [unity_Scale]
Vector 17 [_WorldSpaceCameraPos]
Vector 18 [_WorldSpaceLightPos0]
Vector 19 [_LightPositionRange]
Vector 20 [_MainTex_ST]
Vector 21 [_BumpMap_ST]
"vs_3_0
; 38 ALU
dcl_position o0
dcl_texcoord0 o1
dcl_texcoord1 o2
dcl_texcoord2 o3
dcl_texcoord3 o4
dcl_texcoord4 o5
def c22, 1.00000000, 0, 0, 0
dcl_position0 v0
dcl_tangent0 v1
dcl_normal0 v2
dcl_texcoord0 v3
mov r0.w, c22.x
mov r0.xyz, c17
dp4 r1.z, r0, c10
dp4 r1.y, r0, c9
dp4 r1.x, r0, c8
mad r3.xyz, r1, c16.w, -v0
mov r0.xyz, v1
mul r1.xyz, v2.zxyw, r0.yzxw
mov r0.xyz, v1
mad r1.xyz, v2.yzxw, r0.zxyw, -r1
mul r2.xyz, r1, v1.w
mov r0, c10
dp4 r4.z, c18, r0
mov r0, c9
dp4 r4.y, c18, r0
mov r1, c8
dp4 r4.x, c18, r1
mad r0.xyz, r4, c16.w, -v0
dp3 o2.y, r0, r2
dp3 o2.z, v2, r0
dp3 o2.x, r0, v1
dp4 r0.z, v0, c6
dp4 r0.x, v0, c4
dp4 r0.y, v0, c5
dp4 r0.w, v0, c7
dp3 o3.y, r2, r3
dp3 o3.z, v2, r3
dp3 o3.x, v1, r3
dp4 o4.z, r0, c14
dp4 o4.y, r0, c13
dp4 o4.x, r0, c12
add o5.xyz, r0, -c19
mad o1.zw, v3.xyxy, c21.xyxy, c21
mad o1.xy, v3, c20, c20.zwzw
dp4 o0.w, v0, c3
dp4 o0.z, v0, c2
dp4 o0.y, v0, c1
dp4 o0.x, v0, c0
"
}
}
Program "fp" {
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 78 ALU, 3 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[5];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MOV R5.xyz, c[1];
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
ADD R0.w, -R1, c[5].z;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R2;
DP3 R2.w, R3, R1;
DP3 R1.y, R2, R1;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL R0.xyz, R0, c[2];
MAX R1.x, R1.y, c[5];
MUL R1.z, R1.w, R1.y;
MUL_SAT R0.w, R0, R3;
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R0.w;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R5;
DP3 R0.w, R4, R3;
RCP R1.x, R0.w;
MUL R0.w, R1, R2;
MUL R0.w, R0, R1.x;
MUL R1.y, R0.w, c[5];
MUL R0.w, R1.x, R1.z;
MUL R1.x, R0.w, c[5].y;
DP3 R1.z, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.z, texture[2], 2D;
MIN_SAT R1.x, R1.y, R1;
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 78 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 90 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c5.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c0
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rcp_pp r1.z, r1.z
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
dp3_pp r2.x, r2, r1
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.w, c4.x, c4.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.z
rcp r3.w, r0.x
add r4.w, -r1, c5
pow r0, r4.w, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
dp3_pp r2.w, r3, r1
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, c0
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c1, r5
mul r5.xyz, r5, r0.w
max_pp r1.x, r2, c5.z
mad r1.xyz, r0, r1.x, r5
dp3_pp r0.w, r4, r3
rcp r0.y, r0.w
mul r0.x, r1.w, r2.w
mul r0.x, r0, r0.y
mul r0.z, r0.x, c5.x
mul r0.w, r1, r2.x
mul r0.y, r0, r0.w
dp3 r0.x, v3, v3
mul r0.y, r0, c5.x
min_sat r0.y, r0.z, r0
texld r0.x, r0.x, s2
mul r0.x, r0.y, r0
mul r0.xyz, r0.x, r1
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 72 ALU, 2 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.y, R1, R1;
MAD R0.w, -R1.x, R1.x, -R0.y;
ADD R1.z, R0.w, c[5];
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[2];
ADD R0.xyz, fragment.texcoord[1], R2;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
RSQ R1.z, R1.z;
MOV R4.xyz, c[1];
MUL R3.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R3, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
ADD R0.w, -R1, c[5].z;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
DP3 R2.w, R2, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R4.xyz, R4, c[0];
MUL R4.xyz, R4, R0.w;
DP3 R0.w, fragment.texcoord[1], R1;
MAX R1.x, R0.w, c[5];
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R4;
MUL R1.x, R1.w, R2.w;
DP3 R1.y, R3, R2;
MUL R1.z, R1.w, R0.w;
RCP R0.w, R1.y;
MUL R1.y, R0.w, R1.z;
MUL R0.w, R1.x, R0;
MUL R1.x, R1.y, c[5].y;
MUL R0.w, R0, c[5].y;
MIN_SAT R0.w, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 72 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
"ps_3_0
; 85 ALU, 2 TEX
dcl_2d s0
dcl_2d s1
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.y, r1, r1
mad_pp r0.w, -r1.x, r1.x, -r0.y
add_pp r1.z, r0.w, c5.w
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
add_pp r0.xyz, v1, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.x, c4, c4
mul r0.y, r2.w, r4.x
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.z
rcp r3.w, r0.x
add r4.x, -r1.w, c5.w
pow r0, r4.x, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mov_pp r4.xyz, c0
mul_pp r0.xyz, r0, c2
dp3_pp r2.w, r2, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r4.xyz, c1, r4
mul r4.xyz, r4, r0.w
dp3_pp r0.w, v1, r1
max_pp r1.x, r0.w, c5.z
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r1.x, r4
mul r1.x, r1.w, r2.w
dp3_pp r1.y, r3, r2
mul r1.z, r1.w, r0.w
rcp r0.w, r1.y
mul r1.y, r0.w, r1.z
mul r0.w, r1.x, r0
mul r1.x, r1.y, c5
mul r0.w, r0, c5.x
min_sat r0.w, r0, r1.x
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 84 ALU, 4 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 0.5 },
		{ 2.718282, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[5];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MOV R5.xyz, c[1];
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6].z, c[6].w;
MAD R0.y, R0, R0.x, -c[7].x;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7].y;
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6].y, R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7];
ADD R0.w, -R1, c[5].z;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[6].x, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
POW R0.x, R0.w, c[7].w;
MAD R0.w, R0.x, c[3].x, R2;
DP3 R2.w, R3, R1;
DP3 R1.y, R2, R1;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL R0.xyz, R0, c[2];
MUL R1.z, R1.w, R1.y;
MAX R1.x, R1.y, c[5];
MUL_SAT R0.w, R0, R3;
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R0.w;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R5;
DP3 R0.w, R4, R3;
RCP R1.x, R0.w;
MUL R0.w, R1, R2;
MUL R0.w, R0, R1.x;
MUL R1.y, R0.w, c[5];
MUL R0.w, R1.x, R1.z;
RCP R1.z, fragment.texcoord[3].w;
MAD R1.zw, fragment.texcoord[3].xyxy, R1.z, c[5].w;
MUL R1.x, R0.w, c[5].y;
TEX R0.w, R1.zwzw, texture[2], 2D;
SLT R1.z, c[5].x, fragment.texcoord[3];
DP3 R2.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R0.w, R1.z, R0;
TEX R1.w, R2.x, texture[3], 2D;
MUL R1.z, R0.w, R1.w;
MIN_SAT R0.w, R1.y, R1.x;
MUL R0.w, R0, R1.z;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 84 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
"ps_3_0
; 95 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, 0.50000000, -0.01872930, 0.07426100, -0.21211439
def c7, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c8, 6.28318501, -3.14159298, 2.71828198, 3.14159274
def c9, 5.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c5.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c0
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6, c6.z
mad r0.y, r0, r0.x, c6.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c7
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7.y, r0.y
mad r0.x, r0, c7.z, c7.w
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c8.z, -r3.w
mul r4.w, c4.x, c4.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.w
rcp r3.w, r0.x
add r4.w, -r1, c5
pow r0, r4.w, c9.x
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
dp3_pp r2.w, r3, r1
dp3_pp r1.x, r2, r1
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_pp r0.xyz, r0, c2
mul_pp r0.xyz, r0, c0
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c1, r5
mul r5.xyz, r5, r0.w
max_pp r1.y, r1.x, c5.z
mad r2.xyz, r0, r1.y, r5
dp3_pp r0.w, r4, r3
rcp r0.y, r0.w
mul r0.x, r1.w, r2.w
mul r0.x, r0, r0.y
mul r0.w, r1, r1.x
mul r0.z, r0.x, c5.x
mul r0.x, r0.y, r0.w
mul r0.y, r0.x, c5.x
rcp r0.w, v3.w
mad r1.xy, v3, r0.w, c6.x
texld r0.w, r1, s2
dp3 r0.x, v3, v3
cmp r1.x, -v3.z, c5.z, c5.w
texld r0.x, r0.x, s3
mul_pp r0.w, r1.x, r0
mul_pp r0.w, r0, r0.x
min_sat r0.x, r0.z, r0.y
mul r0.x, r0, r0.w
mul r0.xyz, r0.x, r2
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 80 ALU, 4 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[5];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MOV R5.xyz, c[1];
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
ADD R0.w, -R1, c[5].z;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
DP3 R2.w, R3, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R0.w;
DP3 R0.w, R2, R1;
MAX R1.x, R0.w, c[5];
MUL R1.y, R1.w, R0.w;
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R5;
DP3 R1.x, R4, R3;
RCP R1.x, R1.x;
MUL R0.w, R1, R2;
MUL R1.y, R1.x, R1;
MUL R0.w, R0, R1.x;
MUL R1.x, R0.w, c[5].y;
DP3 R1.z, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, fragment.texcoord[3], texture[3], CUBE;
TEX R1.w, R1.z, texture[2], 2D;
MUL R1.z, R1.w, R0.w;
MUL R1.y, R1, c[5];
MIN_SAT R0.w, R1.x, R1.y;
MUL R0.w, R0, R1.z;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 80 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTextureB0] 2D
SetTexture 3 [_LightTexture0] CUBE
"ps_3_0
; 91 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_cube s3
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c5.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c0
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.w, c4.x, c4.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.z
rcp r3.w, r0.x
add r4.w, -r1, c5
pow r0, r4.w, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul_pp r0.xyz, r0, c2
dp3_pp r2.w, r3, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c1, r5
mul r5.xyz, r5, r0.w
dp3_pp r0.w, r2, r1
max_pp r1.x, r0.w, c5.z
mul r1.y, r1.w, r0.w
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r1.x, r5
dp3_pp r1.x, r4, r3
rcp r1.x, r1.x
mul r0.w, r1, r2
mul r0.w, r0, r1.x
mul r1.x, r1, r1.y
mul r1.y, r0.w, c5.x
mul r1.z, r1.x, c5.x
dp3 r1.x, v3, v3
texld r0.w, v3, s3
texld r1.x, r1.x, s2
mul r1.x, r1, r0.w
min_sat r0.w, r1.y, r1.z
mul r0.w, r0, r1.x
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 74 ALU, 3 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.y, R1, R1;
MAD R0.w, -R1.x, R1.x, -R0.y;
ADD R1.z, R0.w, c[5];
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[2];
ADD R0.xyz, fragment.texcoord[1], R2;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
RSQ R1.z, R1.z;
MOV R4.xyz, c[1];
MUL R3.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R3, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
ADD R0.w, -R1, c[5].z;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
DP3 R2.w, R2, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R4.xyz, R4, c[0];
MUL R4.xyz, R4, R0.w;
DP3 R0.w, fragment.texcoord[1], R1;
DP3 R1.y, R3, R2;
MAX R1.x, R0.w, c[5];
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R4;
MUL R1.x, R1.w, R2.w;
RCP R1.y, R1.y;
MUL R1.z, R1.w, R0.w;
MUL R0.w, R1.x, R1.y;
MUL R1.x, R0.w, c[5].y;
MUL R1.y, R1, R1.z;
MUL R1.y, R1, c[5];
TEX R0.w, fragment.texcoord[3], texture[2], 2D;
MIN_SAT R1.x, R1, R1.y;
MUL R0.w, R1.x, R0;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 74 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_OFF" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
"ps_3_0
; 86 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.y, r1, r1
mad_pp r0.w, -r1.x, r1.x, -r0.y
add_pp r1.z, r0.w, c5.w
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
add_pp r0.xyz, v1, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.x, c4, c4
mul r0.y, r2.w, r4.x
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.z
rcp r3.w, r0.x
add r4.x, -r1.w, c5.w
pow r0, r4.x, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mov_pp r4.xyz, c0
mul_pp r0.xyz, r0, c2
dp3_pp r2.w, r2, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r4.xyz, c1, r4
mul r4.xyz, r4, r0.w
dp3_pp r0.w, v1, r1
dp3_pp r1.y, r3, r2
max_pp r1.x, r0.w, c5.z
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r1.x, r4
mul r1.x, r1.w, r2.w
rcp r1.y, r1.y
mul r1.z, r1.w, r0.w
mul r0.w, r1.x, r1.y
mul r1.x, r0.w, c5
mul r1.y, r1, r1.z
mul r1.y, r1, c5.x
texld r0.w, v3, s2
min_sat r1.x, r1, r1.y
mul r0.w, r1.x, r0
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 90 ALU, 5 TEX
PARAM c[9] = { program.local[0..5],
		{ 0, 2, 1, 0.5 },
		{ 2.718282, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[6].y, -c[6].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[6];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MOV R5.xyz, c[1];
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R3.xyz, R0.y, fragment.texcoord[2];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[6];
MAD R0.y, R0.x, c[7].z, c[7].w;
MAD R0.y, R0, R0.x, -c[8].x;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[8].y;
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[6];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[6], R0;
MAD R0.x, R0, c[7].y, R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[5].x;
MUL R0.z, c[5].x, c[5].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[5].x;
MUL R0.z, R0, c[8];
ADD R0.w, -R1, c[6].z;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[6].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[7].x, -R0.x;
MOV R0.x, c[6].z;
ADD R2.w, R0.x, -c[4].x;
POW R0.x, R0.w, c[8].w;
MAD R0.w, R0.x, c[4].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[3];
DP3 R2.w, R3, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R5.xyz, R5, c[0];
MUL R5.xyz, R5, R0.w;
DP3 R0.w, R2, R1;
MUL R1.y, R1.w, R0.w;
MAX R1.x, R0.w, c[6];
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R5;
DP3 R1.x, R4, R3;
RCP R1.x, R1.x;
MUL R0.w, R1, R2;
MUL R0.w, R0, R1.x;
MUL R1.x, R1, R1.y;
MUL R1.y, R0.w, c[6];
MUL R1.z, R1.x, c[6].y;
TXP R1.x, fragment.texcoord[4], texture[4], 2D;
RCP R0.w, fragment.texcoord[4].w;
MAD R1.w, -fragment.texcoord[4].z, R0, R1.x;
MOV R0.w, c[6].z;
RCP R1.x, fragment.texcoord[3].w;
MAD R2.xy, fragment.texcoord[3], R1.x, c[6].w;
CMP R2.z, R1.w, c[2].x, R0.w;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R1.w, R1.x, texture[3], 2D;
SLT R1.x, c[6], fragment.texcoord[3].z;
TEX R0.w, R2, texture[2], 2D;
MUL R0.w, R1.x, R0;
MUL R0.w, R0, R1;
MUL R1.x, R0.w, R2.z;
MIN_SAT R0.w, R1.y, R1.z;
MUL R0.w, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[6].y;
MOV result.color.w, c[6].x;
END
# 90 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 100 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c6, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c7, 0.50000000, -0.01872930, 0.07426100, -0.21211439
def c8, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c9, 6.28318501, -3.14159298, 2.71828198, 3.14159274
def c10, 5.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c6.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c0
mul_pp r2.xyz, r0.x, v1
mul_pp r3.xyz, r0.y, v2
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c6.w
mad r0.y, r0.x, c7, c7.z
mad r0.y, r0, r0.x, c7.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c8
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c6.z, c6.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c6.x, r0
mad r0.x, r0, c8.y, r0.y
mad r0.x, r0, c8.z, c8.w
frc r0.x, r0
mad r2.w, r0.x, c9.x, c9.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c5
mul r0.x, r0, c5
rcp r0.y, r0.x
add r0.x, -r2.w, c6.w
mul r3.w, r0.x, r0.y
pow r0, c9.z, -r3.w
mul r4.w, c5.x, c5.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c9.w
rcp r3.w, r0.x
add r4.w, -r1, c6
pow r0, r4.w, c10.x
mov_pp r0.y, c4.x
add_pp r0.y, c6.w, -r0
mad r0.y, r0.x, c4.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul_pp r0.xyz, r0, c3
mul_pp r0.xyz, r0, c0
dp3_pp r2.w, r3, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c1, r5
mul r5.xyz, r5, r0.w
dp3_pp r0.w, r2, r1
max_pp r1.x, r0.w, c6.z
mad r1.xyz, r0, r1.x, r5
mul r0.z, r1.w, r0.w
dp3_pp r0.x, r4, r3
rcp r0.y, r0.x
mul r0.x, r1.w, r2.w
mul r0.z, r0.y, r0
mul r0.x, r0, r0.y
mul r0.y, r0.x, c6.x
mul r0.z, r0, c6.x
texldp r0.x, v4, s4
rcp r0.w, v4.w
mad r0.w, -v4.z, r0, r0.x
mov r1.w, c2.x
cmp r2.z, r0.w, c6.w, r1.w
rcp r0.x, v3.w
mad r2.xy, v3, r0.x, c7.x
dp3 r0.x, v3, v3
texld r0.w, r2, s2
cmp r1.w, -v3.z, c6.z, c6
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s3
mul_pp r0.x, r0.w, r0
mul_pp r0.w, r0.x, r2.z
min_sat r0.x, r0.y, r0.z
mul r0.x, r0, r0.w
mul r0.xyz, r0.x, r1
mul oC0.xyz, r0, c6.x
mov_pp oC0.w, c6.z
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_NATIVE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_Color]
Float 4 [_Shininess]
Float 5 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 99 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c6, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c7, 0.50000000, -0.01872930, 0.07426100, -0.21211439
def c8, 1.57072902, 3.14159298, 0.15915491, 0.50000000
def c9, 6.28318501, -3.14159298, 2.71828198, 3.14159274
def c10, 5.00000000, 0, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c6.x, c6.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c6.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c0
mul_pp r2.xyz, r0.x, v1
mul_pp r3.xyz, r0.y, v2
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c6.w
mad r0.y, r0.x, c7, c7.z
mad r0.y, r0, r0.x, c7.w
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c8
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c6.z, c6.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c6.x, r0
mad r0.x, r0, c8.y, r0.y
mad r0.x, r0, c8.z, c8.w
frc r0.x, r0
mad r2.w, r0.x, c9.x, c9.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c5
mul r0.x, r0, c5
rcp r0.y, r0.x
add r0.x, -r2.w, c6.w
mul r3.w, r0.x, r0.y
pow r0, c9.z, -r3.w
mul r4.w, c5.x, c5.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c9.w
rcp r3.w, r0.x
add r4.w, -r1, c6
pow r0, r4.w, c10.x
mov_pp r0.y, c4.x
add_pp r0.y, c6.w, -r0
mad r0.y, r0.x, c4.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul_pp r0.xyz, r0, c3
mul_pp r0.xyz, r0, c0
dp3_pp r2.w, r3, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c1, r5
mul r5.xyz, r5, r0.w
dp3_pp r0.w, r2, r1
max_pp r1.x, r0.w, c6.z
mad r1.xyz, r0, r1.x, r5
mul r0.z, r1.w, r0.w
dp3_pp r0.x, r4, r3
rcp r0.y, r0.x
mul r0.x, r1.w, r2.w
mul r0.z, r0.y, r0
mul r0.x, r0, r0.y
mul r0.y, r0.x, c6.x
mov r0.x, c2
add r1.w, c6, -r0.x
rcp r0.w, v3.w
texldp r0.x, v4, s4
mad r2.z, r0.x, r1.w, c2.x
mad r2.xy, v3, r0.w, c7.x
dp3 r0.x, v3, v3
mul r0.z, r0, c6.x
texld r0.w, r2, s2
cmp r1.w, -v3.z, c6.z, c6
mul_pp r0.w, r1, r0
texld r0.x, r0.x, s3
mul_pp r0.x, r0.w, r0
mul_pp r0.w, r0.x, r2.z
min_sat r0.x, r0.y, r0.z
mul r0.x, r0, r0.w
mul r0.xyz, r0.x, r1
mul oC0.xyz, r0, c6.x
mov_pp oC0.w, c6.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 74 ALU, 3 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.y, R1, R1;
MAD R0.w, -R1.x, R1.x, -R0.y;
ADD R1.z, R0.w, c[5];
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[2];
ADD R0.xyz, fragment.texcoord[1], R2;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
RSQ R1.z, R1.z;
MOV R4.xyz, c[1];
MUL R3.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R3, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
ADD R0.w, -R1, c[5].z;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
DP3 R2.w, R2, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R4.xyz, R4, c[0];
MUL R4.xyz, R4, R0.w;
DP3 R0.w, fragment.texcoord[1], R1;
DP3 R1.y, R3, R2;
MAX R1.x, R0.w, c[5];
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R4;
RCP R1.y, R1.y;
MUL R1.x, R1.w, R2.w;
MUL R1.z, R1.w, R0.w;
MUL R0.w, R1.x, R1.y;
MUL R1.x, R1.y, R1.z;
MUL R1.y, R1.x, c[5];
MUL R0.w, R0, c[5].y;
TXP R1.x, fragment.texcoord[3], texture[2], 2D;
MIN_SAT R0.w, R0, R1.y;
MUL R0.w, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 74 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
"ps_3_0
; 86 ALU, 3 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.y, r1, r1
mad_pp r0.w, -r1.x, r1.x, -r0.y
add_pp r1.z, r0.w, c5.w
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
add_pp r0.xyz, v1, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.x, c4, c4
mul r0.y, r2.w, r4.x
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.z
rcp r3.w, r0.x
add r4.x, -r1.w, c5.w
pow r0, r4.x, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mov_pp r4.xyz, c0
mul_pp r0.xyz, r0, c2
dp3_pp r2.w, r2, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r4.xyz, c1, r4
mul r4.xyz, r4, r0.w
dp3_pp r0.w, v1, r1
dp3_pp r1.y, r3, r2
max_pp r1.x, r0.w, c5.z
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r1.x, r4
rcp r1.y, r1.y
mul r1.x, r1.w, r2.w
mul r1.z, r1.w, r0.w
mul r0.w, r1.x, r1.y
mul r1.x, r1.y, r1.z
mul r1.y, r1.x, c5.x
mul r0.w, r0, c5.x
texldp r1.x, v3, s2
min_sat r0.w, r0, r1.y
mul r0.w, r0, r1.x
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 76 ALU, 4 TEX
PARAM c[8] = { program.local[0..4],
		{ 0, 2, 1, 2.718282 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[5].y, -c[5].z;
MUL R0.y, R1, R1;
MAD R0.w, -R1.x, R1.x, -R0.y;
ADD R1.z, R0.w, c[5];
DP3 R0.x, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.x, R0.x;
MUL R2.xyz, R0.x, fragment.texcoord[2];
ADD R0.xyz, fragment.texcoord[1], R2;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
RSQ R1.z, R1.z;
MOV R4.xyz, c[1];
MUL R3.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R3, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[5];
MAD R0.y, R0.x, c[6], c[6].z;
MAD R0.y, R0, R0.x, -c[6].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[7];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[5];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[5], R0;
MAD R0.x, R0, c[6], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[4].x;
MUL R0.z, c[4].x, c[4].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[4].x;
MUL R0.z, R0, c[7].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[5].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[5].w, -R0.x;
MOV R0.x, c[5].z;
ADD R2.w, R0.x, -c[3].x;
ADD R0.w, -R1, c[5].z;
POW R0.x, R0.w, c[7].z;
MAD R0.w, R0.x, c[3].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[2];
DP3 R2.w, R2, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R4.xyz, R4, c[0];
MUL R4.xyz, R4, R0.w;
DP3 R0.w, fragment.texcoord[1], R1;
DP3 R1.y, R3, R2;
MAX R1.x, R0.w, c[5];
MUL R0.xyz, R0, c[0];
MAD R0.xyz, R0, R1.x, R4;
RCP R1.y, R1.y;
MUL R1.z, R1.w, R0.w;
MUL R1.x, R1.w, R2.w;
MUL R0.w, R1.x, R1.y;
MUL R1.x, R1.y, R1.z;
MUL R1.y, R0.w, c[5];
MUL R1.z, R1.x, c[5].y;
TEX R0.w, fragment.texcoord[3], texture[3], 2D;
TXP R1.x, fragment.texcoord[4], texture[2], 2D;
MUL R1.x, R0.w, R1;
MIN_SAT R0.w, R1.y, R1.z;
MUL R0.w, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[5].y;
MOV result.color.w, c[5].x;
END
# 76 instructions, 5 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "DIRECTIONAL_COOKIE" "SHADOWS_SCREEN" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_Color]
Float 3 [_Shininess]
Float 4 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] 2D
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 87 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
def c5, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c6, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c7, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c8, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xy
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c5.x, c5.y
mul_pp r0.y, r1, r1
mad_pp r0.w, -r1.x, r1.x, -r0.y
add_pp r1.z, r0.w, c5.w
dp3_pp r0.x, v2, v2
rsq_pp r0.x, r0.x
mul_pp r2.xyz, r0.x, v2
add_pp r0.xyz, v1, r2
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r3, r1
abs r0.x, r1.w
add r0.z, -r0.x, c5.w
mad r0.y, r0.x, c6.x, c6
mad r0.y, r0, r0.x, c6.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c6.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c5.z, c5.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c5.x, r0
mad r0.x, r0, c7, r0.y
mad r0.x, r0, c7.y, c7.z
frc r0.x, r0
mad r2.w, r0.x, c8.x, c8.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c4
mul r0.x, r0, c4
rcp r0.y, r0.x
add r0.x, -r2.w, c5.w
mul r3.w, r0.x, r0.y
pow r0, c7.w, -r3.w
mul r4.x, c4, c4
mul r0.y, r2.w, r4.x
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c8.z
rcp r3.w, r0.x
add r4.x, -r1.w, c5.w
pow r0, r4.x, c8.w
mov_pp r0.y, c3.x
add_pp r0.y, c5.w, -r0
mad r0.y, r0.x, c3.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mov_pp r4.xyz, c0
mul_pp r0.xyz, r0, c2
dp3_pp r2.w, r2, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r4.xyz, c1, r4
mul r4.xyz, r4, r0.w
dp3_pp r0.w, v1, r1
dp3_pp r1.y, r3, r2
max_pp r1.x, r0.w, c5.z
mul_pp r0.xyz, r0, c0
mad r0.xyz, r0, r1.x, r4
rcp r1.y, r1.y
mul r1.z, r1.w, r0.w
mul r1.x, r1.w, r2.w
mul r0.w, r1.x, r1.y
mul r1.x, r1.y, r1.z
mul r1.y, r0.w, c5.x
mul r1.z, r1.x, c5.x
texld r0.w, v3, s3
texldp r1.x, v4, s2
mul r1.x, r0.w, r1
min_sat r0.w, r1.y, r1.z
mul r0.w, r0, r1.x
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c5.x
mov_pp oC0.w, c5.z
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 88 ALU, 4 TEX
PARAM c[11] = { program.local[0..6],
		{ 0, 2, 1, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 2.718282, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[7];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MOV R5.xyz, c[2];
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RCP R1.z, R1.z;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[7];
MAD R0.y, R0.x, c[9].z, c[9].w;
MAD R0.y, R0, R0.x, -c[10].x;
RSQ R0.z, R0.z;
DP3 R2.x, R2, R1;
MAD R0.x, R0.y, R0, c[10].y;
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[7];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[7], R0;
MAD R0.x, R0, c[9].y, R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[6].x;
MUL R0.z, c[6].x, c[6].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[6].x;
MUL R0.z, R0, c[10];
ADD R0.w, -R1, c[7].z;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[7].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[9].x, -R0.x;
MOV R0.x, c[7].z;
ADD R2.w, R0.x, -c[5].x;
POW R0.x, R0.w, c[10].w;
MAD R0.w, R0.x, c[5].x, R2;
DP3 R2.w, R3, R1;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL R0.xyz, R0, c[4];
MUL R0.xyz, R0, c[1];
MUL_SAT R0.w, R0, R3;
MUL R5.xyz, R5, c[1];
MUL R5.xyz, R5, R0.w;
MAX R1.x, R2, c[7];
MAD R1.xyz, R0, R1.x, R5;
DP3 R0.w, R4, R3;
RCP R0.y, R0.w;
MUL R0.x, R1.w, R2.w;
MUL R0.x, R0, R0.y;
MUL R0.z, R1.w, R2.x;
MUL R1.w, R0.x, c[7].y;
MUL R0.x, R0.y, R0.z;
DP3 R0.y, fragment.texcoord[4], fragment.texcoord[4];
RSQ R2.y, R0.y;
MUL R2.x, R0, c[7].y;
TEX R0, fragment.texcoord[4], texture[2], CUBE;
DP4 R0.y, R0, c[8];
RCP R2.y, R2.y;
MUL R0.x, R2.y, c[0].w;
MAD R0.z, -R0.x, c[7].w, R0.y;
DP3 R0.y, fragment.texcoord[3], fragment.texcoord[3];
MOV R0.x, c[7].z;
CMP R0.x, R0.z, c[3], R0;
TEX R0.w, R0.y, texture[3], 2D;
MUL R0.y, R0.w, R0.x;
MIN_SAT R0.x, R1.w, R2;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[7].y;
MOV result.color.w, c[7].x;
END
# 88 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 99 ALU, 4 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c7, 2.00000000, -1.00000000, 0.97000003, 0.00000000
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c10, -0.21211439, 1.57072902, 3.14159298, 2.71828198
def c11, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c12, 3.14159274, 5.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c8.x
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c1
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rcp_pp r1.z, r1.z
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c8.x
mad r0.y, r0.x, c9.z, c9.w
mad r0.y, r0, r0.x, c10.x
rsq r0.z, r0.z
dp3_pp r2.x, r2, r1
mad r0.x, r0.y, r0, c10.y
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c9, c9.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c7.x, r0
mad r0.x, r0, c10.z, r0.y
mad r0.x, r0, c11, c11.y
frc r0.x, r0
mad r2.w, r0.x, c11.z, c11
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c6
mul r0.x, r0, c6
rcp r0.y, r0.x
add r0.x, -r2.w, c8
mul r3.w, r0.x, r0.y
pow r0, c10.w, -r3.w
mul r4.w, c6.x, c6.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c12
rcp r3.w, r0.x
add r4.w, -r1, c8.x
pow r0, r4.w, c12.y
mov_pp r0.y, c5.x
add_pp r0.y, c8.x, -r0
mad r0.y, r0.x, c5.x, r0
mul r0.x, r2.w, r3.w
dp3_pp r2.w, r3, r1
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_pp r0.xyz, r0, c4
mul_pp r0.xyz, r0, c1
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c2, r5
mul r5.xyz, r5, r0.w
max_pp r1.x, r2, c7.w
mad r1.xyz, r0, r1.x, r5
dp3_pp r0.w, r4, r3
rcp r0.y, r0.w
mul r0.x, r1.w, r2.w
mul r0.x, r0, r0.y
mul r0.z, r1.w, r2.x
mul r1.w, r0.x, c7.x
mul r0.x, r0.y, r0.z
dp3 r0.y, v4, v4
rsq r2.y, r0.y
mul r2.x, r0, c7
texld r0, v4, s2
dp4 r0.y, r0, c8
rcp r2.y, r2.y
mul r0.x, r2.y, c0.w
mad r0.y, -r0.x, c7.z, r0
mov r0.z, c3.x
dp3 r0.x, v3, v3
cmp r0.y, r0, c8.x, r0.z
texld r0.x, r0.x, s3
mul r0.y, r0.x, r0
min_sat r0.x, r1.w, r2
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r1
mul oC0.xyz, r0, c7.x
mov_pp oC0.w, c7
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 90 ALU, 5 TEX
PARAM c[11] = { program.local[0..6],
		{ 0, 2, 1, 0.97000003 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 2.718282, 3.141593, -0.018729299, 0.074261002 },
		{ 0.21211439, 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[7];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MOV R5.xyz, c[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
MUL R3.xyz, R0.y, fragment.texcoord[2];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
RCP R1.z, R1.z;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
ADD R0.z, -R0.x, c[7];
MAD R0.y, R0.x, c[9].z, c[9].w;
MAD R0.y, R0, R0.x, -c[10].x;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[10].y;
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[7];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[7], R0;
MAD R0.x, R0, c[9].y, R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, R0.x, c[6].x;
MUL R0.z, c[6].x, c[6].x;
MUL R0.z, R0.x, R0;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[6].x;
MUL R0.z, R0, c[10];
ADD R0.w, -R1, c[7].z;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[7].z;
MUL R0.x, R0, R0.y;
POW R0.y, c[9].x, -R0.x;
MOV R0.x, c[7].z;
ADD R2.w, R0.x, -c[5].x;
POW R0.x, R0.w, c[10].w;
MAD R0.w, R0.x, c[5].x, R2;
RCP R0.z, R0.z;
MUL R0.x, R0.y, R0.z;
MUL R3.w, R0.x, R0;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.xyz, R0, c[4];
DP3 R2.w, R3, R1;
MUL R0.w, R0, R3;
RCP R3.w, R2.w;
MUL_SAT R0.w, R0, R3;
MUL R5.xyz, R5, c[1];
MUL R5.xyz, R5, R0.w;
DP3 R0.w, R2, R1;
MUL R1.y, R1.w, R0.w;
MAX R1.x, R0.w, c[7];
MUL R0.xyz, R0, c[1];
MAD R0.xyz, R0, R1.x, R5;
DP3 R1.x, R4, R3;
RCP R1.x, R1.x;
MUL R0.w, R1, R2;
MUL R0.w, R0, R1.x;
MUL R1.x, R1, R1.y;
MUL R2.x, R0.w, c[7].y;
MUL R2.y, R1.x, c[7];
TEX R1, fragment.texcoord[4], texture[2], CUBE;
DP3 R0.w, fragment.texcoord[4], fragment.texcoord[4];
DP4 R1.y, R1, c[8];
RSQ R0.w, R0.w;
RCP R1.x, R0.w;
MUL R1.x, R1, c[0].w;
MAD R1.x, -R1, c[7].w, R1.y;
MOV R0.w, c[7].z;
CMP R1.y, R1.x, c[3].x, R0.w;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R1.w, R1.x, texture[3], 2D;
TEX R0.w, fragment.texcoord[3], texture[4], CUBE;
MUL R0.w, R1, R0;
MUL R1.x, R0.w, R1.y;
MIN_SAT R0.w, R2.x, R2.y;
MUL R0.w, R0, R1.x;
MUL R0.xyz, R0.w, R0;
MUL result.color.xyz, R0, c[7].y;
MOV result.color.w, c[7].x;
END
# 90 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 100 ALU, 5 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_cube s4
def c7, 2.00000000, -1.00000000, 0.97000003, 0.00000000
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 0.00000000, 1.00000000, -0.01872930, 0.07426100
def c10, -0.21211439, 1.57072902, 3.14159298, 2.71828198
def c11, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c12, 3.14159274, 5.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c8.x
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mov_pp r5.xyz, c1
mul_pp r2.xyz, r0.x, v1
mul_pp r3.xyz, r0.y, v2
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c8.x
mad r0.y, r0.x, c9.z, c9.w
mad r0.y, r0, r0.x, c10.x
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c10.y
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c9, c9.y
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c7.x, r0
mad r0.x, r0, c10.z, r0.y
mad r0.x, r0, c11, c11.y
frc r0.x, r0
mad r2.w, r0.x, c11.z, c11
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c6
mul r0.x, r0, c6
rcp r0.y, r0.x
add r0.x, -r2.w, c8
mul r3.w, r0.x, r0.y
pow r0, c10.w, -r3.w
mul r4.w, c6.x, c6.x
mul r0.y, r2.w, r4.w
mul r0.y, r2.w, r0
mov r2.w, r0.x
mul r0.x, r0.y, c12
rcp r3.w, r0.x
add r4.w, -r1, c8.x
pow r0, r4.w, c12.y
mov_pp r0.y, c5.x
add_pp r0.y, c8.x, -r0
mad r0.y, r0.x, c5.x, r0
mul r0.x, r2.w, r3.w
mul r3.w, r0.x, r0.y
texld r0, v0, s0
mul_pp r0.xyz, r0, c4
dp3_pp r2.w, r3, r1
mul r0.w, r0, r3
rcp r3.w, r2.w
mul_sat r0.w, r0, r3
mul_pp r5.xyz, c2, r5
mul r5.xyz, r5, r0.w
dp3_pp r0.w, r2, r1
mul r1.y, r1.w, r0.w
max_pp r1.x, r0.w, c7.w
mul_pp r0.xyz, r0, c1
mad r0.xyz, r0, r1.x, r5
dp3_pp r1.x, r4, r3
rcp r1.x, r1.x
mul r0.w, r1, r2
mul r0.w, r0, r1.x
mul r1.x, r1, r1.y
mul r2.x, r0.w, c7
mul r2.y, r1.x, c7.x
texld r1, v4, s2
dp4 r1.x, r1, c8
dp3 r0.w, v4, v4
rsq r0.w, r0.w
rcp r0.w, r0.w
mul r0.w, r0, c0
mad r0.w, -r0, c7.z, r1.x
mov r1.y, c3.x
cmp r1.y, r0.w, c8.x, r1
dp3 r1.x, v3, v3
texld r1.x, r1.x, s3
texld r0.w, v3, s4
mul r0.w, r1.x, r0
mul r1.x, r0.w, r1.y
min_sat r0.w, r2.x, r2.y
mul r0.w, r0, r1.x
mul r0.xyz, r0.w, r0
mul oC0.xyz, r0, c7.x
mov_pp oC0.w, c7
"
}
SubProgram "opengl " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 102 ALU, 8 TEX
PARAM c[14] = { program.local[0..9],
		{ 0, 2, 1, 0.5 },
		{ 0.25, 2.718282, 3.141593, -0.018729299 },
		{ 0.074261002, 0.21211439, 1.570729, 3.1415927 },
		{ 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[10].y, -c[10].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[10];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
RCP R1.z, R1.z;
DP3 R0.w, R0, R0;
DP3 R2.w, R3, R1;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
DP3 R2.y, R2, R1;
MUL R0.y, R0.x, c[11].w;
ADD R0.z, -R0.x, c[10];
RCP R4.w, R2.w;
ADD R0.y, R0, c[12].x;
MAD R0.y, R0, R0.x, -c[12];
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[12].z;
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[10];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[10], R0;
MAD R0.x, R0, c[11].z, R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, c[9].x, c[9].x;
MUL R0.z, R0.x, R0.y;
MUL R0.y, R0.x, c[9].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[9].x;
MUL R0.z, R0, c[12].w;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[10].z;
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
POW R0.x, c[11].y, -R0.x;
MUL R0.y, R0.x, R0;
MOV R0.x, c[10].z;
ADD R0.z, -R1.w, c[10];
ADD R0.w, R0.x, -c[8].x;
POW R0.x, R0.z, c[13].x;
MAD R0.x, R0, c[8], R0.w;
MUL R3.w, R0.y, R0.x;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, R3;
MUL R0.xyz, R0, c[7];
MUL R0.xyz, R0, c[0];
MUL_SAT R0.w, R0, R4;
DP3 R3.w, R4, R3;
MOV R5.xyz, c[1];
MUL R3.xyz, R5, c[0];
MUL R3.xyz, R3, R0.w;
MAX R1.x, R2.y, c[10];
MAD R1.xyz, R0, R1.x, R3;
RCP R0.w, R3.w;
MUL R0.x, R1.w, R2.y;
MUL R2.w, R1, R2;
MUL R2.w, R2, R0;
MUL R0.x, R0.w, R0;
RCP R1.w, fragment.texcoord[4].w;
MUL R2.x, R2.w, c[10].y;
MAD R0.zw, fragment.texcoord[4].xyxy, R1.w, c[6].xyxy;
MUL R2.y, R0.x, c[10];
TEX R0.x, R0.zwzw, texture[4], 2D;
MAD R2.zw, fragment.texcoord[4].xyxy, R1.w, c[5].xyxy;
MOV R0.w, R0.x;
TEX R0.x, R2.zwzw, texture[4], 2D;
MAD R2.zw, fragment.texcoord[4].xyxy, R1.w, c[4].xyxy;
MOV R0.z, R0.x;
TEX R0.x, R2.zwzw, texture[4], 2D;
MAD R2.zw, fragment.texcoord[4].xyxy, R1.w, c[3].xyxy;
MOV R0.y, R0.x;
TEX R0.x, R2.zwzw, texture[4], 2D;
MAD R0, -fragment.texcoord[4].z, R1.w, R0;
MOV R2.z, c[10];
CMP R0, R0, c[2].x, R2.z;
DP4 R2.z, R0, c[11].x;
RCP R1.w, fragment.texcoord[3].w;
MAD R0.xy, fragment.texcoord[3], R1.w, c[10].w;
TEX R0.w, R0, texture[2], 2D;
DP3 R0.z, fragment.texcoord[3], fragment.texcoord[3];
SLT R0.x, c[10], fragment.texcoord[3].z;
TEX R1.w, R0.z, texture[3], 2D;
MUL R0.x, R0, R0.w;
MUL R0.x, R0, R1.w;
MUL R0.y, R0.x, R2.z;
MIN_SAT R0.x, R2, R2.y;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R1;
MUL result.color.xyz, R0, c[10].y;
MOV result.color.w, c[10].x;
END
# 102 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c10, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c11, 0.50000000, 0.25000000, -0.01872930, 0.07426100
def c12, -0.21211439, 1.57072902, 3.14159298, 2.71828198
def c13, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c14, 3.14159274, 5.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c10.x, c10.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c10.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rcp_pp r1.z, r1.z
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c10.w
mad r0.y, r0.x, c11.z, c11.w
mad r0.y, r0, r0.x, c12.x
rsq r0.z, r0.z
dp3_pp r2.x, r2, r1
mad r0.x, r0.y, r0, c12.y
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c10.z, c10.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c10.x, r0
mad r0.x, r0, c12.z, r0.y
mad r0.x, r0, c13, c13.y
frc r0.x, r0
mad r2.w, r0.x, c13.z, c13
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c9
mul r0.y, r0.x, c9.x
mul r0.z, c9.x, c9.x
mul r4.w, r2, r0.z
add r0.x, -r2.w, c10.w
rcp r0.y, r0.y
mul r3.w, r0.x, r0.y
pow r0, c12.w, -r3.w
mul r0.y, r2.w, r4.w
mov r0.z, r0.x
mul r0.y, r0, c14.x
rcp r0.x, r0.y
add r2.w, -r1, c10
mul r3.w, r0.z, r0.x
pow r0, r2.w, c14.y
dp3_pp r2.w, r3, r1
mov_pp r0.y, c8.x
add_pp r0.y, c10.w, -r0
mad r0.x, r0, c8, r0.y
mul r3.w, r3, r0.x
texld r0, v0, s0
mul r0.w, r0, r3
rcp r4.w, r2.w
mul_pp r0.xyz, r0, c7
mul_pp r0.xyz, r0, c0
mul_sat r0.w, r0, r4
dp3_pp r3.w, r4, r3
mov_pp r5.xyz, c0
mul_pp r3.xyz, c1, r5
mul r3.xyz, r3, r0.w
max_pp r1.x, r2, c10.z
mad r1.xyz, r0, r1.x, r3
mul r0.x, r1.w, r2
rcp r0.w, r3.w
mul r2.w, r1, r2
mul r2.w, r2, r0
mul r0.z, r0.w, r0.x
mul r2.z, r2.w, c10.x
rcp r2.w, v4.w
mad r0.xy, v4, r2.w, c6
texld r0.x, r0, s4
mul r1.w, r0.z, c10.x
mad r2.xy, v4, r2.w, c5
mov r0.w, r0.x
texld r0.x, r2, s4
mad r2.xy, v4, r2.w, c4
mov r0.z, r0.x
texld r0.x, r2, s4
mad r2.xy, v4, r2.w, c3
mov r0.y, r0.x
texld r0.x, r2, s4
mov r2.x, c2
mad r0, -v4.z, r2.w, r0
cmp r0, r0, c10.w, r2.x
dp4_pp r0.z, r0, c11.y
rcp r2.x, v3.w
mad r2.xy, v3, r2.x, c11.x
dp3 r0.x, v3, v3
texld r0.w, r2, s2
cmp r0.y, -v3.z, c10.z, c10.w
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.y, r0
mul_pp r0.y, r0.x, r0.z
min_sat r0.x, r2.z, r1.w
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r1
mul oC0.xyz, r0, c10.x
mov_pp oC0.w, c10.z
"
}
SubProgram "d3d9 " {
Keywords { "SPOT" "SHADOWS_DEPTH" "SHADOWS_SOFT" "SHADOWS_NATIVE" }
Vector 0 [_LightColor0]
Vector 1 [_SpecColor]
Vector 2 [_LightShadowData]
Vector 3 [_ShadowOffsets0]
Vector 4 [_ShadowOffsets1]
Vector 5 [_ShadowOffsets2]
Vector 6 [_ShadowOffsets3]
Vector 7 [_Color]
Float 8 [_Shininess]
Float 9 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_LightTexture0] 2D
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_ShadowMapTexture] 2D
"ps_3_0
; 108 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_2d s2
dcl_2d s3
dcl_2d s4
def c10, 2.00000000, -1.00000000, 0.00000000, 1.00000000
def c11, 0.50000000, 0.25000000, -0.01872930, 0.07426100
def c12, -0.21211439, 1.57072902, 3.14159298, 2.71828198
def c13, 0.15915491, 0.50000000, 6.28318501, -3.14159298
def c14, 3.14159274, 5.00000000, 0, 0
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3
dcl_texcoord4 v4
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c10.x, c10.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c10.w
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c10.w
mad r0.y, r0.x, c11.z, c11.w
mad r0.y, r0, r0.x, c12.x
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c12.y
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c10.z, c10.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c10.x, r0
mad r0.x, r0, c12.z, r0.y
mad r0.x, r0, c13, c13.y
frc r0.x, r0
mad r2.w, r0.x, c13.z, c13
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c9
mul r0.y, r0.x, c9.x
mul r0.z, c9.x, c9.x
mul r4.w, r2, r0.z
add r0.x, -r2.w, c10.w
rcp r0.y, r0.y
mul r3.w, r0.x, r0.y
pow r0, c12.w, -r3.w
mul r0.y, r2.w, r4.w
mov r0.z, r0.x
mul r0.y, r0, c14.x
rcp r0.x, r0.y
add r2.w, -r1, c10
mul r3.w, r0.z, r0.x
pow r0, r2.w, c14.y
dp3_pp r2.w, r3, r1
dp3_pp r1.x, r2, r1
max_pp r1.y, r1.x, c10.z
mov_pp r0.y, c8.x
add_pp r0.y, c10.w, -r0
mad r0.x, r0, c8, r0.y
mul r3.w, r3, r0.x
texld r0, v0, s0
mul r0.w, r0, r3
rcp r4.w, r2.w
mul_pp r0.xyz, r0, c7
mul r1.x, r1.w, r1
mul_sat r0.w, r0, r4
dp3_pp r3.w, r4, r3
mov_pp r5.xyz, c0
mul_pp r3.xyz, c1, r5
mul r3.xyz, r3, r0.w
mul_pp r0.xyz, r0, c0
mad r2.xyz, r0, r1.y, r3
rcp r3.x, v4.w
mad r0.xyz, v4, r3.x, c6
rcp r0.w, r3.w
mul r2.w, r1, r2
mul r2.w, r2, r0
mul r0.w, r0, r1.x
mad r1.xyz, v4, r3.x, c4
texld r0.x, r0, s4
mul r1.w, r0, c10.x
mov_pp r0.w, r0.x
mad r0.xyz, v4, r3.x, c5
texld r0.x, r0, s4
texld r1.x, r1, s4
mov_pp r0.z, r0.x
mov_pp r0.y, r1.x
mad r1.xyz, v4, r3.x, c3
mov r0.x, c2
add r3.x, c10.w, -r0
texld r0.x, r1, s4
mad r0, r0, r3.x, c2.x
dp4_pp r0.z, r0, c11.y
rcp r1.x, v3.w
mad r1.xy, v3, r1.x, c11.x
dp3 r0.x, v3, v3
mul r2.w, r2, c10.x
texld r0.w, r1, s2
cmp r0.y, -v3.z, c10.z, c10.w
mul_pp r0.y, r0, r0.w
texld r0.x, r0.x, s3
mul_pp r0.x, r0.y, r0
mul_pp r0.y, r0.x, r0.z
min_sat r0.x, r2.w, r1.w
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r2
mul oC0.xyz, r0, c10.x
mov_pp oC0.w, c10.z
"
}
SubProgram "opengl " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 99 ALU, 7 TEX
PARAM c[12] = { program.local[0..6],
		{ 0, 2, 1, 0.97000003 },
		{ 0.0078125, -0.0078125, 0.25, 2.718282 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[7];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RCP R1.z, R1.z;
DP3 R2.w, R3, R1;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
DP3 R1.x, R2, R1;
ADD R0.z, -R0.x, c[7];
MAD R0.y, R0.x, c[10], c[10].z;
MAD R0.y, R0, R0.x, -c[10].w;
RCP R4.w, R2.w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[11];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[7];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[7], R0;
MAD R0.x, R0, c[10], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, c[6].x, c[6].x;
MUL R0.z, R0.x, R0.y;
MUL R0.y, R0.x, c[6].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[6].x;
MAX R1.y, R1.x, c[7].x;
MUL R0.z, R0, c[11].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[7].z;
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
POW R0.x, c[8].w, -R0.x;
MUL R0.y, R0.x, R0;
MOV R0.x, c[7].z;
ADD R0.z, -R1.w, c[7];
ADD R0.w, R0.x, -c[5].x;
POW R0.x, R0.z, c[11].z;
MAD R0.x, R0, c[5], R0.w;
MUL R3.w, R0.y, R0.x;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, R3;
MUL R0.xyz, R0, c[4];
DP3 R3.w, R4, R3;
MOV R5.xyz, c[2];
MUL R0.xyz, R0, c[1];
MUL_SAT R0.w, R0, R4;
MUL R3.xyz, R5, c[1];
MUL R3.xyz, R3, R0.w;
MAD R2.xyz, R0, R1.y, R3;
RCP R0.w, R3.w;
MUL R0.x, R1.w, R1;
MUL R1.x, R0.w, R0;
MUL R2.w, R1, R2;
MUL R2.w, R2, R0;
ADD R3.xyz, fragment.texcoord[4], c[8].xyyw;
TEX R0, R3, texture[2], CUBE;
DP4 R3.w, R0, c[9];
MUL R4.x, R1, c[7].y;
ADD R0.xyz, fragment.texcoord[4], c[8].yxyw;
TEX R0, R0, texture[2], CUBE;
DP4 R3.z, R0, c[9];
ADD R1.xyz, fragment.texcoord[4], c[8].yyxw;
TEX R1, R1, texture[2], CUBE;
DP4 R3.y, R1, c[9];
ADD R0.xyz, fragment.texcoord[4], c[8].x;
TEX R0, R0, texture[2], CUBE;
DP3 R1.x, fragment.texcoord[4], fragment.texcoord[4];
RSQ R1.x, R1.x;
DP4 R3.x, R0, c[9];
RCP R0.x, R1.x;
MUL R0.x, R0, c[0].w;
MOV R1.x, c[7].z;
MAD R0, -R0.x, c[7].w, R3;
CMP R0, R0, c[3].x, R1.x;
DP4 R0.x, R0, c[8].z;
DP3 R1.x, fragment.texcoord[3], fragment.texcoord[3];
TEX R0.w, R1.x, texture[3], 2D;
MUL R0.y, R0.w, R0.x;
MUL R2.w, R2, c[7].y;
MIN_SAT R0.x, R2.w, R4;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R2;
MUL result.color.xyz, R0, c[7].y;
MOV result.color.w, c[7].x;
END
# 99 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTexture0] 2D
"ps_3_0
; 107 ALU, 7 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
def c7, 2.00000000, -1.00000000, 0.00781250, -0.00781250
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 0.97000003, 0.25000000, 0.00000000, 1.00000000
def c10, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c11, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c12, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c8.x
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c8.x
mad r0.y, r0.x, c10.x, c10
mad r0.y, r0, r0.x, c10.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c10.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c9.z, c9.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c7.x, r0
mad r0.x, r0, c11, r0.y
mad r0.x, r0, c11.y, c11.z
frc r0.x, r0
mad r2.w, r0.x, c12.x, c12.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c6
mul r0.y, r0.x, c6.x
mul r0.z, c6.x, c6.x
mul r4.w, r2, r0.z
add r0.x, -r2.w, c8
rcp r0.y, r0.y
mul r3.w, r0.x, r0.y
pow r0, c11.w, -r3.w
mul r0.y, r2.w, r4.w
mov r0.z, r0.x
mul r0.y, r0, c12.z
rcp r0.x, r0.y
add r2.w, -r1, c8.x
mul r3.w, r0.z, r0.x
pow r0, r2.w, c12.w
dp3_pp r2.w, r3, r1
dp3_pp r1.x, r2, r1
max_pp r1.y, r1.x, c9.z
mov_pp r0.y, c5.x
add_pp r0.y, c8.x, -r0
mad r0.x, r0, c5, r0.y
mul r3.w, r3, r0.x
texld r0, v0, s0
mul r0.w, r0, r3
rcp r4.w, r2.w
mul_pp r0.xyz, r0, c4
dp3_pp r3.w, r4, r3
mov_pp r5.xyz, c1
mul_sat r0.w, r0, r4
mul_pp r3.xyz, c2, r5
mul r3.xyz, r3, r0.w
mul_pp r0.xyz, r0, c1
mad r2.xyz, r0, r1.y, r3
rcp r0.w, r3.w
mul r2.w, r1, r2
mul r2.w, r2, r0
mul r1.x, r1.w, r1
mul r1.x, r0.w, r1
mul r4.x, r1, c7
add r0.xyz, v4, c7.zwww
texld r0, r0, s2
dp4 r3.w, r0, c8
add r0.xyz, v4, c7.wzww
texld r0, r0, s2
dp4 r3.z, r0, c8
add r1.xyz, v4, c7.wwzw
texld r1, r1, s2
dp4 r3.y, r1, c8
add r0.xyz, v4, c7.z
texld r0, r0, s2
dp3 r1.x, v4, v4
rsq r1.x, r1.x
dp4 r3.x, r0, c8
rcp r0.x, r1.x
mul r0.x, r0, c0.w
mad r0, -r0.x, c9.x, r3
mov r1.x, c3
cmp r1, r0, c8.x, r1.x
dp3 r0.x, v3, v3
texld r0.x, r0.x, s3
dp4_pp r0.y, r1, c9.y
mul r0.y, r0.x, r0
mul r2.w, r2, c7.x
min_sat r0.x, r2.w, r4
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r2
mul oC0.xyz, r0, c7.x
mov_pp oC0.w, c9.z
"
}
SubProgram "opengl " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"3.0-!!ARBfp1.0
OPTION ARB_precision_hint_fastest;
# 101 ALU, 8 TEX
PARAM c[12] = { program.local[0..6],
		{ 0, 2, 1, 0.97000003 },
		{ 0.0078125, -0.0078125, 0.25, 2.718282 },
		{ 1, 0.0039215689, 1.53787e-005, 6.2273724e-009 },
		{ 3.141593, -0.018729299, 0.074261002, 0.21211439 },
		{ 1.570729, 3.1415927, 5 } };
TEMP R0;
TEMP R1;
TEMP R2;
TEMP R3;
TEMP R4;
TEMP R5;
TEX R0.yw, fragment.texcoord[0].zwzw, texture[1], 2D;
MAD R1.xy, R0.wyzw, c[7].y, -c[7].z;
MUL R0.x, R1.y, R1.y;
MAD R0.w, -R1.x, R1.x, -R0.x;
ADD R1.z, R0.w, c[7];
DP3 R0.y, fragment.texcoord[2], fragment.texcoord[2];
RSQ R0.y, R0.y;
DP3 R0.x, fragment.texcoord[1], fragment.texcoord[1];
RSQ R0.x, R0.x;
RSQ R1.z, R1.z;
MUL R3.xyz, R0.y, fragment.texcoord[2];
MUL R2.xyz, R0.x, fragment.texcoord[1];
ADD R0.xyz, R2, R3;
DP3 R0.w, R0, R0;
RCP R1.z, R1.z;
DP3 R2.w, R3, R1;
RSQ R0.w, R0.w;
MUL R4.xyz, R0.w, R0;
DP3 R1.w, R4, R1;
ABS R0.x, R1.w;
DP3 R1.x, R2, R1;
MAX R1.y, R1.x, c[7].x;
ADD R0.z, -R0.x, c[7];
MAD R0.y, R0.x, c[10], c[10].z;
MAD R0.y, R0, R0.x, -c[10].w;
RSQ R0.z, R0.z;
MAD R0.x, R0.y, R0, c[11];
RCP R0.z, R0.z;
MUL R0.y, R0.x, R0.z;
SLT R0.x, R1.w, c[7];
MUL R0.z, R0.x, R0.y;
MAD R0.y, -R0.z, c[7], R0;
MAD R0.x, R0, c[10], R0.y;
COS R0.x, R0.x;
MUL R0.x, R0, R0;
MUL R0.y, c[6].x, c[6].x;
MUL R0.z, R0.x, R0.y;
MUL R0.y, R0.x, c[6].x;
MUL R0.z, R0.x, R0;
MUL R0.y, R0, c[6].x;
MUL R1.x, R1.w, R1;
MUL R0.z, R0, c[11].y;
RCP R0.y, R0.y;
ADD R0.x, -R0, c[7].z;
MUL R0.x, R0, R0.y;
RCP R0.y, R0.z;
POW R0.x, c[8].w, -R0.x;
MUL R0.y, R0.x, R0;
MOV R0.x, c[7].z;
ADD R0.z, -R1.w, c[7];
ADD R0.w, R0.x, -c[5].x;
POW R0.x, R0.z, c[11].z;
MAD R0.x, R0, c[5], R0.w;
MUL R3.w, R0.y, R0.x;
TEX R0, fragment.texcoord[0], texture[0], 2D;
MUL R0.w, R0, R3;
DP3 R3.w, R4, R3;
RCP R3.w, R3.w;
RCP R4.w, R2.w;
MOV R5.xyz, c[2];
MUL R0.xyz, R0, c[4];
MUL R4.x, R3.w, R1;
MUL_SAT R0.w, R0, R4;
MUL R3.xyz, R5, c[1];
MUL R3.xyz, R3, R0.w;
MUL R0.w, R1, R2;
MUL R0.w, R0, R3;
MUL R0.xyz, R0, c[1];
MAD R2.xyz, R0, R1.y, R3;
ADD R1.xyz, fragment.texcoord[4], c[8].yyxw;
TEX R1, R1, texture[2], CUBE;
DP4 R3.y, R1, c[9];
DP3 R1.x, fragment.texcoord[4], fragment.texcoord[4];
MUL R2.w, R0, c[7].y;
ADD R0.xyz, fragment.texcoord[4], c[8].xyyw;
TEX R0, R0, texture[2], CUBE;
DP4 R3.w, R0, c[9];
ADD R0.xyz, fragment.texcoord[4], c[8].yxyw;
TEX R0, R0, texture[2], CUBE;
DP4 R3.z, R0, c[9];
ADD R0.xyz, fragment.texcoord[4], c[8].x;
TEX R0, R0, texture[2], CUBE;
RSQ R1.x, R1.x;
DP4 R3.x, R0, c[9];
RCP R0.x, R1.x;
MUL R0.x, R0, c[0].w;
MOV R1.x, c[7].z;
MAD R0, -R0.x, c[7].w, R3;
CMP R0, R0, c[3].x, R1.x;
DP4 R0.y, R0, c[8].z;
DP3 R0.x, fragment.texcoord[3], fragment.texcoord[3];
MUL R1.x, R4, c[7].y;
TEX R0.w, fragment.texcoord[3], texture[4], CUBE;
TEX R1.w, R0.x, texture[3], 2D;
MUL R0.x, R1.w, R0.w;
MUL R0.y, R0.x, R0;
MIN_SAT R0.x, R2.w, R1;
MUL R0.x, R0, R0.y;
MUL R0.xyz, R0.x, R2;
MUL result.color.xyz, R0, c[7].y;
MOV result.color.w, c[7].x;
END
# 101 instructions, 6 R-regs
"
}
SubProgram "d3d9 " {
Keywords { "POINT_COOKIE" "SHADOWS_CUBE" "SHADOWS_SOFT" }
Vector 0 [_LightPositionRange]
Vector 1 [_LightColor0]
Vector 2 [_SpecColor]
Vector 3 [_LightShadowData]
Vector 4 [_Color]
Float 5 [_Shininess]
Float 6 [_RMS]
SetTexture 0 [_MainTex] 2D
SetTexture 1 [_BumpMap] 2D
SetTexture 2 [_ShadowMapTexture] CUBE
SetTexture 3 [_LightTextureB0] 2D
SetTexture 4 [_LightTexture0] CUBE
"ps_3_0
; 108 ALU, 8 TEX
dcl_2d s0
dcl_2d s1
dcl_cube s2
dcl_2d s3
dcl_cube s4
def c7, 2.00000000, -1.00000000, 0.00781250, -0.00781250
def c8, 1.00000000, 0.00392157, 0.00001538, 0.00000001
def c9, 0.97000003, 0.25000000, 0.00000000, 1.00000000
def c10, -0.01872930, 0.07426100, -0.21211439, 1.57072902
def c11, 3.14159298, 0.15915491, 0.50000000, 2.71828198
def c12, 6.28318501, -3.14159298, 3.14159274, 5.00000000
dcl_texcoord0 v0
dcl_texcoord1 v1.xyz
dcl_texcoord2 v2.xyz
dcl_texcoord3 v3.xyz
dcl_texcoord4 v4.xyz
texld r0.yw, v0.zwzw, s1
mad_pp r1.xy, r0.wyzw, c7.x, c7.y
mul_pp r0.x, r1.y, r1.y
mad_pp r0.w, -r1.x, r1.x, -r0.x
add_pp r1.z, r0.w, c8.x
dp3_pp r0.y, v2, v2
rsq_pp r0.y, r0.y
dp3_pp r0.x, v1, v1
rsq_pp r0.x, r0.x
rsq_pp r1.z, r1.z
mul_pp r3.xyz, r0.y, v2
mul_pp r2.xyz, r0.x, v1
add_pp r0.xyz, r2, r3
dp3_pp r0.w, r0, r0
rsq_pp r0.w, r0.w
mul_pp r4.xyz, r0.w, r0
rcp_pp r1.z, r1.z
dp3 r1.w, r4, r1
abs r0.x, r1.w
add r0.z, -r0.x, c8.x
mad r0.y, r0.x, c10.x, c10
mad r0.y, r0, r0.x, c10.z
rsq r0.z, r0.z
mad r0.x, r0.y, r0, c10.w
rcp r0.z, r0.z
mul r0.y, r0.x, r0.z
cmp r0.x, r1.w, c9.z, c9.w
mul r0.z, r0.x, r0.y
mad r0.y, -r0.z, c7.x, r0
mad r0.x, r0, c11, r0.y
mad r0.x, r0, c11.y, c11.z
frc r0.x, r0
mad r2.w, r0.x, c12.x, c12.y
sincos r0.xy, r2.w
mul r2.w, r0.x, r0.x
mul r0.x, r2.w, c6
mul r0.y, r0.x, c6.x
mul r0.z, c6.x, c6.x
mul r4.w, r2, r0.z
add r0.x, -r2.w, c8
rcp r0.y, r0.y
mul r3.w, r0.x, r0.y
pow r0, c11.w, -r3.w
mul r0.y, r2.w, r4.w
mov r0.z, r0.x
mul r0.y, r0, c12.z
rcp r0.x, r0.y
add r2.w, -r1, c8.x
mul r3.w, r0.z, r0.x
pow r0, r2.w, c12.w
dp3_pp r2.w, r3, r1
dp3_pp r1.x, r2, r1
max_pp r1.y, r1.x, c9.z
mov_pp r0.y, c5.x
add_pp r0.y, c8.x, -r0
mad r0.x, r0, c5, r0.y
mul r3.w, r3, r0.x
texld r0, v0, s0
mul r0.w, r0, r3
dp3_pp r3.w, r4, r3
rcp r4.w, r2.w
mov_pp r5.xyz, c1
mul_pp r0.xyz, r0, c4
rcp r3.w, r3.w
mul r1.x, r1.w, r1
mul r4.x, r3.w, r1
mul_sat r0.w, r0, r4
mul_pp r3.xyz, c2, r5
mul r3.xyz, r3, r0.w
mul r0.w, r1, r2
mul r0.w, r0, r3
mul_pp r0.xyz, r0, c1
mad r2.xyz, r0, r1.y, r3
add r1.xyz, v4, c7.wwzw
texld r1, r1, s2
dp4 r3.y, r1, c8
dp3 r1.x, v4, v4
mul r2.w, r0, c7.x
add r0.xyz, v4, c7.zwww
texld r0, r0, s2
dp4 r3.w, r0, c8
add r0.xyz, v4, c7.wzww
texld r0, r0, s2
dp4 r3.z, r0, c8
add r0.xyz, v4, c7.z
texld r0, r0, s2
rsq r1.x, r1.x
dp4 r3.x, r0, c8
rcp r0.x, r1.x
mul r0.x, r0, c0.w
mov r1.x, c3
mad r0, -r0.x, c9.x, r3
cmp r0, r0, c8.x, r1.x
dp4_pp r0.y, r0, c9.y
dp3 r0.x, v3, v3
mul r1.x, r4, c7
texld r0.w, v3, s4
texld r0.x, r0.x, s3
mul r0.x, r0, r0.w
mul r0.y, r0.x, r0
min_sat r0.x, r2.w, r1
mul r0.x, r0, r0.y
mul r0.xyz, r0.x, r2
mul oC0.xyz, r0, c7.x
mov_pp oC0.w, c9.z
"
}
}
 }
}
Fallback "Specular"
}