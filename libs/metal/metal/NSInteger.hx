package metal;

import haxe.Int32;
import haxe.Int64;

// @:keep
// class _NSInteger1
// {
//     public var low : Int32;
//     public var high : Int32;

//     private function new(low: Int32, high: Int32) {
//         this.low = low;
//         this.high = high;
//     }

//     public static function fromI64_32Range(val: haxe.Int64): _NSInteger1 {
//         var high : Int = 0;
//         var low = val.low;
//         if (val < 0) {
//             high = 0x80000000;

//             // ensure sign bit is off
//             low = low | 0x80000000;
//             low = low ^ 0x80000000;
//         }

//         return new _NSInteger1(
//             low,
//             high);
//     }
// }

// typedef NSInteger = _NSInteger1;
