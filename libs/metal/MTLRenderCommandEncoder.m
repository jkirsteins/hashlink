#import "MTLRenderCommandEncoder.h"
#import "MTLBuffer.h"
#import "MTLRenderPipelineState.h"
#import "MetalTexture.h"

typedef struct s_input {
    Float32 positionX;
    Float32 positionY;
    
    Float32 u;
    Float32 v;
    
    Float32 color1;
    Float32 color2;
    Float32 color3;
    Float32 color4;
} s_input;


HL_PRIM void HL_NAME(mtlrendercommandencoder_setVertexBuffer_offset_index)(
                                                                           id<MTLRenderCommandEncoder> encoder,
                                                                           id<MTLBuffer> buffer,
                                                                           int32_t offset,
                                                                           int32_t index) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_setVertexBuffer_offset_index: start");

    NSData *d = [NSData dataWithBytes:buffer.contents length:buffer.length];
    DEBUG_NSLOG(@"Buffer (offset %d; length %lu; index %d) contents: %@", offset, buffer.length, index, d.debugDescription)
    
    s_input *vertices = (s_input*)buffer.contents;
    for (int i = 0; i < 4; ++i) {
//        if (i == 0) {
//            vertices[i].positionX = 0.0;
//            vertices[i].positionY = 0.0;
//        }
//        if (i == 1) {
//            vertices[i].positionX = 1.0;
//            vertices[i].positionY = 0.0;
//        }
//        if (i == 2) {
//            vertices[i].positionX = 0.0;
//            vertices[i].positionY = 1.0;
//        }
//        if (i == 3) {
//            vertices[i].positionX = 1.0;
//            vertices[i].positionY = 1.0;
//        }
//
        // v1: 0x0, 1x0, 0x1
        // v2: 1x0, 1x1, 0x1
        
        // i1: 0 1 2
        // i2: 1 3 2
        
//        if (i == 3) {
//            vertices[i].positionX = 0.0;
//            vertices[i].positionY = -0.5;
//        }
        NSLog(@"POS %d: %f %f", i, vertices[i].positionX, vertices[i].positionY);
        NSLog(@" UV %d: %f %f", i, vertices[i].u, vertices[i].v);
    }
    
    [encoder setVertexBuffer:buffer offset:offset atIndex:index];
    
    DEBUG_NSLOG(@"mtlrendercommandencoder_setVertexBuffer_offset_index: end");
}

HL_PRIM void HL_NAME(mtlrendercommandencoder_setViewport_viewport)(
                                                                     id<MTLRenderCommandEncoder> encoder,
                                                                     Proxy_MTLViewport *viewport) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_setViewport_viewport: start");
    DEBUG_NSLOG(@"viewport: %f.%f, %f.%f, %f-%f", viewport->originX, viewport->originY, viewport->width, viewport->height, viewport->znear, viewport->zfar);
    
    [encoder setViewport:(MTLViewport){ viewport->originX, viewport->originY, viewport->width, viewport->height, viewport->znear, viewport->zfar }];
    
    DEBUG_NSLOG(@"mtlrendercommandencoder_setViewport_viewport: end");
}

HL_PRIM void HL_NAME(mtlrendercommandencoder_setRenderPipelineState)(
                                                                     id<MTLRenderCommandEncoder> encoder,
                                                                     id<MTLRenderPipelineState> state) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_setRenderPipelineState: start");

    [encoder setRenderPipelineState:state];
    
    DEBUG_NSLOG(@"mtlrendercommandencoder_setRenderPipelineState: end");
}

HL_PRIM void HL_NAME(mtlrendercommandencoder_setFragmentTexture_index)(
                                                                       id<MTLRenderCommandEncoder> encoder,
                                                                       id<MTLTexture> texture,
                                                                       int32_t index) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_setFragmentTexture_index: start");
    DEBUG_NSLOG(@"texture: %@", texture);
    DEBUG_NSLOG(@"index: %d", index);
    [encoder setFragmentTexture:texture atIndex:index];
    DEBUG_NSLOG(@"mtlrendercommandencoder_setFragmentTexture_index: end");
}


