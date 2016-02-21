//arcade car

using UnityEngine;
using System.Collections;

public class Car : MonoBehaviour {


public WheelCollider Wheel_FL;
public WheelCollider Wheel_FR;
public WheelCollider Wheel_RL;
public WheelCollider Wheel_RR;
public float[] GearRatio = {1.31f,1.71f,1.88f,2.41f,1.13f,0.93f};
public int CurrentGear = 0;
public float EngineTorque = 16600.0f;
public float MaxEngineRPM = 8500.0f;
public float MinEngineRPM = 8000.0f;
public float SteerAngle = 20f;
public Transform COM;
public float Speed;
public float maxSpeed = 150;
public AudioSource skidAudio;
private float EngineRPM = 0.0f;
private float motorInput;
private Rigidbody CarRigidbody;
private AudioSource AudioCar;
public bool  Controllable = false;

//WheelHit GroundHitRR;
//WheelHit GroundHitRL;
//float diferential1;
//float diferential2;

//Text texto1;
//Text texto2;


public float maxReverseSpeed = -30;
WheelHit CorrespondingGroundHit;

void  Awake (){
	CarRigidbody = GetComponent<Rigidbody>();
	AudioCar = GetComponent<AudioSource>();
}

void  Start (){

	CarRigidbody.centerOfMass = new Vector3(COM.localPosition.x * transform.localScale.x, COM.localPosition.y * transform.localScale.y, COM.localPosition.z * transform.localScale.z);
	
}

void  Control (){
	EngineRPM = (Wheel_FL.rpm + Wheel_FR.rpm)/2 * GearRatio[CurrentGear];
	
	ShiftGears();
	
	//Input For MotorInput.
	motorInput = Input.GetAxis("Vertical");
	
	//Audio
	AudioCar.pitch = Mathf.Abs(EngineRPM / MaxEngineRPM) + 1.0f;
	if (AudioCar.pitch > 2.0f) {
		AudioCar.pitch = 2.0f;
	}
	SteerAngle = Mathf.Lerp(33,6,Speed/(maxSpeed-20));
	//Steering

	

	Wheel_FL.steerAngle = SteerAngle * Input.GetAxis("Horizontal");
	Wheel_FR.steerAngle = SteerAngle * Input.GetAxis("Horizontal");
	
	/*
	///////////////
	Wheel_RR.GetGroundHit(GroundHitRR);
	Wheel_RL.GetGroundHit(GroundHitRL);
	diferential1 = (Mathf.Abs(GroundHitRL.sidewaysSlip) - Mathf.Abs(GroundHitRR.sidewaysSlip))*5+1;
	diferential2 = (Mathf.Abs(GroundHitRR.sidewaysSlip) - Mathf.Abs(GroundHitRL.sidewaysSlip))*5+1;
	
	

	texto1.text = ""+diferential1;
	texto2.text = ""+diferential2;
	/////////qq*/
	
	
	
	//HandBrake
	
	if(Input.GetButton("Jump")){
		Wheel_RL.motorTorque = 0;
		Wheel_RR.motorTorque = 0;
		Wheel_RL.brakeTorque = 5500;
		Wheel_RR.brakeTorque = 5500;
		Wheel_FL.brakeTorque = 100;
		Wheel_FR.brakeTorque = 100;
		//Debug.Log("Hand Brake");
	}else{
		//Speed Limiter.
		if (motorInput < 0 && Speed > 0.4f || motorInput > 0 && Speed <-1.2f){
			Wheel_RL.motorTorque = 0;
			Wheel_RR.motorTorque = 0;
			Wheel_RL.brakeTorque = 80 * motorInput*0.75f;
			Wheel_RR.brakeTorque = 80 * motorInput*0.75f;
			Wheel_FL.brakeTorque = 120 * motorInput;
			Wheel_FR.brakeTorque = 120 * motorInput;
			
			// Debug.Log("brake");
		}else{
			Wheel_RL.brakeTorque = 0;
			Wheel_RR.brakeTorque = 0;
			Wheel_FL.brakeTorque = 0;
			Wheel_FR.brakeTorque = 0;
		}
		if (motorInput > 0 && Speed >= -1.2f)
		{
			Wheel_RL.motorTorque =EngineTorque / GearRatio[CurrentGear] *1 *motorInput;
			Wheel_RR.motorTorque = EngineTorque / GearRatio[CurrentGear] *1*  motorInput;
			
			//Debug.Log("no brake");
		}else if(motorInput < 0 && Speed <= 0.4f){
			Wheel_RL.motorTorque =3000*motorInput;
			Wheel_RR.motorTorque = 3000*  motorInput;
			// Debug.Log("reverse");
		}
		if(Speed > maxSpeed || Speed < maxReverseSpeed){
			Wheel_RL.motorTorque = 0;
			Wheel_RR.motorTorque = 0;
		}
	}
}
void  Update (){
	//Speed = GetComponent.<Rigidbody>().velocity.magnitude * 3.6ff;
	//GetComponent.<Rigidbody>().drag = GetComponent.<Rigidbody>().velocity.magnitude / 100;
	
	if(Controllable)
	{
		Control();
	}
	else
	{
		Wheel_RL.motorTorque = 0;
		Wheel_RR.motorTorque = 0;
		Wheel_RL.brakeTorque = 5500;
		Wheel_RR.brakeTorque = 5500;
		Wheel_FL.brakeTorque = 100;
		Wheel_FR.brakeTorque = 100;
	}

	
	
	
	
}

void  LateUpdate (){
	Speed = transform.InverseTransformDirection(CarRigidbody.velocity).z * 3.6f;
	CarRigidbody.drag = Speed/ 360;
}

void  ShiftGears (){
	int AppropriateGear = CurrentGear;
	if (EngineRPM >= MaxEngineRPM) {
		
		AppropriateGear = CurrentGear;
		for (int i= 0; i < GearRatio.Length; i ++) {
			if(Wheel_FL.rpm * GearRatio[i] < MaxEngineRPM) {
				AppropriateGear = i;
				break;
			}
		}
		CurrentGear = AppropriateGear;
	}
	
	if(EngineRPM <= MinEngineRPM) {
		AppropriateGear = CurrentGear;
		for ( int j= GearRatio.Length-1; j >= 0; j -- ) {
			if ( Wheel_FL.rpm * GearRatio[j] > MinEngineRPM ) {
				AppropriateGear = j;
				break;
			}
		}
		CurrentGear = AppropriateGear;
	}
}

}