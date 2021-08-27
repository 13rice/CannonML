
package org.si.cml.core;

#if heaps
class Point extends h2d.col.Point
{

}
#else
@:structInit class Point
{
	public var x: Float;
	public var y: Float;

	public function new(x: Float, y: Float) { this.x = x; this.y = y; }
}
#end