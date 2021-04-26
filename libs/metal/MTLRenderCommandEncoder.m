#import "MTLRenderCommandEncoder.h"
#import "MTLBuffer.h"
#import "MTLRenderPipelineState.h"

HL_PRIM void HL_NAME(mtlrendercommandencoder_setVertexBuffer_offset_index)(
                                                                           id<MTLRenderCommandEncoder> encoder,
                                                                           id<MTLBuffer> buffer,
                                                                           int32_t offset,
                                                                           int32_t index) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_setVertexBuffer_offset_index: start");

    [encoder setVertexBuffer:buffer offset:offset atIndex:index];
    
    DEBUG_NSLOG(@"mtlrendercommandencoder_setVertexBuffer_offset_index: end");
}

HL_PRIM void HL_NAME(mtlrendercommandencoder_setRenderPipelineState)(
                                                                     id<MTLRenderCommandEncoder> encoder,
                                                                     id<MTLRenderPipelineState> state) {
    DEBUG_NSLOG(@"mtlrendercommandencoder_setRenderPipelineState: start");

    [encoder setRenderPipelineState:state];
    
    DEBUG_NSLOG(@"mtlrendercommandencoder_setRenderPipelineState: end");
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
    
    [rce release];

    DEBUG_NSLOG(@"mtlrendercommandencoder_release: end");
}

DEFINE_PRIM(_VOID,mtlrendercommandencoder_release,_MTL_RENDER_COMMAND_ENCODER);

DEFINE_PRIM(_VOID,mtlrendercommandencoder_endEncoding,_MTL_RENDER_COMMAND_ENCODER);
DEFINE_PRIM(
            _VOID,
            mtlrendercommandencoder_drawIndexedPrimitives_indexCount_indexType_indexBuffer_indexBufferOffset_instanceCount_baseVertex_baseInstance,
            _MTL_RENDER_COMMAND_ENCODER _I32 _I32 _I32 _MTL_BUFFER _I32 _I32 _I32 _I32);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_setVertexBuffer_offset_index,_MTL_RENDER_COMMAND_ENCODER _MTL_BUFFER _I32 _I32);
DEFINE_PRIM(_VOID,mtlrendercommandencoder_setRenderPipelineState,_MTL_RENDER_COMMAND_ENCODER _MTL_RENDER_PIPELINE_STATE);
