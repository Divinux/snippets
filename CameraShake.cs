using UnityEngine;
using System.Collections;
//http://armedunity.com/topic/5205-camera-shake-c/
public class CameraShake : MonoBehaviour {
	public float duration = 0.5f;
	public float speed = 1.0f;
	public float magnitude = 0.1f;

	void Update() {
                //Press F on the keyboard to simulate the effect
		if(Input.GetKeyDown(KeyCode.F)) {
			PlayShake();
		}
	}
        
        //This function is used outside (or inside) the script
        public void PlayShake() {
                StopAllCoroutines();
	        StartCoroutine("Shake");
        }
	
	private IEnumerator Shake() {
		float elapsed = 0.0f;
		
		Vector3 originalCamPos = transform.position;
		float randomStart = Random.Range(-1000.0f, 1000.0f);
		
		while (elapsed < duration) {
			elapsed += Time.deltaTime;			
			
			float percentComplete = elapsed / duration;			
			
			float damper = 1.0f - Mathf.Clamp(1.5f * percentComplete - 1.0f, 0.0f, 1.0f);
			float alpha = randomStart + speed * percentComplete;
			
			float x = Mathf.PerlinNoise(alpha, 0.0f) * 2.0f - 1.0f;
			float y = Mathf.PerlinNoise(0.0f, alpha) * 2.0f - 1.0f;
			
			x *= magnitude * damper;
			y *= magnitude * damper;
			
			transform.position = new Vector3(x, y, originalCamPos.z);
				
			yield return 0;
		}
		
		transform.position = Vector3.Lerp(transform.position, originalCamPos, Time.deltaTime * 5f);
	}
}