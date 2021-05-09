#import "MTLCommandBuffer.h"
#import "CAMetalDrawable.h"
#import "MTLRenderCommandEncoder.h"

MTLRenderPassDescriptor* _unwrap_render_pass_descriptor(Proxy_MTLRenderPassDescriptor *descriptor) {
    MTLRenderPassDescriptor *result = [MTLRenderPassDescriptor new];
    
    for (int i = 0; i < descriptor->colorAttachments->size; ++i) {
        Proxy_MTLRenderPassColorAttachmentDescriptor *colorAttachment = hl_aptr(descriptor->colorAttachments, Proxy_MTLRenderPassColorAttachmentDescriptor*)[i];
        
        result.colorAttachments[i].loadAction = (MTLLoadAction)colorAttachment->base.loadAction;
        DEBUG_NSLOG(@"Setting loadAction[%d] to %d", i, colorAttachment->base.loadAction);
        
        result.colorAttachments[i].storeAction = (MTLStoreAction)colorAttachment->base.storeAction;
        DEBUG_NSLOG(@"Setting storeAction[%d] to %d", i, colorAttachment->base.storeAction);
        
        result.colorAttachments[i].clearColor = MTLClearColorMake(
                                                                  colorAttachment->clearColor->red,
                                                                  colorAttachment->clearColor->green,
                                                                  colorAttachment->clearColor->blue,
                                                                  colorAttachment->clearColor->alpha);
        DEBUG_NSLOG(@"Setting clearColor[%d] to %f %f %f %f", i, result.colorAttachments[i].clearColor.red, result.colorAttachments[i].clearColor.green, result.colorAttachments[i].clearColor.blue, result.colorAttachments[i].clearColor.alpha);
        
        
        id<MTLTexture> tex = colorAttachment->base.texture->texture;
        DEBUG_NSLOG(@"Setting render pass descriptor texture: %@", tex);
        result.colorAttachments[i].texture = tex;
    }
    
    result.depthAttachment.loadAction = descriptor->depthAttachment->base.loadAction;
    result.depthAttachment.storeAction = descriptor->depthAttachment->base.storeAction;
    result.depthAttachment.clearDepth = descriptor->depthAttachment->clearDepth;
    DEBUG_NSLOG(@"Setting depth store to %lu", (unsigned long)result.depthAttachment.storeAction);
    DEBUG_NSLOG(@"Setting depth load to %lu", (unsigned long)result.depthAttachment.loadAction);
    DEBUG_NSLOG(@"Setting depth clear to %f", result.depthAttachment.clearDepth);
     
    result.stencilAttachment.loadAction = descriptor->stencilAttachment->base.loadAction;
    result.stencilAttachment.storeAction = descriptor->stencilAttachment->base.storeAction;
    result.stencilAttachment.clearStencil = descriptor->stencilAttachment->clearStencil;
    DEBUG_NSLOG(@"Setting stencil store to %lu", (unsigned long)result.stencilAttachment.storeAction);
    DEBUG_NSLOG(@"Setting stencil load to %lu", (unsigned long)result.stencilAttachment.loadAction);
    DEBUG_NSLOG(@"Setting stencil clear to %d", result.stencilAttachment.clearStencil);
    
    
    return result;
}

HL_PRIM id<MTLRenderCommandEncoder> HL_NAME(mtlcommandbuffer_renderCommandEncoder_descriptor)(id<MTLCommandBuffer> buffer, Proxy_MTLRenderPassDescriptor *descriptor) {
    DEBUG_NSLOG(@"mtlcommandbuffer_renderCommandEncoder_descriptor: begin with %@", buffer);

    MTLRenderPassDescriptor *renderPassDescriptor = _unwrap_render_pass_descriptor(descriptor);
    DEBUG_NSLOG(@"Unwrapped descriptor %@", renderPassDescriptor);
    DEBUG_NSLOG(@"Asking %@ to create an encoder", buffer);
    id<MTLRenderCommandEncoder> encoder = [buffer renderCommandEncoderWithDescriptor:renderPassDescriptor];
    DEBUG_NSLOG(@"mtlcommandbuffer_renderCommandEncoder_descriptor: returning encoder %@", encoder);
    
    [encoder setCullMode:MTLCullModeNone];
    
    return encoder;
}

HL_PRIM void HL_NAME(mtlcommandbuffer_commit)(id<MTLCommandBuffer> buffer) {
    DEBUG_NSLOG(@"mtlcommandbuffer_commit: start");

    [buffer commit];
     
    DEBUG_NSLOG(@"mtlcommandbuffer_commit: end");
}

HL_PRIM void HL_NAME(mtlcommandbuffer_presentDrawable)(id<MTLCommandBuffer> buffer, id<CAMetalDrawable> drawable) {
    DEBUG_NSLOG(@"mtlcommandbuffer_presentDrawable: start");

    [buffer presentDrawable:drawable];
    
    DEBUG_NSLOG(@"mtlcommandbuffer_presentDrawable: end");
}

//HL_PRIM void HL_NAME(mtlcommandbuffer_nativeTest)(/*Proxy_MTLClearColorExtended *ext*/varray *exts) {
//    @autoreleasepool {
////        NSLog(@"mtlcommandbuffer_nativeTest");
////        NSLog(@"array size: %d", exts->size);
////
////        for( int i=0; i<exts->size; i++ ){
////            Proxy_MTLClearColor *ext = hl_aptr(exts, Proxy_MTLClearColor*)[i];
////            NSLog(@"%f %f %f %f", ext->base.red, ext->base.green, ext->base.blue, ext->alpha);
////        }
//    }
//}

HL_PRIM void HL_NAME(mtlcommandbuffer_release)(id<MTLCommandBuffer> cb) {
    DEBUG_NSLOG(@"mtlcommandbuffer_release: start with %@", cb);
    
    [cb release];

    DEBUG_NSLOG(@"mtlcommandbuffer_release: end");
}

DEFINE_PRIM(_VOID,mtlcommandbuffer_release,_MTL_COMMAND_BUFFER);

//DEFINE_PRIM(_VOID,mtlcommandbuffer_nativeTest,_ARR);
DEFINE_PRIM(_VOID,mtlcommandbuffer_presentDrawable,_MTL_COMMAND_BUFFER _CA_METAL_DRAWABLE);
DEFINE_PRIM(_VOID,mtlcommandbuffer_commit,_MTL_COMMAND_BUFFER);
DEFINE_PRIM(_MTL_RENDER_COMMAND_ENCODER,mtlcommandbuffer_renderCommandEncoder_descriptor,_MTL_COMMAND_BUFFER _DYN);
