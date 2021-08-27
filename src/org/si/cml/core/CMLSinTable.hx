package org.si.cml.core;

/** @private */
class CMLSinTable implements ArrayAccess<Int>
{
    private var d2i:Float;
    private var fil:Int;
    public  var cos_shift:Int;
    private var sin:Array<Float>;

    private static var sinTableCache: Map<Int, Array<Float>> = [];

    public function new(table_size:Int=4096)
    {


        cos_shift = table_size>>2;

        var size:Int    = table_size + cos_shift,
            step:Float = Math.PI / (table_size >> 1),
            i:Int;

        if( !sinTableCache.exists( table_size ) )
        {
            var sin = new Array<Float>();
            for (i in 0...size) { sin.push(Math.sin(i*step)); }
            sinTableCache[table_size] = sin;
        }

        sin = sinTableCache[table_size];

        d2i = table_size/360;
        fil = table_size - 1;
    }

    public function index(deg:Float) : Int
    {
        return (Std.int(deg*d2i))&fil;
    }

    @:arrayAccess public inline function __get(key:Int):Float {
        return sin[key];
    }

    @:arrayAccess public inline function arrayWrite(key:Int, value:Float):Float {
        sin[key]=value;
        return value;
    }
}



