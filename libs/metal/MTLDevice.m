#import "MTLDevice.h"
#import "MTLLibrary.h"

#define _MTL_RENDER_PIPELINE_STATE _ABSTRACT(id_mtl_render_pipeline_state)
#define _MTL_COMMAND_QUEUE _ABSTRACT(id_mtl_command_queue)

typedef struct Proxy_MTLFunction {
    hl_type *t;
    id<MTLFunction> function;
} Proxy_MTLFunction;

typedef struct Proxy_MTLTextureDescriptor {
    hl_type *t;
    Proxy_MTLFunction *vertexFunction;
    Proxy_MTLFunction *fragmentFunction;
} Proxy_MTLTextureDescriptor;


HL_PRIM id<MTLCommandQueue> HL_NAME(mtldevice_newCommandQueue)(id<MTLDevice> device) {
    return [device newCommandQueue];
}

HL_PRIM id<MTLRenderPipelineState> HL_NAME(mtldevice_newRenderPipelineState_descriptor)(id<MTLDevice> device, Proxy_MTLTextureDescriptor *proxyDesc) {
    NSLog(@"mtldevice_newRenderPipelineState_descriptor");

    NSLog(@"Vertex: %@", proxyDesc->vertexFunction->function);
    NSLog(@"Fragment: %@", proxyDesc->fragmentFunction->function);

    MTLRenderPipelineDescriptor *desc = [MTLRenderPipelineDescriptor new];
    desc.vertexFunction = proxyDesc->vertexFunction->function;
    desc.fragmentFunction = proxyDesc->fragmentFunction->function;

    NSError *error;
    id<MTLRenderPipelineState> result = [device newRenderPipelineStateWithDescriptor:desc error:&error];

    if (error != NULL) {
        NSLog(@"Failed to create MTLRenderPipelineState from descriptor: %@", error.localizedDescription);
        exit(1);
    }

    NSLog(@"Created MTLRenderPipelineState %@", result);
    return result;
}

HL_PRIM id<MTLLibrary> HL_NAME(mtldevice_newLibrary_source)(id<MTLDevice> device, vbyte *source) {
    NSLog(@"mtldevice_newLibrary_source");

    NSString *nsSource = [NSString stringWithUTF8String:(char*)source];
    NSLog(@"Source: %@", nsSource);

    NSError *error;
    id<MTLLibrary> result = [device newLibraryWithSource:nsSource options:0 error:&error];

    if (error != NULL) {
        NSLog(@"Failed to create MTLLibrary from source: %@", error.localizedDescription);
        exit(1);
    }

    NSLog(@"Created library %@", result);
    return result;
}

HL_PRIM id<MTLBuffer> HL_NAME(mtldevice_newBuffer_length_options)(id<MTLDevice> device, int32_t length, int32_t options) {
    NSLog(@"mtldevice_newBuffer_length_options");

    return [device newBufferWithLength:(NSUInteger)length
                            options:options];
}

DEFINE_PRIM(_MTL_BUFFER,mtldevice_newBuffer_length_options,_MTL_DEVICE _I32 _I32);
DEFINE_PRIM(_MTL_COMMAND_QUEUE,mtldevice_newCommandQueue,_MTL_DEVICE);
DEFINE_PRIM(_MTL_RENDER_PIPELINE_STATE,mtldevice_newRenderPipelineState_descriptor,_MTL_DEVICE _DYN);
DEFINE_PRIM(_MTL_LIBRARY,mtldevice_newLibrary_source,_MTL_DEVICE _BYTES);



