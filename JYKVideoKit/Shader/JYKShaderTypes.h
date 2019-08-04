//
//  JYKShaderTypes.h
//  JYKVideoKit
//
//  Created by Joyoki on 2019/8/4.
//  Copyright © 2019 Joyoki. All rights reserved.
//

#ifndef JYKShaderTypes_h
#define JYKShaderTypes_h

#include <simd/simd.h>

typedef struct
{
    vector_float4 position;
    vector_float2 textureCoordinate;
} JYKVertex;

#endif /* JYKShaderTypes_h */
