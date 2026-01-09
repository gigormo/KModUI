Shader "Custom/KModMainUIPressedShader"
{
    Properties
    {
        _ColorA ("Color A", Color) = (1,1,1,1)
        _ColorB ("Color B", Color) = (1,1,1,1)
        _MainTex ("Albedo (RGB)", 2D) = "white" {}
        _TimeScale ("Time Scale", Float) = 1.0
        _Color ("Color", Color) = (1,1,1,1)
        _ShouldAnimate ("Should Animate", Range(0,1)) = 1.0
    }

    SubShader
    {
        Tags { "Queue"="Transparent" "RenderType"="Transparent" "IgnoreProjector"="True" }
        LOD 200

        Blend SrcAlpha OneMinusSrcAlpha
        Cull Off ZWrite Off ZTest Always

        Pass
        {
            CGPROGRAM
            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            sampler2D _MainTex;

            float4 _ColorA, _ColorB, _Color;
            float _TimeScale, _ShouldAnimate;

            struct appdata_t
            {
                float4 vertex : POSITION;
                float2 uv : TEXCOORD0;
            };

            struct v2f
            {
                float2 uv : TEXCOORD0;
                float4 vertex : SV_POSITION;
            };

            v2f vert(appdata_t v)
            {
                v2f o;
                o.vertex = UnityObjectToClipPos(v.vertex);
                o.uv = v.uv;
                return o;
            }

            float3 palette(float t)
            {
                return float3(0.8, 0.8, 0.8) + 
                       float3(0.5, 0.5, 0.5) * cos(60.28318 * (float3(1.0, 1.0, 1.0) * t + float3(0.163, 0.416, 0.557)));
            }

            fixed4 frag(v2f i) : SV_Target
            {
                float2 uv = (i.uv * 2.0 - 1.0) * (_ScreenParams.y / _ScreenParams.x);
                fixed4 texColor = tex2D(_MainTex, i.uv);

                if (_ShouldAnimate <= 0.9)
                    return texColor;

                float time = _Time.y * _TimeScale;
                float borderMask = texColor.a;

                // Electric effect
                float electricPattern = sin(i.uv.x * 50.0 + time * 5.0) * sin(i.uv.y * 5.0 + time * 5.0);
                float electricEffect = smoothstep(0.16, 0.9, borderMask) * abs(electricPattern);
                float flicker = abs(sin(time * 0.4));
                float lerpFactor = saturate(electricEffect + flicker);

                // Interpolate colors
                fixed4 lerpedColor = lerp(_ColorA, _ColorB, lerpFactor);

                if (borderMask < 0.8)
                {
                    texColor.rgb = lerpedColor.rgb;
                } 
                else if (borderMask >= 0.02 && borderMask < 0.99)
                {
                    float3 finalColor = float3(0.0, 0.0, 0.0);

                    for (float j = 0.0; j < 10.0; j++)
                    {
                        float2 uvOffset = frac(uv * 2.5) - 0.5;
                        float d = length(uvOffset) * exp(-length(uv));
                        d = abs(sin(d * 2.9 + time) / 6.0);
                        d = pow(0.01 / d, 0.4);
                        finalColor += texColor.rgb * d;
                    }

                    if (length(finalColor) < 0.2)
                        return texColor;


                    return float4(finalColor, texColor.a) * lerp(texColor, _Color, lerpFactor) * 0.5f;
                }

                return texColor;
            }
            ENDCG
        }
    }

    FallBack "Transparent"
}