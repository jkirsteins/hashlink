#define HL_NAME(n) metal_##n

#include <hl.h>
#import <Metal/Metal.h>
#import "MetalDriver.h"
#import "MetalWindow.h"
#import "MetalView.h"

#include <Appkit/AppKit.h>
#include <simd/simd.h>

#define _DRIVER _ABSTRACT(metal_driver)
#define _METAL_BUFFER _ABSTRACT(id_mtl_buffer)
#define _METAL_TEXTURE _ABSTRACT(id_mtl_texture)

typedef struct Proxy_MTLTextureDescriptor {
public:
    hl_type *t;
    int32_t width;
    int32_t height;
    int32_t depth;

    int32_t textureType;
    int32_t pixelFormat;

//    public var mipmapLevelCount: Int;
//    public var sampleCount: Int;
//    public var arrayLength: Int;
//    public var resourceOptions: MTLResourceOptions;
//    public var cpuCacheMode: MTLCPUCacheMode;
//    public var storageMode: MTLStorageMode;
//    public var hazardTrackingMode: MTLHazardTrackingMode;
//    public var allowGPUOptimizedContents: Bool;
//    public var usage: MTLTextureUsage;
//    public var swizzle: MTLTextureSwizzleChannels;
} Proxy_MTLTextureDescriptor;

char const *defaultSource = "#include <simd/simd.h>\n"
"\n"
"#ifndef COMMON_H\n"
"#define COMMON_H\n"
"\n"
"#include <simd/simd.h>\n"
"\n"
"enum VertexAttributes {\n"
"    VertexAttributePosition = 0,\n"
"    VertexAttributeColor = 1,\n"
"};\n"
"\n"
"enum BufferIndex  {\n"
"    MeshVertexBuffer = 0,\n"
"    FrameUniformBuffer = 1,\n"
"};\n"
"\n"
"struct FrameUniforms {\n"
"    simd::float4x4 projectionViewModel;\n"
"};\n"
"\n"
"#endif\n"
"\n"
"using namespace metal;\n"
"\n"
"struct VertexInput {\n"
"    float3 position [[attribute(VertexAttributePosition)]];\n"
"    half4 color [[attribute(VertexAttributeColor)]];\n"
"};\n"
"\n"
"struct ShaderInOut {\n"
"    float4 position [[position]];\n"
"    half4  color;\n"
"};\n"
"\n"
"vertex ShaderInOut vert(VertexInput in [[stage_in]],\n"
"\t   constant FrameUniforms& uniforms [[buffer(FrameUniformBuffer)]]) {\n"
"    ShaderInOut out;\n"
"    float4 pos4 = float4(in.position, 1.0);\n"
"    out.position = uniforms.projectionViewModel * pos4;\n"
"    out.color = in.color / 255.0;\n"
"    return out;\n"
"}\n"
"\n"
"fragment half4 frag(ShaderInOut in [[stage_in]]) {\n"
"    return in.color;\n"
"}\n"
"";

HL_PRIM MetalDriver* HL_NAME(driver_create)(MetalWindow* win) {
	@autoreleasepool {
		NSLog(@"Creating driver");
        return [[MetalDriver alloc] initWithWindow:win];
	}
}

HL_PRIM id<MTLBuffer> HL_NAME(driver_create_buffer)(MetalDriver* driver, int32_t length) {
    @autoreleasepool {
        NSLog(@"Creating buffer");

        id<MTLDevice> dev = driver.device;
        return [dev newBufferWithLength:(NSUInteger)length
                                options:0];
    }
}

HL_PRIM void HL_NAME(driver_resize_viewport)(MetalDriver* driver, int32_t width, int32_t height) {
    @autoreleasepool {
        NSLog(@"Resizing viewport to %d %d", width, height);

        [driver setSize:CGSizeMake(width, height)];
    }
}

HL_PRIM void HL_NAME(driver_update_buffer)(
                                           id<MTLBuffer> buffer,
                                           vbyte* data,
                                           int32_t offset,
                                           int32_t size) {
    @autoreleasepool {
        if (size < 0) {
            NSLog(@"Not updating buffer %@ because size is <0 (%d)", buffer, size);
            return;
        }

        NSLog(@"Updating buffer %@ offset %d size %d", buffer, offset, size);

        memcpy((char*)buffer.contents + offset, data, size);
    }
}

