#import "MTLDevice.h"
#import "MTLLibrary.h"


HL_PRIM id<MTLLibrary> HL_NAME(mtldevice_newLibrary_source)(id<MTLDevice> device, vbyte *source) {
    NSLog(@"mtldevice_newLibrary_source");
    
    NSString *nsSource = [NSString stringWithUTF8String:(char*)source];
    NSLog(@"Source: %@", nsSource);
    
    NSError *error;
    id<MTLLibrary> result = [device newLibraryWithSource:nsSource options:0 error:&error];
    
    if (error != NULL) {
        NSLog(@"Failed to create MTLLibrary from source: %@", error.localizedDescription);
        exit(1);
    }
    
    NSLog(@"Created library %@", result);
    return result;
}

DEFINE_PRIM(_MTL_LIBRARY,mtldevice_newLibrary_source,_MTL_DEVICE _BYTES);


 
