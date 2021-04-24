#import "MTLCommandQueue.h"
#import "MTLCommandBuffer.h"

HL_PRIM id<MTLCommandBuffer> HL_NAME(mtlcommandqueue_commandBuffer)(id<MTLCommandQueue> commandQueue) {
    @autoreleasepool {
        NSLog(@"mtlcommandqueue_commandBuffer");
        
        return [commandQueue commandBuffer];
    }
}

DEFINE_PRIM(_MTL_COMMAND_BUFFER,mtlcommandqueue_commandBuffer,_MTL_COMMAND_QUEUE);
