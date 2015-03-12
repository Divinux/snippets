static function Hermite(start : float, end : float, value : float) : float
{
    return Mathf.Lerp(start, end, value * value * (3.0 - 2.0 * value));
}
 
static function Sinerp(start : float, end : float, value : float) : float
{
    return Mathf.Lerp(start, end, Mathf.Sin(value * Mathf.PI * 0.5));
}
 
static function Coserp(start : float, end : float, value : float) : float
{
    return Mathf.Lerp(start, end, 1.0 - Mathf.Cos(value * Mathf.PI * 0.5));
}
 
static function Berp(start : float, end : float, value : float) : float
{
    value = Mathf.Clamp01(value);
    value = (Mathf.Sin(value * Mathf.PI * (0.2 + 2.5 * value * value * value)) * Mathf.Pow(1 - value, 2.2) + value) * (1 + (1.2 * (1 - value)));
    return start + (end - start) * value;
}
 
static function SmoothStep (x : float, min : float, max : float) : float
{
    x = Mathf.Clamp (x, min, max);
    var v1 = (x-min)/(max-min);
    var v2 = (x-min)/(max-min);
    return -2*v1 * v1 *v1 + 3*v2 * v2;
}
 
static function Lerp(start : float, end : float, value : float) : float
{
    return ((1.0 - value) * start) + (value * end);
}
 
static function NearestPoint(lineStart : Vector3, lineEnd : Vector3, point : Vector3) : Vector3
{
    var lineDirection = Vector3.Normalize(lineEnd-lineStart);
    var closestPoint = Vector3.Dot((point-lineStart),lineDirection)/Vector3.Dot(lineDirection,lineDirection);
    return lineStart+(closestPoint*lineDirection);
}
 
static function NearestPointStrict(lineStart : Vector3, lineEnd : Vector3, point : Vector3) : Vector3
{
    var fullDirection = lineEnd-lineStart;
    var lineDirection = Vector3.Normalize(fullDirection);
    var closestPoint = Vector3.Dot((point-lineStart),lineDirection)/Vector3.Dot(lineDirection,lineDirection);
    return lineStart+(Mathf.Clamp(closestPoint,0.0,Vector3.Magnitude(fullDirection))*lineDirection);
}
//original function
static function Bounce(x : float) : float {
    return Mathf.Abs(Mathf.Sin(6.28*(x+1)*(x+1)) * (1-x));
}
//takes an additional float for the amount of boounces
	static function Bounce(x : float, bounces : float) : float {
		return Mathf.Abs(Mathf.Sin(bounces*(x+1f)*(x+1f)) * (1f-x));
	}
 
// test for value that is near specified float (due to floating point inprecision)
// all thanks to Opless for this!
static function Approx(val : float, about : float, range : float) : boolean {
    return ( ( Mathf.Abs(val - about) < range) );
}
 
// test if a Vector3 is close to another Vector3 (due to floating point inprecision)
// compares the square of the distance to the square of the range as this 
// avoids calculating a square root which is much slower than squaring the range
static function Approx(val : Vector3, about : Vector3, range : float) : boolean {
   return ( (val - about).sqrMagnitude < range*range);
}
 
// CLerp - Circular Lerp - is like lerp but handles the wraparound from 0 to 360.
// This is useful when interpolating eulerAngles and the object
// crosses the 0/360 boundary.  The standard Lerp function causes the object
// to rotate in the wrong direction and looks stupid. Clerp fixes that.
static function Clerp(start : float, end : float, value : float) : float {
   var min = 0.0;
   var max = 360.0;
   var half = Mathf.Abs((max - min)/2.0);//half the distance between min and max
   var retval = 0.0;
   var diff = 0.0;
 
   if((end - start) < -half){
       diff = ((max - start)+end)*value;
       retval =  start+diff;
   }
   else if((end - start) > half){
       diff = -((max - end)+start)*value;
       retval =  start+diff;
   }
   else retval =  start+(end-start)*value;
 
   // Debug.Log("Start: "  + start + "   End: " + end + "  Value: " + value + "  Half: " + half + "  Diff: " + diff + "  Retval: " + retval);
   return retval;
}

//one full sine rotation
static function Sine(amp : float, speed : float, value : float) : float {
	return amp*Mathf.Cos(speed*value);
}	
/*  Weighted Average
Returns ((v * (N - 1)) + w) / N; 
where v is the current value, w is the value towards which we want to move, and N is the slowdown factor. The higher N, the slower v approaches w.
The closer v gets to w, the slower it moves; the further away they are, the faster v changes. 
http://sol.gfxile.net/interpolation/index.html
*/
static function Weighted(current : float, target : float, slowdown : float) : float{
	return ((current * (slowdown - 1))+target)/slowdown;
}
/*	Catmull-Rom Spline
Catmull-Rom spline is handy in the way that it always goes through the control points, and as such it can be easily applied to these interpolators. 
http://sol.gfxile.net/interpolation/index.html
Q and T modify the shape  */
static function Crom(from : float, to : float, value : float, Q : float, T : float) : float{
	value = catmullrom(value, Q, 0, 1, T);
	return (to * value) + (from * (1 - value));
}
static function catmullrom(t : float, p0 : float, p1 : float, p2 : float, p3 : float) : float{
	return 0.5f * ((2 * p1) +
	(-p0 + p2) * t +
	(2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
	(-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t);
}