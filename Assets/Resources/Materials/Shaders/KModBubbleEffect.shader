Shader "Custom/KModBubbleEffect"
{
    Properties
    {
        _Color ("Color", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _TimeScale ("Time Scale", Float) = 1.0
    }
    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" }
        LOD 200

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

            sampler2D _MainTex;
            float4 _Color;
            float _TimeScale;

            v2f vert(appdata v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float2 rotate(float2 p, float angle)
            {
                float c = cos(angle);
                float s = sin(angle);
                return float2(c * p.x - s * p.y, s * p.x + c * p.y);
            }

            float map(float3 p)
            {
                // Simplified mapping function
                p.xz = abs(p.xz) - 0.5;
                return length(p) - 0.1;
            }

            float4 raymarch(float3 ro, float3 rd)
            {
                float t = 0.0;
                float3 col = float3(0.0, 0.0, 0.0);
                const int maxSteps = 8; // Reduced number of steps
                const float maxDist = 4.0;
                const float minDist = 0.01;

                for (int i = 0; i < maxSteps; ++i)
                {
                    float3 p = ro + rd * t;
                    float d = map(p);

                    if (d < minDist)
                        break;

                    if (t > maxDist)
                        break;

                    col += float3(0.2, 0.2, 0.9) / (2.0 + t * t); // Simplified color accumulation
                    t += d;
                }

                return float4(col, 0.9);
            }

            float4 frag(v2f i) : SV_Target
            {
                float2 uv = (i.uv - 0.5) * 2.0; // Center UV coordinates
                float3 ro = float3(0.0, 0.0, -1.0);
                float time = _Time.y * _TimeScale;

                // Rotate the camera position
                ro.yz = rotate(ro.yz, time);

                // Calculate ray direction
                float3 rd = normalize(float3(uv, -1.0));

                // Perform raymarching
                float4 col = raymarch(ro, rd);

                return col * _Color;
            }
            ENDCG
        }
    }
    FallBack "Diffuse"
}