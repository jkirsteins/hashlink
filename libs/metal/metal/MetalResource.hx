package metal;

@:generic
class MetalResource<TPtr> {
  private var ptr: TPtr;

  private function new(value: TPtr) {
    this.ptr = value;
  }
}