HL_PRIM void HL_NAME(driver_set_depth_stencil_format)(MetalDriver* driver, int32_t pixelFormat) {
    @autoreleasepool {
        switch ((MTLPixelFormat)pixelFormat) {
            case MTLPixelFormatDepth32Float_Stencil8:
                NSLog(@"Setting depth stencil pixel format: MTLPixelFormatDepth32Float_Stencil8");
                driver.metalView.depthStencilPixelFormat = MTLPixelFormatDepth32Float_Stencil8;
                break;
            default:
                NSLog(@"Invalid pixel format %d", pixelFormat);
                exit(1);
        }
    }
}

HL_PRIM id<MTLTexture> HL_NAME(driver_create_texture)(MetalDriver* driver, Proxy_MTLTextureDescriptor *proxyDescriptor) {
    @autoreleasepool {
        NSLog(@"Creating a texture");
        NSLog(@"Texture descriptor: %d x %d (%d) (%lu)",
              proxyDescriptor->width,
              proxyDescriptor->height,
              proxyDescriptor->pixelFormat,
              ((MTLPixelFormat)proxyDescriptor->pixelFormat));
        
        MTLTextureDescriptor *textureDescriptor = [MTLTextureDescriptor new];
        
        textureDescriptor.pixelFormat = (MTLPixelFormat)proxyDescriptor->pixelFormat;
        textureDescriptor.width = proxyDescriptor->width;
        textureDescriptor.height = proxyDescriptor->height;
        
        return [driver.device newTextureWithDescriptor:textureDescriptor];
    }
}

DEFINE_PRIM(_DRIVER,driver_create,_WINPTR);
DEFINE_PRIM(_METAL_BUFFER,driver_create_buffer,_DRIVER _I32);
DEFINE_PRIM(_VOID,driver_update_buffer,_METAL_BUFFER _BYTES _I32 _I32);
DEFINE_PRIM(_VOID,driver_resize_viewport,_DRIVER _I32 _I32);
DEFINE_PRIM(_VOID,driver_set_depth_stencil_format,_DRIVER _I32);
DEFINE_PRIM(_METAL_TEXTURE,driver_create_texture,_DRIVER _DYN);

@implementation MetalDriver
{
    MetalWindow *_window;
    CGSize _size;
    id <MTLCommandQueue> _commandQueue;

    id <MTLLibrary> _library;
    id <MTLRenderPipelineState> _pipelineState;
    id <MTLDepthStencilState> _depthState;
    dispatch_semaphore_t _semaphore;

}

enum VertexAttributes {
    VertexAttributePosition = 0,
    VertexAttributeColor = 1,
};

enum BufferIndex  {
    MeshVertexBuffer = 0,
    FrameUniformBuffer = 1,
};
 
//struct FrameUniforms {
//    simd::float4x4 projectionViewModel;
//};

// Vertex structure on CPU memory.
typedef struct {
    float position[3];
    unsigned char color[4];
} Vertex;

#define member_size(type, member) sizeof(((type *)0)->member)