HL_PRIM void HL_NAME(mtlrendercommandencoder_drawIndexedPrimitives_indexCount_indexType_indexBuffer_indexBufferOffset_instanceCount_baseVertex_baseInstance)(
                                                                                                                                                             id<MTLRenderCommandEncoder> encoder,
                                                                                                                                                             int32_t primitiveType,
                                                                                                                                                             int32_t indexCount,
                                                                                                                                                             int32_t indexType,
                                                                                                                                                             id<MTLBuffer> indexBuffer,
                                                                                                                                                             int32_t indexBufferOffset,
                                                                                                                                                             int32_t instanceCount,
                                                                                                                                                             int32_t baseVertex,
                                                                                                                                                             int32_t baseInstance) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_drawIndexedPrimitives_indexCount_indexType_indexBuffer_indexBufferOffset_instanceCount_baseVertex_baseInstance: start");

    NSData *d = [NSData dataWithBytes:indexBuffer.contents length:indexBuffer.length];
    
    DEBUG_NSLOG(@"Primitive type: %lu", (MTLPrimitiveType)primitiveType);
    DEBUG_NSLOG(@"Index count: %d", indexCount);
    DEBUG_NSLOG(@"Index type: %lu", (MTLIndexType)indexType);
    DEBUG_NSLOG(@"Index buffer (length %lu): %@", indexBuffer.length, d.description);
    DEBUG_NSLOG(@"Index offset: %d", indexBufferOffset);
    DEBUG_NSLOG(@"Instance count: %d", instanceCount);
    DEBUG_NSLOG(@"Base vertex: %d", baseVertex);
    DEBUG_NSLOG(@"Base instance: %d", baseInstance);
    
    for (int i = 0; i < instanceCount*3; ++i) {
        
//        if (i == 3) {
//            ((uint16_t*)indexBuffer.contents)[i] = 1;
//        }
//        if (i == 4) {
//            ((uint16_t*)indexBuffer.contents)[i] = 3;
//        }
//        if (i == 5) {
//            ((uint16_t*)indexBuffer.contents)[i] = 2;
//        }
        
        // i1: 0 1 2
        // i2: 1 3 2
        
        uint16_t index = ((uint16_t*)indexBuffer.contents)[i];
        DEBUG_NSLOG(@"index[%d]: %d", i, index);
    }
    
//    hl_fatal_error("instance count test", __FILE__, __LINE__);
    
    [encoder drawIndexedPrimitives:primitiveType
                        indexCount:indexCount
                         indexType:indexType
                       indexBuffer:indexBuffer
                 indexBufferOffset:indexBufferOffset
                     instanceCount:instanceCount
                        baseVertex:baseVertex
                      baseInstance:baseInstance];
    
    
    DEBUG_NSLOG(@"mtlrendercommandencoder_drawIndexedPrimitives_indexCount_indexType_indexBuffer_indexBufferOffset_instanceCount_baseVertex_baseInstance: end");
}


HL_PRIM void HL_NAME(mtlrendercommandencoder_endEncoding)(id<MTLRenderCommandEncoder> encoder) {
    DEBUG_NSLOG(@"metal@mtlrendercommandencoder_endEncoding: start");

    [encoder endEncoding];
    
    DEBUG_NSLOG(@"metal@mtlrendercommandencoder_endEncoding: end");
}

HL_PRIM void HL_NAME(mtlrendercommandencoder_release)(id<MTLRenderCommandEncoder> rce) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_release: start with %@", rce);
    
    //hl_fatal_error("stopping mtlrendercom", __FILE__, __LINE__);
    [rce release];

    DEBUG_NSLOG(@"mtlrendercommandencoder_release: end");
}

DEFINE_PRIM(_VOID,mtlrendercommandencoder_setFragmentTexture_index,_MTL_RENDER_COMMAND_ENCODER _MTL_TEXTURE _I32);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_release,_MTL_RENDER_COMMAND_ENCODER);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_setViewport_viewport,_MTL_RENDER_COMMAND_ENCODER _DYN);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_endEncoding,_MTL_RENDER_COMMAND_ENCODER);
DEFINE_PRIM(
            _VOID,
            mtlrendercommandencoder_drawIndexedPrimitives_indexCount_indexType_indexBuffer_indexBufferOffset_instanceCount_baseVertex_baseInstance,
            _MTL_RENDER_COMMAND_ENCODER _I32 _I32 _I32 _MTL_BUFFER _I32 _I32 _I32 _I32);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_setVertexBuffer_offset_index,_MTL_RENDER_COMMAND_ENCODER _MTL_BUFFER _I32 _I32);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_setRenderPipelineState,_MTL_RENDER_COMMAND_ENCODER _MTL_RENDER_PIPELINE_STATE);
