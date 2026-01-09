Shader "Custom/KModFillShader"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _TimeScale ("Time Scale", Float) = 1.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True"}
        LOD 200



        Blend SrcAlpha OneMinusSrcAlpha // Enable alpha blending
 
        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            
            #include "UnityCG.cginc"

            struct appdata
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            float4 _Color;
            float _TimeScale;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float3 palette(float t)
            {
                float3 a = float3(0.5, 0.5, 0.5);
                float3 b = float3(0.5, 0.5, 0.5);
                float3 c = float3(1.0, 1.0, 1.0);
                float3 d = float3(0.263, 0.416, 0.557);

                return a + b * cos(6.28318 * (c * t + d));
            }

            float4 frag(v2f i) : SV_Target
            {
                float2 uv = (i.uv * 2.0 - 1.0) * (_ScreenParams.y / _ScreenParams.x);
                float2 uv0 = uv;
                float3 finalColor = float3(0.0, 0.0, 0.0);

                float time = _Time.y * _TimeScale;

                for (float j = 0.0; j < 4.0; j++)
                {
                    uv = frac(uv * 1.5) - 0.5;

                    float d = length(uv) * exp(-length(uv0));

                    float3 col = palette(length(uv0) + j * 0.4 + time * 0.4);

                    d = sin(d * 8.0 + time) / 8.0;
                    d = abs(d);

                    d = pow(0.01 / d, 1.2);

                    finalColor += col * d;
                }

                return float4(finalColor, 0.5) * _Color;
            }
            ENDCG
        }
        
    }
    FallBack "Diffuse"
}