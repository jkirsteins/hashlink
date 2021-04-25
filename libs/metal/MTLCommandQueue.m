#import "MTLCommandQueue.h"
#import "MTLCommandBuffer.h"

HL_PRIM id<MTLCommandBuffer> HL_NAME(mtlcommandqueue_commandBuffer)(id<MTLCommandQueue> commandQueue) {
    DEBUG_NSLOG(@"mtlcommandqueue_commandBuffer: begin with %@", commandQueue);
    
    id<MTLCommandBuffer> buffer = [commandQueue commandBuffer];
    DEBUG_NSLOG(@"mtlcommandqueue_commandBuffer: returning %@", buffer);
    return buffer;
}

DEFINE_PRIM(_MTL_COMMAND_BUFFER,mtlcommandqueue_commandBuffer,_MTL_COMMAND_QUEUE);
