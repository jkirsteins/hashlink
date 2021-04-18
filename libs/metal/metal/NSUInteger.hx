package metal;

import haxe.Int32;
import haxe.Int64;

@:keep
class _NSUInteger1
{
    public var low : Int32;
    public var high : Int32;

    private function new(low: Int32, high: Int32) {
        this.low = low;
        this.high = high;
    }

    public static function fromI64_32Range(val: Int64): _NSUInteger1 {
        return new _NSUInteger1(val.low, 0);
    }
}

typedef NSUInteger = _NSUInteger1;
