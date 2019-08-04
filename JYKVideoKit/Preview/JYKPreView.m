//
//  JYKPreView.m
//  JYKVideoKit
//
//  Created by Joyoki on 2019/2/25.
//  Copyright © 2019年 Joyoki. All rights reserved.
//
//  github: https://github.com/Joyoki-J/JYKVideoKit
//

#import "JYKPreView.h"
#import "JYKShaderTypes.h"
#import <Metal/Metal.h>

@interface JYKPreView ()
{
    id<MTLDevice> _device;
    CAMetalLayer *_metalLayer;
    id<MTLBuffer> _vertexBuffer;
    id<MTLRenderPipelineState> _pipelineState;
    id<MTLCommandQueue> _commandQueue;
    CVMetalTextureCacheRef _textureCache;
    NSInteger _numVertices;
}

@end

@implementation JYKPreView

- (instancetype)init
{
    self = [super init];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self createPreviewLayer];
    }
    return self;
}

- (instancetype)initWithFrame:(CGRect)frame
{
    self = [super initWithFrame:frame];
    if (self) {
        self.backgroundColor = [UIColor blackColor];
        [self createPreviewLayer];
    }
    return self;
}


- (void)createPreviewLayer {
    
    _device = MTLCreateSystemDefaultDevice();
    
    _metalLayer = [CAMetalLayer layer];
    _metalLayer.device = _device;
    _metalLayer.pixelFormat = MTLPixelFormatBGRA8Unorm;
    _metalLayer.framebufferOnly = YES;
    _metalLayer.frame = self.bounds;
    [self.layer addSublayer:_metalLayer];
    
    static const JYKVertex quadVertices[] =
    {   // 顶点坐标，分别是x、y、z、w；    纹理坐标，x、y；
        { {  1.0, -1.0, 0.0, 1.0 },  { 1.f, 1.f } },
        { { -1.0, -1.0, 0.0, 1.0 },  { 0.f, 1.f } },
        { { -1.0,  1.0, 0.0, 1.0 },  { 0.f, 0.f } },
        
        { {  1.0, -1.0, 0.0, 1.0 },  { 1.f, 1.f } },
        { { -1.0,  1.0, 0.0, 1.0 },  { 0.f, 0.f } },
        { {  1.0,  1.0, 0.0, 1.0 },  { 1.f, 0.f } },
    };
    
    _vertexBuffer = [_device newBufferWithBytes:quadVertices
                                         length:sizeof(quadVertices)
                                        options:MTLResourceOptionCPUCacheModeDefault];
    _numVertices = sizeof(quadVertices) / sizeof(JYKVertex);
    
    CVMetalTextureCacheCreate(kCFAllocatorDefault, NULL, _device, NULL, &_textureCache);
    
    NSError *error;
    id<MTLLibrary> defaultLibrary = [_device newLibraryWithFile:[[NSBundle mainBundle].privateFrameworksPath stringByAppendingPathComponent:@"/JYKVideoKit.framework/default.metallib"] error:&error];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    id <MTLFunction> vertexFunction = [defaultLibrary newFunctionWithName:@"vertexShader"];
    id <MTLFunction> fragmentFunction = [defaultLibrary newFunctionWithName:@"samplingShader"];
    
    MTLRenderPipelineDescriptor *pipelineStateDescriptor = [[MTLRenderPipelineDescriptor alloc] init];
    pipelineStateDescriptor.vertexFunction = vertexFunction;
    pipelineStateDescriptor.fragmentFunction = fragmentFunction;
    pipelineStateDescriptor.colorAttachments[0].pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    _pipelineState = [_device newRenderPipelineStateWithDescriptor:pipelineStateDescriptor error:&error];
    if (error) {
        NSLog(@"%@",error);
        return;
    }
    
    _commandQueue = [_device newCommandQueue];
}

- (void)renderWithTexture:(id<MTLTexture>)texture {
    if (!texture) return;
    
    id<CAMetalDrawable> drawable = [_metalLayer nextDrawable];
    
    id<MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];
    commandBuffer.label = @"MyCommand";
    
    MTLRenderPassDescriptor *renderPassDescriptor = [[MTLRenderPassDescriptor alloc] init];
    
    if(renderPassDescriptor != nil)
    {
        renderPassDescriptor.colorAttachments[0].texture = drawable.texture;
        renderPassDescriptor.colorAttachments[0].loadAction = MTLLoadActionClear;
        renderPassDescriptor.colorAttachments[0].clearColor = MTLClearColorMake(0, 0, 0, 1);
        
        id<MTLRenderCommandEncoder> renderEncoder =
        [commandBuffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
        renderEncoder.label = @"MyRenderEncoder";
        
//        // Set the region of the drawable to draw into.
//        [renderEncoder setViewport:(MTLViewport){0.0, 0.0, _viewportSize.x, _viewportSize.y, -1.0, 1.0 }];
        
        [renderEncoder setRenderPipelineState:_pipelineState];
        
        [renderEncoder setVertexBuffer:_vertexBuffer
                                offset:0
                               atIndex:0];
        
//        [renderEncoder setVertexBytes:&_viewportSize
//                               length:sizeof(_viewportSize)
//                              atIndex:AAPLVertexInputIndexViewportSize];
//
        [renderEncoder setFragmentTexture:texture
                                  atIndex:0];
        
        [renderEncoder drawPrimitives:MTLPrimitiveTypeTriangle
                          vertexStart:0
                          vertexCount:_numVertices];
        
        [renderEncoder endEncoding];
        
        [commandBuffer presentDrawable:drawable];
    }
    
    [commandBuffer commit];
}

- (void)render:(CVPixelBufferRef)pixelBuffer {
    id<MTLTexture> texture = [self loadTextureUsingPixelBuffer:pixelBuffer];
    @autoreleasepool {
        [self renderWithTexture:texture];
    }
}

- (id<MTLTexture>)loadTextureUsingPixelBuffer:(CVPixelBufferRef)pixelBuffer {
    
    size_t width = CVPixelBufferGetWidth(pixelBuffer);
    size_t height = CVPixelBufferGetHeight(pixelBuffer);
    MTLPixelFormat pixelFormat = MTLPixelFormatBGRA8Unorm;
    
    CVMetalTextureRef tempTexture = NULL; // CoreVideo的Metal纹理
    CVReturn status = CVMetalTextureCacheCreateTextureFromImage(kCFAllocatorDefault, _textureCache, pixelBuffer, NULL, pixelFormat, width, height, 0, &tempTexture);
    id<MTLTexture> texture;
    if (status == kCVReturnSuccess) {
        texture = CVMetalTextureGetTexture(tempTexture); // 转成Metal用的纹理
        CFRelease(tempTexture);
    }
    return texture;
}


@end
