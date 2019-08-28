//
//  JYKShader.metal
//  JYKVideoKit
//
//  Created by Joyoki on 2019/8/4.
//  Copyright © 2019 Joyoki. All rights reserved.
//

#include <metal_stdlib>
#include <simd/simd.h>
#import "JYKShaderTypes.h"

using namespace metal;

typedef struct
{
    float4 clipSpacePosition [[position]]; // position的修饰符表示这个是顶点
    
    float2 textureCoordinate; // 纹理坐标，会做插值处理
    
} JYKRasterizerData;

vertex JYKRasterizerData // 返回给片元着色器的结构体
vertexShader(uint vertexID [[ vertex_id ]], // vertex_id是顶点shader每次处理的index，用于定位当前的顶点
             constant JYKVertex *vertexArray [[ buffer(0) ]]) { // buffer表明是缓存数据，0是索引
    JYKRasterizerData out;
    out.clipSpacePosition = vertexArray[vertexID].position;
    out.textureCoordinate = vertexArray[vertexID].textureCoordinate;
    return out;
}

fragment half4
samplingShader(JYKRasterizerData input [[stage_in]], // stage_in表示这个数据来自光栅化。（光栅化是顶点处理之后的步骤，业务层无法修改）
               texture2d<half> inputTexture [[ texture(0) ]],
               sampler         samplr        [[ sampler(0) ]])
{
    return inputTexture.sample(samplr, input.textureCoordinate);
}
