Shader "Custom/NewWaterAnimated" {
	Properties {
		_Color ("Color", Vector) = (1,1,1,1)
		_MainTex ("Albedo (RGB)", 2D) = "white" {}
		_BumpMap ("Albedo (RGB)", 2D) = "white" {}
		_Specular ("Specular", Range(0, 1)) = 0
		_Glossiness ("Smoothness", Range(0, 1)) = 0.5
		_FadeColor ("Fade Color", Vector) = (1,1,1,1)
		_InvFade ("Soft Factor", Range(0.01, 3)) = 1
		_Surf ("Water Surf", 2D) = "white" {}
		_XScrollSpeed ("X Scroll Speed", Float) = 1
		_YScrollSpeed ("Y Scroll Speed", Float) = 1
	}
	SubShader {
		LOD 200
		Tags { "QUEUE" = "Transparent" "RenderType" = "Transparent" }
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDBASE" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One OneMinusSrcAlpha, One OneMinusSrcAlpha
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 22883
			Program "vp" {
				SubProgram "d3d11 " {
					Keywords { "DIRECTIONAL" }
					"vs_4_0
					
					#version 330
					#extension GL_ARB_explicit_attrib_location : require
					#extension GL_ARB_explicit_uniform_location : require
					
					layout(std140) uniform VGlobals {
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
						vec4 _Surf_ST;
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
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
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
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat15 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat15 = unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
					    u_xlat15 = unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
					    u_xlat15 = unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
					    vs_TEXCOORD6 = (-u_xlat15);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Surf_ST.xy + _Surf_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat1.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD7.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
						vec4 _Surf_ST;
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
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
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
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat15 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat15 = unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
					    u_xlat15 = unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
					    u_xlat15 = unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
					    vs_TEXCOORD6 = (-u_xlat15);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Surf_ST.xy + _Surf_ST.zw;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat1.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD7.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
						vec4 _Surf_ST;
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
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
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
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat15 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat15 = unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
					    u_xlat15 = unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
					    u_xlat15 = unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
					    vs_TEXCOORD6 = (-u_xlat15);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Surf_ST.xy + _Surf_ST.zw;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3 = vec4(u_xlat16) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat1.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat15 * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat2 = u_xlat3.ywzx * u_xlat3;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    vs_TEXCOORD7.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat2.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
						vec4 _Surf_ST;
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
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
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
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat15 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat15 = unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
					    u_xlat15 = unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
					    u_xlat15 = unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
					    vs_TEXCOORD6 = (-u_xlat15);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Surf_ST.xy + _Surf_ST.zw;
					    vs_TEXCOORD8 = u_xlat2.z;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat1.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD7.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
						vec4 _Surf_ST;
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
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec3 u_xlat4;
					float u_xlat15;
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
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat15 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat15 = unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
					    u_xlat15 = unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
					    u_xlat15 = unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
					    vs_TEXCOORD6 = (-u_xlat15);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Surf_ST.xy + _Surf_ST.zw;
					    vs_TEXCOORD8 = u_xlat2.z;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat0.x = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat0.x = inversesqrt(u_xlat0.x);
					    u_xlat3 = u_xlat0.xxxx * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat1.yzx + (-u_xlat4.xyz);
					    u_xlat0.x = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat0.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat0.w = u_xlat0.x * 0.5;
					    u_xlat0.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat0.zz + u_xlat0.xw;
					    u_xlat0.x = u_xlat3.y * u_xlat3.y;
					    u_xlat0.x = u_xlat3.x * u_xlat3.x + (-u_xlat0.x);
					    u_xlat1 = u_xlat3.ywzx * u_xlat3;
					    u_xlat2.x = dot(unity_SHBr, u_xlat1);
					    u_xlat2.y = dot(unity_SHBg, u_xlat1);
					    u_xlat2.z = dot(unity_SHBb, u_xlat1);
					    vs_TEXCOORD7.xyz = unity_SHC.xyz * u_xlat0.xxx + u_xlat2.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
						vec4 _Surf_ST;
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
						vec4 unused_3_2;
						vec4 unity_WorldTransformParams;
					};
					layout(std140) uniform UnityPerFrame {
						vec4 unused_4_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_4_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_4_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec2 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out float vs_TEXCOORD8;
					out vec4 vs_TEXCOORD2;
					out vec4 vs_TEXCOORD3;
					out vec4 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					float u_xlat15;
					float u_xlat16;
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
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat15 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat15 = unity_MatrixV[0].z * u_xlat1.x + u_xlat15;
					    u_xlat15 = unity_MatrixV[2].z * u_xlat1.z + u_xlat15;
					    u_xlat15 = unity_MatrixV[3].z * u_xlat1.w + u_xlat15;
					    vs_TEXCOORD6 = (-u_xlat15);
					    vs_TEXCOORD1.xy = in_TEXCOORD0.xy * _Surf_ST.xy + _Surf_ST.zw;
					    vs_TEXCOORD8 = u_xlat2.z;
					    u_xlat1.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat1.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat1.xyz;
					    u_xlat1.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat1.xyz;
					    u_xlat15 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat15 = inversesqrt(u_xlat15);
					    u_xlat1.xyz = vec3(u_xlat15) * u_xlat1.xyz;
					    vs_TEXCOORD2.x = u_xlat1.z;
					    u_xlat15 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.x = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat3.y = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat3.z = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3 = vec4(u_xlat16) * u_xlat3.xyzz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.wxy;
					    u_xlat4.xyz = u_xlat3.ywx * u_xlat1.yzx + (-u_xlat4.xyz);
					    u_xlat4.xyz = vec3(u_xlat15) * u_xlat4.xyz;
					    vs_TEXCOORD2.y = u_xlat4.x;
					    vs_TEXCOORD2.w = u_xlat0.x;
					    vs_TEXCOORD2.z = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat1.x;
					    vs_TEXCOORD4.x = u_xlat1.y;
					    vs_TEXCOORD3.y = u_xlat4.y;
					    vs_TEXCOORD4.y = u_xlat4.z;
					    vs_TEXCOORD3.w = u_xlat0.y;
					    vs_TEXCOORD3.z = u_xlat3.y;
					    vs_TEXCOORD4.w = u_xlat0.z;
					    vs_TEXCOORD4.z = u_xlat3.w;
					    u_xlat15 = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat15 * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1 = (-u_xlat0.xxxx) + unity_4LightPosX0;
					    u_xlat2 = (-u_xlat0.yyyy) + unity_4LightPosY0;
					    u_xlat0 = (-u_xlat0.zzzz) + unity_4LightPosZ0;
					    u_xlat4 = u_xlat3.yyyy * u_xlat2;
					    u_xlat2 = u_xlat2 * u_xlat2;
					    u_xlat2 = u_xlat1 * u_xlat1 + u_xlat2;
					    u_xlat1 = u_xlat1 * u_xlat3.xxxx + u_xlat4;
					    u_xlat1 = u_xlat0 * u_xlat3.wwzw + u_xlat1;
					    u_xlat0 = u_xlat0 * u_xlat0 + u_xlat2;
					    u_xlat0 = max(u_xlat0, vec4(9.99999997e-07, 9.99999997e-07, 9.99999997e-07, 9.99999997e-07));
					    u_xlat2 = inversesqrt(u_xlat0);
					    u_xlat0 = u_xlat0 * unity_4LightAtten0 + vec4(1.0, 1.0, 1.0, 1.0);
					    u_xlat0 = vec4(1.0, 1.0, 1.0, 1.0) / u_xlat0;
					    u_xlat1 = u_xlat1 * u_xlat2;
					    u_xlat1 = max(u_xlat1, vec4(0.0, 0.0, 0.0, 0.0));
					    u_xlat0 = u_xlat0 * u_xlat1;
					    u_xlat1.xyz = u_xlat0.yyy * unity_LightColor[1].xyz;
					    u_xlat1.xyz = unity_LightColor[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    u_xlat0.xyz = unity_LightColor[3].xyz * u_xlat0.www + u_xlat0.xyz;
					    u_xlat1.xyz = u_xlat0.xyz * vec3(0.305306017, 0.305306017, 0.305306017) + vec3(0.682171106, 0.682171106, 0.682171106);
					    u_xlat1.xyz = u_xlat0.xyz * u_xlat1.xyz + vec3(0.0125228781, 0.0125228781, 0.0125228781);
					    u_xlat15 = u_xlat3.y * u_xlat3.y;
					    u_xlat15 = u_xlat3.x * u_xlat3.x + (-u_xlat15);
					    u_xlat2 = u_xlat3.ywzx * u_xlat3;
					    u_xlat3.x = dot(unity_SHBr, u_xlat2);
					    u_xlat3.y = dot(unity_SHBg, u_xlat2);
					    u_xlat3.z = dot(unity_SHBb, u_xlat2);
					    u_xlat2.xyz = unity_SHC.xyz * vec3(u_xlat15) + u_xlat3.xyz;
					    vs_TEXCOORD7.xyz = u_xlat0.xyz * u_xlat1.xyz + u_xlat2.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 _FadeColor;
						vec4 unused_0_7;
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _Surf;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD7;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					vec4 u_xlat10_10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					bvec3 u_xlatb14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					vec3 u_xlat20;
					float u_xlat21;
					float u_xlat23;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					vec2 u_xlat33;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
					bool u_xlatb48;
					float u_xlat50;
					bool u_xlatb50;
					float u_xlat51;
					float u_xlat16_51;
					float u_xlat52;
					bool u_xlatb52;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat45 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat45 = inversesqrt(u_xlat45);
					    u_xlat2.xyz = vec3(u_xlat45) * u_xlat1.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx;
					    u_xlat33.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat5 = texture(_BumpMap, u_xlat33.xy);
					    u_xlat5.x = u_xlat5.w * u_xlat5.x;
					    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat46 = dot(u_xlat5.xy, u_xlat5.xy);
					    u_xlat46 = min(u_xlat46, 1.0);
					    u_xlat46 = (-u_xlat46) + 1.0;
					    u_xlat5.z = sqrt(u_xlat46);
					    u_xlat33.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_6 = texture(_CameraDepthTexture, u_xlat33.xy);
					    u_xlat46 = _ZBufferParams.z * u_xlat10_6.x + _ZBufferParams.w;
					    u_xlat46 = float(1.0) / u_xlat46;
					    u_xlatb47 = 0.0<u_xlat10_6.x;
					    u_xlat46 = u_xlat46 + (-vs_TEXCOORD6);
					    u_xlat46 = u_xlat46 * _InvFade;
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat46 = (u_xlatb47) ? u_xlat46 : 1.0;
					    u_xlat10_3 = texture(_Surf, u_xlat3.xy);
					    u_xlat47 = (-u_xlat46) + 1.0;
					    u_xlat47 = log2(u_xlat47);
					    u_xlat6.xy = vec2(u_xlat47) * vec2(10.0, 30.0);
					    u_xlat6.xy = exp2(u_xlat6.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xxx;
					    u_xlat47 = (-u_xlat6.y) + 1.0;
					    u_xlat3.xyz = vec3(u_xlat47) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat46) * _FadeColor.xyz + u_xlat3.xyz;
					    u_xlat47 = u_xlat46 * _Specular;
					    u_xlatb48 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb48){
					        u_xlatb50 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb50)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat50 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat21 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat50, u_xlat21);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat50 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat50 = clamp(u_xlat50, 0.0, 1.0);
					    u_xlat6.x = dot(vs_TEXCOORD2.xyz, u_xlat5.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat6.xyz = u_xlat5.xxx * u_xlat6.xyz;
					    u_xlat5.x = (-_Glossiness) + 1.0;
					    u_xlat20.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
					    u_xlat20.x = u_xlat20.x + u_xlat20.x;
					    u_xlat7.xyz = u_xlat6.xyz * (-u_xlat20.xxx) + (-u_xlat2.xyz);
					    u_xlat20.xyz = vec3(u_xlat50) * _LightColor0.xyz;
					    if(u_xlatb48){
					        u_xlatb48 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb48)) ? u_xlat8.xyz : u_xlat0.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat48 = u_xlat8.y * 0.25;
					        u_xlat52 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat23 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat48 = max(u_xlat48, u_xlat52);
					        u_xlat8.x = min(u_xlat23, u_xlat48);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat8.xzw);
					        u_xlat10.xyz = u_xlat8.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_10 = texture(unity_ProbeVolumeSH, u_xlat10.xyz);
					        u_xlat8.xyz = u_xlat8.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(u_xlat10_9, u_xlat6);
					        u_xlat9.y = dot(u_xlat10_10, u_xlat6);
					        u_xlat9.z = dot(u_xlat10_8, u_xlat6);
					    } else {
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(unity_SHAr, u_xlat6);
					        u_xlat9.y = dot(unity_SHAg, u_xlat6);
					        u_xlat9.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat8.xyz = u_xlat9.xyz + vs_TEXCOORD7.xyz;
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat8.xyz = log2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat8.xyz = exp2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb48 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb48){
					        u_xlat48 = dot(u_xlat7.xyz, u_xlat7.xyz);
					        u_xlat48 = inversesqrt(u_xlat48);
					        u_xlat9.xyz = vec3(u_xlat48) * u_xlat7.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					        u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					        u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat10;
					            hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					            hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					            hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					            u_xlat10 = hlslcc_movcTemp;
					        }
					        u_xlat48 = min(u_xlat10.y, u_xlat10.x);
					        u_xlat48 = min(u_xlat10.z, u_xlat48);
					        u_xlat10.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat48) + u_xlat10.xyz;
					    } else {
					        u_xlat9.xyz = u_xlat7.xyz;
					    //ENDIF
					    }
					    u_xlat48 = (-u_xlat5.x) * 0.699999988 + 1.70000005;
					    u_xlat48 = u_xlat48 * u_xlat5.x;
					    u_xlat48 = u_xlat48 * 6.0;
					    u_xlat10_9 = textureLod(unity_SpecCube0, u_xlat9.xyz, u_xlat48);
					    u_xlat16_51 = u_xlat10_9.w + -1.0;
					    u_xlat51 = unity_SpecCube0_HDR.w * u_xlat16_51 + 1.0;
					    u_xlat51 = u_xlat51 * unity_SpecCube0_HDR.x;
					    u_xlat10.xyz = u_xlat10_9.xyz * vec3(u_xlat51);
					    u_xlatb52 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb52){
					        u_xlatb52 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb52){
					            u_xlat52 = dot(u_xlat7.xyz, u_xlat7.xyz);
					            u_xlat52 = inversesqrt(u_xlat52);
					            u_xlat11.xyz = vec3(u_xlat52) * u_xlat7.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat11.xyz;
					            u_xlat13.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat13.xyz = u_xlat13.xyz / u_xlat11.xyz;
					            u_xlatb14.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat11.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat12;
					                hlslcc_movcTemp.x = (u_xlatb14.x) ? u_xlat12.x : u_xlat13.x;
					                hlslcc_movcTemp.y = (u_xlatb14.y) ? u_xlat12.y : u_xlat13.y;
					                hlslcc_movcTemp.z = (u_xlatb14.z) ? u_xlat12.z : u_xlat13.z;
					                u_xlat12 = hlslcc_movcTemp;
					            }
					            u_xlat52 = min(u_xlat12.y, u_xlat12.x);
					            u_xlat52 = min(u_xlat12.z, u_xlat52);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat52) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_7 = textureLod(unity_SpecCube1, u_xlat7.xyz, u_xlat48);
					        u_xlat16_0 = u_xlat10_7.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_7.xyz * u_xlat0.xxx;
					        u_xlat7.xyz = vec3(u_xlat51) * u_xlat10_9.xyz + (-u_xlat0.xyz);
					        u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-_Specular) * u_xlat46 + 1.0;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat15 = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat0.x + u_xlat15;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat45) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
					    u_xlat30 = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat45 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat16 = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = dot(vec2(u_xlat16), u_xlat5.xx);
					    u_xlat16 = u_xlat16 + -0.5;
					    u_xlat31 = (-u_xlat45) + 1.0;
					    u_xlat17 = u_xlat31 * u_xlat31;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat31 = u_xlat31 * u_xlat17;
					    u_xlat31 = u_xlat16 * u_xlat31 + 1.0;
					    u_xlat17 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat17 * u_xlat17;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat17 = u_xlat17 * u_xlat32;
					    u_xlat16 = u_xlat16 * u_xlat17 + 1.0;
					    u_xlat16 = u_xlat16 * u_xlat31;
					    u_xlat16 = u_xlat45 * u_xlat16;
					    u_xlat31 = u_xlat5.x * u_xlat5.x;
					    u_xlat31 = max(u_xlat31, 0.00200000009);
					    u_xlat32 = (-u_xlat31) + 1.0;
					    u_xlat48 = abs(u_xlat30) * u_xlat32 + u_xlat31;
					    u_xlat32 = u_xlat45 * u_xlat32 + u_xlat31;
					    u_xlat30 = abs(u_xlat30) * u_xlat32;
					    u_xlat30 = u_xlat45 * u_xlat48 + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat32 = u_xlat31 * u_xlat31;
					    u_xlat48 = u_xlat2.x * u_xlat32 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat48 * u_xlat2.x + 1.0;
					    u_xlat32 = u_xlat32 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat32 / u_xlat2.x;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat30 = u_xlat30 * 3.14159274;
					    u_xlat30 = max(u_xlat30, 9.99999975e-05);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = u_xlat45 * u_xlat30;
					    u_xlat45 = u_xlat31 * 0.280000001;
					    u_xlat45 = (-u_xlat45) * u_xlat5.x + 1.0;
					    u_xlat31 = dot(vec3(u_xlat47), vec3(u_xlat47));
					    u_xlatb31 = u_xlat31!=0.0;
					    u_xlat31 = u_xlatb31 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat31;
					    u_xlat15 = u_xlat15 + _Glossiness;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat20.xyz * vec3(u_xlat16) + u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat20.xyz * vec3(u_xlat30);
					    u_xlat30 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat30 * u_xlat30;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat30 + u_xlat47;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat6.xyz + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat10.xyz * vec3(u_xlat45);
					    u_xlat15 = (-_Specular) * u_xlat46 + u_xlat15;
					    u_xlat15 = u_xlat17 * u_xlat15 + u_xlat47;
					    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat15) + u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat3.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 _FadeColor;
						vec4 unused_0_7;
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _Surf;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD7;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					vec4 u_xlat10_10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					bvec3 u_xlatb14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					vec3 u_xlat20;
					float u_xlat21;
					float u_xlat23;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					vec2 u_xlat33;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
					bool u_xlatb48;
					float u_xlat50;
					bool u_xlatb50;
					float u_xlat51;
					float u_xlat16_51;
					float u_xlat52;
					bool u_xlatb52;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat45 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat45 = inversesqrt(u_xlat45);
					    u_xlat2.xyz = vec3(u_xlat45) * u_xlat1.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx;
					    u_xlat33.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat5 = texture(_BumpMap, u_xlat33.xy);
					    u_xlat5.x = u_xlat5.w * u_xlat5.x;
					    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat46 = dot(u_xlat5.xy, u_xlat5.xy);
					    u_xlat46 = min(u_xlat46, 1.0);
					    u_xlat46 = (-u_xlat46) + 1.0;
					    u_xlat5.z = sqrt(u_xlat46);
					    u_xlat33.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_6 = texture(_CameraDepthTexture, u_xlat33.xy);
					    u_xlat46 = _ZBufferParams.z * u_xlat10_6.x + _ZBufferParams.w;
					    u_xlat46 = float(1.0) / u_xlat46;
					    u_xlatb47 = 0.0<u_xlat10_6.x;
					    u_xlat46 = u_xlat46 + (-vs_TEXCOORD6);
					    u_xlat46 = u_xlat46 * _InvFade;
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat46 = (u_xlatb47) ? u_xlat46 : 1.0;
					    u_xlat10_3 = texture(_Surf, u_xlat3.xy);
					    u_xlat47 = (-u_xlat46) + 1.0;
					    u_xlat47 = log2(u_xlat47);
					    u_xlat6.xy = vec2(u_xlat47) * vec2(10.0, 30.0);
					    u_xlat6.xy = exp2(u_xlat6.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xxx;
					    u_xlat47 = (-u_xlat6.y) + 1.0;
					    u_xlat3.xyz = vec3(u_xlat47) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat46) * _FadeColor.xyz + u_xlat3.xyz;
					    u_xlat47 = u_xlat46 * _Specular;
					    u_xlatb48 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb48){
					        u_xlatb50 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb50)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat50 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat21 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat50, u_xlat21);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat50 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat50 = clamp(u_xlat50, 0.0, 1.0);
					    u_xlat6.x = dot(vs_TEXCOORD2.xyz, u_xlat5.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat6.xyz = u_xlat5.xxx * u_xlat6.xyz;
					    u_xlat5.x = (-_Glossiness) + 1.0;
					    u_xlat20.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
					    u_xlat20.x = u_xlat20.x + u_xlat20.x;
					    u_xlat7.xyz = u_xlat6.xyz * (-u_xlat20.xxx) + (-u_xlat2.xyz);
					    u_xlat20.xyz = vec3(u_xlat50) * _LightColor0.xyz;
					    if(u_xlatb48){
					        u_xlatb48 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb48)) ? u_xlat8.xyz : u_xlat0.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat48 = u_xlat8.y * 0.25;
					        u_xlat52 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat23 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat48 = max(u_xlat48, u_xlat52);
					        u_xlat8.x = min(u_xlat23, u_xlat48);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat8.xzw);
					        u_xlat10.xyz = u_xlat8.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_10 = texture(unity_ProbeVolumeSH, u_xlat10.xyz);
					        u_xlat8.xyz = u_xlat8.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(u_xlat10_9, u_xlat6);
					        u_xlat9.y = dot(u_xlat10_10, u_xlat6);
					        u_xlat9.z = dot(u_xlat10_8, u_xlat6);
					    } else {
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(unity_SHAr, u_xlat6);
					        u_xlat9.y = dot(unity_SHAg, u_xlat6);
					        u_xlat9.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat8.xyz = u_xlat9.xyz + vs_TEXCOORD7.xyz;
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat8.xyz = log2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat8.xyz = exp2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb48 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb48){
					        u_xlat48 = dot(u_xlat7.xyz, u_xlat7.xyz);
					        u_xlat48 = inversesqrt(u_xlat48);
					        u_xlat9.xyz = vec3(u_xlat48) * u_xlat7.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					        u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					        u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat10;
					            hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					            hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					            hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					            u_xlat10 = hlslcc_movcTemp;
					        }
					        u_xlat48 = min(u_xlat10.y, u_xlat10.x);
					        u_xlat48 = min(u_xlat10.z, u_xlat48);
					        u_xlat10.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat48) + u_xlat10.xyz;
					    } else {
					        u_xlat9.xyz = u_xlat7.xyz;
					    //ENDIF
					    }
					    u_xlat48 = (-u_xlat5.x) * 0.699999988 + 1.70000005;
					    u_xlat48 = u_xlat48 * u_xlat5.x;
					    u_xlat48 = u_xlat48 * 6.0;
					    u_xlat10_9 = textureLod(unity_SpecCube0, u_xlat9.xyz, u_xlat48);
					    u_xlat16_51 = u_xlat10_9.w + -1.0;
					    u_xlat51 = unity_SpecCube0_HDR.w * u_xlat16_51 + 1.0;
					    u_xlat51 = u_xlat51 * unity_SpecCube0_HDR.x;
					    u_xlat10.xyz = u_xlat10_9.xyz * vec3(u_xlat51);
					    u_xlatb52 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb52){
					        u_xlatb52 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb52){
					            u_xlat52 = dot(u_xlat7.xyz, u_xlat7.xyz);
					            u_xlat52 = inversesqrt(u_xlat52);
					            u_xlat11.xyz = vec3(u_xlat52) * u_xlat7.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat11.xyz;
					            u_xlat13.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat13.xyz = u_xlat13.xyz / u_xlat11.xyz;
					            u_xlatb14.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat11.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat12;
					                hlslcc_movcTemp.x = (u_xlatb14.x) ? u_xlat12.x : u_xlat13.x;
					                hlslcc_movcTemp.y = (u_xlatb14.y) ? u_xlat12.y : u_xlat13.y;
					                hlslcc_movcTemp.z = (u_xlatb14.z) ? u_xlat12.z : u_xlat13.z;
					                u_xlat12 = hlslcc_movcTemp;
					            }
					            u_xlat52 = min(u_xlat12.y, u_xlat12.x);
					            u_xlat52 = min(u_xlat12.z, u_xlat52);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat52) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_7 = textureLod(unity_SpecCube1, u_xlat7.xyz, u_xlat48);
					        u_xlat16_0 = u_xlat10_7.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_7.xyz * u_xlat0.xxx;
					        u_xlat7.xyz = vec3(u_xlat51) * u_xlat10_9.xyz + (-u_xlat0.xyz);
					        u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-_Specular) * u_xlat46 + 1.0;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat15 = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat0.x + u_xlat15;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat45) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
					    u_xlat30 = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat45 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat16 = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = dot(vec2(u_xlat16), u_xlat5.xx);
					    u_xlat16 = u_xlat16 + -0.5;
					    u_xlat31 = (-u_xlat45) + 1.0;
					    u_xlat17 = u_xlat31 * u_xlat31;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat31 = u_xlat31 * u_xlat17;
					    u_xlat31 = u_xlat16 * u_xlat31 + 1.0;
					    u_xlat17 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat17 * u_xlat17;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat17 = u_xlat17 * u_xlat32;
					    u_xlat16 = u_xlat16 * u_xlat17 + 1.0;
					    u_xlat16 = u_xlat16 * u_xlat31;
					    u_xlat16 = u_xlat45 * u_xlat16;
					    u_xlat31 = u_xlat5.x * u_xlat5.x;
					    u_xlat31 = max(u_xlat31, 0.00200000009);
					    u_xlat32 = (-u_xlat31) + 1.0;
					    u_xlat48 = abs(u_xlat30) * u_xlat32 + u_xlat31;
					    u_xlat32 = u_xlat45 * u_xlat32 + u_xlat31;
					    u_xlat30 = abs(u_xlat30) * u_xlat32;
					    u_xlat30 = u_xlat45 * u_xlat48 + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat32 = u_xlat31 * u_xlat31;
					    u_xlat48 = u_xlat2.x * u_xlat32 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat48 * u_xlat2.x + 1.0;
					    u_xlat32 = u_xlat32 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat32 / u_xlat2.x;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat30 = u_xlat30 * 3.14159274;
					    u_xlat30 = max(u_xlat30, 9.99999975e-05);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = u_xlat45 * u_xlat30;
					    u_xlat45 = u_xlat31 * 0.280000001;
					    u_xlat45 = (-u_xlat45) * u_xlat5.x + 1.0;
					    u_xlat31 = dot(vec3(u_xlat47), vec3(u_xlat47));
					    u_xlatb31 = u_xlat31!=0.0;
					    u_xlat31 = u_xlatb31 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat31;
					    u_xlat15 = u_xlat15 + _Glossiness;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat20.xyz * vec3(u_xlat16) + u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat20.xyz * vec3(u_xlat30);
					    u_xlat30 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat30 * u_xlat30;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat30 + u_xlat47;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat6.xyz + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat10.xyz * vec3(u_xlat45);
					    u_xlat15 = (-_Specular) * u_xlat46 + u_xlat15;
					    u_xlat15 = u_xlat17 * u_xlat15 + u_xlat47;
					    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat15) + u_xlat1.xyz;
					    SV_Target0.xyz = u_xlat3.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 _FadeColor;
						vec4 unused_0_7;
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _Surf;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD7;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					vec4 u_xlat10_10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					bvec3 u_xlatb14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					vec3 u_xlat20;
					float u_xlat21;
					float u_xlat23;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					vec2 u_xlat33;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
					bool u_xlatb48;
					float u_xlat50;
					bool u_xlatb50;
					float u_xlat51;
					float u_xlat16_51;
					float u_xlat52;
					bool u_xlatb52;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat45 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat45 = inversesqrt(u_xlat45);
					    u_xlat2.xyz = vec3(u_xlat45) * u_xlat1.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx;
					    u_xlat33.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat5 = texture(_BumpMap, u_xlat33.xy);
					    u_xlat5.x = u_xlat5.w * u_xlat5.x;
					    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat46 = dot(u_xlat5.xy, u_xlat5.xy);
					    u_xlat46 = min(u_xlat46, 1.0);
					    u_xlat46 = (-u_xlat46) + 1.0;
					    u_xlat5.z = sqrt(u_xlat46);
					    u_xlat33.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_6 = texture(_CameraDepthTexture, u_xlat33.xy);
					    u_xlat46 = _ZBufferParams.z * u_xlat10_6.x + _ZBufferParams.w;
					    u_xlat46 = float(1.0) / u_xlat46;
					    u_xlatb47 = 0.0<u_xlat10_6.x;
					    u_xlat46 = u_xlat46 + (-vs_TEXCOORD6);
					    u_xlat46 = u_xlat46 * _InvFade;
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat46 = (u_xlatb47) ? u_xlat46 : 1.0;
					    u_xlat10_3 = texture(_Surf, u_xlat3.xy);
					    u_xlat47 = (-u_xlat46) + 1.0;
					    u_xlat47 = log2(u_xlat47);
					    u_xlat6.xy = vec2(u_xlat47) * vec2(10.0, 30.0);
					    u_xlat6.xy = exp2(u_xlat6.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xxx;
					    u_xlat47 = (-u_xlat6.y) + 1.0;
					    u_xlat3.xyz = vec3(u_xlat47) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat46) * _FadeColor.xyz + u_xlat3.xyz;
					    u_xlat47 = u_xlat46 * _Specular;
					    u_xlatb48 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb48){
					        u_xlatb50 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb50)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat50 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat21 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat50, u_xlat21);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat50 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat50 = clamp(u_xlat50, 0.0, 1.0);
					    u_xlat6.x = dot(vs_TEXCOORD2.xyz, u_xlat5.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat6.xyz = u_xlat5.xxx * u_xlat6.xyz;
					    u_xlat5.x = (-_Glossiness) + 1.0;
					    u_xlat20.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
					    u_xlat20.x = u_xlat20.x + u_xlat20.x;
					    u_xlat7.xyz = u_xlat6.xyz * (-u_xlat20.xxx) + (-u_xlat2.xyz);
					    u_xlat20.xyz = vec3(u_xlat50) * _LightColor0.xyz;
					    if(u_xlatb48){
					        u_xlatb48 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb48)) ? u_xlat8.xyz : u_xlat0.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat48 = u_xlat8.y * 0.25;
					        u_xlat52 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat23 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat48 = max(u_xlat48, u_xlat52);
					        u_xlat8.x = min(u_xlat23, u_xlat48);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat8.xzw);
					        u_xlat10.xyz = u_xlat8.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_10 = texture(unity_ProbeVolumeSH, u_xlat10.xyz);
					        u_xlat8.xyz = u_xlat8.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(u_xlat10_9, u_xlat6);
					        u_xlat9.y = dot(u_xlat10_10, u_xlat6);
					        u_xlat9.z = dot(u_xlat10_8, u_xlat6);
					    } else {
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(unity_SHAr, u_xlat6);
					        u_xlat9.y = dot(unity_SHAg, u_xlat6);
					        u_xlat9.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat8.xyz = u_xlat9.xyz + vs_TEXCOORD7.xyz;
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat8.xyz = log2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat8.xyz = exp2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb48 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb48){
					        u_xlat48 = dot(u_xlat7.xyz, u_xlat7.xyz);
					        u_xlat48 = inversesqrt(u_xlat48);
					        u_xlat9.xyz = vec3(u_xlat48) * u_xlat7.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					        u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					        u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat10;
					            hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					            hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					            hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					            u_xlat10 = hlslcc_movcTemp;
					        }
					        u_xlat48 = min(u_xlat10.y, u_xlat10.x);
					        u_xlat48 = min(u_xlat10.z, u_xlat48);
					        u_xlat10.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat48) + u_xlat10.xyz;
					    } else {
					        u_xlat9.xyz = u_xlat7.xyz;
					    //ENDIF
					    }
					    u_xlat48 = (-u_xlat5.x) * 0.699999988 + 1.70000005;
					    u_xlat48 = u_xlat48 * u_xlat5.x;
					    u_xlat48 = u_xlat48 * 6.0;
					    u_xlat10_9 = textureLod(unity_SpecCube0, u_xlat9.xyz, u_xlat48);
					    u_xlat16_51 = u_xlat10_9.w + -1.0;
					    u_xlat51 = unity_SpecCube0_HDR.w * u_xlat16_51 + 1.0;
					    u_xlat51 = u_xlat51 * unity_SpecCube0_HDR.x;
					    u_xlat10.xyz = u_xlat10_9.xyz * vec3(u_xlat51);
					    u_xlatb52 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb52){
					        u_xlatb52 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb52){
					            u_xlat52 = dot(u_xlat7.xyz, u_xlat7.xyz);
					            u_xlat52 = inversesqrt(u_xlat52);
					            u_xlat11.xyz = vec3(u_xlat52) * u_xlat7.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat11.xyz;
					            u_xlat13.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat13.xyz = u_xlat13.xyz / u_xlat11.xyz;
					            u_xlatb14.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat11.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat12;
					                hlslcc_movcTemp.x = (u_xlatb14.x) ? u_xlat12.x : u_xlat13.x;
					                hlslcc_movcTemp.y = (u_xlatb14.y) ? u_xlat12.y : u_xlat13.y;
					                hlslcc_movcTemp.z = (u_xlatb14.z) ? u_xlat12.z : u_xlat13.z;
					                u_xlat12 = hlslcc_movcTemp;
					            }
					            u_xlat52 = min(u_xlat12.y, u_xlat12.x);
					            u_xlat52 = min(u_xlat12.z, u_xlat52);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat52) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_7 = textureLod(unity_SpecCube1, u_xlat7.xyz, u_xlat48);
					        u_xlat16_0 = u_xlat10_7.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_7.xyz * u_xlat0.xxx;
					        u_xlat7.xyz = vec3(u_xlat51) * u_xlat10_9.xyz + (-u_xlat0.xyz);
					        u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-_Specular) * u_xlat46 + 1.0;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat15 = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat0.x + u_xlat15;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat45) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
					    u_xlat30 = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat45 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat16 = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = dot(vec2(u_xlat16), u_xlat5.xx);
					    u_xlat16 = u_xlat16 + -0.5;
					    u_xlat31 = (-u_xlat45) + 1.0;
					    u_xlat17 = u_xlat31 * u_xlat31;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat31 = u_xlat31 * u_xlat17;
					    u_xlat31 = u_xlat16 * u_xlat31 + 1.0;
					    u_xlat17 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat17 * u_xlat17;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat17 = u_xlat17 * u_xlat32;
					    u_xlat16 = u_xlat16 * u_xlat17 + 1.0;
					    u_xlat16 = u_xlat16 * u_xlat31;
					    u_xlat16 = u_xlat45 * u_xlat16;
					    u_xlat31 = u_xlat5.x * u_xlat5.x;
					    u_xlat31 = max(u_xlat31, 0.00200000009);
					    u_xlat32 = (-u_xlat31) + 1.0;
					    u_xlat48 = abs(u_xlat30) * u_xlat32 + u_xlat31;
					    u_xlat32 = u_xlat45 * u_xlat32 + u_xlat31;
					    u_xlat30 = abs(u_xlat30) * u_xlat32;
					    u_xlat30 = u_xlat45 * u_xlat48 + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat32 = u_xlat31 * u_xlat31;
					    u_xlat48 = u_xlat2.x * u_xlat32 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat48 * u_xlat2.x + 1.0;
					    u_xlat32 = u_xlat32 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat32 / u_xlat2.x;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat30 = u_xlat30 * 3.14159274;
					    u_xlat30 = max(u_xlat30, 9.99999975e-05);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = u_xlat45 * u_xlat30;
					    u_xlat45 = u_xlat31 * 0.280000001;
					    u_xlat45 = (-u_xlat45) * u_xlat5.x + 1.0;
					    u_xlat31 = dot(vec3(u_xlat47), vec3(u_xlat47));
					    u_xlatb31 = u_xlat31!=0.0;
					    u_xlat31 = u_xlatb31 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat31;
					    u_xlat15 = u_xlat15 + _Glossiness;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat20.xyz * vec3(u_xlat16) + u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat20.xyz * vec3(u_xlat30);
					    u_xlat30 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat30 * u_xlat30;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat30 + u_xlat47;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat6.xyz + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat10.xyz * vec3(u_xlat45);
					    u_xlat15 = (-_Specular) * u_xlat46 + u_xlat15;
					    u_xlat15 = u_xlat17 * u_xlat15 + u_xlat47;
					    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat15) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat45 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat45 = (-u_xlat45) + 1.0;
					    u_xlat45 = u_xlat45 * _ProjectionParams.z;
					    u_xlat45 = max(u_xlat45, 0.0);
					    u_xlat45 = u_xlat45 * unity_FogParams.x;
					    u_xlat45 = u_xlat45 * (-u_xlat45);
					    u_xlat45 = exp2(u_xlat45);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat45) * u_xlat0.xyz + unity_FogColor.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 _FadeColor;
						vec4 unused_0_7;
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[3];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _Surf;
					uniform  samplerCube unity_SpecCube0;
					uniform  samplerCube unity_SpecCube1;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec2 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  float vs_TEXCOORD8;
					in  vec4 vs_TEXCOORD2;
					in  vec4 vs_TEXCOORD3;
					in  vec4 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  vec3 vs_TEXCOORD7;
					layout(location = 0) out vec4 SV_Target0;
					vec4 u_xlat0;
					float u_xlat16_0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					vec4 u_xlat10_7;
					vec4 u_xlat8;
					vec4 u_xlat10_8;
					vec3 u_xlat9;
					vec4 u_xlat10_9;
					vec3 u_xlat10;
					vec4 u_xlat10_10;
					vec3 u_xlat11;
					vec3 u_xlat12;
					bvec3 u_xlatb12;
					vec3 u_xlat13;
					bvec3 u_xlatb14;
					float u_xlat15;
					float u_xlat16;
					float u_xlat17;
					vec3 u_xlat20;
					float u_xlat21;
					float u_xlat23;
					float u_xlat30;
					float u_xlat31;
					bool u_xlatb31;
					float u_xlat32;
					vec2 u_xlat33;
					float u_xlat45;
					float u_xlat46;
					float u_xlat47;
					bool u_xlatb47;
					float u_xlat48;
					bool u_xlatb48;
					float u_xlat50;
					bool u_xlatb50;
					float u_xlat51;
					float u_xlat16_51;
					float u_xlat52;
					bool u_xlatb52;
					void main()
					{
					    u_xlat0.x = vs_TEXCOORD2.w;
					    u_xlat0.y = vs_TEXCOORD3.w;
					    u_xlat0.z = vs_TEXCOORD4.w;
					    u_xlat1.xyz = (-u_xlat0.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat45 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat45 = inversesqrt(u_xlat45);
					    u_xlat2.xyz = vec3(u_xlat45) * u_xlat1.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx;
					    u_xlat33.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vs_TEXCOORD1.xy;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat5 = texture(_BumpMap, u_xlat33.xy);
					    u_xlat5.x = u_xlat5.w * u_xlat5.x;
					    u_xlat5.xy = u_xlat5.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat46 = dot(u_xlat5.xy, u_xlat5.xy);
					    u_xlat46 = min(u_xlat46, 1.0);
					    u_xlat46 = (-u_xlat46) + 1.0;
					    u_xlat5.z = sqrt(u_xlat46);
					    u_xlat33.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_6 = texture(_CameraDepthTexture, u_xlat33.xy);
					    u_xlat46 = _ZBufferParams.z * u_xlat10_6.x + _ZBufferParams.w;
					    u_xlat46 = float(1.0) / u_xlat46;
					    u_xlatb47 = 0.0<u_xlat10_6.x;
					    u_xlat46 = u_xlat46 + (-vs_TEXCOORD6);
					    u_xlat46 = u_xlat46 * _InvFade;
					    u_xlat46 = clamp(u_xlat46, 0.0, 1.0);
					    u_xlat46 = (u_xlatb47) ? u_xlat46 : 1.0;
					    u_xlat10_3 = texture(_Surf, u_xlat3.xy);
					    u_xlat47 = (-u_xlat46) + 1.0;
					    u_xlat47 = log2(u_xlat47);
					    u_xlat6.xy = vec2(u_xlat47) * vec2(10.0, 30.0);
					    u_xlat6.xy = exp2(u_xlat6.xy);
					    u_xlat3.xyz = u_xlat10_3.xyz * u_xlat6.xxx;
					    u_xlat47 = (-u_xlat6.y) + 1.0;
					    u_xlat3.xyz = vec3(u_xlat47) * u_xlat3.xyz;
					    u_xlat3.xyz = vec3(u_xlat46) * _FadeColor.xyz + u_xlat3.xyz;
					    u_xlat47 = u_xlat46 * _Specular;
					    u_xlatb48 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb48){
					        u_xlatb50 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb50)) ? u_xlat6.xyz : u_xlat0.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat50 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat21 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat50, u_xlat21);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat50 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat50 = clamp(u_xlat50, 0.0, 1.0);
					    u_xlat6.x = dot(vs_TEXCOORD2.xyz, u_xlat5.xyz);
					    u_xlat6.y = dot(vs_TEXCOORD3.xyz, u_xlat5.xyz);
					    u_xlat6.z = dot(vs_TEXCOORD4.xyz, u_xlat5.xyz);
					    u_xlat5.x = dot(u_xlat6.xyz, u_xlat6.xyz);
					    u_xlat5.x = inversesqrt(u_xlat5.x);
					    u_xlat6.xyz = u_xlat5.xxx * u_xlat6.xyz;
					    u_xlat5.x = (-_Glossiness) + 1.0;
					    u_xlat20.x = dot((-u_xlat2.xyz), u_xlat6.xyz);
					    u_xlat20.x = u_xlat20.x + u_xlat20.x;
					    u_xlat7.xyz = u_xlat6.xyz * (-u_xlat20.xxx) + (-u_xlat2.xyz);
					    u_xlat20.xyz = vec3(u_xlat50) * _LightColor0.xyz;
					    if(u_xlatb48){
					        u_xlatb48 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat8.xyz = vs_TEXCOORD3.www * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD2.www + u_xlat8.xyz;
					        u_xlat8.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.www + u_xlat8.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat8.xyz = (bool(u_xlatb48)) ? u_xlat8.xyz : u_xlat0.xyz;
					        u_xlat8.xyz = u_xlat8.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat8.yzw = u_xlat8.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat48 = u_xlat8.y * 0.25;
					        u_xlat52 = unity_ProbeVolumeParams.z * 0.5;
					        u_xlat23 = (-unity_ProbeVolumeParams.z) * 0.5 + 0.25;
					        u_xlat48 = max(u_xlat48, u_xlat52);
					        u_xlat8.x = min(u_xlat23, u_xlat48);
					        u_xlat10_9 = texture(unity_ProbeVolumeSH, u_xlat8.xzw);
					        u_xlat10.xyz = u_xlat8.xzw + vec3(0.25, 0.0, 0.0);
					        u_xlat10_10 = texture(unity_ProbeVolumeSH, u_xlat10.xyz);
					        u_xlat8.xyz = u_xlat8.xzw + vec3(0.5, 0.0, 0.0);
					        u_xlat10_8 = texture(unity_ProbeVolumeSH, u_xlat8.xyz);
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(u_xlat10_9, u_xlat6);
					        u_xlat9.y = dot(u_xlat10_10, u_xlat6);
					        u_xlat9.z = dot(u_xlat10_8, u_xlat6);
					    } else {
					        u_xlat6.w = 1.0;
					        u_xlat9.x = dot(unity_SHAr, u_xlat6);
					        u_xlat9.y = dot(unity_SHAg, u_xlat6);
					        u_xlat9.z = dot(unity_SHAb, u_xlat6);
					    //ENDIF
					    }
					    u_xlat8.xyz = u_xlat9.xyz + vs_TEXCOORD7.xyz;
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlat8.xyz = log2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(0.416666657, 0.416666657, 0.416666657);
					    u_xlat8.xyz = exp2(u_xlat8.xyz);
					    u_xlat8.xyz = u_xlat8.xyz * vec3(1.05499995, 1.05499995, 1.05499995) + vec3(-0.0549999997, -0.0549999997, -0.0549999997);
					    u_xlat8.xyz = max(u_xlat8.xyz, vec3(0.0, 0.0, 0.0));
					    u_xlatb48 = 0.0<unity_SpecCube0_ProbePosition.w;
					    if(u_xlatb48){
					        u_xlat48 = dot(u_xlat7.xyz, u_xlat7.xyz);
					        u_xlat48 = inversesqrt(u_xlat48);
					        u_xlat9.xyz = vec3(u_xlat48) * u_xlat7.xyz;
					        u_xlat10.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMax.xyz;
					        u_xlat10.xyz = u_xlat10.xyz / u_xlat9.xyz;
					        u_xlat11.xyz = (-u_xlat0.xyz) + unity_SpecCube0_BoxMin.xyz;
					        u_xlat11.xyz = u_xlat11.xyz / u_xlat9.xyz;
					        u_xlatb12.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat9.xyzx).xyz;
					        {
					            vec3 hlslcc_movcTemp = u_xlat10;
					            hlslcc_movcTemp.x = (u_xlatb12.x) ? u_xlat10.x : u_xlat11.x;
					            hlslcc_movcTemp.y = (u_xlatb12.y) ? u_xlat10.y : u_xlat11.y;
					            hlslcc_movcTemp.z = (u_xlatb12.z) ? u_xlat10.z : u_xlat11.z;
					            u_xlat10 = hlslcc_movcTemp;
					        }
					        u_xlat48 = min(u_xlat10.y, u_xlat10.x);
					        u_xlat48 = min(u_xlat10.z, u_xlat48);
					        u_xlat10.xyz = u_xlat0.xyz + (-unity_SpecCube0_ProbePosition.xyz);
					        u_xlat9.xyz = u_xlat9.xyz * vec3(u_xlat48) + u_xlat10.xyz;
					    } else {
					        u_xlat9.xyz = u_xlat7.xyz;
					    //ENDIF
					    }
					    u_xlat48 = (-u_xlat5.x) * 0.699999988 + 1.70000005;
					    u_xlat48 = u_xlat48 * u_xlat5.x;
					    u_xlat48 = u_xlat48 * 6.0;
					    u_xlat10_9 = textureLod(unity_SpecCube0, u_xlat9.xyz, u_xlat48);
					    u_xlat16_51 = u_xlat10_9.w + -1.0;
					    u_xlat51 = unity_SpecCube0_HDR.w * u_xlat16_51 + 1.0;
					    u_xlat51 = u_xlat51 * unity_SpecCube0_HDR.x;
					    u_xlat10.xyz = u_xlat10_9.xyz * vec3(u_xlat51);
					    u_xlatb52 = unity_SpecCube0_BoxMin.w<0.999989986;
					    if(u_xlatb52){
					        u_xlatb52 = 0.0<unity_SpecCube1_ProbePosition.w;
					        if(u_xlatb52){
					            u_xlat52 = dot(u_xlat7.xyz, u_xlat7.xyz);
					            u_xlat52 = inversesqrt(u_xlat52);
					            u_xlat11.xyz = vec3(u_xlat52) * u_xlat7.xyz;
					            u_xlat12.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMax.xyz;
					            u_xlat12.xyz = u_xlat12.xyz / u_xlat11.xyz;
					            u_xlat13.xyz = (-u_xlat0.xyz) + unity_SpecCube1_BoxMin.xyz;
					            u_xlat13.xyz = u_xlat13.xyz / u_xlat11.xyz;
					            u_xlatb14.xyz = lessThan(vec4(0.0, 0.0, 0.0, 0.0), u_xlat11.xyzx).xyz;
					            {
					                vec3 hlslcc_movcTemp = u_xlat12;
					                hlslcc_movcTemp.x = (u_xlatb14.x) ? u_xlat12.x : u_xlat13.x;
					                hlslcc_movcTemp.y = (u_xlatb14.y) ? u_xlat12.y : u_xlat13.y;
					                hlslcc_movcTemp.z = (u_xlatb14.z) ? u_xlat12.z : u_xlat13.z;
					                u_xlat12 = hlslcc_movcTemp;
					            }
					            u_xlat52 = min(u_xlat12.y, u_xlat12.x);
					            u_xlat52 = min(u_xlat12.z, u_xlat52);
					            u_xlat0.xyz = u_xlat0.xyz + (-unity_SpecCube1_ProbePosition.xyz);
					            u_xlat7.xyz = u_xlat11.xyz * vec3(u_xlat52) + u_xlat0.xyz;
					        //ENDIF
					        }
					        u_xlat10_7 = textureLod(unity_SpecCube1, u_xlat7.xyz, u_xlat48);
					        u_xlat16_0 = u_xlat10_7.w + -1.0;
					        u_xlat0.x = unity_SpecCube1_HDR.w * u_xlat16_0 + 1.0;
					        u_xlat0.x = u_xlat0.x * unity_SpecCube1_HDR.x;
					        u_xlat0.xyz = u_xlat10_7.xyz * u_xlat0.xxx;
					        u_xlat7.xyz = vec3(u_xlat51) * u_xlat10_9.xyz + (-u_xlat0.xyz);
					        u_xlat10.xyz = unity_SpecCube0_BoxMin.www * u_xlat7.xyz + u_xlat0.xyz;
					    //ENDIF
					    }
					    u_xlat0.x = (-_Specular) * u_xlat46 + 1.0;
					    u_xlat4.xyz = u_xlat0.xxx * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat15 = (-u_xlat0.x) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat0.x + u_xlat15;
					    u_xlat1.xyz = u_xlat1.xyz * vec3(u_xlat45) + _WorldSpaceLightPos0.xyz;
					    u_xlat30 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat30 = max(u_xlat30, 0.00100000005);
					    u_xlat30 = inversesqrt(u_xlat30);
					    u_xlat1.xyz = vec3(u_xlat30) * u_xlat1.xyz;
					    u_xlat30 = dot(u_xlat6.xyz, u_xlat2.xyz);
					    u_xlat45 = dot(u_xlat6.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat45 = clamp(u_xlat45, 0.0, 1.0);
					    u_xlat2.x = dot(u_xlat6.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat1.x = dot(_WorldSpaceLightPos0.xyz, u_xlat1.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat16 = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = dot(vec2(u_xlat16), u_xlat5.xx);
					    u_xlat16 = u_xlat16 + -0.5;
					    u_xlat31 = (-u_xlat45) + 1.0;
					    u_xlat17 = u_xlat31 * u_xlat31;
					    u_xlat17 = u_xlat17 * u_xlat17;
					    u_xlat31 = u_xlat31 * u_xlat17;
					    u_xlat31 = u_xlat16 * u_xlat31 + 1.0;
					    u_xlat17 = -abs(u_xlat30) + 1.0;
					    u_xlat32 = u_xlat17 * u_xlat17;
					    u_xlat32 = u_xlat32 * u_xlat32;
					    u_xlat17 = u_xlat17 * u_xlat32;
					    u_xlat16 = u_xlat16 * u_xlat17 + 1.0;
					    u_xlat16 = u_xlat16 * u_xlat31;
					    u_xlat16 = u_xlat45 * u_xlat16;
					    u_xlat31 = u_xlat5.x * u_xlat5.x;
					    u_xlat31 = max(u_xlat31, 0.00200000009);
					    u_xlat32 = (-u_xlat31) + 1.0;
					    u_xlat48 = abs(u_xlat30) * u_xlat32 + u_xlat31;
					    u_xlat32 = u_xlat45 * u_xlat32 + u_xlat31;
					    u_xlat30 = abs(u_xlat30) * u_xlat32;
					    u_xlat30 = u_xlat45 * u_xlat48 + u_xlat30;
					    u_xlat30 = u_xlat30 + 9.99999975e-06;
					    u_xlat30 = 0.5 / u_xlat30;
					    u_xlat32 = u_xlat31 * u_xlat31;
					    u_xlat48 = u_xlat2.x * u_xlat32 + (-u_xlat2.x);
					    u_xlat2.x = u_xlat48 * u_xlat2.x + 1.0;
					    u_xlat32 = u_xlat32 * 0.318309873;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x + 1.00000001e-07;
					    u_xlat2.x = u_xlat32 / u_xlat2.x;
					    u_xlat30 = u_xlat30 * u_xlat2.x;
					    u_xlat30 = u_xlat30 * 3.14159274;
					    u_xlat30 = max(u_xlat30, 9.99999975e-05);
					    u_xlat30 = sqrt(u_xlat30);
					    u_xlat30 = u_xlat45 * u_xlat30;
					    u_xlat45 = u_xlat31 * 0.280000001;
					    u_xlat45 = (-u_xlat45) * u_xlat5.x + 1.0;
					    u_xlat31 = dot(vec3(u_xlat47), vec3(u_xlat47));
					    u_xlatb31 = u_xlat31!=0.0;
					    u_xlat31 = u_xlatb31 ? 1.0 : float(0.0);
					    u_xlat30 = u_xlat30 * u_xlat31;
					    u_xlat15 = u_xlat15 + _Glossiness;
					    u_xlat15 = clamp(u_xlat15, 0.0, 1.0);
					    u_xlat6.xyz = u_xlat20.xyz * vec3(u_xlat16) + u_xlat8.xyz;
					    u_xlat5.xyz = u_xlat20.xyz * vec3(u_xlat30);
					    u_xlat30 = (-u_xlat1.x) + 1.0;
					    u_xlat1.x = u_xlat30 * u_xlat30;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat30 = u_xlat30 * u_xlat1.x;
					    u_xlat0.x = u_xlat0.x * u_xlat30 + u_xlat47;
					    u_xlat1.xyz = u_xlat0.xxx * u_xlat5.xyz;
					    u_xlat1.xyz = u_xlat4.xyz * u_xlat6.xyz + u_xlat1.xyz;
					    u_xlat0.xzw = u_xlat10.xyz * vec3(u_xlat45);
					    u_xlat15 = (-_Specular) * u_xlat46 + u_xlat15;
					    u_xlat15 = u_xlat17 * u_xlat15 + u_xlat47;
					    u_xlat0.xyz = u_xlat0.xzw * vec3(u_xlat15) + u_xlat1.xyz;
					    u_xlat0.xyz = u_xlat3.xyz + u_xlat0.xyz;
					    u_xlat45 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat45 = (-u_xlat45) + 1.0;
					    u_xlat45 = u_xlat45 * _ProjectionParams.z;
					    u_xlat45 = max(u_xlat45, 0.0);
					    u_xlat45 = u_xlat45 * unity_FogParams.x;
					    u_xlat45 = u_xlat45 * (-u_xlat45);
					    u_xlat45 = exp2(u_xlat45);
					    u_xlat0.xyz = u_xlat0.xyz + (-unity_FogColor.xyz);
					    SV_Target0.xyz = vec3(u_xlat45) * u_xlat0.xyz + unity_FogColor.xyz;
					    return;
					}"
				}
			}
		}
		Pass {
			Name "FORWARD"
			LOD 200
			Tags { "LIGHTMODE" = "FORWARDADD" "QUEUE" = "Transparent" "RenderType" = "Transparent" }
			Blend One One, One One
			ColorMask RGB -1
			ZWrite Off
			GpuProgramID 77936
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat5 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat5;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec2 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD8 = u_xlat2.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_0[9];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec3 u_xlat2;
					vec3 u_xlat3;
					float u_xlat5;
					float u_xlat13;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat0 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat0;
					    u_xlat0 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat0;
					    u_xlat0 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat0;
					    gl_Position = u_xlat0;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat5 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat5;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat13 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat1.xyz = vec3(u_xlat13) * u_xlat1.xyz;
					    u_xlat2.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat2.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat2.xyz;
					    u_xlat2.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat2.xyz;
					    u_xlat13 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat13 = inversesqrt(u_xlat13);
					    u_xlat2.xyz = vec3(u_xlat13) * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.xyz * u_xlat2.xyz;
					    u_xlat3.xyz = u_xlat1.zxy * u_xlat2.yzx + (-u_xlat3.xyz);
					    u_xlat13 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat3.xyz = vec3(u_xlat13) * u_xlat3.xyz;
					    vs_TEXCOORD1.y = u_xlat3.x;
					    vs_TEXCOORD1.x = u_xlat2.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat2.x;
					    vs_TEXCOORD3.x = u_xlat2.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat3.y;
					    vs_TEXCOORD3.y = u_xlat3.z;
					    vs_TEXCOORD8 = u_xlat0.z;
					    u_xlat0.y = u_xlat0.y * _ProjectionParams.x;
					    u_xlat1.xzw = u_xlat0.xwy * vec3(0.5, 0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat0.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec4 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD8 = u_xlat2.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1 = u_xlat0.yyyy * unity_WorldToLight[1];
					    u_xlat1 = unity_WorldToLight[0] * u_xlat0.xxxx + u_xlat1;
					    u_xlat1 = unity_WorldToLight[2] * u_xlat0.zzzz + u_xlat1;
					    vs_TEXCOORD7 = unity_WorldToLight[3] * u_xlat0.wwww + u_xlat1;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out float vs_TEXCOORD8;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec3 vs_TEXCOORD7;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD8 = u_xlat2.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    u_xlat1.xyz = u_xlat0.yyy * unity_WorldToLight[1].xyz;
					    u_xlat1.xyz = unity_WorldToLight[0].xyz * u_xlat0.xxx + u_xlat1.xyz;
					    u_xlat0.xyz = unity_WorldToLight[2].xyz * u_xlat0.zzz + u_xlat1.xyz;
					    vs_TEXCOORD7.xyz = unity_WorldToLight[3].xyz * u_xlat0.www + u_xlat0.xyz;
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
						vec4 unused_0_2[5];
						vec4 _MainTex_ST;
						vec4 _BumpMap_ST;
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
						vec4 unused_3_0[9];
						mat4x4 unity_MatrixV;
						vec4 unused_3_2[4];
						mat4x4 unity_MatrixVP;
						vec4 unused_3_4[2];
					};
					in  vec4 in_POSITION0;
					in  vec4 in_TANGENT0;
					in  vec3 in_NORMAL0;
					in  vec4 in_TEXCOORD0;
					out vec4 vs_TEXCOORD0;
					out vec3 vs_TEXCOORD1;
					out float vs_TEXCOORD6;
					out vec3 vs_TEXCOORD2;
					out vec3 vs_TEXCOORD3;
					out vec3 vs_TEXCOORD4;
					out vec4 vs_TEXCOORD5;
					out vec2 vs_TEXCOORD7;
					out float vs_TEXCOORD8;
					vec4 u_xlat0;
					vec4 u_xlat1;
					vec4 u_xlat2;
					vec3 u_xlat3;
					vec3 u_xlat4;
					float u_xlat6;
					float u_xlat16;
					void main()
					{
					    u_xlat0 = in_POSITION0.yyyy * unity_ObjectToWorld[1];
					    u_xlat0 = unity_ObjectToWorld[0] * in_POSITION0.xxxx + u_xlat0;
					    u_xlat0 = unity_ObjectToWorld[2] * in_POSITION0.zzzz + u_xlat0;
					    u_xlat1 = u_xlat0 + unity_ObjectToWorld[3];
					    u_xlat2 = u_xlat1.yyyy * unity_MatrixVP[1];
					    u_xlat2 = unity_MatrixVP[0] * u_xlat1.xxxx + u_xlat2;
					    u_xlat2 = unity_MatrixVP[2] * u_xlat1.zzzz + u_xlat2;
					    u_xlat2 = unity_MatrixVP[3] * u_xlat1.wwww + u_xlat2;
					    gl_Position = u_xlat2;
					    vs_TEXCOORD0.xy = in_TEXCOORD0.xy * _MainTex_ST.xy + _MainTex_ST.zw;
					    vs_TEXCOORD0.zw = in_TEXCOORD0.xy * _BumpMap_ST.xy + _BumpMap_ST.zw;
					    u_xlat6 = u_xlat1.y * unity_MatrixV[1].z;
					    u_xlat1.x = unity_MatrixV[0].z * u_xlat1.x + u_xlat6;
					    u_xlat1.x = unity_MatrixV[2].z * u_xlat1.z + u_xlat1.x;
					    u_xlat1.x = unity_MatrixV[3].z * u_xlat1.w + u_xlat1.x;
					    vs_TEXCOORD6 = (-u_xlat1.x);
					    u_xlat1.y = dot(in_NORMAL0.xyz, unity_WorldToObject[0].xyz);
					    u_xlat1.z = dot(in_NORMAL0.xyz, unity_WorldToObject[1].xyz);
					    u_xlat1.x = dot(in_NORMAL0.xyz, unity_WorldToObject[2].xyz);
					    u_xlat16 = dot(u_xlat1.xyz, u_xlat1.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat1.xyz = vec3(u_xlat16) * u_xlat1.xyz;
					    u_xlat3.xyz = in_TANGENT0.yyy * unity_ObjectToWorld[1].yzx;
					    u_xlat3.xyz = unity_ObjectToWorld[0].yzx * in_TANGENT0.xxx + u_xlat3.xyz;
					    u_xlat3.xyz = unity_ObjectToWorld[2].yzx * in_TANGENT0.zzz + u_xlat3.xyz;
					    u_xlat16 = dot(u_xlat3.xyz, u_xlat3.xyz);
					    u_xlat16 = inversesqrt(u_xlat16);
					    u_xlat3.xyz = vec3(u_xlat16) * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.xyz * u_xlat3.xyz;
					    u_xlat4.xyz = u_xlat1.zxy * u_xlat3.yzx + (-u_xlat4.xyz);
					    u_xlat16 = in_TANGENT0.w * unity_WorldTransformParams.w;
					    u_xlat4.xyz = vec3(u_xlat16) * u_xlat4.xyz;
					    vs_TEXCOORD1.y = u_xlat4.x;
					    vs_TEXCOORD1.x = u_xlat3.z;
					    vs_TEXCOORD1.z = u_xlat1.y;
					    vs_TEXCOORD2.x = u_xlat3.x;
					    vs_TEXCOORD3.x = u_xlat3.y;
					    vs_TEXCOORD2.z = u_xlat1.z;
					    vs_TEXCOORD3.z = u_xlat1.x;
					    vs_TEXCOORD2.y = u_xlat4.y;
					    vs_TEXCOORD3.y = u_xlat4.z;
					    vs_TEXCOORD4.xyz = unity_ObjectToWorld[3].xyz * in_POSITION0.www + u_xlat0.xyz;
					    u_xlat0 = unity_ObjectToWorld[3] * in_POSITION0.wwww + u_xlat0;
					    u_xlat1.x = u_xlat2.y * _ProjectionParams.x;
					    u_xlat1.w = u_xlat1.x * 0.5;
					    u_xlat1.xz = u_xlat2.xw * vec2(0.5, 0.5);
					    vs_TEXCOORD5.xy = u_xlat1.zz + u_xlat1.xw;
					    vs_TEXCOORD5.zw = u_xlat2.zw;
					    vs_TEXCOORD8 = u_xlat2.z;
					    u_xlat1.xy = u_xlat0.yy * unity_WorldToLight[1].xy;
					    u_xlat0.xy = unity_WorldToLight[0].xy * u_xlat0.xx + u_xlat1.xy;
					    u_xlat0.xy = unity_WorldToLight[2].xy * u_xlat0.zz + u_xlat0.xy;
					    vs_TEXCOORD7.xy = unity_WorldToLight[3].xy * u_xlat0.ww + u_xlat0.xy;
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat3 = texture(_BumpMap, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_CameraDepthTexture, u_xlat5.xy);
					    u_xlat22 = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlatb23 = 0.0<u_xlat10_5.x;
					    u_xlat22 = u_xlat22 + (-vs_TEXCOORD6);
					    u_xlat22 = u_xlat22 * _InvFade;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat22 = (u_xlatb23) ? u_xlat22 : 1.0;
					    u_xlat23 = u_xlat22 * _Specular;
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb24 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb24){
					        u_xlatb24 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb24)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat24 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat24, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat24 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xx);
					    u_xlat24 = u_xlat24 * u_xlat10_5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
					    u_xlat22 = (-_Specular) * u_xlat22 + 1.0;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat24 = (-u_xlat22) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat22 + u_xlat24;
					    u_xlat24 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat24));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat24 * u_xlat24;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(vec3(u_xlat23), vec3(u_xlat23));
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat23;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_6[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_10[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					vec3 u_xlat10;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_3 * _Color;
					    u_xlat2 = texture(_BumpMap, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_CameraDepthTexture, u_xlat4.xy);
					    u_xlat19 = _ZBufferParams.z * u_xlat10_4.x + _ZBufferParams.w;
					    u_xlat19 = float(1.0) / u_xlat19;
					    u_xlatb20 = 0.0<u_xlat10_4.x;
					    u_xlat19 = u_xlat19 + (-vs_TEXCOORD6);
					    u_xlat19 = u_xlat19 * _InvFade;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat19 = (u_xlatb20) ? u_xlat19 : 1.0;
					    u_xlat20 = u_xlat19 * _Specular;
					    u_xlatb4 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb4){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat10.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat10.x, u_xlat5.x);
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
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xxx * _LightColor0.xyz;
					    u_xlat19 = (-_Specular) * u_xlat19 + 1.0;
					    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.www * u_xlat3.xyz;
					    u_xlat22 = (-u_xlat19) + 1.0;
					    SV_Target0.w = u_xlat3.w * u_xlat19 + u_xlat22;
					    u_xlat21 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat21));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat21 * u_xlat21;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat2.x = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat2.x + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(vec3(u_xlat20), vec3(u_xlat20));
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat19 * u_xlat0.x + u_xlat20;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bool u_xlatb6;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat10;
					vec2 u_xlat14;
					float u_xlat16;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat3 = texture(_BumpMap, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat25 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat3.z = sqrt(u_xlat25);
					    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_CameraDepthTexture, u_xlat5.xy);
					    u_xlat25 = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlatb26 = 0.0<u_xlat10_5.x;
					    u_xlat25 = u_xlat25 + (-vs_TEXCOORD6);
					    u_xlat25 = u_xlat25 * _InvFade;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat25 = (u_xlatb26) ? u_xlat25 : 1.0;
					    u_xlat26 = u_xlat25 * _Specular;
					    u_xlat5 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb27)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat14.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat27, u_xlat14.x);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat27 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlatb6 = 0.0<u_xlat5.z;
					    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
					    u_xlat14.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
					    u_xlat10_7 = texture(_LightTexture0, u_xlat14.xy);
					    u_xlat29 = u_xlat6.x * u_xlat10_7.w;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, u_xlat5.xx);
					    u_xlat5.x = u_xlat29 * u_xlat10_6.x;
					    u_xlat27 = u_xlat27 * u_xlat5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
					    u_xlat25 = (-_Specular) * u_xlat25 + 1.0;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat27 = (-u_xlat25) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat25 + u_xlat27;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat10 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat27));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat27 * u_xlat27;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat2.x * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat10 * u_xlat16 + (-u_xlat10);
					    u_xlat1.x = u_xlat1.x * u_xlat10 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat2.xx * u_xlat8.xy;
					    u_xlat24 = dot(vec3(u_xlat26), vec3(u_xlat26));
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat26;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					float u_xlat16_5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat3 = texture(_BumpMap, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_CameraDepthTexture, u_xlat5.xy);
					    u_xlat22 = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlatb23 = 0.0<u_xlat10_5.x;
					    u_xlat22 = u_xlat22 + (-vs_TEXCOORD6);
					    u_xlat22 = u_xlat22 * _InvFade;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat22 = (u_xlatb23) ? u_xlat22 : 1.0;
					    u_xlat23 = u_xlat22 * _Specular;
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb24 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb24){
					        u_xlatb24 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb24)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat24 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat24, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat24 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, vec2(u_xlat26));
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat16_5 = u_xlat10_5.w * u_xlat10_6.x;
					    u_xlat24 = u_xlat24 * u_xlat16_5;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
					    u_xlat22 = (-_Specular) * u_xlat22 + 1.0;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat24 = (-u_xlat22) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat22 + u_xlat24;
					    u_xlat24 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat24));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat24 * u_xlat24;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(vec3(u_xlat23), vec3(u_xlat23));
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat23;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    SV_Target0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 unused_1_3[2];
						vec4 _ZBufferParams;
						vec4 unused_1_5;
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
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_3 * _Color;
					    u_xlat2 = texture(_BumpMap, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_CameraDepthTexture, u_xlat4.xy);
					    u_xlat19 = _ZBufferParams.z * u_xlat10_4.x + _ZBufferParams.w;
					    u_xlat19 = float(1.0) / u_xlat19;
					    u_xlatb20 = 0.0<u_xlat10_4.x;
					    u_xlat19 = u_xlat19 + (-vs_TEXCOORD6);
					    u_xlat19 = u_xlat19 * _InvFade;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat19 = (u_xlatb20) ? u_xlat19 : 1.0;
					    u_xlat20 = u_xlat19 * _Specular;
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb16)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat16);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat16 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat10_5 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat4.x = u_xlat16 * u_xlat10_5.w;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xxx * _LightColor0.xyz;
					    u_xlat19 = (-_Specular) * u_xlat19 + 1.0;
					    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.www * u_xlat3.xyz;
					    u_xlat22 = (-u_xlat19) + 1.0;
					    SV_Target0.w = u_xlat3.w * u_xlat19 + u_xlat22;
					    u_xlat21 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat21));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat21 * u_xlat21;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat2.x = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat2.x + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(vec3(u_xlat20), vec3(u_xlat20));
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat19 * u_xlat0.x + u_xlat20;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    SV_Target0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat3 = texture(_BumpMap, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_CameraDepthTexture, u_xlat5.xy);
					    u_xlat22 = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlatb23 = 0.0<u_xlat10_5.x;
					    u_xlat22 = u_xlat22 + (-vs_TEXCOORD6);
					    u_xlat22 = u_xlat22 * _InvFade;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat22 = (u_xlatb23) ? u_xlat22 : 1.0;
					    u_xlat23 = u_xlat22 * _Specular;
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb24 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb24){
					        u_xlatb24 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb24)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat24 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat24, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat24 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xx);
					    u_xlat24 = u_xlat24 * u_xlat10_5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
					    u_xlat22 = (-_Specular) * u_xlat22 + 1.0;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat24 = (-u_xlat22) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat22 + u_xlat24;
					    u_xlat24 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat24));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat24 * u_xlat24;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(vec3(u_xlat23), vec3(u_xlat23));
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat23;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_6[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_10[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					bool u_xlatb4;
					vec3 u_xlat5;
					vec3 u_xlat6;
					float u_xlat7;
					vec3 u_xlat10;
					float u_xlat12;
					float u_xlat13;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_3 * _Color;
					    u_xlat2 = texture(_BumpMap, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_CameraDepthTexture, u_xlat4.xy);
					    u_xlat19 = _ZBufferParams.z * u_xlat10_4.x + _ZBufferParams.w;
					    u_xlat19 = float(1.0) / u_xlat19;
					    u_xlatb20 = 0.0<u_xlat10_4.x;
					    u_xlat19 = u_xlat19 + (-vs_TEXCOORD6);
					    u_xlat19 = u_xlat19 * _InvFade;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat19 = (u_xlatb20) ? u_xlat19 : 1.0;
					    u_xlat20 = u_xlat19 * _Specular;
					    u_xlatb4 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb4){
					        u_xlatb4 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat10.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat10.xyz;
					        u_xlat10.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat10.xyz;
					        u_xlat10.xyz = u_xlat10.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat4.xyz = (bool(u_xlatb4)) ? u_xlat10.xyz : vs_TEXCOORD4.xyz;
					        u_xlat4.xyz = u_xlat4.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat4.yzw = u_xlat4.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat10.x = u_xlat4.y * 0.25 + 0.75;
					        u_xlat5.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat4.x = max(u_xlat10.x, u_xlat5.x);
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
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xxx * _LightColor0.xyz;
					    u_xlat19 = (-_Specular) * u_xlat19 + 1.0;
					    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.www * u_xlat3.xyz;
					    u_xlat22 = (-u_xlat19) + 1.0;
					    SV_Target0.w = u_xlat3.w * u_xlat19 + u_xlat22;
					    u_xlat21 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat21));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat21 * u_xlat21;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat2.x = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat2.x + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(vec3(u_xlat20), vec3(u_xlat20));
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat19 * u_xlat0.x + u_xlat20;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    u_xlat18 = exp2(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler2D _LightTextureB0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					bool u_xlatb6;
					vec4 u_xlat10_7;
					vec3 u_xlat8;
					float u_xlat9;
					float u_xlat10;
					vec2 u_xlat14;
					float u_xlat16;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat25;
					float u_xlat26;
					bool u_xlatb26;
					float u_xlat27;
					bool u_xlatb27;
					float u_xlat29;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat1.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat25 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat25 = inversesqrt(u_xlat25);
					    u_xlat2.xyz = vec3(u_xlat25) * u_xlat2.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat3 = texture(_BumpMap, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat25 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat25 = min(u_xlat25, 1.0);
					    u_xlat25 = (-u_xlat25) + 1.0;
					    u_xlat3.z = sqrt(u_xlat25);
					    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_CameraDepthTexture, u_xlat5.xy);
					    u_xlat25 = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
					    u_xlat25 = float(1.0) / u_xlat25;
					    u_xlatb26 = 0.0<u_xlat10_5.x;
					    u_xlat25 = u_xlat25 + (-vs_TEXCOORD6);
					    u_xlat25 = u_xlat25 * _InvFade;
					    u_xlat25 = clamp(u_xlat25, 0.0, 1.0);
					    u_xlat25 = (u_xlatb26) ? u_xlat25 : 1.0;
					    u_xlat26 = u_xlat25 * _Specular;
					    u_xlat5 = vs_TEXCOORD4.yyyy * unity_WorldToLight[1];
					    u_xlat5 = unity_WorldToLight[0] * vs_TEXCOORD4.xxxx + u_xlat5;
					    u_xlat5 = unity_WorldToLight[2] * vs_TEXCOORD4.zzzz + u_xlat5;
					    u_xlat5 = u_xlat5 + unity_WorldToLight[3];
					    u_xlatb27 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb27){
					        u_xlatb27 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb27)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat27 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat14.x = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat27, u_xlat14.x);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat27 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat27 = clamp(u_xlat27, 0.0, 1.0);
					    u_xlatb6 = 0.0<u_xlat5.z;
					    u_xlat6.x = u_xlatb6 ? 1.0 : float(0.0);
					    u_xlat14.xy = u_xlat5.xy / u_xlat5.ww;
					    u_xlat14.xy = u_xlat14.xy + vec2(0.5, 0.5);
					    u_xlat10_7 = texture(_LightTexture0, u_xlat14.xy);
					    u_xlat29 = u_xlat6.x * u_xlat10_7.w;
					    u_xlat5.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, u_xlat5.xx);
					    u_xlat5.x = u_xlat29 * u_xlat10_6.x;
					    u_xlat27 = u_xlat27 * u_xlat5.x;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat27) * _LightColor0.xyz;
					    u_xlat25 = (-_Specular) * u_xlat25 + 1.0;
					    u_xlat4.xyz = vec3(u_xlat25) * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat27 = (-u_xlat25) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat25 + u_xlat27;
					    u_xlat27 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat24) + u_xlat2.xyz;
					    u_xlat24 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat24 = max(u_xlat24, 0.00100000005);
					    u_xlat24 = inversesqrt(u_xlat24);
					    u_xlat0.xyz = vec3(u_xlat24) * u_xlat0.xyz;
					    u_xlat24 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat10 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat10 = clamp(u_xlat10, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat8.x = u_xlat0.x * u_xlat0.x;
					    u_xlat8.x = dot(u_xlat8.xx, vec2(u_xlat27));
					    u_xlat8.x = u_xlat8.x + -0.5;
					    u_xlat16 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat1.x;
					    u_xlat16 = u_xlat8.x * u_xlat16 + 1.0;
					    u_xlat1.x = -abs(u_xlat24) + 1.0;
					    u_xlat9 = u_xlat1.x * u_xlat1.x;
					    u_xlat9 = u_xlat9 * u_xlat9;
					    u_xlat1.x = u_xlat1.x * u_xlat9;
					    u_xlat8.x = u_xlat8.x * u_xlat1.x + 1.0;
					    u_xlat8.x = u_xlat8.x * u_xlat16;
					    u_xlat16 = u_xlat27 * u_xlat27;
					    u_xlat16 = max(u_xlat16, 0.00200000009);
					    u_xlat1.x = (-u_xlat16) + 1.0;
					    u_xlat9 = abs(u_xlat24) * u_xlat1.x + u_xlat16;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat16;
					    u_xlat24 = abs(u_xlat24) * u_xlat1.x;
					    u_xlat24 = u_xlat2.x * u_xlat9 + u_xlat24;
					    u_xlat24 = u_xlat24 + 9.99999975e-06;
					    u_xlat24 = 0.5 / u_xlat24;
					    u_xlat16 = u_xlat16 * u_xlat16;
					    u_xlat1.x = u_xlat10 * u_xlat16 + (-u_xlat10);
					    u_xlat1.x = u_xlat1.x * u_xlat10 + 1.0;
					    u_xlat16 = u_xlat16 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat16 = u_xlat16 / u_xlat1.x;
					    u_xlat16 = u_xlat16 * u_xlat24;
					    u_xlat16 = u_xlat16 * 3.14159274;
					    u_xlat16 = max(u_xlat16, 9.99999975e-05);
					    u_xlat8.y = sqrt(u_xlat16);
					    u_xlat8.xy = u_xlat2.xx * u_xlat8.xy;
					    u_xlat24 = dot(vec3(u_xlat26), vec3(u_xlat26));
					    u_xlatb24 = u_xlat24!=0.0;
					    u_xlat24 = u_xlatb24 ? 1.0 : float(0.0);
					    u_xlat16 = u_xlat24 * u_xlat8.y;
					    u_xlat1.xyz = u_xlat8.xxx * u_xlat5.xyz;
					    u_xlat8.xyz = u_xlat5.xyz * vec3(u_xlat16);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat25 * u_xlat0.x + u_xlat26;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat8.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat24 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat24 = (-u_xlat24) + 1.0;
					    u_xlat24 = u_xlat24 * _ProjectionParams.z;
					    u_xlat24 = max(u_xlat24, 0.0);
					    u_xlat24 = u_xlat24 * unity_FogParams.x;
					    u_xlat24 = u_xlat24 * (-u_xlat24);
					    u_xlat24 = exp2(u_xlat24);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat24);
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTextureB0;
					uniform  samplerCube _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  float vs_TEXCOORD8;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec3 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat4;
					vec4 u_xlat10_4;
					vec3 u_xlat5;
					float u_xlat16_5;
					vec4 u_xlat10_5;
					vec4 u_xlat6;
					vec4 u_xlat10_6;
					vec3 u_xlat7;
					float u_xlat8;
					float u_xlat9;
					float u_xlat14;
					float u_xlat21;
					bool u_xlatb21;
					float u_xlat22;
					float u_xlat23;
					bool u_xlatb23;
					float u_xlat24;
					bool u_xlatb24;
					float u_xlat26;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceLightPos0.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat1.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat2.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat22 = dot(u_xlat2.xyz, u_xlat2.xyz);
					    u_xlat22 = inversesqrt(u_xlat22);
					    u_xlat2.xyz = vec3(u_xlat22) * u_xlat2.xyz;
					    u_xlat3.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_4 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat4 = u_xlat10_4 * _Color;
					    u_xlat3 = texture(_BumpMap, u_xlat3.xy);
					    u_xlat3.x = u_xlat3.w * u_xlat3.x;
					    u_xlat3.xy = u_xlat3.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat22 = dot(u_xlat3.xy, u_xlat3.xy);
					    u_xlat22 = min(u_xlat22, 1.0);
					    u_xlat22 = (-u_xlat22) + 1.0;
					    u_xlat3.z = sqrt(u_xlat22);
					    u_xlat5.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_5 = texture(_CameraDepthTexture, u_xlat5.xy);
					    u_xlat22 = _ZBufferParams.z * u_xlat10_5.x + _ZBufferParams.w;
					    u_xlat22 = float(1.0) / u_xlat22;
					    u_xlatb23 = 0.0<u_xlat10_5.x;
					    u_xlat22 = u_xlat22 + (-vs_TEXCOORD6);
					    u_xlat22 = u_xlat22 * _InvFade;
					    u_xlat22 = clamp(u_xlat22, 0.0, 1.0);
					    u_xlat22 = (u_xlatb23) ? u_xlat22 : 1.0;
					    u_xlat23 = u_xlat22 * _Specular;
					    u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_WorldToLight[1].xyz;
					    u_xlat5.xyz = unity_WorldToLight[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					    u_xlat5.xyz = unity_WorldToLight[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					    u_xlat5.xyz = u_xlat5.xyz + unity_WorldToLight[3].xyz;
					    u_xlatb24 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb24){
					        u_xlatb24 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat6.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat6.xyz;
					        u_xlat6.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat6.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat6.xyz = (bool(u_xlatb24)) ? u_xlat6.xyz : vs_TEXCOORD4.xyz;
					        u_xlat6.xyz = u_xlat6.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat6.yzw = u_xlat6.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat24 = u_xlat6.y * 0.25 + 0.75;
					        u_xlat26 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat6.x = max(u_xlat24, u_xlat26);
					        u_xlat6 = texture(unity_ProbeVolumeSH, u_xlat6.xzw);
					    } else {
					        u_xlat6.x = float(1.0);
					        u_xlat6.y = float(1.0);
					        u_xlat6.z = float(1.0);
					        u_xlat6.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat24 = dot(u_xlat6, unity_OcclusionMaskSelector);
					    u_xlat24 = clamp(u_xlat24, 0.0, 1.0);
					    u_xlat26 = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat10_6 = texture(_LightTextureB0, vec2(u_xlat26));
					    u_xlat10_5 = texture(_LightTexture0, u_xlat5.xyz);
					    u_xlat16_5 = u_xlat10_5.w * u_xlat10_6.x;
					    u_xlat24 = u_xlat24 * u_xlat16_5;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat3.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat3.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat3.xyz);
					    u_xlat3.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat3.x = inversesqrt(u_xlat3.x);
					    u_xlat3.xyz = u_xlat3.xxx * u_xlat5.xyz;
					    u_xlat5.xyz = vec3(u_xlat24) * _LightColor0.xyz;
					    u_xlat22 = (-_Specular) * u_xlat22 + 1.0;
					    u_xlat4.xyz = vec3(u_xlat22) * u_xlat4.xyz;
					    u_xlat4.xyz = u_xlat4.www * u_xlat4.xyz;
					    u_xlat24 = (-u_xlat22) + 1.0;
					    SV_Target0.w = u_xlat4.w * u_xlat22 + u_xlat24;
					    u_xlat24 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat21) + u_xlat2.xyz;
					    u_xlat21 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat21 = max(u_xlat21, 0.00100000005);
					    u_xlat21 = inversesqrt(u_xlat21);
					    u_xlat0.xyz = vec3(u_xlat21) * u_xlat0.xyz;
					    u_xlat21 = dot(u_xlat3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat3.xyz, u_xlat1.xyz);
					    u_xlat2.x = clamp(u_xlat2.x, 0.0, 1.0);
					    u_xlat9 = dot(u_xlat3.xyz, u_xlat0.xyz);
					    u_xlat9 = clamp(u_xlat9, 0.0, 1.0);
					    u_xlat0.x = dot(u_xlat1.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat7.x = u_xlat0.x * u_xlat0.x;
					    u_xlat7.x = dot(u_xlat7.xx, vec2(u_xlat24));
					    u_xlat7.x = u_xlat7.x + -0.5;
					    u_xlat14 = (-u_xlat2.x) + 1.0;
					    u_xlat1.x = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat1.x;
					    u_xlat14 = u_xlat7.x * u_xlat14 + 1.0;
					    u_xlat1.x = -abs(u_xlat21) + 1.0;
					    u_xlat8 = u_xlat1.x * u_xlat1.x;
					    u_xlat8 = u_xlat8 * u_xlat8;
					    u_xlat1.x = u_xlat1.x * u_xlat8;
					    u_xlat7.x = u_xlat7.x * u_xlat1.x + 1.0;
					    u_xlat7.x = u_xlat7.x * u_xlat14;
					    u_xlat14 = u_xlat24 * u_xlat24;
					    u_xlat14 = max(u_xlat14, 0.00200000009);
					    u_xlat1.x = (-u_xlat14) + 1.0;
					    u_xlat8 = abs(u_xlat21) * u_xlat1.x + u_xlat14;
					    u_xlat1.x = u_xlat2.x * u_xlat1.x + u_xlat14;
					    u_xlat21 = abs(u_xlat21) * u_xlat1.x;
					    u_xlat21 = u_xlat2.x * u_xlat8 + u_xlat21;
					    u_xlat21 = u_xlat21 + 9.99999975e-06;
					    u_xlat21 = 0.5 / u_xlat21;
					    u_xlat14 = u_xlat14 * u_xlat14;
					    u_xlat1.x = u_xlat9 * u_xlat14 + (-u_xlat9);
					    u_xlat1.x = u_xlat1.x * u_xlat9 + 1.0;
					    u_xlat14 = u_xlat14 * 0.318309873;
					    u_xlat1.x = u_xlat1.x * u_xlat1.x + 1.00000001e-07;
					    u_xlat14 = u_xlat14 / u_xlat1.x;
					    u_xlat14 = u_xlat14 * u_xlat21;
					    u_xlat14 = u_xlat14 * 3.14159274;
					    u_xlat14 = max(u_xlat14, 9.99999975e-05);
					    u_xlat7.y = sqrt(u_xlat14);
					    u_xlat7.xy = u_xlat2.xx * u_xlat7.xy;
					    u_xlat21 = dot(vec3(u_xlat23), vec3(u_xlat23));
					    u_xlatb21 = u_xlat21!=0.0;
					    u_xlat21 = u_xlatb21 ? 1.0 : float(0.0);
					    u_xlat14 = u_xlat21 * u_xlat7.y;
					    u_xlat1.xyz = u_xlat7.xxx * u_xlat5.xyz;
					    u_xlat7.xyz = u_xlat5.xyz * vec3(u_xlat14);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat22 * u_xlat0.x + u_xlat23;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat7.xyz;
					    u_xlat0.xyz = u_xlat4.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat21 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat21 = (-u_xlat21) + 1.0;
					    u_xlat21 = u_xlat21 * _ProjectionParams.z;
					    u_xlat21 = max(u_xlat21, 0.0);
					    u_xlat21 = u_xlat21 * unity_FogParams.x;
					    u_xlat21 = u_xlat21 * (-u_xlat21);
					    u_xlat21 = exp2(u_xlat21);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat21);
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
						float _Specular;
						float _Glossiness;
						vec4 unused_0_7[2];
						float _InvFade;
						float _XScrollSpeed;
						float _YScrollSpeed;
						vec4 unused_0_11[2];
					};
					layout(std140) uniform UnityPerCamera {
						vec4 _Time;
						vec4 unused_1_1[3];
						vec3 _WorldSpaceCameraPos;
						vec4 _ProjectionParams;
						vec4 unused_1_4;
						vec4 _ZBufferParams;
						vec4 unused_1_6;
					};
					layout(std140) uniform UnityLighting {
						vec4 _WorldSpaceLightPos0;
						vec4 unused_2_1[45];
						vec4 unity_OcclusionMaskSelector;
						vec4 unused_2_3;
					};
					layout(std140) uniform UnityFog {
						vec4 unused_3_0;
						vec4 unity_FogParams;
					};
					layout(std140) uniform UnityProbeVolume {
						vec4 unity_ProbeVolumeParams;
						mat4x4 unity_ProbeVolumeWorldToObject;
						vec3 unity_ProbeVolumeSizeInv;
						vec3 unity_ProbeVolumeMin;
					};
					uniform  sampler2D _MainTex;
					uniform  sampler2D _BumpMap;
					uniform  sampler2D _CameraDepthTexture;
					uniform  sampler2D _LightTexture0;
					uniform  sampler3D unity_ProbeVolumeSH;
					in  vec4 vs_TEXCOORD0;
					in  vec3 vs_TEXCOORD1;
					in  float vs_TEXCOORD6;
					in  vec3 vs_TEXCOORD2;
					in  vec3 vs_TEXCOORD3;
					in  vec3 vs_TEXCOORD4;
					in  vec4 vs_TEXCOORD5;
					in  float vs_TEXCOORD8;
					layout(location = 0) out vec4 SV_Target0;
					vec3 u_xlat0;
					vec3 u_xlat1;
					vec4 u_xlat2;
					vec4 u_xlat3;
					vec4 u_xlat10_3;
					vec3 u_xlat4;
					vec4 u_xlat10_4;
					vec4 u_xlat5;
					vec4 u_xlat10_5;
					vec3 u_xlat6;
					float u_xlat7;
					float u_xlat12;
					float u_xlat13;
					float u_xlat16;
					bool u_xlatb16;
					float u_xlat18;
					bool u_xlatb18;
					float u_xlat19;
					float u_xlat20;
					bool u_xlatb20;
					float u_xlat21;
					float u_xlat22;
					void main()
					{
					    u_xlat0.xyz = (-vs_TEXCOORD4.xyz) + _WorldSpaceCameraPos.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat1.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat2.xy = vec2(_XScrollSpeed, _YScrollSpeed) * _Time.xx + vs_TEXCOORD0.zw;
					    u_xlat10_3 = texture(_MainTex, vs_TEXCOORD0.xy);
					    u_xlat3 = u_xlat10_3 * _Color;
					    u_xlat2 = texture(_BumpMap, u_xlat2.xy);
					    u_xlat2.x = u_xlat2.w * u_xlat2.x;
					    u_xlat2.xy = u_xlat2.xy * vec2(2.0, 2.0) + vec2(-1.0, -1.0);
					    u_xlat19 = dot(u_xlat2.xy, u_xlat2.xy);
					    u_xlat19 = min(u_xlat19, 1.0);
					    u_xlat19 = (-u_xlat19) + 1.0;
					    u_xlat2.z = sqrt(u_xlat19);
					    u_xlat4.xy = vs_TEXCOORD5.xy / vs_TEXCOORD5.ww;
					    u_xlat10_4 = texture(_CameraDepthTexture, u_xlat4.xy);
					    u_xlat19 = _ZBufferParams.z * u_xlat10_4.x + _ZBufferParams.w;
					    u_xlat19 = float(1.0) / u_xlat19;
					    u_xlatb20 = 0.0<u_xlat10_4.x;
					    u_xlat19 = u_xlat19 + (-vs_TEXCOORD6);
					    u_xlat19 = u_xlat19 * _InvFade;
					    u_xlat19 = clamp(u_xlat19, 0.0, 1.0);
					    u_xlat19 = (u_xlatb20) ? u_xlat19 : 1.0;
					    u_xlat20 = u_xlat19 * _Specular;
					    u_xlat4.xy = vs_TEXCOORD4.yy * unity_WorldToLight[1].xy;
					    u_xlat4.xy = unity_WorldToLight[0].xy * vs_TEXCOORD4.xx + u_xlat4.xy;
					    u_xlat4.xy = unity_WorldToLight[2].xy * vs_TEXCOORD4.zz + u_xlat4.xy;
					    u_xlat4.xy = u_xlat4.xy + unity_WorldToLight[3].xy;
					    u_xlatb16 = unity_ProbeVolumeParams.x==1.0;
					    if(u_xlatb16){
					        u_xlatb16 = unity_ProbeVolumeParams.y==1.0;
					        u_xlat5.xyz = vs_TEXCOORD4.yyy * unity_ProbeVolumeWorldToObject[1].xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[0].xyz * vs_TEXCOORD4.xxx + u_xlat5.xyz;
					        u_xlat5.xyz = unity_ProbeVolumeWorldToObject[2].xyz * vs_TEXCOORD4.zzz + u_xlat5.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + unity_ProbeVolumeWorldToObject[3].xyz;
					        u_xlat5.xyz = (bool(u_xlatb16)) ? u_xlat5.xyz : vs_TEXCOORD4.xyz;
					        u_xlat5.xyz = u_xlat5.xyz + (-unity_ProbeVolumeMin.xyz);
					        u_xlat5.yzw = u_xlat5.xyz * unity_ProbeVolumeSizeInv.xyz;
					        u_xlat16 = u_xlat5.y * 0.25 + 0.75;
					        u_xlat22 = unity_ProbeVolumeParams.z * 0.5 + 0.75;
					        u_xlat5.x = max(u_xlat22, u_xlat16);
					        u_xlat5 = texture(unity_ProbeVolumeSH, u_xlat5.xzw);
					    } else {
					        u_xlat5.x = float(1.0);
					        u_xlat5.y = float(1.0);
					        u_xlat5.z = float(1.0);
					        u_xlat5.w = float(1.0);
					    //ENDIF
					    }
					    u_xlat16 = dot(u_xlat5, unity_OcclusionMaskSelector);
					    u_xlat16 = clamp(u_xlat16, 0.0, 1.0);
					    u_xlat10_5 = texture(_LightTexture0, u_xlat4.xy);
					    u_xlat4.x = u_xlat16 * u_xlat10_5.w;
					    u_xlat5.x = dot(vs_TEXCOORD1.xyz, u_xlat2.xyz);
					    u_xlat5.y = dot(vs_TEXCOORD2.xyz, u_xlat2.xyz);
					    u_xlat5.z = dot(vs_TEXCOORD3.xyz, u_xlat2.xyz);
					    u_xlat2.x = dot(u_xlat5.xyz, u_xlat5.xyz);
					    u_xlat2.x = inversesqrt(u_xlat2.x);
					    u_xlat2.xyz = u_xlat2.xxx * u_xlat5.xyz;
					    u_xlat4.xyz = u_xlat4.xxx * _LightColor0.xyz;
					    u_xlat19 = (-_Specular) * u_xlat19 + 1.0;
					    u_xlat3.xyz = vec3(u_xlat19) * u_xlat3.xyz;
					    u_xlat3.xyz = u_xlat3.www * u_xlat3.xyz;
					    u_xlat22 = (-u_xlat19) + 1.0;
					    SV_Target0.w = u_xlat3.w * u_xlat19 + u_xlat22;
					    u_xlat21 = (-_Glossiness) + 1.0;
					    u_xlat0.xyz = u_xlat0.xyz * vec3(u_xlat18) + _WorldSpaceLightPos0.xyz;
					    u_xlat18 = dot(u_xlat0.xyz, u_xlat0.xyz);
					    u_xlat18 = max(u_xlat18, 0.00100000005);
					    u_xlat18 = inversesqrt(u_xlat18);
					    u_xlat0.xyz = vec3(u_xlat18) * u_xlat0.xyz;
					    u_xlat18 = dot(u_xlat2.xyz, u_xlat1.xyz);
					    u_xlat1.x = dot(u_xlat2.xyz, _WorldSpaceLightPos0.xyz);
					    u_xlat1.x = clamp(u_xlat1.x, 0.0, 1.0);
					    u_xlat7 = dot(u_xlat2.xyz, u_xlat0.xyz);
					    u_xlat7 = clamp(u_xlat7, 0.0, 1.0);
					    u_xlat0.x = dot(_WorldSpaceLightPos0.xyz, u_xlat0.xyz);
					    u_xlat0.x = clamp(u_xlat0.x, 0.0, 1.0);
					    u_xlat6.x = u_xlat0.x * u_xlat0.x;
					    u_xlat6.x = dot(u_xlat6.xx, vec2(u_xlat21));
					    u_xlat6.x = u_xlat6.x + -0.5;
					    u_xlat12 = (-u_xlat1.x) + 1.0;
					    u_xlat13 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat13 * u_xlat13;
					    u_xlat12 = u_xlat12 * u_xlat13;
					    u_xlat12 = u_xlat6.x * u_xlat12 + 1.0;
					    u_xlat13 = -abs(u_xlat18) + 1.0;
					    u_xlat2.x = u_xlat13 * u_xlat13;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat13 = u_xlat13 * u_xlat2.x;
					    u_xlat6.x = u_xlat6.x * u_xlat13 + 1.0;
					    u_xlat6.x = u_xlat6.x * u_xlat12;
					    u_xlat12 = u_xlat21 * u_xlat21;
					    u_xlat12 = max(u_xlat12, 0.00200000009);
					    u_xlat13 = (-u_xlat12) + 1.0;
					    u_xlat2.x = abs(u_xlat18) * u_xlat13 + u_xlat12;
					    u_xlat13 = u_xlat1.x * u_xlat13 + u_xlat12;
					    u_xlat18 = abs(u_xlat18) * u_xlat13;
					    u_xlat18 = u_xlat1.x * u_xlat2.x + u_xlat18;
					    u_xlat18 = u_xlat18 + 9.99999975e-06;
					    u_xlat18 = 0.5 / u_xlat18;
					    u_xlat12 = u_xlat12 * u_xlat12;
					    u_xlat13 = u_xlat7 * u_xlat12 + (-u_xlat7);
					    u_xlat7 = u_xlat13 * u_xlat7 + 1.0;
					    u_xlat12 = u_xlat12 * 0.318309873;
					    u_xlat7 = u_xlat7 * u_xlat7 + 1.00000001e-07;
					    u_xlat12 = u_xlat12 / u_xlat7;
					    u_xlat12 = u_xlat12 * u_xlat18;
					    u_xlat12 = u_xlat12 * 3.14159274;
					    u_xlat12 = max(u_xlat12, 9.99999975e-05);
					    u_xlat6.y = sqrt(u_xlat12);
					    u_xlat6.xy = u_xlat1.xx * u_xlat6.xy;
					    u_xlat18 = dot(vec3(u_xlat20), vec3(u_xlat20));
					    u_xlatb18 = u_xlat18!=0.0;
					    u_xlat18 = u_xlatb18 ? 1.0 : float(0.0);
					    u_xlat12 = u_xlat18 * u_xlat6.y;
					    u_xlat1.xyz = u_xlat6.xxx * u_xlat4.xyz;
					    u_xlat6.xyz = u_xlat4.xyz * vec3(u_xlat12);
					    u_xlat0.x = (-u_xlat0.x) + 1.0;
					    u_xlat2.x = u_xlat0.x * u_xlat0.x;
					    u_xlat2.x = u_xlat2.x * u_xlat2.x;
					    u_xlat0.x = u_xlat0.x * u_xlat2.x;
					    u_xlat0.x = u_xlat19 * u_xlat0.x + u_xlat20;
					    u_xlat0.xyz = u_xlat0.xxx * u_xlat6.xyz;
					    u_xlat0.xyz = u_xlat3.xyz * u_xlat1.xyz + u_xlat0.xyz;
					    u_xlat18 = vs_TEXCOORD8 / _ProjectionParams.y;
					    u_xlat18 = (-u_xlat18) + 1.0;
					    u_xlat18 = u_xlat18 * _ProjectionParams.z;
					    u_xlat18 = max(u_xlat18, 0.0);
					    u_xlat18 = u_xlat18 * unity_FogParams.x;
					    u_xlat18 = u_xlat18 * (-u_xlat18);
					    u_xlat18 = exp2(u_xlat18);
					    SV_Target0.xyz = u_xlat0.xyz * vec3(u_xlat18);
					    return;
					}"
				}
			}
		}
	}
	Fallback "Diffuse"
}