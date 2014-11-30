Shader "Custom/Half Lambert Bumped" {
Properties {
    _Color ("Main Color", Color) = (1,1,1,1)
    _WrapAmount ("Wrap Amount", Range (1.0, 0.5)) = 0.5
    _MainTex ("Base (RGB)", 2D) = "white" {}
    _BumpMap ("Bumpmap (RGB)", 2D) = "bump" {}
}
 
Category {
    Tags { "RenderType"="Opaque" }
    LOD 200
    Blend AppSrcAdd AppDstAdd
    Fog { Color [_AddFog] }
   
    SubShader {
        // Ambient pass
        UsePass "Half Lambert/BASE"
        // Pixel lights
        Pass {
            Name "PPL"
            Tags { "LightMode" = "Pixel" }
            CGPROGRAM
                #pragma vertex vert
                #pragma fragment frag
                #pragma multi_compile_builtin
                #pragma fragmentoption ARB_fog_exp2
                #pragma fragmentoption ARB_precision_hint_fastest
                #include "UnityCG.cginc"
                #include "AutoLight.cginc"
               
                struct v2f {
                    V2F_POS_FOG;
                    LIGHTING_COORDS
                    float2  uv;
                    float2  uv2;
                    float3  lightDirT;
                };
               
                uniform float4 _MainTex_ST, _BumpMap_ST;
               
                v2f vert (appdata_tan v)
                {
                    v2f o;
                    PositionFog( v.vertex, o.pos, o.fog );
                    o.uv = TRANSFORM_TEX(v.texcoord, _MainTex);
                    o.uv2 = TRANSFORM_TEX(v.texcoord,_BumpMap);
                   
                    TANGENT_SPACE_ROTATION;
                    o.lightDirT = mul( rotation, ObjSpaceLightDir( v.vertex ) );
                   
                    TRANSFER_VERTEX_TO_FRAGMENT(o);
                    return o;
                }
               
                uniform sampler2D _MainTex;
                uniform sampler2D _BumpMap;
                uniform float _WrapAmount;
               
                // Wrapped Lambertian (diffuse) lighting model
                inline half4 WrappedLight( half3 lightDir, half3 normal, half4 color, half atten, half wrapAmount)
                {
                    #ifndef USING_DIRECTIONAL_LIGHT
                    lightDir = normalize(lightDir);
                    #endif
                   
                    half diffuse = dot( normal, lightDir )*wrapAmount + (1 - wrapAmount);
                   
                    half4 c;
                    c.rgb = color.rgb * _ModelLightColor0.rgb * (diffuse * atten * 2);
                    c.a = 0; // diffuse passes by default don't contribute to overbright
                    return c;
                }
               
                float4 frag (v2f i) : COLOR
                {
                    float3 normal = tex2D(_BumpMap, i.uv2).xyz * 2 - 1;
                   
                    half4 texcol = tex2D( _MainTex, i.uv );
                   
                    return WrappedLight( i.lightDirT, normal, texcol, LIGHT_ATTENUATION(i), _WrapAmount);
                }
            ENDCG
        }
    }
}
 
Fallback "VertexLit"
 
}