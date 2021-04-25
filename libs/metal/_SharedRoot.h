#define HL_NAME(n) metal_##n
#include <hl.h>
#import <Cocoa/Cocoa.h>
#import <Metal/Metal.h>
#import <QuartzCore/QuartzCore.h>


#define DEBUG 1

#ifdef DEBUG

#define DEBUG_NSLOG(...) NSLog(__VA_ARGS__);

#else

#define DEBUG_NSLOG(...) ;

#endif

typedef struct Proxy_MTLOrigin {
    hl_type * _;
    int32_t x;
    int32_t y;
    int32_t z;
} Proxy_MTLOrigin;

typedef struct Proxy_MTLSize {
    hl_type * _;
    int32_t width;
    int32_t height;
    int32_t depth;
} Proxy_MTLSize;

typedef struct Proxy_MTLRegion {
    hl_type * _;
    Proxy_MTLOrigin *origin;
    Proxy_MTLSize *size;
} Proxy_MTLRegion;

typedef struct Proxy_MTLClearColor
{
    hl_type *t;
    double red;
    double green;
    double blue;
    double alpha;
} Proxy_MTLClearColor;

typedef int32_t Proxy_MTLLoadAction;
typedef int32_t Proxy_MTLStoreAction;

typedef struct Proxy_MTLTexture {
    hl_type *t;
    id<MTLTexture> texture;
} Proxy_MTLTexture;

typedef struct Proxy_MTLRenderPassAttachmentDescriptor {
    hl_type *t;
    Proxy_MTLLoadAction loadAction;
    Proxy_MTLStoreAction storeAction;
    Proxy_MTLTexture *texture;
} Proxy_MTLRenderPassAttachmentDescriptor;

typedef struct Proxy_MTLRenderPassColorAttachmentDescriptor {
    Proxy_MTLRenderPassAttachmentDescriptor base;
    Proxy_MTLClearColor *clearColor;
} Proxy_MTLRenderPassColorAttachmentDescriptor;

typedef struct Proxy_MTLRenderPassDescriptor {
    hl_type *t;
    varray *colorAttachments;
} Proxy_MTLRenderPassDescriptor;
