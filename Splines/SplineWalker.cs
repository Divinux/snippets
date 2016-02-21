using UnityEngine;

public class SplineWalker : MonoBehaviour {

	public BezierSpline spline;

	public float speed;

	public bool lookForward;

	public SplineWalkerMode mode;

	private float progress;
	private bool goingForward = true;

	private void Update () {
		if (goingForward) {
			progress +=  Input.GetAxisRaw("Vertical") *speed;
			if (progress > 1f) {
				if (mode == SplineWalkerMode.Once) {
					progress = 1f;
				}
				else if (mode == SplineWalkerMode.Loop) {
					progress -= 1f;
				}
				else {
					progress = 2f - progress;
					goingForward = false;
				}
			}
		}
		else {
			progress -= Input.GetAxisRaw("Vertical") * speed;
			if (progress < 0f) {
				progress = -progress;
				goingForward = true;
			}
		}
Debug.Log(progress);
		Vector3 position = spline.GetPoint(progress);
		transform.localPosition = position;
		if (lookForward) {
			transform.LookAt(position + spline.GetDirection(progress));
		}
	}
}