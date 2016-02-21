using UnityEngine;
using System.Collections;
//screenshake by changing position,
//rotation, and soft camera height
//requires vp_perlin
public class Shake : MonoBehaviour 
{
	// Transform of the camera to shake. 
	public Transform shakeTransform;
	// How long the object should shake for.
	public bool shake = false;
	
	//position shake
	public bool positionShake = true;
	// Amplitude of the shake. A larger value shakes the camera harder.
	public float shakeAmount = 0.7f;
	//how smooth the shake is. lower values are smoother
	public float smooth = 1f;
	
	//rotation shake
	public bool rotationShake = true;
	public float ShakeSpeed = 1.0f;
	public Vector3 ShakeAmplitude = new Vector3(10, 10, 0);
	protected Vector3 m_Shake = Vector3.zero;
	float m_Pitch = 0.0f;
	float m_Yaw = 0.0f;
	float m_Tilt = 0.0f;
	
	//bobbing stuff
	//automatically found by tag
	public GameObject cam;
	//damping speed
	public float speed = 1f;
	
	
	Vector3 originalPos;
	Vector3 targetPos;
	void Awake()
	{
		if (shakeTransform == null)
		{
			shakeTransform = this.transform;
		}
		cam = GameObject.FindWithTag("MainCamera");
	}
	
	void OnEnable()
	{
		originalPos = shakeTransform.localPosition;
		//originalRot = shakeTransform.localRotation;
	}

	void Update()
	{
		//shaking
		if (shake)
		{
			if(positionShake)
			{
				PosShake();
			}
			if(rotationShake)
			{
				RotShake();
			}
		}
		else
		{
			targetPos = originalPos;
			//shakeTransform.localRotation = originalRot;
		}
		shakeTransform.localPosition = Vector3.Lerp(shakeTransform.localPosition, targetPos, Time.deltaTime);
		
		//bobbing
		float a =  Mathf.Lerp(cam.transform.position.y, transform.position.y, speed);
		cam.transform.position = new Vector3(transform.position.x,a,transform.position.z);
		cam.transform.rotation = transform.rotation;
	}
	void RotShake()
	{

		// apply camera shakes
		if (ShakeSpeed != 0.0f)
		{
			m_Yaw = transform.localEulerAngles.y - m_Shake.y;			// subtract shake from last frame or camera will drift
			m_Pitch = transform.localEulerAngles.x - m_Shake.x;
			m_Tilt = transform.localEulerAngles.z - m_Shake.z;
			m_Shake = Vector3.Scale(vp_SmoothRandom.GetVector3Centered(ShakeSpeed), ShakeAmplitude);
			m_Yaw += m_Shake.y;			// apply new shake
			m_Pitch += m_Shake.x;
			m_Tilt += m_Shake.z;
			transform.localEulerAngles = new Vector3(m_Pitch,m_Yaw,m_Tilt);
			//m_RotationSpring.AddForce(Vector3.forward * m_Shake.z * Time.timeScale);
		}
		
	}
	void PosShake()
	{
		targetPos = originalPos + Random.insideUnitSphere * shakeAmount;
	}
}
