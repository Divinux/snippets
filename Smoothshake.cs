using UnityEngine;
using System.Collections;

public class Smoothshake : MonoBehaviour {
// camera shake
	public float ShakeSpeed = 0.0f;
	public Vector3 ShakeAmplitude = new Vector3(10, 10, 0);
	protected Vector3 m_Shake = Vector3.zero;
	public float m_Pitch = 0.0f;
	public float m_Yaw = 0.0f;
	public float m_Tilt = 0.0f;
	void Start () {
	
	}
	
	// Update is called once per frame
	void Update () 
	{
	UpdateShakes();
	}
	void UpdateShakes()
	{

		// apply camera shakes
		if (ShakeSpeed != 0.0f)
		{
			m_Yaw -= m_Shake.y;			// subtract shake from last frame or camera will drift
			m_Pitch -= m_Shake.x;
			m_Tilt -= m_Shake.z;
			m_Shake = Vector3.Scale(vp_SmoothRandom.GetVector3Centered(ShakeSpeed), ShakeAmplitude);
			m_Yaw += m_Shake.y;			// apply new shake
			m_Pitch += m_Shake.x;
			m_Tilt += m_Shake.z;
			transform.localEulerAngles = new Vector3(m_Pitch,m_Yaw,m_Tilt);
			//m_RotationSpring.AddForce(Vector3.forward * m_Shake.z * Time.timeScale);
		}
	
	}
	
}
