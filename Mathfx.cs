//http://wiki.unity3d.com/index.php/Mathfx
using UnityEngine;
using System;

public class Mathfx
{
	/////////////////////Vectors and bools/////////////////////////
	public static Vector3 NearestPoint(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{

		Vector3 lineDirection = Vector3.Normalize(lineEnd-lineStart);
		float closestPoint = Vector3.Dot((point-lineStart), lineDirection)/Vector3.Dot(lineDirection, lineDirection);
		return lineStart+(closestPoint*lineDirection);
	}
	public static Vector3 NearestPointStrict(Vector3 lineStart, Vector3 lineEnd, Vector3 point)
	{

		Vector3 fullDirection = lineEnd-lineStart;
		Vector3 lineDirection = Vector3.Normalize(fullDirection);
		float closestPoint = Vector3.Dot((point-lineStart), lineDirection)/Vector3.Dot(lineDirection, lineDirection);
		return lineStart+(Mathf.Clamp(closestPoint, 0.0f, Vector3.Magnitude(fullDirection))*lineDirection);
	}
	// test for value that is near specified float (due to floating point inprecision)
	// all thanks to Opless for this!
    public static bool Approx(float val, float about, float range)
	{

		return ((Mathf.Abs(val - about) < range));
	}
	// test if a Vector3 is close to another Vector3 (due to floating point inprecision)
	// compares the square of the distance to the square of the range as this 
	// avoids calculating a square root which is much slower than squaring the range
    public static bool Approx(Vector3 val, Vector3 about, float range)
	{

		return ((val - about).sqrMagnitude < range*range);
	}
	////////////////////Floats/////////////////////////////////
	//classic lerp for comparison
	public static float Lerp(float start, float end, float value)
	{

		return ((1.0f - value) * start) + (value * end);
	}
	//classic smoothstep.returns value between 0 and 1
	public static float SmoothStep (float x, float min, float max)
	{

		x = Mathf.Clamp (x, min, max);
		float v1 = (x-min)/(max-min);
		float v2 = (x-min)/(max-min);
		return -2*v1 * v1 *v1 + 3*v2 * v2;
	}
	//This method will interpolate while easing in and out at the limits.
	public static float Hermite(float start, float end, float value)
	{

		return Mathf.Lerp(start, end, value * value * (3.0f - 2.0f * value));
	}


	//ease out
	public static float Sinerp(float start, float end, float value)
	{

		return Mathf.Lerp(start, end, Mathf.Sin(value * Mathf.PI * 0.5f));
	}


	//ease in
	public static float Coserp(float start, float end, float value)
	{

		return Mathf.Lerp(start, end, 1.0f - Mathf.Cos(value * Mathf.PI * 0.5f));
	}
	//Short for 'boing-like interpolation', this method will first overshoot, then waver back and forth around the end value before coming to a rest.
	public static float Berp(float start, float end, float value)
	{

		value = Mathf.Clamp01(value);
		value = (Mathf.Sin(value * Mathf.PI * (0.2f + 2.5f * value * value * value)) * Mathf.Pow(1f - value, 2.2f) + value) * (1f + (1.2f * (1f - value)));
		return start + (end - start) * value;
	}
	//Returns a value between 0 and 1 that can be used to easily make bouncing GUI items (a la OS X's Dock)
	public static float Bounce(float x, float bumps)
	{

		return Mathf.Abs(Mathf.Sin(bumps*(x+1f)*(x+1f)) * (1f-x));
	}
	/*
     * CLerp - Circular Lerp - is like lerp but handles the wraparound from 0 to 360.
     * This is useful when interpolating eulerAngles and the object
     * crosses the 0/360 boundary.  The standard Lerp function causes the object
     * to rotate in the wrong direction and looks stupid. Clerp fixes that.
     */
    public static float Clerp(float start , float end, float value)
	{

		float min = 0.0f;
		float max = 360.0f;
		float half = Mathf.Abs((max - min)/2.0f);//half the distance between min and max
        float retval = 0.0f;
		float diff = 0.0f;

		if((end - start) < -half) {
			diff = ((max - start)+end)*value;
			retval = start+diff;
		}
		else if((end - start) > half) {
			diff = -((max - end)+start)*value;
			retval = start+diff;
		}
		else retval = start+(end-start)*value;

		// Debug.Log("Start: "  + start + "   End: " + end + "  Value: " + value + "  Half: " + half + "  Diff: " + diff + "  Retval: " + retval);
		return retval;
	}
	/*  Weighted Average
		One rather handy algorithm, especially when you don't necessarily know how the target will behave in the future 
		(such as a camera tracking the player's character), is to apply weighted average to the value.
		return ((v * (N - 1)) + w) / N; 
		where v is the current value, w is the value towards which we want to move, and N is the slowdown factor. The higher N, the slower v approaches w.
		The closer v gets to w, the slower it moves; the further away they are, the faster v changes. 
		In ideal world, v will never actually reach w, as the steps towards the goal get smaller and smaller. Then again, computers aren't ideal.
		http://sol.gfxile.net/interpolation/index.html
	*/
	public static float Weighted(float current, float target, float slowdown)
	{

		return ((current * (slowdown - 1))+target)/slowdown;
	}
	/*	Catmull-Rom Spline
		Catmull-Rom spline is handy in the way that it always goes through the control points, and as such it can be easily applied to these interpolators. 
		http://sol.gfxile.net/interpolation/index.html
		iterator is the iterator in your for loop coroutine you are calling this from.
		stepamount is the amount of steps between from and to.
		Q and T modify the shape  */
	//takes a value like the other functions in mathfx
	public static float Crom(float from, float to, float value, float Q, float T)
	{

		value = catmullrom(value, Q, 0, 1, T);
		return (to * value) + (from * (1 - value));
	}
	//takes the loop iterator from which this function is called and the total amount of steps
	public static float Crom(float from, float to, float iterator, float stepamount, float Q, float T)
	{

		float vv = iterator / stepamount;
		vv = catmullrom(vv, Q, 0, 1, T);
		return (to * vv) + (from * (1 - vv));
	}
	public static float catmullrom(float t, float p0, float p1, float p2, float p3)
	{

		return 0.5f * ((2 * p1) +
		(-p0 + p2) * t +
		(2 * p0 - 5 * p1 + 4 * p2 - p3) * t * t +
		(-p0 + 3 * p1 - 3 * p2 + p3) * t * t * t);
	}
	//
	public static float Sine(float amp, float speed, float value)
	{
		return amp*Mathf.Cos(speed*value);
	}
	
	//ghor
	 public static float Remap( float value, float inMin, float inMax, float outMin, float outMax ) 
	 { 
	 return outMin + ( ( ( value - inMin ) / ( inMax - inMin ) ) * ( outMax - outMin ) ); }



 
}
