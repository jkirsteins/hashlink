#import "MTLBuffer.h"

HL_PRIM void HL_NAME(mtlbuffer_contents_memcpy)(
                                           id<MTLBuffer> buffer,
                                           vbyte* data,
                                           int32_t offset,
                                           int32_t size) {
    @autoreleasepool {
        DEBUG_NSLOG(@"mtlbuffer_contents_memcpy: start");
        DEBUG_NSLOG(@"mtlbuffer_contents_memcpy: offset (%d) size (%d)", offset, size);
        DEBUG_NSLOG(@"mtlbuffer_contents_memcpy: buffer (%@)", buffer);
        
        if (buffer == NULL) {
            hl_fatal_error("Specified MTLBufferPtr is null", __FILE__, __LINE__);
        }

        if (size < 0) {
            NSLog(@"Not updating buffer %@ because size is <0 (%d)", buffer, size);
            return;
        }
        
        if (size - offset > buffer.length) {
            hl_fatal_error("Given data does not fit in buffer", __FILE__, __LINE__);
        }

        DEBUG_NSLOG(@"Updating buffer %@ offset %d size %d", buffer, offset, size);

        memcpy((char*)buffer.contents + offset, data, size);
        
        DEBUG_NSLOG(@"mtlbuffer_contents_memcpy: end");
    }
}

HL_PRIM int32_t HL_NAME(mtlbuffer_length)(id<MTLBuffer> buffer) {
    @autoreleasepool {
        DEBUG_NSLOG(@"mtlbuffer_length: start");

        int32_t result = (int32_t)buffer.length;
        DEBUG_NSLOG(@"mtlbuffer_length: end (return %d)", result);
        return result;
    }
}

DEFINE_PRIM(_I32,mtlbuffer_length,_MTL_BUFFER);
DEFINE_PRIM(_VOID,mtlbuffer_contents_memcpy,_MTL_BUFFER _BYTES _I32 _I32);
