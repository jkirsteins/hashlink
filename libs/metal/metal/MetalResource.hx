package metal;

import hl.Bytes;

// class NSObject
// {
//   @:hlNative("metal", "nsobject_release")
//   private static function nativeRelease( ptr: Dynamic ) {
//   }
// }

@:generic
class MetalResource<TPtr> {
  private var ptr: TPtr;

  private function new(value: TPtr) {
    this.ptr = value;
  }
}