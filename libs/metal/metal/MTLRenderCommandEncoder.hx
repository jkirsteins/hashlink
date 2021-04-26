package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLCommandBuffer)
@:hlNative("metal", "mtlrendercommandencoder_")
class MTLRenderCommandEncoder extends MetalResource<MTLRenderCommandEncoderPtr> {

    public function setVertexBufferWithOffsetAtIndex(buffer: MTLBuffer, offset: Int, index: Int)
    {
        MTLRenderCommandEncoder.nativeSetVertexBufferWithOffsetAtIndex(
            ptr,
            @:privateAccess buffer.ptr,
            offset,
            index
        );
    }

    public function setRenderPipelineState(state: MTLRenderPipelineState) {
        MTLRenderCommandEncoder.nativeSetRenderPipelineState(
            ptr,
            @:privateAccess state.ptr
        );
    }

    public function drawIndexedPrimitives(
        primitiveType: MTLPrimitiveType,
        indexCount: Int,
         indexType: MTLIndexType,
       indexBuffer: MTLBuffer,
 indexBufferOffset: Int,
     instanceCount: Int,
        baseVertex: Int,
      baseInstance: Int)
    {
        MTLRenderCommandEncoder.nativeDrawIndexedPrimitives(
            ptr,
            primitiveType,
            indexCount,
            indexType,
            @:privateAccess indexBuffer.ptr,
            indexBufferOffset,
            instanceCount,
            baseVertex,
            baseInstance
        );
    }

    public function endEncoding() {
        MTLRenderCommandEncoder.nativeEndEncoding( ptr );
    }

    public function release() {
        nativeRelease( ptr );
    }

    @:hlNative("metal", "mtlrendercommandencoder_release")
    private static function nativeRelease( ptr: MTLRenderCommandEncoderPtr ) {
    }

    @:hlNative("metal", "mtlrendercommandencoder_endEncoding")
    private static function nativeEndEncoding( encoder: MTLRenderCommandEncoderPtr )
    {
    }

    @:hlNative("metal", "mtlrendercommandencoder_drawIndexedPrimitives_indexCount_indexType_indexBuffer_indexBufferOffset_instanceCount_baseVertex_baseInstance")
    private static function nativeDrawIndexedPrimitives(
        encoder: MTLRenderCommandEncoderPtr,
        primitiveType: MTLPrimitiveType,
        indexCount: Int,
         indexType: MTLIndexType,
       indexBuffer: MTLBufferPtr,
 indexBufferOffset: Int,
     instanceCount: Int,
        baseVertex: Int,
      baseInstance: Int) {
    }

    @:hlNative("metal", "mtlrendercommandencoder_setRenderPipelineState")
    private static function nativeSetRenderPipelineState(encoder: MTLRenderCommandEncoderPtr, state: MTLRenderPipelineStatePtr) {
    }

    @:hlNative("metal", "mtlrendercommandencoder_setVertexBuffer_offset_index")
    private static function nativeSetVertexBufferWithOffsetAtIndex(encoder: MTLRenderCommandEncoderPtr, buffer: MTLBufferPtr, offset: Int, index: Int) {
    }
}
