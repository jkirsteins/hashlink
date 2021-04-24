#import "MTLLibrary.h"
#import "MTLFunction.h"


HL_PRIM id<MTLFunction> HL_NAME(mtllibrary_newFunction_name)(id<MTLLibrary> library, vbyte *name) {
    NSString *nsName = [NSString stringWithUTF8String:(char*)name];
    NSLog(@"Name: %@", nsName);

    id<MTLFunction> result = [library newFunctionWithName:nsName];

#if DEBUG
    NSLog(@"Found function %@", result);
#endif
    return result;
}

DEFINE_PRIM(_MTL_FUNCTION,mtllibrary_newFunction_name,_MTL_LIBRARY _BYTES);


 
