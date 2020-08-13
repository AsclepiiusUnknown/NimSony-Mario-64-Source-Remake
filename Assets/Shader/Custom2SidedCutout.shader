Shader "Custom/2SidedCutout" {
	Properties {
		_Color ("Main Color", Vector) = (1,1,1,1)
		_MainTex ("Base (RGB) Trans (A)", 2D) = "white" {}
		_Cutoff ("Alpha cutoff", Range(0, 1)) = 0.5
	}
	SubShader {
		LOD 200
		Tags { "IGNOREPROJECTOR" = "true" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" "SHADOWSUPPORT" = "true" }
			ColorMask RGB -1
			Cull Off
			GpuProgramID 56585
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat10 = u_xlat1.y * u_xlat1.y;
					    u_xlat10 = u_xlat1.x * u_xlat1.x + (-u_xlat10);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat1.x = dot(unity_SHBr, u_xlat2);
					    u_xlat1.y = dot(unity_SHBg, u_xlat2);
					    u_xlat1.z = dot(unity_SHBb, u_xlat2);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat10) + u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat6 = u_xlat1.y * u_xlat1.y;
					    u_xlat6 = u_xlat1.x * u_xlat1.x + (-u_xlat6);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat2.xyz;
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat6 = u_xlat1.y * u_xlat1.y;
					    u_xlat6 = u_xlat1.x * u_xlat1.x + (-u_xlat6);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat2.xyz;
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    u_xlat1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat2.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat2.zz + u_xlat2.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_1_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat18 = u_xlat1.y * u_xlat1.y;
					    u_xlat18 = u_xlat1.x * u_xlat1.x + (-u_xlat18);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat1);
					    u_xlat3.y = dot(unity_SHAg, u_xlat1);
					    u_xlat3.z = dot(unity_SHAb, u_xlat1);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat2.xyz + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat7;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat7 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat7 = inversesqrt(u_xlat7);
					    vs_TEXCOORD1.xyz = vec3(u_xlat7) * u_xlat1.xyz;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.zw = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.zw = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
					    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
					    vs_TEXCOORD4 = exp2(u_xlat0.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
					    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
					    vs_TEXCOORD4 = exp2(u_xlat0.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_6_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
					    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
					    vs_TEXCOORD4 = exp2(u_xlat0.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD3.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_3_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat1.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.xy = u_xlat1.xy;
					    vs_TEXCOORD5.xy = u_xlat1.xy;
					    vs_TEXCOORD5.zw = vec2(0.0, 0.0);
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.zxy * u_xlat1.xyz;
					    u_xlat2.xyz = u_xlat0.yzx * u_xlat1.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat0.x;
					    vs_TEXCOORD6.x = u_xlat1.z;
					    vs_TEXCOORD7.x = u_xlat1.x;
					    vs_TEXCOORD8.x = u_xlat1.y;
					    vs_TEXCOORD7.z = u_xlat0.y;
					    vs_TEXCOORD8.z = u_xlat0.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat6 = u_xlat1.y * u_xlat1.y;
					    u_xlat6 = u_xlat1.x * u_xlat1.x + (-u_xlat6);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat2.xyz;
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat6 = u_xlat1.y * u_xlat1.y;
					    u_xlat6 = u_xlat1.x * u_xlat1.x + (-u_xlat6);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat2.xyz;
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat6 = u_xlat1.y * u_xlat1.y;
					    u_xlat6 = u_xlat1.x * u_xlat1.x + (-u_xlat6);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat2.xyz;
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[42];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_5[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    u_xlat6 = u_xlat1.y * u_xlat1.y;
					    u_xlat6 = u_xlat1.x * u_xlat1.x + (-u_xlat6);
					    u_xlat1 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD3.xyz = unity_SHC.xyz * vec3(u_xlat6) + u_xlat2.xyz;
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD6;
					out vec3 vs_TEXCOORD7;
					out vec3 vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					float u_xlat3;
					float u_xlat6;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    u_xlat1.xyz = vec3(u_xlat6) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD3.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD3.zw = vec2(0.0, 0.0);
					    u_xlat3 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat3 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat0.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat0.xyz;
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    u_xlat0.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    u_xlat2.xyz = u_xlat0.xyz * u_xlat1.zxy;
					    u_xlat2.xyz = u_xlat1.yzx * u_xlat0.yzx + (-u_xlat2.xyz);
					    u_xlat9 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat2.xyz = vec3(u_xlat9) * u_xlat2.xyz;
					    vs_TEXCOORD6.y = u_xlat2.x;
					    vs_TEXCOORD6.z = u_xlat1.x;
					    vs_TEXCOORD6.x = u_xlat0.z;
					    vs_TEXCOORD7.x = u_xlat0.x;
					    vs_TEXCOORD8.x = u_xlat0.y;
					    vs_TEXCOORD7.z = u_xlat1.y;
					    vs_TEXCOORD8.z = u_xlat1.z;
					    vs_TEXCOORD7.y = u_xlat2.y;
					    vs_TEXCOORD8.y = u_xlat2.z;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
					    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
					    vs_TEXCOORD4 = exp2(u_xlat0.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[31];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_14[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_5_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat18 = u_xlat1.z / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    vs_TEXCOORD4 = exp2(u_xlat18);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    vs_TEXCOORD1.xyz = u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat18 = u_xlat1.y * u_xlat1.y;
					    u_xlat18 = u_xlat1.x * u_xlat1.x + (-u_xlat18);
					    u_xlat2 = u_xlat1.yzzx * u_xlat1.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat3.xyz;
					    u_xlat1.w = 1.0;
					    u_xlat3.x = dot(unity_SHAr, u_xlat1);
					    u_xlat3.y = dot(unity_SHAg, u_xlat1);
					    u_xlat3.z = dot(unity_SHAb, u_xlat1);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat3 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat4 = u_xlat1.yyyy * u_xlat3;
					    u_xlat3 = u_xlat3 * u_xlat3;
					    u_xlat5 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat5 * u_xlat1.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat1.zzzz + u_xlat4;
					    u_xlat3 = u_xlat5 * u_xlat5 + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat3;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat3 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat3;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = u_xlat2.xyz + u_xlat0.xyz;
					    vs_TEXCOORD5 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD5.zw = u_xlat1.zw;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.zw = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat2;
					float u_xlat4;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD4 = u_xlat0.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat4 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat4 = inversesqrt(u_xlat4);
					    vs_TEXCOORD1.xyz = vec3(u_xlat4) * u_xlat1.xyz;
					    u_xlat2 = u_xlat0.y * _ProjectionParams.x;
					    u_xlat0.xz = u_xlat0.xw * vec2(0.5, 0.5);
					    u_xlat0.w = u_xlat2 * 0.5;
					    vs_TEXCOORD5.zw = u_xlat0.zz + u_xlat0.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" "VERTEXLIGHT_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[3];
						vec4 unity_4LightPosX0;
						vec4 unity_4LightPosY0;
						vec4 unity_4LightPosZ0;
						vec4 unity_4LightAtten0;
						vec4 unity_LightColor[8];
						vec4 unused_2_6[34];
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_11[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_5_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD4;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD6;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat5;
					float u_xlat18;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    vs_TEXCOORD4 = u_xlat1.z;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat2.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat2.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat2.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat2.xyz = vec3(u_xlat18) * u_xlat2.xyz;
					    vs_TEXCOORD1.xyz = u_xlat2.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    u_xlat3 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat4 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat5 = u_xlat2.yyyy * u_xlat4;
					    u_xlat4 = u_xlat4 * u_xlat4;
					    u_xlat4 = u_xlat3 * u_xlat3 + u_xlat4;
					    u_xlat3 = u_xlat3 * u_xlat2.xxxx + u_xlat5;
					    u_xlat3 = u_xlat0 * u_xlat2.zzzz + u_xlat3;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat4;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat4 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat3 = u_xlat3 * u_xlat4;
					    u_xlat3 = max(u_xlat3, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat3;
					    u_xlat3.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat3.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat3.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat3.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat3.xyz = u_xlat0.xyz * u_xlat3.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat18 = u_xlat2.y * u_xlat2.y;
					    u_xlat18 = u_xlat2.x * u_xlat2.x + (-u_xlat18);
					    u_xlat2 = u_xlat2.yzzx * u_xlat2.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    vs_TEXCOORD3.xyz = u_xlat0.xyz * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.x = u_xlat1.y * _ProjectionParams.x;
					    u_xlat1.xz = u_xlat1.xw * vec2(0.5, 0.5);
					    u_xlat1.w = u_xlat0.x * 0.5;
					    vs_TEXCOORD5.zw = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD6 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat18 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat19 = u_xlat19 + u_xlat19;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat19)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 5.28750038);
					    u_xlat16_18 = u_xlat10_3.w + -1.0;
					    u_xlat18 = unity_SpecCube0_HDR.w * u_xlat16_18 + 1.0;
					    u_xlat18 = u_xlat18 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat18);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat19 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat5.xyz * (-vec3(u_xlat19)) + u_xlat0.xyz;
					    u_xlat19 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat18) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 0.75;
					    u_xlat10_5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat16_0 = u_xlat10_5.x * 16.0;
					    u_xlat0.xzw = u_xlat1.xyz * vec3(u_xlat16_0);
					    u_xlat0.xzw = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xzw;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
					    u_xlat4.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat2.xyz + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat18 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat19 = u_xlat19 + u_xlat19;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat19)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 5.28750038);
					    u_xlat16_18 = u_xlat10_3.w + -1.0;
					    u_xlat18 = unity_SpecCube0_HDR.w * u_xlat16_18 + 1.0;
					    u_xlat18 = u_xlat18 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat18);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat19 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat5.xyz * (-vec3(u_xlat19)) + u_xlat0.xyz;
					    u_xlat19 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat18) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 0.75;
					    u_xlat10_5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat16_0 = u_xlat10_5.x * 16.0;
					    u_xlat0.xzw = vec3(u_xlat16_0) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat5.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat4.xyz + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_3_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_3_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat18 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat19 = u_xlat19 + u_xlat19;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat19)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 5.28750038);
					    u_xlat16_18 = u_xlat10_3.w + -1.0;
					    u_xlat18 = unity_SpecCube0_HDR.w * u_xlat16_18 + 1.0;
					    u_xlat18 = u_xlat18 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat18);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat19 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat5.xyz * (-vec3(u_xlat19)) + u_xlat0.xyz;
					    u_xlat19 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat18) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 0.75;
					    u_xlat10_5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat16_0 = u_xlat10_5.x * 16.0;
					    u_xlat0.xzw = vec3(u_xlat16_0) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat5.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat0.xzw * u_xlat4.xyz + u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					bool u_xlatb37;
					float u_xlat38;
					float u_xlat16_38;
					bool u_xlatb38;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat37 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb37 = u_xlat37<0.0;
					    if(((int(u_xlatb37) * int(0xffffffffu)))!=0){discard;}
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_6.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
					    u_xlat37 = u_xlat37 + 0.5;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat10_5.xyz;
					    u_xlat16_37 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat16_37);
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 5.28750038);
					    u_xlat16_37 = u_xlat10_6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat16_37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat10_6.xyz * vec3(u_xlat37);
					    u_xlatb38 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb38){
					        u_xlatb38 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb38){
					            u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat38 = inversesqrt(u_xlat38);
					            u_xlat8.xyz = vec3(u_xlat38) * u_xlat4.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat38 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat38 = min(u_xlat9.z, u_xlat38);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat9.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_38 = u_xlat10_4.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat16_38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz + (-u_xlat4.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * 1.5 + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat37 = u_xlat25 * u_xlat25;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat25 = u_xlat25 * u_xlat37;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = abs(u_xlat36) * 0.4375 + 0.5625;
					    u_xlat37 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat36 = abs(u_xlat36) * u_xlat37;
					    u_xlat24.x = u_xlat1.x * u_xlat24.x + u_xlat36;
					    u_xlat24.x = u_xlat24.x + 9.99999975e-06;
					    u_xlat36 = u_xlat13 * u_xlat13;
					    u_xlat36 = u_xlat36 * -0.68359375 + 1.0;
					    u_xlat24.y = u_xlat36 * u_xlat36 + 1.00000001e-07;
					    u_xlat24.xy = vec2(0.5, 0.100715235) / u_xlat24.xy;
					    u_xlat24.x = u_xlat24.y * u_xlat24.x;
					    u_xlat24.x = u_xlat24.x * 3.14159274;
					    u_xlat24.x = max(u_xlat24.x, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24.x);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24.x = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyw = _LightColor0.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat24.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat38 = u_xlat0.x * u_xlat0.x;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat0.x = u_xlat0.x * u_xlat38;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat7.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					bool u_xlatb37;
					float u_xlat38;
					float u_xlat16_38;
					bool u_xlatb38;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat37 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb37 = u_xlat37<0.0;
					    if(((int(u_xlatb37) * int(0xffffffffu)))!=0){discard;}
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat38);
					        u_xlat5.x = min(u_xlat40, u_xlat37);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat10_6, u_xlat8);
					        u_xlat6.y = dot(u_xlat10_7, u_xlat8);
					        u_xlat6.z = dot(u_xlat10_5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    //ENDIF
					    }
					    u_xlat5 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat37 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat37 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat37);
					    u_xlat5.xyz = unity_SHC.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat37 = u_xlat37 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz;
					    u_xlat16_37 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_37);
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 5.28750038);
					    u_xlat16_37 = u_xlat10_6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat16_37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat10_6.xyz * vec3(u_xlat37);
					    u_xlatb38 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb38){
					        u_xlatb38 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb38){
					            u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat38 = inversesqrt(u_xlat38);
					            u_xlat8.xyz = vec3(u_xlat38) * u_xlat4.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat38 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat38 = min(u_xlat9.z, u_xlat38);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat9.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_38 = u_xlat10_4.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat16_38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz + (-u_xlat4.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * 1.5 + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat37 = u_xlat25 * u_xlat25;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat25 = u_xlat25 * u_xlat37;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = abs(u_xlat36) * 0.4375 + 0.5625;
					    u_xlat37 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat36 = abs(u_xlat36) * u_xlat37;
					    u_xlat24.x = u_xlat1.x * u_xlat24.x + u_xlat36;
					    u_xlat24.x = u_xlat24.x + 9.99999975e-06;
					    u_xlat36 = u_xlat13 * u_xlat13;
					    u_xlat36 = u_xlat36 * -0.68359375 + 1.0;
					    u_xlat24.y = u_xlat36 * u_xlat36 + 1.00000001e-07;
					    u_xlat24.xy = vec2(0.5, 0.100715235) / u_xlat24.xy;
					    u_xlat24.x = u_xlat24.y * u_xlat24.x;
					    u_xlat24.x = u_xlat24.x * 3.14159274;
					    u_xlat24.x = max(u_xlat24.x, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24.x);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24.x = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyw = _LightColor0.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat24.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat38 = u_xlat0.x * u_xlat0.x;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat0.x = u_xlat0.x * u_xlat38;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat7.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat16_5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat33 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat10_4 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_5 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_5.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
					    u_xlat33 = u_xlat33 + 0.5;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat10_4.xyz;
					    u_xlat16_33 = max(u_xlat10_5.w, 9.99999975e-05);
					    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_3.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat3.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat33 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat34 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat36 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat34);
					        u_xlat4.x = min(u_xlat36, u_xlat33);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD1.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat10_5, u_xlat7);
					        u_xlat5.y = dot(u_xlat10_6, u_xlat7);
					        u_xlat5.z = dot(u_xlat10_4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    //ENDIF
					    }
					    u_xlat4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat33 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_6.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
					    u_xlat33 = u_xlat33 + 0.5;
					    u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz;
					    u_xlat16_33 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat16_33);
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_3.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat3.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					bool u_xlatb37;
					float u_xlat38;
					float u_xlat16_38;
					bool u_xlatb38;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat37 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb37 = u_xlat37<0.0;
					    if(((int(u_xlatb37) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat37 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat38 = sqrt(u_xlat38);
					    u_xlat38 = (-u_xlat37) + u_xlat38;
					    u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
					    u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb38){
					        u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb38)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat38 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat38, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat38 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat38 = u_xlat38 + (-u_xlat10_4.x);
					    u_xlat37 = u_xlat37 * u_xlat38 + u_xlat10_4.x;
					    u_xlat38 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat38 = u_xlat38 + u_xlat38;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat38)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 5.28750038);
					    u_xlat16_37 = u_xlat10_6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat16_37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat10_6.xyz * vec3(u_xlat37);
					    u_xlatb38 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb38){
					        u_xlatb38 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb38){
					            u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat38 = inversesqrt(u_xlat38);
					            u_xlat8.xyz = vec3(u_xlat38) * u_xlat4.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat38 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat38 = min(u_xlat9.z, u_xlat38);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat9.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_38 = u_xlat10_4.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat16_38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz + (-u_xlat4.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * 1.5 + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat37 = u_xlat25 * u_xlat25;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat25 = u_xlat25 * u_xlat37;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = abs(u_xlat36) * 0.4375 + 0.5625;
					    u_xlat37 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat36 = abs(u_xlat36) * u_xlat37;
					    u_xlat24.x = u_xlat1.x * u_xlat24.x + u_xlat36;
					    u_xlat24.x = u_xlat24.x + 9.99999975e-06;
					    u_xlat36 = u_xlat13 * u_xlat13;
					    u_xlat36 = u_xlat36 * -0.68359375 + 1.0;
					    u_xlat24.y = u_xlat36 * u_xlat36 + 1.00000001e-07;
					    u_xlat24.xy = vec2(0.5, 0.100715235) / u_xlat24.xy;
					    u_xlat24.x = u_xlat24.y * u_xlat24.x;
					    u_xlat24.x = u_xlat24.x * 3.14159274;
					    u_xlat24.x = max(u_xlat24.x, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24.x);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24.x = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyw = u_xlat12.xxx * u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat5.xyz * u_xlat24.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat38 = u_xlat0.x * u_xlat0.x;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat0.x = u_xlat0.x * u_xlat38;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat7.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat4.x = u_xlat4.x + (-u_xlat10_5.x);
					    u_xlat40 = u_xlat40 * u_xlat4.x + u_xlat10_5.x;
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat40 = u_xlat40 + u_xlat10_5.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat40 = min(u_xlat4.x, u_xlat40);
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.zw / hlslcc_FragCoord.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat4.x = u_xlat4.x + (-u_xlat10_5.x);
					    u_xlat40 = u_xlat40 * u_xlat4.x + u_xlat10_5.x;
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.zw / hlslcc_FragCoord.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat40 = u_xlat40 + u_xlat10_5.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat40 = min(u_xlat4.x, u_xlat40);
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat16_41 = (-u_xlat10_4.x) + 1.0;
					    u_xlat40 = u_xlat40 * u_xlat16_41 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat16_41 = (-u_xlat10_4.x) + 1.0;
					    u_xlat40 = u_xlat40 * u_xlat16_41 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat4.x, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[9];
						vec4 unity_ShadowColor;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat16_11;
					vec3 u_xlat15;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat33 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat33 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat11.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = (-u_xlat0.x) + u_xlat11.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat11.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat10_4.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_11.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat11.x = dot(vs_TEXCOORD1.xyz, u_xlat16_11.xyz);
					    u_xlat11.x = u_xlat11.x + 0.5;
					    u_xlat11.xyz = u_xlat11.xxx * u_xlat10_5.xyz;
					    u_xlat16_34 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat11.xyz = u_xlat11.xyz / vec3(u_xlat16_34);
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat34 = max(u_xlat34, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat5.xyz = (-u_xlat0.xxx) * _LightColor0.xyz + u_xlat11.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, unity_ShadowColor.xyz);
					    u_xlat6.xyz = u_xlat11.xyz + (-u_xlat5.xyz);
					    u_xlat5.xyz = _LightShadowData.xxx * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = min(u_xlat11.xyz, u_xlat5.xyz);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat15.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat15.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat15.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat15.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_4.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat4.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat33 = -abs(u_xlat33) + 1.0;
					    u_xlat34 = u_xlat33 * u_xlat33;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat33 = u_xlat33 * u_xlat34;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[9];
						vec4 unity_ShadowColor;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bool u_xlatb11;
					vec3 u_xlat15;
					float u_xlat22;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat33 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat33 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat11.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = (-u_xlat0.x) + u_xlat11.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat11.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat10_4.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb11 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb11){
					        u_xlatb11 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat11.xyz = (bool(u_xlatb11)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat11.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat5.y * 0.25;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat33 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat11.x = max(u_xlat22, u_xlat11.x);
					        u_xlat5.x = min(u_xlat33, u_xlat11.x);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat11.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat11.xyz);
					        u_xlat11.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat11.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat10_6, u_xlat8);
					        u_xlat6.y = dot(u_xlat10_7, u_xlat8);
					        u_xlat6.z = dot(u_xlat10_5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    //ENDIF
					    }
					    u_xlat5 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat11.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat11.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat11.x);
					    u_xlat11.xyz = unity_SHC.xyz * u_xlat11.xxx + u_xlat7.xyz;
					    u_xlat11.xyz = u_xlat11.xyz + u_xlat6.xyz;
					    u_xlat11.xyz = max(u_xlat11.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat11.xyz = max(u_xlat11.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_6.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
					    u_xlat34 = u_xlat34 + 0.5;
					    u_xlat5.xyz = vec3(u_xlat34) * u_xlat10_5.xyz;
					    u_xlat16_34 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat16_34);
					    u_xlat11.xyz = u_xlat11.xyz + u_xlat5.xyz;
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat34 = max(u_xlat34, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat5.xyz = (-u_xlat0.xxx) * _LightColor0.xyz + u_xlat11.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, unity_ShadowColor.xyz);
					    u_xlat6.xyz = u_xlat11.xyz + (-u_xlat5.xyz);
					    u_xlat5.xyz = _LightShadowData.xxx * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = min(u_xlat11.xyz, u_xlat5.xyz);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat15.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat15.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat15.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat15.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_4.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat4.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat33 = -abs(u_xlat33) + 1.0;
					    u_xlat34 = u_xlat33 * u_xlat33;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat33 = u_xlat33 * u_xlat34;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat1.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = (-u_xlat10_4.x) + u_xlat40;
					    u_xlat40 = u_xlat41 * u_xlat40 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = (-u_xlat10_4.x) + u_xlat40;
					    u_xlat40 = u_xlat41 * u_xlat40 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat4.x, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat41 = u_xlat41 + u_xlat10_4.x;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = min(u_xlat40, u_xlat41);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat41 = u_xlat41 + u_xlat10_4.x;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = min(u_xlat40, u_xlat41);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat4.x, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    SV_Target0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat18 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat19 = u_xlat19 + u_xlat19;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat19)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 5.28750038);
					    u_xlat16_18 = u_xlat10_3.w + -1.0;
					    u_xlat18 = unity_SpecCube0_HDR.w * u_xlat16_18 + 1.0;
					    u_xlat18 = u_xlat18 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat18);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat19 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat5.xyz * (-vec3(u_xlat19)) + u_xlat0.xyz;
					    u_xlat19 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat18) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 0.75;
					    u_xlat10_5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat16_0 = u_xlat10_5.x * 16.0;
					    u_xlat0.xzw = u_xlat1.xyz * vec3(u_xlat16_0);
					    u_xlat0.xzw = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xzw;
					    u_xlat2.xyz = vec3(u_xlat19) * u_xlat4.xyz;
					    u_xlat4.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD4;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat18 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat19 = u_xlat19 + u_xlat19;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat19)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 5.28750038);
					    u_xlat16_18 = u_xlat10_3.w + -1.0;
					    u_xlat18 = unity_SpecCube0_HDR.w * u_xlat16_18 + 1.0;
					    u_xlat18 = u_xlat18 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat18);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat19 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat5.xyz * (-vec3(u_xlat19)) + u_xlat0.xyz;
					    u_xlat19 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat18) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 0.75;
					    u_xlat10_5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat16_0 = u_xlat10_5.x * 16.0;
					    u_xlat0.xzw = vec3(u_xlat16_0) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat5.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD4;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unused_3_1;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unused_4_0[3];
						vec4 unity_SpecCube0_HDR;
						vec4 unused_4_2[4];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat18 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb18)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat18, u_xlat19);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat19 = u_xlat19 + u_xlat19;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat19)) + (-u_xlat0.xyz);
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat10_3 = textureLod(unity_SpecCube0, u_xlat3.xyz, 5.28750038);
					    u_xlat16_18 = u_xlat10_3.w + -1.0;
					    u_xlat18 = unity_SpecCube0_HDR.w * u_xlat16_18 + 1.0;
					    u_xlat18 = u_xlat18 * unity_SpecCube0_HDR.x;
					    u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat18);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat19 = u_xlat18 + u_xlat18;
					    u_xlat0.xyz = u_xlat5.xyz * (-vec3(u_xlat19)) + u_xlat0.xyz;
					    u_xlat19 = dot(u_xlat5.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat18 = u_xlat18;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat5.y = (-u_xlat18) + 1.0;
					    u_xlat5.zw = u_xlat5.xy * u_xlat5.xy;
					    u_xlat0.xy = u_xlat5.xy * u_xlat5.xw;
					    u_xlat0.xy = u_xlat5.zy * u_xlat0.xy;
					    u_xlat0.z = 0.75;
					    u_xlat10_5 = texture(unity_NHxRoughness, u_xlat0.xz);
					    u_xlat16_0 = u_xlat10_5.x * 16.0;
					    u_xlat0.xzw = vec3(u_xlat16_0) * u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat4.xyz = vec3(u_xlat19) * u_xlat4.xyz;
					    u_xlat5.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.yyy * u_xlat5.xyz + u_xlat1.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat1.xyz = vs_TEXCOORD3.xyz * u_xlat2.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat0.xzw * u_xlat4.xyz + u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD4;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat18) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					bool u_xlatb37;
					float u_xlat38;
					float u_xlat16_38;
					bool u_xlatb38;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat37 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb37 = u_xlat37<0.0;
					    if(((int(u_xlatb37) * int(0xffffffffu)))!=0){discard;}
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_6.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
					    u_xlat37 = u_xlat37 + 0.5;
					    u_xlat5.xyz = vec3(u_xlat37) * u_xlat10_5.xyz;
					    u_xlat16_37 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat16_37);
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 5.28750038);
					    u_xlat16_37 = u_xlat10_6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat16_37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat10_6.xyz * vec3(u_xlat37);
					    u_xlatb38 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb38){
					        u_xlatb38 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb38){
					            u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat38 = inversesqrt(u_xlat38);
					            u_xlat8.xyz = vec3(u_xlat38) * u_xlat4.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat38 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat38 = min(u_xlat9.z, u_xlat38);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat9.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_38 = u_xlat10_4.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat16_38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz + (-u_xlat4.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * 1.5 + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat37 = u_xlat25 * u_xlat25;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat25 = u_xlat25 * u_xlat37;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = abs(u_xlat36) * 0.4375 + 0.5625;
					    u_xlat37 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat36 = abs(u_xlat36) * u_xlat37;
					    u_xlat24.x = u_xlat1.x * u_xlat24.x + u_xlat36;
					    u_xlat24.x = u_xlat24.x + 9.99999975e-06;
					    u_xlat36 = u_xlat13 * u_xlat13;
					    u_xlat36 = u_xlat36 * -0.68359375 + 1.0;
					    u_xlat24.y = u_xlat36 * u_xlat36 + 1.00000001e-07;
					    u_xlat24.xy = vec2(0.5, 0.100715235) / u_xlat24.xy;
					    u_xlat24.x = u_xlat24.y * u_xlat24.x;
					    u_xlat24.x = u_xlat24.x * 3.14159274;
					    u_xlat24.x = max(u_xlat24.x, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24.x);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24.x = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyw = _LightColor0.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat24.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat38 = u_xlat0.x * u_xlat0.x;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat0.x = u_xlat0.x * u_xlat38;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat7.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.x;
					    u_xlat36 = u_xlat36 * (-u_xlat36);
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					bool u_xlatb37;
					float u_xlat38;
					float u_xlat16_38;
					bool u_xlatb38;
					float u_xlat40;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat37 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb37 = u_xlat37<0.0;
					    if(((int(u_xlatb37) * int(0xffffffffu)))!=0){discard;}
					    u_xlat37 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat37 = u_xlat37 + u_xlat37;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat37)) + (-u_xlat1.xyz);
					    u_xlatb37 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb37){
					        u_xlatb37 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb37)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat37 = u_xlat5.y * 0.25;
					        u_xlat38 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat40 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat37 = max(u_xlat37, u_xlat38);
					        u_xlat5.x = min(u_xlat40, u_xlat37);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat7.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat7.xyz);
					        u_xlat5.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat5.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat10_6, u_xlat8);
					        u_xlat6.y = dot(u_xlat10_7, u_xlat8);
					        u_xlat6.z = dot(u_xlat10_5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    //ENDIF
					    }
					    u_xlat5 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat37 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat37 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat37);
					    u_xlat5.xyz = unity_SHC.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat5.xyz = log2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat5.xyz = exp2(u_xlat5.xyz);
					    u_xlat5.xyz = u_xlat5.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat5.xyz = max(u_xlat5.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat37 = u_xlat37 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz;
					    u_xlat16_37 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_37);
					    u_xlat5.xyz = u_xlat5.xyz + u_xlat6.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 5.28750038);
					    u_xlat16_37 = u_xlat10_6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat16_37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat10_6.xyz * vec3(u_xlat37);
					    u_xlatb38 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb38){
					        u_xlatb38 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb38){
					            u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat38 = inversesqrt(u_xlat38);
					            u_xlat8.xyz = vec3(u_xlat38) * u_xlat4.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat38 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat38 = min(u_xlat9.z, u_xlat38);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat9.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_38 = u_xlat10_4.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat16_38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz + (-u_xlat4.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * 1.5 + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat37 = u_xlat25 * u_xlat25;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat25 = u_xlat25 * u_xlat37;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = abs(u_xlat36) * 0.4375 + 0.5625;
					    u_xlat37 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat36 = abs(u_xlat36) * u_xlat37;
					    u_xlat24.x = u_xlat1.x * u_xlat24.x + u_xlat36;
					    u_xlat24.x = u_xlat24.x + 9.99999975e-06;
					    u_xlat36 = u_xlat13 * u_xlat13;
					    u_xlat36 = u_xlat36 * -0.68359375 + 1.0;
					    u_xlat24.y = u_xlat36 * u_xlat36 + 1.00000001e-07;
					    u_xlat24.xy = vec2(0.5, 0.100715235) / u_xlat24.xy;
					    u_xlat24.x = u_xlat24.y * u_xlat24.x;
					    u_xlat24.x = u_xlat24.x * 3.14159274;
					    u_xlat24.x = max(u_xlat24.x, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24.x);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24.x = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyw = _LightColor0.xyz * u_xlat12.xxx + u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat24.xxx * _LightColor0.xyz;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat38 = u_xlat0.x * u_xlat0.x;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat0.x = u_xlat0.x * u_xlat38;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat7.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.x;
					    u_xlat36 = u_xlat36 * (-u_xlat36);
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat16_5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat33 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlat10_4 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_5 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_5.xyz = u_xlat10_5.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, u_xlat16_5.xyz);
					    u_xlat33 = u_xlat33 + 0.5;
					    u_xlat4.xyz = vec3(u_xlat33) * u_xlat10_4.xyz;
					    u_xlat16_33 = max(u_xlat10_5.w, 9.99999975e-05);
					    u_xlat4.xyz = u_xlat4.xyz / vec3(u_xlat16_33);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_3.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat3.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_2_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_8[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
					vec4 u_xlat10_6;
					vec4 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					float u_xlat36;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat0.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat33 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat33 = dot((-u_xlat0.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat3.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat0.xyz);
					    u_xlatb33 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb33){
					        u_xlatb33 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb33)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat33 = u_xlat4.y * 0.25;
					        u_xlat34 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat36 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat33 = max(u_xlat33, u_xlat34);
					        u_xlat4.x = min(u_xlat36, u_xlat33);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					        u_xlat6.xyz = u_xlat4.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat4.xyz = u_xlat4.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat7.xyz = vs_TEXCOORD1.xyz;
					        u_xlat7.w = 1.0;
					        u_xlat5.x = dot(u_xlat10_5, u_xlat7);
					        u_xlat5.y = dot(u_xlat10_6, u_xlat7);
					        u_xlat5.z = dot(u_xlat10_4, u_xlat7);
					    } else {
					        u_xlat4.xyz = vs_TEXCOORD1.xyz;
					        u_xlat4.w = 1.0;
					        u_xlat5.x = dot(unity_SHAr, u_xlat4);
					        u_xlat5.y = dot(unity_SHAg, u_xlat4);
					        u_xlat5.z = dot(unity_SHAb, u_xlat4);
					    //ENDIF
					    }
					    u_xlat4 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat6.x = dot(unity_SHBr, u_xlat4);
					    u_xlat6.y = dot(unity_SHBg, u_xlat4);
					    u_xlat6.z = dot(unity_SHBb, u_xlat4);
					    u_xlat33 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat33 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat33);
					    u_xlat4.xyz = unity_SHC.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat4.xyz = log2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat4.xyz = exp2(u_xlat4.xyz);
					    u_xlat4.xyz = u_xlat4.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat4.xyz = max(u_xlat4.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_6.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
					    u_xlat33 = u_xlat33 + 0.5;
					    u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz;
					    u_xlat16_33 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat16_33);
					    u_xlat4.xyz = u_xlat4.xyz + u_xlat5.xyz;
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat3.xyz, u_xlat3.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat3.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat3.xyz, u_xlat3.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat3.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat3.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_3 = textureLod(unity_SpecCube1, u_xlat3.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_3.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat3.xyz = u_xlat10_3.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat3.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat3.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat3.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * u_xlat4.xyz;
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat11.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat0.x = -abs(u_xlat0.x) + 1.0;
					    u_xlat34 = u_xlat0.x * u_xlat0.x;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat3.xyz = (-u_xlat1.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat3.xyz + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat11.xyz * u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat10_4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    u_xlat40 = dot(u_xlat10_4, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat41 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat41 = u_xlat41 + u_xlat41;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat41)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					bvec3 u_xlatb9;
					vec3 u_xlat10;
					bvec3 u_xlatb11;
					vec3 u_xlat12;
					float u_xlat13;
					float u_xlat16;
					vec2 u_xlat24;
					float u_xlat25;
					float u_xlat36;
					bool u_xlatb36;
					float u_xlat37;
					float u_xlat16_37;
					bool u_xlatb37;
					float u_xlat38;
					float u_xlat16_38;
					bool u_xlatb38;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat1.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat37 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb37 = u_xlat37<0.0;
					    if(((int(u_xlatb37) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat37 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat38 = sqrt(u_xlat38);
					    u_xlat38 = (-u_xlat37) + u_xlat38;
					    u_xlat37 = unity_ShadowFadeCenterAndType.w * u_xlat38 + u_xlat37;
					    u_xlat37 = u_xlat37 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat37 = clamp(u_xlat37, 0.0, 1.0);
					    u_xlatb38 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb38){
					        u_xlatb38 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb38)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat38 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat38, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat38 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat38 = clamp(u_xlat38, 0.0, 1.0);
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat38 = u_xlat38 + (-u_xlat10_4.x);
					    u_xlat37 = u_xlat37 * u_xlat38 + u_xlat10_4.x;
					    u_xlat38 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat38 = u_xlat38 + u_xlat38;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat38)) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat37) * _LightColor0.xyz;
					    u_xlatb37 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb37){
					        u_xlat37 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat37 = inversesqrt(u_xlat37);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat4.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat6.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat6.xyz;
					        u_xlatb9.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat6.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat7;
					            hlslcc_movcTemp.x = (u_xlatb9.x) ? u_xlat7.x : u_xlat8.x;
					            hlslcc_movcTemp.y = (u_xlatb9.y) ? u_xlat7.y : u_xlat8.y;
					            hlslcc_movcTemp.z = (u_xlatb9.z) ? u_xlat7.z : u_xlat8.z;
					            u_xlat7 = hlslcc_movcTemp;
					        }
					        u_xlat37 = min(u_xlat7.y, u_xlat7.x);
					        u_xlat37 = min(u_xlat7.z, u_xlat37);
					        u_xlat7.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat6.xyz = u_xlat6.xyz * vec3(u_xlat37) + u_xlat7.xyz;
					    } else {
					        u_xlat6.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_6 = textureLod(unity_SpecCube0, u_xlat6.xyz, 5.28750038);
					    u_xlat16_37 = u_xlat10_6.w + -1.0;
					    u_xlat37 = unity_SpecCube0_HDR.w * u_xlat16_37 + 1.0;
					    u_xlat37 = u_xlat37 * unity_SpecCube0_HDR.x;
					    u_xlat7.xyz = u_xlat10_6.xyz * vec3(u_xlat37);
					    u_xlatb38 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb38){
					        u_xlatb38 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb38){
					            u_xlat38 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat38 = inversesqrt(u_xlat38);
					            u_xlat8.xyz = vec3(u_xlat38) * u_xlat4.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat8.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat8.xyz;
					            u_xlatb11.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat8.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat9;
					                hlslcc_movcTemp.x = (u_xlatb11.x) ? u_xlat9.x : u_xlat10.x;
					                hlslcc_movcTemp.y = (u_xlatb11.y) ? u_xlat9.y : u_xlat10.y;
					                hlslcc_movcTemp.z = (u_xlatb11.z) ? u_xlat9.z : u_xlat10.z;
					                u_xlat9 = hlslcc_movcTemp;
					            }
					            u_xlat38 = min(u_xlat9.y, u_xlat9.x);
					            u_xlat38 = min(u_xlat9.z, u_xlat38);
					            u_xlat9.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat8.xyz * vec3(u_xlat38) + u_xlat9.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_38 = u_xlat10_4.w + -1.0;
					        u_xlat38 = unity_SpecCube1_HDR.w * u_xlat16_38 + 1.0;
					        u_xlat38 = u_xlat38 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat38);
					        u_xlat6.xyz = vec3(u_xlat37) * u_xlat10_6.xyz + (-u_xlat4.xyz);
					        u_xlat7.xyz = unity_SpecCube0_BoxMin.www * u_xlat6.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat37 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat37 = inversesqrt(u_xlat37);
					    u_xlat4.xyz = vec3(u_xlat37) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat36) + _WorldSpaceLightPos0.xyz;
					    u_xlat36 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat36 = max(u_xlat36, 0.00100000005);
					    u_xlat36 = inversesqrt(u_xlat36);
					    u_xlat0.xyz = vec3(u_xlat36) * u_xlat0.xyz;
					    u_xlat36 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat13 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat13 = clamp(u_xlat13, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat12.x = u_xlat0.x * u_xlat0.x;
					    u_xlat12.x = u_xlat12.x * 1.5 + -0.5;
					    u_xlat24.x = (-u_xlat1.x) + 1.0;
					    u_xlat25 = u_xlat24.x * u_xlat24.x;
					    u_xlat25 = u_xlat25 * u_xlat25;
					    u_xlat24.x = u_xlat24.x * u_xlat25;
					    u_xlat24.x = u_xlat12.x * u_xlat24.x + 1.0;
					    u_xlat25 = -abs(u_xlat36) + 1.0;
					    u_xlat37 = u_xlat25 * u_xlat25;
					    u_xlat37 = u_xlat37 * u_xlat37;
					    u_xlat25 = u_xlat25 * u_xlat37;
					    u_xlat12.x = u_xlat12.x * u_xlat25 + 1.0;
					    u_xlat12.x = u_xlat12.x * u_xlat24.x;
					    u_xlat24.x = abs(u_xlat36) * 0.4375 + 0.5625;
					    u_xlat37 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat36 = abs(u_xlat36) * u_xlat37;
					    u_xlat24.x = u_xlat1.x * u_xlat24.x + u_xlat36;
					    u_xlat24.x = u_xlat24.x + 9.99999975e-06;
					    u_xlat36 = u_xlat13 * u_xlat13;
					    u_xlat36 = u_xlat36 * -0.68359375 + 1.0;
					    u_xlat24.y = u_xlat36 * u_xlat36 + 1.00000001e-07;
					    u_xlat24.xy = vec2(0.5, 0.100715235) / u_xlat24.xy;
					    u_xlat24.x = u_xlat24.y * u_xlat24.x;
					    u_xlat24.x = u_xlat24.x * 3.14159274;
					    u_xlat24.x = max(u_xlat24.x, 9.99999975e-05);
					    u_xlat12.y = sqrt(u_xlat24.x);
					    u_xlat12.xy = u_xlat1.xx * u_xlat12.xy;
					    u_xlat36 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb36 = u_xlat36!=0.0;
					    u_xlat36 = u_xlatb36 ? 1.0 : float(0.0);
					    u_xlat24.x = u_xlat36 * u_xlat12.y;
					    u_xlat1.xyw = u_xlat12.xxx * u_xlat5.xyz;
					    u_xlat12.xyz = u_xlat5.xyz * u_xlat24.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat38 = u_xlat0.x * u_xlat0.x;
					    u_xlat38 = u_xlat38 * u_xlat38;
					    u_xlat0.x = u_xlat0.x * u_xlat38;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat12.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat7.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat36 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat36 = (-u_xlat36) + 1.0;
					    u_xlat36 = u_xlat36 * _ProjectionParams.z;
					    u_xlat36 = max(u_xlat36, 0.0);
					    u_xlat36 = u_xlat36 * unity_FogParams.x;
					    u_xlat36 = u_xlat36 * (-u_xlat36);
					    u_xlat36 = exp2(u_xlat36);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat36) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat4.x = u_xlat4.x + (-u_xlat10_5.x);
					    u_xlat40 = u_xlat40 * u_xlat4.x + u_xlat10_5.x;
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat40 = u_xlat40 + u_xlat10_5.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat40 = min(u_xlat4.x, u_xlat40);
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.zw / hlslcc_FragCoord.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat4.x = u_xlat4.x + (-u_xlat10_5.x);
					    u_xlat40 = u_xlat40 * u_xlat4.x + u_xlat10_5.x;
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unused_2_5[4];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_7;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					float u_xlat43;
					void main()
					{
					vec4 hlslcc_FragCoord = vec4(gl_FragCoord.xyz, 1.0/gl_FragCoord.w);
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.x = unity_MatrixV[0].z;
					    u_xlat4.y = unity_MatrixV[1].z;
					    u_xlat4.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat4.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlatb41 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb41){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat17.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat17.xyz;
					        u_xlat17.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat17.xyz;
					        u_xlat17.xyz = u_xlat17.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat17.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat17.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat17.x, u_xlat5.x);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4 = texture(unity_ShadowMask, vs_TEXCOORD5.xy);
					    //ENDIF
					    }
					    u_xlat4.x = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat4.x = clamp(u_xlat4.x, 0.0, 1.0);
					    u_xlat17.xy = vs_TEXCOORD5.zw / hlslcc_FragCoord.ww;
					    u_xlat10_5 = texture(_ShadowMapTexture, u_xlat17.xy);
					    u_xlat40 = u_xlat40 + u_xlat10_5.x;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat40 = min(u_xlat4.x, u_xlat40);
					    u_xlat4.x = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat4.x = u_xlat4.x + u_xlat4.x;
					    u_xlat4.xyz = vs_TEXCOORD1.xyz * (-u_xlat4.xxx) + (-u_xlat1.xyz);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    if(u_xlatb41){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat43 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat43, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6.xyz = u_xlat7.xyz + vs_TEXCOORD3.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat4.xyz, u_xlat4.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat4.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat4.xyz, u_xlat4.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat4.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat4.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat4.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat16_41 = (-u_xlat10_4.x) + 1.0;
					    u_xlat40 = u_xlat40 * u_xlat16_41 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat40 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat41 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat41 = sqrt(u_xlat41);
					    u_xlat41 = (-u_xlat40) + u_xlat41;
					    u_xlat40 = unity_ShadowFadeCenterAndType.w * u_xlat41 + u_xlat40;
					    u_xlat40 = u_xlat40 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat16_41 = (-u_xlat10_4.x) + 1.0;
					    u_xlat40 = u_xlat40 * u_xlat16_41 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat4.x, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[47];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[9];
						vec4 unity_ShadowColor;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					vec3 u_xlat16_11;
					vec3 u_xlat15;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat33 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat33 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat11.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = (-u_xlat0.x) + u_xlat11.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat11.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat10_4.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_11.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat11.x = dot(vs_TEXCOORD1.xyz, u_xlat16_11.xyz);
					    u_xlat11.x = u_xlat11.x + 0.5;
					    u_xlat11.xyz = u_xlat11.xxx * u_xlat10_5.xyz;
					    u_xlat16_34 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat11.xyz = u_xlat11.xyz / vec3(u_xlat16_34);
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat34 = max(u_xlat34, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat5.xyz = (-u_xlat0.xxx) * _LightColor0.xyz + u_xlat11.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, unity_ShadowColor.xyz);
					    u_xlat6.xyz = u_xlat11.xyz + (-u_xlat5.xyz);
					    u_xlat5.xyz = _LightShadowData.xxx * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = min(u_xlat11.xyz, u_xlat5.xyz);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat15.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat15.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat15.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat15.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_4.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat4.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat33 = -abs(u_xlat33) + 1.0;
					    u_xlat34 = u_xlat33 * u_xlat33;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat33 = u_xlat33 * u_xlat34;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat1.xyz;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_2_9[2];
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[9];
						vec4 unity_ShadowColor;
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec3 u_xlat16_6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					bvec3 u_xlatb8;
					vec3 u_xlat9;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bool u_xlatb11;
					vec3 u_xlat15;
					float u_xlat22;
					float u_xlat33;
					float u_xlat16_33;
					bool u_xlatb33;
					float u_xlat34;
					float u_xlat16_34;
					bool u_xlatb34;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat33 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat1.xyz = vec3(u_xlat33) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat33 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb33 = u_xlat33<0.0;
					    if(((int(u_xlatb33) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat33 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat33 = u_xlat33 + u_xlat33;
					    u_xlat15.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat33)) + (-u_xlat1.xyz);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat0.x = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat11.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat11.x = dot(u_xlat11.xyz, u_xlat11.xyz);
					    u_xlat11.x = sqrt(u_xlat11.x);
					    u_xlat11.x = (-u_xlat0.x) + u_xlat11.x;
					    u_xlat0.x = unity_ShadowFadeCenterAndType.w * u_xlat11.x + u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * _LightShadowData.z + _LightShadowData.w;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat0.x = u_xlat0.x + u_xlat10_4.x;
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlatb11 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb11){
					        u_xlatb11 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat11.xyz = (bool(u_xlatb11)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat11.xyz = u_xlat11.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat11.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat11.x = u_xlat5.y * 0.25;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat33 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat11.x = max(u_xlat22, u_xlat11.x);
					        u_xlat5.x = min(u_xlat33, u_xlat11.x);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					        u_xlat11.xyz = u_xlat5.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat11.xyz);
					        u_xlat11.xyz = u_xlat5.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_5 = texture(unity_ProbeVolumeSH, u_xlat11.xyz);
					        u_xlat8.xyz = vs_TEXCOORD1.xyz;
					        u_xlat8.w = 1.0;
					        u_xlat6.x = dot(u_xlat10_6, u_xlat8);
					        u_xlat6.y = dot(u_xlat10_7, u_xlat8);
					        u_xlat6.z = dot(u_xlat10_5, u_xlat8);
					    } else {
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat6.x = dot(unity_SHAr, u_xlat5);
					        u_xlat6.y = dot(unity_SHAg, u_xlat5);
					        u_xlat6.z = dot(unity_SHAb, u_xlat5);
					    //ENDIF
					    }
					    u_xlat5 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat7.x = dot(unity_SHBr, u_xlat5);
					    u_xlat7.y = dot(unity_SHBg, u_xlat5);
					    u_xlat7.z = dot(unity_SHBb, u_xlat5);
					    u_xlat11.x = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat11.x = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat11.x);
					    u_xlat11.xyz = unity_SHC.xyz * u_xlat11.xxx + u_xlat7.xyz;
					    u_xlat11.xyz = u_xlat11.xyz + u_xlat6.xyz;
					    u_xlat11.xyz = max(u_xlat11.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat11.xyz = log2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat11.xyz = exp2(u_xlat11.xyz);
					    u_xlat11.xyz = u_xlat11.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat11.xyz = max(u_xlat11.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_5 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_6 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_6.xyz = u_xlat10_6.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, u_xlat16_6.xyz);
					    u_xlat34 = u_xlat34 + 0.5;
					    u_xlat5.xyz = vec3(u_xlat34) * u_xlat10_5.xyz;
					    u_xlat16_34 = max(u_xlat10_6.w, 9.99999975e-05);
					    u_xlat5.xyz = u_xlat5.xyz / vec3(u_xlat16_34);
					    u_xlat11.xyz = u_xlat11.xyz + u_xlat5.xyz;
					    u_xlat34 = dot(vs_TEXCOORD1.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat34 = max(u_xlat34, 0.0);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * u_xlat34;
					    u_xlat5.xyz = (-u_xlat0.xxx) * _LightColor0.xyz + u_xlat11.xyz;
					    u_xlat5.xyz = max(u_xlat5.xyz, unity_ShadowColor.xyz);
					    u_xlat6.xyz = u_xlat11.xyz + (-u_xlat5.xyz);
					    u_xlat5.xyz = _LightShadowData.xxx * u_xlat6.xyz + u_xlat5.xyz;
					    u_xlat0.xyz = min(u_xlat11.xyz, u_xlat5.xyz);
					    u_xlatb33 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb33){
					        u_xlat33 = dot(u_xlat15.xyz, u_xlat15.xyz);
					        u_xlat33 = inversesqrt(u_xlat33);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat15.xyz;
					        u_xlat6.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat6.xyz = u_xlat6.xyz / u_xlat5.xyz;
					        u_xlat7.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat7.xyz = u_xlat7.xyz / u_xlat5.xyz;
					        u_xlatb8.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat5.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat6;
					            hlslcc_movcTemp.x = (u_xlatb8.x) ? u_xlat6.x : u_xlat7.x;
					            hlslcc_movcTemp.y = (u_xlatb8.y) ? u_xlat6.y : u_xlat7.y;
					            hlslcc_movcTemp.z = (u_xlatb8.z) ? u_xlat6.z : u_xlat7.z;
					            u_xlat6 = hlslcc_movcTemp;
					        }
					        u_xlat33 = min(u_xlat6.y, u_xlat6.x);
					        u_xlat33 = min(u_xlat6.z, u_xlat33);
					        u_xlat6.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat5.xyz = u_xlat5.xyz * vec3(u_xlat33) + u_xlat6.xyz;
					    } else {
					        u_xlat5.xyz = u_xlat15.xyz;
					    //ENDIF
					    }
					    u_xlat10_5 = textureLod(unity_SpecCube0, u_xlat5.xyz, 5.28750038);
					    u_xlat16_33 = u_xlat10_5.w + -1.0;
					    u_xlat33 = unity_SpecCube0_HDR.w * u_xlat16_33 + 1.0;
					    u_xlat33 = u_xlat33 * unity_SpecCube0_HDR.x;
					    u_xlat6.xyz = u_xlat10_5.xyz * vec3(u_xlat33);
					    u_xlatb34 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb34){
					        u_xlatb34 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb34){
					            u_xlat34 = dot(u_xlat15.xyz, u_xlat15.xyz);
					            u_xlat34 = inversesqrt(u_xlat34);
					            u_xlat7.xyz = vec3(u_xlat34) * u_xlat15.xyz;
					            u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					            u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					            u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					            {
					                vec4 hlslcc_movcTemp = u_xlat8;
					                hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					                hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					                hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					                u_xlat8 = hlslcc_movcTemp;
					            }
					            u_xlat34 = min(u_xlat8.y, u_xlat8.x);
					            u_xlat34 = min(u_xlat8.z, u_xlat34);
					            u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat15.xyz = u_xlat7.xyz * vec3(u_xlat34) + u_xlat8.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat15.xyz, 5.28750038);
					        u_xlat16_34 = u_xlat10_4.w + -1.0;
					        u_xlat34 = unity_SpecCube1_HDR.w * u_xlat16_34 + 1.0;
					        u_xlat34 = u_xlat34 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat34);
					        u_xlat5.xyz = vec3(u_xlat33) * u_xlat10_5.xyz + (-u_xlat4.xyz);
					        u_xlat6.xyz = unity_SpecCube0_BoxMin.www * u_xlat5.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat33 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat33 = inversesqrt(u_xlat33);
					    u_xlat4.xyz = vec3(u_xlat33) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat3.xyz;
					    u_xlat33 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.xyz = u_xlat6.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat33 = -abs(u_xlat33) + 1.0;
					    u_xlat34 = u_xlat33 * u_xlat33;
					    u_xlat34 = u_xlat34 * u_xlat34;
					    u_xlat33 = u_xlat33 * u_xlat34;
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat33) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat1.xyz;
					    u_xlat33 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat33 = (-u_xlat33) + 1.0;
					    u_xlat33 = u_xlat33 * _ProjectionParams.z;
					    u_xlat33 = max(u_xlat33, 0.0);
					    u_xlat33 = u_xlat33 * unity_FogParams.x;
					    u_xlat33 = u_xlat33 * (-u_xlat33);
					    u_xlat33 = exp2(u_xlat33);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat33) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = (-u_xlat10_4.x) + u_xlat40;
					    u_xlat40 = u_xlat41 * u_xlat40 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = (-u_xlat10_4.x) + u_xlat40;
					    u_xlat40 = u_xlat41 * u_xlat40 + u_xlat10_4.x;
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat4.x, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec3 u_xlat16_7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat41 = u_xlat41 + u_xlat10_4.x;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = min(u_xlat40, u_xlat41);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlat10_6 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_7 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_7.xyz = u_xlat10_7.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_7.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat6.xyz = vec3(u_xlat40) * u_xlat10_6.xyz;
					    u_xlat16_40 = max(u_xlat10_7.w, 9.99999975e-05);
					    u_xlat6.xyz = u_xlat6.xyz / vec3(u_xlat16_40);
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "SHADOWS_SCREEN" "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTMAP_SHADOW_MIXING" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_3[3];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[38];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_10;
					};
					layout(std140) uniform UnityShadows {
						vec4 unused_3_0[24];
						vec4 _LightShadowData;
						vec4 unity_ShadowFadeCenterAndType;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[10];
					};
					layout(std140) uniform UnityFog {
						vec4 unity_FogColor;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityReflectionProbes {
						vec4 unity_SpecCube0_BoxMax;
						vec4 unity_SpecCube0_BoxMin;
						vec4 unity_SpecCube0_ProbePosition;
						vec4 unity_SpecCube0_HDR;
						vec4 unity_SpecCube1_BoxMax;
						vec4 unity_SpecCube1_BoxMin;
						vec4 unity_SpecCube1_ProbePosition;
						vec4 unity_SpecCube1_HDR;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _ShadowMapTexture;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD4;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					vec3 u_xlat16_8;
					vec4 u_xlat10_8;
					vec4 u_xlat9;
					vec3 u_xlat10;
					bvec3 u_xlatb10;
					vec3 u_xlat11;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					float u_xlat14;
					vec3 u_xlat17;
					vec2 u_xlat26;
					float u_xlat27;
					float u_xlat39;
					bool u_xlatb39;
					float u_xlat40;
					float u_xlat16_40;
					bool u_xlatb40;
					float u_xlat41;
					float u_xlat16_41;
					bool u_xlatb41;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat1.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat40 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb40 = u_xlat40<0.0;
					    if(((int(u_xlatb40) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_ShadowMapTexture, u_xlat4.xy);
					    u_xlat40 = dot((-u_xlat1.xyz), vs_TEXCOORD1.xyz);
					    u_xlat40 = u_xlat40 + u_xlat40;
					    u_xlat17.xyz = vs_TEXCOORD1.xyz * (-vec3(u_xlat40)) + (-u_xlat1.xyz);
					    u_xlat10_5 = texture(unity_ShadowMask, vs_TEXCOORD3.xy);
					    u_xlat40 = dot(u_xlat10_5, unity_OcclusionMaskSelector);
					    u_xlat40 = clamp(u_xlat40, 0.0, 1.0);
					    u_xlat5.x = unity_MatrixV[0].z;
					    u_xlat5.y = unity_MatrixV[1].z;
					    u_xlat5.z = unity_MatrixV[2].z;
					    u_xlat41 = dot(u_xlat0.xyz, u_xlat5.xyz);
					    u_xlat5.xyz = vs_TEXCOORD2.xyz + (-unity_ShadowFadeCenterAndType.xyz);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat5.x = sqrt(u_xlat5.x);
					    u_xlat5.x = (-u_xlat41) + u_xlat5.x;
					    u_xlat41 = unity_ShadowFadeCenterAndType.w * u_xlat5.x + u_xlat41;
					    u_xlat41 = u_xlat41 * _LightShadowData.z + _LightShadowData.w;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat41 = u_xlat41 + u_xlat10_4.x;
					    u_xlat41 = clamp(u_xlat41, 0.0, 1.0);
					    u_xlat40 = min(u_xlat40, u_xlat41);
					    u_xlat5.xyz = vec3(u_xlat40) * _LightColor0.xyz;
					    u_xlatb40 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb40){
					        u_xlatb40 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb40)) ? u_xlat6.xyz : vs_TEXCOORD2.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat40 = u_xlat6.y * 0.25;
					        u_xlat41 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat4.x = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat40 = max(u_xlat40, u_xlat41);
					        u_xlat6.x = min(u_xlat4.x, u_xlat40);
					        u_xlat10_7 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					        u_xlat8.xyz = u_xlat6.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.xyz = u_xlat6.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_6 = texture(unity_ProbeVolumeSH, u_xlat6.xyz);
					        u_xlat9.xyz = vs_TEXCOORD1.xyz;
					        u_xlat9.w = 1.0;
					        u_xlat7.x = dot(u_xlat10_7, u_xlat9);
					        u_xlat7.y = dot(u_xlat10_8, u_xlat9);
					        u_xlat7.z = dot(u_xlat10_6, u_xlat9);
					    } else {
					        u_xlat6.xyz = vs_TEXCOORD1.xyz;
					        u_xlat6.w = 1.0;
					        u_xlat7.x = dot(unity_SHAr, u_xlat6);
					        u_xlat7.y = dot(unity_SHAg, u_xlat6);
					        u_xlat7.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat6 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat8.x = dot(unity_SHBr, u_xlat6);
					    u_xlat8.y = dot(unity_SHBg, u_xlat6);
					    u_xlat8.z = dot(unity_SHBb, u_xlat6);
					    u_xlat40 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat40 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat40);
					    u_xlat6.xyz = unity_SHC.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat6.xyz = log2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat6.xyz = exp2(u_xlat6.xyz);
					    u_xlat6.xyz = u_xlat6.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat6.xyz = max(u_xlat6.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_7 = texture(unity_Lightmap, vs_TEXCOORD3.xy);
					    u_xlat10_8 = texture(unity_LightmapInd, vs_TEXCOORD3.xy);
					    u_xlat16_8.xyz = u_xlat10_8.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, u_xlat16_8.xyz);
					    u_xlat40 = u_xlat40 + 0.5;
					    u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz;
					    u_xlat16_40 = max(u_xlat10_8.w, 9.99999975e-05);
					    u_xlat7.xyz = u_xlat7.xyz / vec3(u_xlat16_40);
					    u_xlat6.xyz = u_xlat6.xyz + u_xlat7.xyz;
					    u_xlatb40 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb40){
					        u_xlat40 = dot(u_xlat17.xyz, u_xlat17.xyz);
					        u_xlat40 = inversesqrt(u_xlat40);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat17.xyz;
					        u_xlat8.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat8.xyz = u_xlat8.xyz / u_xlat7.xyz;
					        u_xlat9.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat9.xyz = u_xlat9.xyz / u_xlat7.xyz;
					        u_xlatb10.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat7.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat8;
					            hlslcc_movcTemp.x = (u_xlatb10.x) ? u_xlat8.x : u_xlat9.x;
					            hlslcc_movcTemp.y = (u_xlatb10.y) ? u_xlat8.y : u_xlat9.y;
					            hlslcc_movcTemp.z = (u_xlatb10.z) ? u_xlat8.z : u_xlat9.z;
					            u_xlat8 = hlslcc_movcTemp;
					        }
					        u_xlat40 = min(u_xlat8.y, u_xlat8.x);
					        u_xlat40 = min(u_xlat8.z, u_xlat40);
					        u_xlat8.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat7.xyz = u_xlat7.xyz * vec3(u_xlat40) + u_xlat8.xyz;
					    } else {
					        u_xlat7.xyz = u_xlat17.xyz;
					    //ENDIF
					    }
					    u_xlat10_7 = textureLod(unity_SpecCube0, u_xlat7.xyz, 5.28750038);
					    u_xlat16_40 = u_xlat10_7.w + -1.0;
					    u_xlat40 = unity_SpecCube0_HDR.w * u_xlat16_40 + 1.0;
					    u_xlat40 = u_xlat40 * unity_SpecCube0_HDR.x;
					    u_xlat8.xyz = u_xlat10_7.xyz * vec3(u_xlat40);
					    u_xlatb41 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb41){
					        u_xlatb41 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb41){
					            u_xlat41 = dot(u_xlat17.xyz, u_xlat17.xyz);
					            u_xlat41 = inversesqrt(u_xlat41);
					            u_xlat9.xyz = vec3(u_xlat41) * u_xlat17.xyz;
					            u_xlat10.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					            u_xlat11.xyz = (-vs_TEXCOORD2.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					            u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat10;
					                hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					                hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					                hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					                u_xlat10 = hlslcc_movcTemp;
					            }
					            u_xlat41 = min(u_xlat10.y, u_xlat10.x);
					            u_xlat41 = min(u_xlat10.z, u_xlat41);
					            u_xlat10.xyz = vs_TEXCOORD2.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat17.xyz = u_xlat9.xyz * vec3(u_xlat41) + u_xlat10.xyz;
					        //ENDIF
					        }
					        u_xlat10_4 = textureLod(unity_SpecCube1, u_xlat17.xyz, 5.28750038);
					        u_xlat16_41 = u_xlat10_4.w + -1.0;
					        u_xlat41 = unity_SpecCube1_HDR.w * u_xlat16_41 + 1.0;
					        u_xlat41 = u_xlat41 * unity_SpecCube1_HDR.x;
					        u_xlat4.xyz = u_xlat10_4.xyz * vec3(u_xlat41);
					        u_xlat7.xyz = vec3(u_xlat40) * u_xlat10_7.xyz + (-u_xlat4.xyz);
					        u_xlat8.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat4.xyz;
					    //ENDIF
					    }
					    u_xlat40 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat40 = inversesqrt(u_xlat40);
					    u_xlat4.xyz = vec3(u_xlat40) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat3.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat39) + _WorldSpaceLightPos0.xyz;
					    u_xlat39 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat39 = max(u_xlat39, 0.00100000005);
					    u_xlat39 = inversesqrt(u_xlat39);
					    u_xlat0.xyz = vec3(u_xlat39) * u_xlat0.xyz;
					    u_xlat39 = dot(u_xlat4.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat14 = dot(u_xlat4.xyz, u_xlat0.xyz);
					    u_xlat14 = clamp(u_xlat14, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat13.x = u_xlat0.x * u_xlat0.x;
					    u_xlat13.x = u_xlat13.x * 1.5 + -0.5;
					    u_xlat26.x = (-u_xlat1.x) + 1.0;
					    u_xlat27 = u_xlat26.x * u_xlat26.x;
					    u_xlat27 = u_xlat27 * u_xlat27;
					    u_xlat26.x = u_xlat26.x * u_xlat27;
					    u_xlat26.x = u_xlat13.x * u_xlat26.x + 1.0;
					    u_xlat27 = -abs(u_xlat39) + 1.0;
					    u_xlat40 = u_xlat27 * u_xlat27;
					    u_xlat40 = u_xlat40 * u_xlat40;
					    u_xlat27 = u_xlat27 * u_xlat40;
					    u_xlat13.x = u_xlat13.x * u_xlat27 + 1.0;
					    u_xlat13.x = u_xlat13.x * u_xlat26.x;
					    u_xlat26.x = abs(u_xlat39) * 0.4375 + 0.5625;
					    u_xlat40 = u_xlat1.x * 0.4375 + 0.5625;
					    u_xlat39 = abs(u_xlat39) * u_xlat40;
					    u_xlat26.x = u_xlat1.x * u_xlat26.x + u_xlat39;
					    u_xlat26.x = u_xlat26.x + 9.99999975e-06;
					    u_xlat39 = u_xlat14 * u_xlat14;
					    u_xlat39 = u_xlat39 * -0.68359375 + 1.0;
					    u_xlat26.y = u_xlat39 * u_xlat39 + 1.00000001e-07;
					    u_xlat26.xy = vec2(0.5, 0.100715235) / u_xlat26.xy;
					    u_xlat26.x = u_xlat26.y * u_xlat26.x;
					    u_xlat26.x = u_xlat26.x * 3.14159274;
					    u_xlat26.x = max(u_xlat26.x, 9.99999975e-05);
					    u_xlat13.y = sqrt(u_xlat26.x);
					    u_xlat13.xy = u_xlat1.xx * u_xlat13.xy;
					    u_xlat39 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlatb39 = u_xlat39!=0.0;
					    u_xlat39 = u_xlatb39 ? 1.0 : float(0.0);
					    u_xlat26.x = u_xlat39 * u_xlat13.y;
					    u_xlat1.xyw = u_xlat5.xyz * u_xlat13.xxx + u_xlat6.xyz;
					    u_xlat13.xyz = u_xlat5.xyz * u_xlat26.xxx;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat41 = u_xlat0.x * u_xlat0.x;
					    u_xlat41 = u_xlat41 * u_xlat41;
					    u_xlat0.x = u_xlat0.x * u_xlat41;
					    u_xlat4.xyz = (-u_xlat2.xyz) + vec3(1.0, 1.0, 1.0);
					    u_xlat4.xyz = u_xlat4.xyz * u_xlat0.xxx + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat13.xyz * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyw + u_xlat0.xyz;
					    u_xlat1.xyw = u_xlat8.xyz * vec3(0.881874979, 0.881874979, 0.881874979);
					    u_xlat3.xyz = (-u_xlat2.xyz) + vec3(0.704641402, 0.704641402, 0.704641402);
					    u_xlat2.xyz = vec3(u_xlat27) * u_xlat3.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = u_xlat1.xyw * u_xlat2.xyz + u_xlat0.xyz;
					    u_xlat39 = vs_TEXCOORD4 / _ProjectionParams.y;
					    u_xlat39 = (-u_xlat39) + 1.0;
					    u_xlat39 = u_xlat39 * _ProjectionParams.z;
					    u_xlat39 = max(u_xlat39, 0.0);
					    u_xlat39 = u_xlat39 * unity_FogParams.x;
					    u_xlat39 = u_xlat39 * (-u_xlat39);
					    u_xlat39 = exp2(u_xlat39);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat39) * u_xlat0.xyz + unity_FogColor.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "FORWARDADD" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Blend One One, One One
			ColorMask RGB -1
			ZWrite Off
			Cull Off
			GpuProgramID 66410
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat1.x = u_xlat1.z / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.x;
					    u_xlat1.x = u_xlat1.x * (-u_xlat1.x);
					    vs_TEXCOORD5 = exp2(u_xlat1.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    u_xlat0.x = u_xlat0.z / _ProjectionParams.y;
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat0.x = u_xlat0.x * _ProjectionParams.z;
					    u_xlat0.x = max(u_xlat0.x, 0.0);
					    u_xlat0.x = u_xlat0.x * unity_FogParams.x;
					    u_xlat0.x = u_xlat0.x * (-u_xlat0.x);
					    vs_TEXCOORD5 = exp2(u_xlat0.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat1.x = u_xlat1.z / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.x;
					    u_xlat1.x = u_xlat1.x * (-u_xlat1.x);
					    vs_TEXCOORD5 = exp2(u_xlat1.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD3 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat10;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat1.x = u_xlat1.z / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.x;
					    u_xlat1.x = u_xlat1.x * (-u_xlat1.x);
					    vs_TEXCOORD5 = exp2(u_xlat1.x);
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat10 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat10 = inversesqrt(u_xlat10);
					    vs_TEXCOORD1.xyz = vec3(u_xlat10) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD3.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[4];
						mat4x4 unity_WorldToLight;
						vec4 unused_0_2;
						vec4 _MainTex_ST;
						vec4 unused_0_4;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[5];
						vec4 _ProjectionParams;
						vec4 unused_1_2[3];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityFog {
						vec4 unused_4_0;
						vec4 unity_FogParams;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD5;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat1 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat1;
					    u_xlat1.x = u_xlat1.z / _ProjectionParams.y;
					    u_xlat1.x = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat1.x * _ProjectionParams.z;
					    u_xlat1.x = max(u_xlat1.x, 0.0);
					    u_xlat1.x = u_xlat1.x * unity_FogParams.x;
					    u_xlat1.x = u_xlat1.x * (-u_xlat1.x);
					    vs_TEXCOORD5 = exp2(u_xlat1.x);
					    u_xlat1 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0.xy = u_xlat1.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat1.xx + u_xlat0.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat1.zz + u_xlat0.xy;
					    vs_TEXCOORD3.xy = unity_WorldToLight[3].xy * u_xlat1.ww + u_xlat0.xy;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					Keywords { "POINT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat18 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb18)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_4 = texture(_LightTexture0, vec2(u_xlat19));
					    u_xlat18 = u_xlat18 * u_xlat10_4.x;
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat5.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_1.x * 16.0;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat15 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_4 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_4.x * 16.0;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat18 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb18)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb19 = 0.0<u_xlat4.z;
					    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat19 = u_xlat19 * u_xlat10_5.w;
					    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_4 = texture(_LightTextureB0, vec2(u_xlat20));
					    u_xlat19 = u_xlat19 * u_xlat10_4.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat5.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_1.x * 16.0;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat16_19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat18 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb18)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_5 = texture(_LightTextureB0, vec2(u_xlat19));
					    u_xlat10_4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat16_19 = u_xlat10_4.w * u_xlat10_5.x;
					    u_xlat18 = u_xlat18 * u_xlat16_19;
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat5.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_1.x * 16.0;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat15 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat3.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb15)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat15, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat15 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat10_3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat15 = u_xlat15 * u_xlat10_3.w;
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_4 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_4.x * 16.0;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    SV_Target0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat18 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb18)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_4 = texture(_LightTexture0, vec2(u_xlat19));
					    u_xlat18 = u_xlat18 * u_xlat10_4.x;
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat5.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_1.x * 16.0;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						vec4 _Color;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat15 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat3.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat3.xyz;
					        u_xlat3.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat3.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat3.xyz = (bool(u_xlatb15)) ? u_xlat3.xyz : vs_TEXCOORD2.xyz;
					        u_xlat3.xyz = u_xlat3.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat3.yzw = u_xlat3.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat3.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat3.x = max(u_xlat15, u_xlat16);
					        u_xlat3 = texture(unity_ProbeVolumeSH, u_xlat3.xzw);
					    } else {
					        u_xlat3.x = float(1.0);
					        u_xlat3.y = float(1.0);
					        u_xlat3.z = float(1.0);
					        u_xlat3.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat15 = dot(u_xlat3, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_4 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_4.x * 16.0;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD5;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SPOT" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					bool u_xlatb19;
					float u_xlat20;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat18 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4 = vs_TEXCOORD2.yyyy * unity_WorldToLight[1];
					    u_xlat4 = unity_WorldToLight[0] * vs_TEXCOORD2.xxxx + u_xlat4;
					    u_xlat4 = unity_WorldToLight[2] * vs_TEXCOORD2.zzzz + u_xlat4;
					    u_xlat4 = u_xlat4 + unity_WorldToLight[3];
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb18)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlatb19 = 0.0<u_xlat4.z;
					    u_xlat19 = u_xlatb19 ? 1.0 : float(0.0);
					    u_xlat5.xy = u_xlat4.xy / u_xlat4.ww;
					    u_xlat5.xy = u_xlat5.xy + vec2(0.5, 0.5);
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xy);
					    u_xlat19 = u_xlat19 * u_xlat10_5.w;
					    u_xlat20 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_4 = texture(_LightTextureB0, vec2(u_xlat20));
					    u_xlat19 = u_xlat19 * u_xlat10_4.x;
					    u_xlat18 = u_xlat18 * u_xlat19;
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat5.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_1.x * 16.0;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "POINT_COOKIE" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec3 u_xlat2;
					vec4 u_xlat10_2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat16_19;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat1.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat1.xyz;
					    u_xlat10_2 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_2 * _Color;
					    u_xlat18 = u_xlat10_2.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_WorldToLight[1].xyz;
					    u_xlat4.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					    u_xlat4.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb18)) ? u_xlat5.xyz : vs_TEXCOORD2.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat18, u_xlat19);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat18 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat19 = dot(u_xlat4.xyz, u_xlat4.xyz);
					    u_xlat10_5 = texture(_LightTextureB0, vec2(u_xlat19));
					    u_xlat10_4 = texture(_LightTexture0, u_xlat4.xyz);
					    u_xlat16_19 = u_xlat10_4.w * u_xlat10_5.x;
					    u_xlat18 = u_xlat18 * u_xlat16_19;
					    u_xlat4.xyz = vec3(u_xlat18) * _LightColor0.xyz;
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat5.xyz = vec3(u_xlat18) * vs_TEXCOORD1.xyz;
					    u_xlat2.xyz = u_xlat10_2.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat18 = dot(u_xlat1.xyz, u_xlat5.xyz);
					    u_xlat18 = u_xlat18 + u_xlat18;
					    u_xlat1.xyz = u_xlat5.xyz * (-vec3(u_xlat18)) + u_xlat1.xyz;
					    u_xlat18 = dot(u_xlat5.xyz, u_xlat0.xyz);
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_1 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_1.x * 16.0;
					    u_xlat0.xyz = u_xlat2.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat3.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat4.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat18 = vs_TEXCOORD5;
					    u_xlat18 = clamp(u_xlat18, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    SV_Target0.w = u_xlat3.w;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL_COOKIE" "FOG_EXP2" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[2];
						vec4 _LightColor0;
						vec4 unused_0_2;
						mat4x4 unity_WorldToLight;
						vec4 _Color;
						vec4 unused_0_5;
						float _Cutoff;
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D unity_NHxRoughness;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec4 u_xlat10_1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					float u_xlat15;
					bool u_xlatb15;
					float u_xlat16;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD2.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat0.xyz = vec3(u_xlat15) * u_xlat0.xyz;
					    u_xlat10_1 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat2 = u_xlat10_1 * _Color;
					    u_xlat15 = u_xlat10_1.w * _Color.w + (-_Cutoff);
					    u_xlatb15 = u_xlat15<0.0;
					    if(((int(u_xlatb15) * int(0xffffffffu)))!=0){discard;}
					    u_xlat3.xy = vs_TEXCOORD2.yy * unity_WorldToLight[1].xy;
					    u_xlat3.xy = unity_WorldToLight[0].xy * vs_TEXCOORD2.xx + u_xlat3.xy;
					    u_xlat3.xy = unity_WorldToLight[2].xy * vs_TEXCOORD2.zz + u_xlat3.xy;
					    u_xlat3.xy = u_xlat3.xy + unity_WorldToLight[3].xy;
					    u_xlatb15 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb15){
					        u_xlatb15 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat4.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat4.xyz;
					        u_xlat4.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb15)) ? u_xlat4.xyz : vs_TEXCOORD2.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat15 = u_xlat4.y * 0.25 + 0.75;
					        u_xlat16 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat15, u_xlat16);
					        u_xlat4 = texture(unity_ProbeVolumeSH, u_xlat4.xzw);
					    } else {
					        u_xlat4.x = float(1.0);
					        u_xlat4.y = float(1.0);
					        u_xlat4.z = float(1.0);
					        u_xlat4.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat15 = dot(u_xlat4, unity_OcclusionMaskSelector);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat10_3 = texture(_LightTexture0, u_xlat3.xy);
					    u_xlat15 = u_xlat15 * u_xlat10_3.w;
					    u_xlat3.xyz = vec3(u_xlat15) * _LightColor0.xyz;
					    u_xlat15 = dot(vs_TEXCOORD1.xyz, vs_TEXCOORD1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat4.xyz = vec3(u_xlat15) * vs_TEXCOORD1.xyz;
					    u_xlat1.xyz = u_xlat10_1.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    u_xlat1.xyz = u_xlat1.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat15 = dot(u_xlat0.xyz, u_xlat4.xyz);
					    u_xlat15 = u_xlat15 + u_xlat15;
					    u_xlat0.xyz = u_xlat4.xyz * (-vec3(u_xlat15)) + u_xlat0.xyz;
					    u_xlat15 = dot(u_xlat4.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat0.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.x = u_xlat0.x * u_xlat0.x;
					    u_xlat0.y = 0.75;
					    u_xlat10_4 = texture(unity_NHxRoughness, u_xlat0.xy);
					    u_xlat16_0 = u_xlat10_4.x * 16.0;
					    u_xlat0.xyz = u_xlat1.xyz * vec3(u_xlat16_0);
					    u_xlat0.xyz = u_xlat2.xyz * vec3(0.545358598, 0.545358598, 0.545358598) + u_xlat0.xyz;
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    u_xlat15 = vs_TEXCOORD5;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat15);
					    SV_Target0.w = u_xlat2.w;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "DEFERRED"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "DEFERRED" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Cull Off
			GpuProgramID 178266
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_SHADOWMASK" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_1_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					float u_xlat6;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat6 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat6 = inversesqrt(u_xlat6);
					    vs_TEXCOORD1.xyz = vec3(u_xlat6) * u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[2];
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD4;
					out vec3 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					float u_xlat12;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD2.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat0.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat0.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat12 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat12 = inversesqrt(u_xlat12);
					    u_xlat0.xyz = vec3(u_xlat12) * u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = u_xlat0.xyz;
					    vs_TEXCOORD4 = vec4(0.0, 0.0, 0.0, 0.0);
					    u_xlat1.x = u_xlat0.y * u_xlat0.y;
					    u_xlat1.x = u_xlat0.x * u_xlat0.x + (-u_xlat1.x);
					    u_xlat2 = u_xlat0.yzzx * u_xlat0.xyzz;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat1.xyz = unity_SHC.xyz * u_xlat1.xxx + u_xlat3.xyz;
					    u_xlat0.w = 1.0;
					    u_xlat2.x = dot(unity_SHAr, u_xlat0);
					    u_xlat2.y = dot(unity_SHAg, u_xlat0);
					    u_xlat2.z = dot(unity_SHAb, u_xlat0);
					    u_xlat0.xyz = u_xlat1.xyz + u_xlat2.xyz;
					    u_xlat0.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    vs_TEXCOORD5.xyz = max(u_xlat0.xyz, vec3(0.0, 0.0, 0.0));
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[5];
						vec4 _MainTex_ST;
						vec4 unused_0_2[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 unused_1_0[4];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_2[4];
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						mat4x4 unity_WorldToObject;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_3_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unused_4_1;
					};
					in  vec4 in_POSITION0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat0.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    gl_Position = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat9 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat9 = inversesqrt(u_xlat9);
					    vs_TEXCOORD1.xyz = vec3(u_xlat9) * u_xlat1.xyz;
					    vs_TEXCOORD2.xyz = u_xlat0.xyz;
					    vs_TEXCOORD3.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    vs_TEXCOORD4.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    vs_TEXCOORD4.zw = vec2(0.0, 0.0);
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat6 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb6 = u_xlat6<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(1.0, 1.0, 1.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat6 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb6 = u_xlat6<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.xyz = u_xlat0.xyz;
					    u_xlat0.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[47];
						vec4 unity_ProbesOcclusion;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					float u_xlat9;
					bool u_xlatb9;
					float u_xlat10;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat9 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb9 = u_xlat9<0.0;
					    if(((int(u_xlatb9) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat1.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
					    u_xlatb9 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb9){
					        u_xlatb9 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb9)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat9 = u_xlat2.y * 0.25 + 0.75;
					        u_xlat10 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat2.x = max(u_xlat9, u_xlat10);
					        SV_Target4 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					    } else {
					        SV_Target4 = unity_ProbesOcclusion;
					    //ENDIF
					    }
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat16_1;
					vec4 u_xlat10_1;
					vec4 u_xlat10_2;
					float u_xlat9;
					float u_xlat16_9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb9 = u_xlat9<0.0;
					    if(((int(u_xlatb9) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    u_xlat10_1 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_9 = max(u_xlat10_1.w, 9.99999975e-05);
					    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat10_2 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10_2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat16_9);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					float u_xlat8;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat18 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat19);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat18 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat18 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat18);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_3 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat10_4 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
					    u_xlat18 = u_xlat18 + 0.5;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat10_3.xyz;
					    u_xlat16_18 = max(u_xlat10_4.w, 9.99999975e-05);
					    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_18);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat16_1;
					vec4 u_xlat10_1;
					vec4 u_xlat10_2;
					float u_xlat9;
					float u_xlat16_9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb9 = u_xlat9<0.0;
					    if(((int(u_xlatb9) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    u_xlat10_1 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_9 = max(u_xlat10_1.w, 9.99999975e-05);
					    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat10_2 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10_2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat16_9);
					    u_xlat0.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.xyz = exp2((-u_xlat0.xyz));
					    SV_Target3.w = 1.0;
					    SV_Target4 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					float u_xlat8;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat18 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat19);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat18 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat18 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat18);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_3 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat10_4 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
					    u_xlat18 = u_xlat18 + 0.5;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat10_3.xyz;
					    u_xlat16_18 = max(u_xlat10_4.w, 9.99999975e-05);
					    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_18);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlat1.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target4 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
					    SV_Target3.xyz = exp2((-u_xlat1.xyz));
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat6 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb6 = u_xlat6<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target3.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_SHADOWMASK" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[47];
						vec4 unity_ProbesOcclusion;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec4 u_xlat0;
					vec4 u_xlat10_0;
					bool u_xlatb0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat6 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb6 = u_xlat6<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    SV_Target0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    u_xlatb0 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb0){
					        u_xlatb0 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat0.xyz = (bool(u_xlatb0)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat0.xyz = u_xlat0.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat0.yzw = u_xlat0.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat2.x = u_xlat0.y * 0.25 + 0.75;
					        u_xlat1.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat0.x = max(u_xlat2.x, u_xlat1.x);
					        SV_Target4 = texture(unity_ProbeVolumeSH, u_xlat0.xzw);
					    } else {
					        SV_Target4 = unity_ProbesOcclusion;
					    //ENDIF
					    }
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3 = vec4(0.0, 0.0, 0.0, 1.0);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[2];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[47];
						vec4 unity_ProbesOcclusion;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec4 u_xlat1;
					float u_xlat3;
					float u_xlat6;
					bool u_xlatb6;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat6 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb6 = u_xlat6<0.0;
					    if(((int(u_xlatb6) * int(0xffffffffu)))!=0){discard;}
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target3.xyz = u_xlat0.xyz * vs_TEXCOORD5.xyz;
					    u_xlatb6 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb6){
					        u_xlatb6 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat1.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat1.xyz;
					        u_xlat1.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat1.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat1.xyz = (bool(u_xlatb6)) ? u_xlat1.xyz : vs_TEXCOORD2.xyz;
					        u_xlat1.xyz = u_xlat1.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat1.yzw = u_xlat1.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat6 = u_xlat1.y * 0.25 + 0.75;
					        u_xlat3 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat1.x = max(u_xlat6, u_xlat3);
					        SV_Target4 = texture(unity_ProbeVolumeSH, u_xlat1.xzw);
					    } else {
					        SV_Target4 = unity_ProbesOcclusion;
					    //ENDIF
					    }
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat16_1;
					vec4 u_xlat10_1;
					vec4 u_xlat10_2;
					float u_xlat9;
					float u_xlat16_9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb9 = u_xlat9<0.0;
					    if(((int(u_xlatb9) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    u_xlat10_1 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_9 = max(u_xlat10_1.w, 9.99999975e-05);
					    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat10_2 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10_2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat16_9);
					    SV_Target3.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					float u_xlat8;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat18 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat19);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat18 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat18 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat18);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_3 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat10_4 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
					    u_xlat18 = u_xlat18 + 0.5;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat10_3.xyz;
					    u_xlat16_18 = max(u_xlat10_4.w, 9.99999975e-05);
					    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_18);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target3.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec3 u_xlat16_1;
					vec4 u_xlat10_1;
					vec4 u_xlat10_2;
					float u_xlat9;
					float u_xlat16_9;
					bool u_xlatb9;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat9 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb9 = u_xlat9<0.0;
					    if(((int(u_xlatb9) * int(0xffffffffu)))!=0){discard;}
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    u_xlat10_1 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_1.xyz = u_xlat10_1.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat16_9 = max(u_xlat10_1.w, 9.99999975e-05);
					    u_xlat1.x = dot(vs_TEXCOORD1.xyz, u_xlat16_1.xyz);
					    u_xlat1.x = u_xlat1.x + 0.5;
					    u_xlat10_2 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat1.xyz = u_xlat1.xxx * u_xlat10_2.xyz;
					    u_xlat1.xyz = u_xlat1.xyz / vec3(u_xlat16_9);
					    SV_Target3.xyz = u_xlat0.xyz * u_xlat1.xyz;
					    SV_Target3.w = 1.0;
					    SV_Target4 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
					    return;
					}"
				}
				SubProgram "d3d11 " {
					Keywords { "LIGHTMAP_ON" "DIRLIGHTMAP_COMBINED" "SHADOWS_SHADOWMASK" "LIGHTPROBE_SH" "UNITY_HDR_ON" }
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						vec4 unused_0_2[3];
						float _Cutoff;
					};
					layout(std140) uniform UnityLighting {
						vec4 unused_1_0[39];
						vec4 unity_SHAr;
						vec4 unity_SHAg;
						vec4 unity_SHAb;
						vec4 unity_SHBr;
						vec4 unity_SHBg;
						vec4 unity_SHBb;
						vec4 unity_SHC;
						vec4 unused_1_8[2];
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D unity_Lightmap;
					uniform  sampler2D unity_LightmapInd;
					uniform  sampler2D unity_ShadowMask;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec2 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  vec3 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD4;
					layout(location = 0) out vec4 SV_Target0;
					layout(location = 1) out vec4 SV_Target1;
					layout(location = 2) out vec4 SV_Target2;
					layout(location = 3) out vec4 SV_Target3;
					layout(location = 4) out vec4 SV_Target4;
					vec3 u_xlat0;
					vec4 u_xlat10_0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat10_2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec3 u_xlat16_4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					float u_xlat8;
					float u_xlat18;
					float u_xlat16_18;
					bool u_xlatb18;
					float u_xlat19;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat1.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat18 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlatb18 = u_xlat18<0.0;
					    if(((int(u_xlatb18) * int(0xffffffffu)))!=0){discard;}
					    u_xlatb18 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb18){
					        u_xlatb18 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat2.xyz = vs_TEXCOORD2.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.xxx + u_xlat2.xyz;
					        u_xlat2.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD2.zzz + u_xlat2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat2.xyz = (bool(u_xlatb18)) ? u_xlat2.xyz : vs_TEXCOORD2.xyz;
					        u_xlat2.xyz = u_xlat2.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat2.yzw = u_xlat2.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat18 = u_xlat2.y * 0.25;
					        u_xlat19 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat8 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat18 = max(u_xlat18, u_xlat19);
					        u_xlat2.x = min(u_xlat8, u_xlat18);
					        u_xlat10_3 = texture(unity_ProbeVolumeSH, u_xlat2.xzw);
					        u_xlat4.xyz = u_xlat2.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_4 = texture(unity_ProbeVolumeSH, u_xlat4.xyz);
					        u_xlat2.xyz = u_xlat2.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_2 = texture(unity_ProbeVolumeSH, u_xlat2.xyz);
					        u_xlat5.xyz = vs_TEXCOORD1.xyz;
					        u_xlat5.w = 1.0;
					        u_xlat3.x = dot(u_xlat10_3, u_xlat5);
					        u_xlat3.y = dot(u_xlat10_4, u_xlat5);
					        u_xlat3.z = dot(u_xlat10_2, u_xlat5);
					    } else {
					        u_xlat2.xyz = vs_TEXCOORD1.xyz;
					        u_xlat2.w = 1.0;
					        u_xlat3.x = dot(unity_SHAr, u_xlat2);
					        u_xlat3.y = dot(unity_SHAg, u_xlat2);
					        u_xlat3.z = dot(unity_SHAb, u_xlat2);
					    //ENDIF
					    }
					    u_xlat2 = vs_TEXCOORD1.yzzx * vs_TEXCOORD1.xyzz;
					    u_xlat4.x = dot(unity_SHBr, u_xlat2);
					    u_xlat4.y = dot(unity_SHBg, u_xlat2);
					    u_xlat4.z = dot(unity_SHBb, u_xlat2);
					    u_xlat18 = vs_TEXCOORD1.y * vs_TEXCOORD1.y;
					    u_xlat18 = vs_TEXCOORD1.x * vs_TEXCOORD1.x + (-u_xlat18);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat18) + u_xlat4.xyz;
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat2.xyz = log2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat2.xyz = exp2(u_xlat2.xyz);
					    u_xlat2.xyz = u_xlat2.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat2.xyz = max(u_xlat2.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat10_3 = texture(unity_Lightmap, vs_TEXCOORD4.xy);
					    u_xlat10_4 = texture(unity_LightmapInd, vs_TEXCOORD4.xy);
					    u_xlat16_4.xyz = u_xlat10_4.xyz + vec3(-0.5, -0.5, -0.5);
					    u_xlat18 = dot(vs_TEXCOORD1.xyz, u_xlat16_4.xyz);
					    u_xlat18 = u_xlat18 + 0.5;
					    u_xlat3.xyz = vec3(u_xlat18) * u_xlat10_3.xyz;
					    u_xlat16_18 = max(u_xlat10_4.w, 9.99999975e-05);
					    u_xlat3.xyz = u_xlat3.xyz / vec3(u_xlat16_18);
					    u_xlat2.xyz = u_xlat2.xyz + u_xlat3.xyz;
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz + vec3(-0.220916301, -0.220916301, -0.220916301);
					    SV_Target1.xyz = u_xlat0.xyz * vec3(0.300000012, 0.300000012, 0.300000012) + vec3(0.220916301, 0.220916301, 0.220916301);
					    u_xlat0.xyz = u_xlat1.xyz * vec3(0.545358598, 0.545358598, 0.545358598);
					    SV_Target3.xyz = u_xlat2.xyz * u_xlat0.xyz;
					    SV_Target4 = texture(unity_ShadowMask, vs_TEXCOORD4.xy);
					    SV_Target0.xyz = u_xlat0.xyz;
					    SV_Target0.w = 1.0;
					    SV_Target1.w = 0.25;
					    SV_Target2.xyz = vs_TEXCOORD1.xyz * vec3(0.5, 0.5, 0.5) + vec3(0.5, 0.5, 0.5);
					    SV_Target2.w = 1.0;
					    SV_Target3.w = 1.0;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "Meta"
			LOD 200
			Tags { "IGNOREPROJECTOR" = "true" "LIGHTMODE" = "META" "QUEUE" = "AlphaTest" "RenderType" = "TransparentCutout" }
			Cull Off
			GpuProgramID 215055
			Program "vp" {
				SubProgram "d3d11 " {
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[6];
						vec4 _MainTex_ST;
						vec4 unused_0_2;
					};
					layout(std140) uniform UnityPerDraw {
						mat4x4 unity_ObjectToWorld;
						vec4 unused_1_1[6];
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_2_0[17];
						mat4x4 unity_MatrixVP;
						vec4 unused_2_2[2];
					};
					layout(std140) uniform UnityLightmaps {
						vec4 unity_LightmapST;
						vec4 unity_DynamicLightmapST;
					};
					layout(std140) uniform UnityMetaPass {
						bvec4 unity_MetaVertexControl;
						vec4 unused_4_1[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TEXCOORD0;
					in  vec4 in_TEXCOORD1;
					in  vec4 in_TEXCOORD2;
					out vec2 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					vec4 u_xlat0;
					bool u_xlatb0;
					vec4 u_xlat1;
					bool u_xlatb6;
					void main()
					{
					    u_xlatb0 = 0.0<in_POSITION0.z;
					    u_xlat0.z = u_xlatb0 ? 9.99999975e-05 : float(0.0);
					    u_xlat0.xy = in_TEXCOORD1.xy * unity_LightmapST.xy + unity_LightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.x) ? u_xlat0.xyz : in_POSITION0.xyz;
					    u_xlatb6 = 0.0<u_xlat0.z;
					    u_xlat1.z = u_xlatb6 ? 9.99999975e-05 : float(0.0);
					    u_xlat1.xy = in_TEXCOORD2.xy * unity_DynamicLightmapST.xy + unity_DynamicLightmapST.zw;
					    u_xlat0.xyz = (unity_MetaVertexControl.y) ? u_xlat1.xyz : u_xlat0.xyz;
					    u_xlat1 = u_xlat0.yyyy * unity_MatrixVP[1];
					    u_xlat1 = unity_MatrixVP[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat0.zzzz + u_xlat1;
					    gl_Position = u_xlat0 + unity_MatrixVP[3];
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    u_xlat0.xyz = in_POSITION0.yyy * unity_ObjectToWorld[1].xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[0].xyz * in_POSITION0.xxx + u_xlat0.xyz;
					    u_xlat0.xyz = unity_ObjectToWorld[2].xyz * in_POSITION0.zzz + u_xlat0.xyz;
					    vs_TEXCOORD1.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    return;
					}"
				}
			}
			Program "fp" {
				SubProgram "d3d11 " {
					"ps_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform PGlobals {
						vec4 unused_0_0[4];
						vec4 _Color;
						float unity_OneOverOutputBoost;
						float unity_MaxOutputValue;
						vec4 unused_0_4;
						float _Cutoff;
					};
					layout(std140) uniform UnityMetaPass {
						vec4 unused_1_0;
						bvec4 unity_MetaFragmentControl;
						vec4 unused_1_2;
					};
					uniform  sampler2D _MainTex;
					in  vec2 vs_TEXCOORD0;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					vec4 u_xlat10_0;
					float u_xlat3;
					bool u_xlatb3;
					void main()
					{
					    u_xlat10_0 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_0.w * _Color.w + (-_Cutoff);
					    u_xlat0.xyz = u_xlat10_0.xyz * _Color.xyz;
					    u_xlat0.xyz = log2(u_xlat0.xyz);
					    u_xlatb3 = u_xlat3<0.0;
					    if(((int(u_xlatb3) * int(0xffffffffu)))!=0){discard;}
					    u_xlat3 = unity_OneOverOutputBoost;
					    u_xlat3 = clamp(u_xlat3, 0.0, 1.0);
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat3);
					    u_xlat0.xyz = exp2(u_xlat0.xyz);
					    u_xlat0.xyz = min(u_xlat0.xyz, vec3(vec3(unity_MaxOutputValue, unity_MaxOutputValue, unity_MaxOutputValue)));
					    u_xlat0.w = 1.0;
					    u_xlat0 = (unity_MetaFragmentControl.x) ? u_xlat0 : vec4(0.0, 0.0, 0.0, 0.0);
					    SV_Target0 = (unity_MetaFragmentControl.y) ? vec4(0.0, 0.0, 0.0, 1.0) : u_xlat0;
					    return;
					}"
				}
			}
		}
	}
	Fallback "Transparent/Cutout/VertexLit"
}