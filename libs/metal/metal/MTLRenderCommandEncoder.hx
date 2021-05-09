package metal;

@:allow(metal.Driver)
@:allow(metal.MTLDevice)
@:allow(metal.MTLCommandBuffer)
@:hlNative("metal", "mtlrendercommandencoder_")
class MTLRenderCommandEncoder extends MetalResource<MTLRenderCommandEncoderPtr> {

    public function setVertexBufferWithOffsetAtIndex(buffer: MTLBuffer, offset: Int, index: Int)
    {
        trace('Setting vertex buffer at index $index');
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

    public function setFragmentTextureAtIndex(tex: MTLTexture, index: Int) {
        nativeSetFragmentTextureAtIndex(
            ptr,
            @:privateAccess tex.ptr,
            index
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

    public function setViewport(viewport: MTLViewport) {
        nativeSetViewport( ptr, viewport );
    }

    @:hlNative("metal", "mtlrendercommandencoder_setFragmentTexture_index")
    private static function nativeSetFragmentTextureAtIndex(
        ptr: MTLRenderCommandEncoderPtr,
        texPtr: MTLTexturePtr,
        index: Int ) {
    }

    @:hlNative("metal", "mtlrendercommandencoder_setViewport_viewport")
    private static function nativeSetViewport( ptr: MTLRenderCommandEncoderPtr, viewport: Dynamic ) {
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