- (id)initWithWindow:(MetalWindow*)window {
    NSLog(@"Super init");
    self = [super init];
    NSLog(@"Super init 2");
    if (self) {
        NSLog(@"In self");
        self->_window = window;

        self->_size = window.frame.size;
        NSLog(@"Driver size: %f %f", self->_size.width, self->_size.height);

        NSLog(@"Driver device: %@", self.device);

        self->_commandQueue = [self.device newCommandQueue];

        _semaphore = dispatch_semaphore_create(1);

        NSError *error = nil;

        NSString *source = [NSString stringWithCString:defaultSource encoding:NSUTF8StringEncoding];
        NSLog(@"Metal library source: %@", source);
        _library = [self.device newLibraryWithSource:source options:0 error:&error];
        if (!_library) {
            NSLog(@"Failed to load library. error %@", error);
            exit(0);
        }
        id <MTLFunction> vertFunc = [_library newFunctionWithName:@"vert"];
        id <MTLFunction> fragFunc = [_library newFunctionWithName:@"frag"];

        // Create depth state.
        MTLDepthStencilDescriptor *depthDesc = [MTLDepthStencilDescriptor new];
        depthDesc.depthCompareFunction = MTLCompareFunctionLess;
        depthDesc.depthWriteEnabled = YES;
        _depthState = [self.device newDepthStencilStateWithDescriptor:depthDesc];

        // Create vertex descriptor.
        MTLVertexDescriptor *vertDesc = [MTLVertexDescriptor new];
        vertDesc.attributes[VertexAttributePosition].format = MTLVertexFormatFloat3;
        vertDesc.attributes[VertexAttributePosition].offset = 0;
        vertDesc.attributes[VertexAttributePosition].bufferIndex = MeshVertexBuffer;
        vertDesc.attributes[VertexAttributeColor].format = MTLVertexFormatUChar4;
        vertDesc.attributes[VertexAttributeColor].offset = member_size(Vertex, position);
        vertDesc.attributes[VertexAttributeColor].bufferIndex = MeshVertexBuffer;
        vertDesc.layouts[MeshVertexBuffer].stride = sizeof(Vertex);
        vertDesc.layouts[MeshVertexBuffer].stepRate = 1;
        vertDesc.layouts[MeshVertexBuffer].stepFunction = MTLVertexStepFunctionPerVertex;

        MTLRenderPipelineDescriptor *pipelineDesc = [MTLRenderPipelineDescriptor new];
        pipelineDesc.sampleCount = self.sampleCount;
        pipelineDesc.vertexFunction = vertFunc;
        pipelineDesc.fragmentFunction = fragFunc;
        pipelineDesc.vertexDescriptor = vertDesc;
        pipelineDesc.colorAttachments[0].pixelFormat = self.metalView.colorPixelFormat;
        pipelineDesc.depthAttachmentPixelFormat = self.metalView.depthStencilPixelFormat;
        pipelineDesc.stencilAttachmentPixelFormat = self.metalView.depthStencilPixelFormat;

        _pipelineState = [self.device newRenderPipelineStateWithDescriptor:pipelineDesc error:&error];

        if (!_pipelineState) {
            NSLog(@"Failed to create pipeline state, error %@", error);
            exit(0);
        }
    }
    return self;
}

-(MTKView*)metalView {
    return (MetalView*)[self->_window contentView];
}

-(id<MTLDevice>)device {
    return self.metalView.device;
}

-(NSUInteger)sampleCount {
    return self.metalView.sampleCount;
}

-(void)setSize:(CGSize)newSize
{
    self->_size = newSize;
}

-(void)present {
    // Wait for an available uniform buffer.
    dispatch_semaphore_wait(_semaphore, DISPATCH_TIME_FOREVER);

    // Create a command buffer.
    id <MTLCommandBuffer> commandBuffer = [_commandQueue commandBuffer];

    // Encode render command.
    id <MTLRenderCommandEncoder> encoder =
        [commandBuffer renderCommandEncoderWithDescriptor:self.metalView.currentRenderPassDescriptor];

//    [[MTLViewport alloc] init (0, 0, self->_size.width, self->_size.height, 0, 1)

    MTLViewport x;
    x.originX = 0;
    x.originY = 0;
    x.width = self->_size.width;
    x.height = self->_size.height;
    x.znear = 0;
    x.zfar = 1;
    [encoder setViewport:x];

    [encoder setDepthStencilState:_depthState];
    [encoder setRenderPipelineState:_pipelineState];
    [encoder endEncoding];

    // Set callback for semaphore.
    __block dispatch_semaphore_t semaphore = _semaphore;
    [commandBuffer addCompletedHandler:^(id<MTLCommandBuffer> buffer) {
        dispatch_semaphore_signal(semaphore);
    }];
    [commandBuffer presentDrawable:self.metalView.currentDrawable];
    [commandBuffer commit];

//    // Draw children.
//    [super drawRect:rect];
}
@end

