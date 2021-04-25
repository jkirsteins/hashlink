#import "MTLBuffer.h"

HL_PRIM void HL_NAME(mtlbuffer_contents_memcpy)(
                                           id<MTLBuffer> buffer,
                                           vbyte* data,
                                           int32_t offset,
                                           int32_t size) {
    @autoreleasepool {
        NSLog(@"mtlbuffer_contents_memcpy");

        if (size < 0) {
            NSLog(@"Not updating buffer %@ because size is <0 (%d)", buffer, size);
            return;
        }

        NSLog(@"Updating buffer %@ offset %d size %d", buffer, offset, size);

        memcpy((char*)buffer.contents + offset, data, size);
    }
}

DEFINE_PRIM(_VOID,mtlbuffer_contents_memcpy,_MTL_BUFFER _BYTES _I32 _I32);
