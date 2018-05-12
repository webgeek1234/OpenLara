#include "common.hlsl"

struct VS_OUTPUT {
	float4 wPos			: POSITION;
	float2 vTexCoord	: TEXCOORD0;
	float4 vDiffuse		: COLOR0;
};

#ifdef VERTEX
VS_OUTPUT main(VS_INPUT In) {
	VS_OUTPUT Out;
	Out.wPos      = float4(In.aCoord.xy * (1.0 / 32767.0), 0.0, 1.0);
	Out.vTexCoord = In.aTexCoord.xy * (1.0 / 32767.0);
	Out.vDiffuse  = In.aLight;
	return Out;
}

#else // PIXEL

sampler sDiffuse : register(s0);

float4 main(VS_OUTPUT In) : COLOR0 {
	return (In.vDiffuse * tex2D(sDiffuse, In.vTexCoord.xy)).bgra;
}
#endif