using UnityEngine;
using System.Collections;

public class cursorlocker : MonoBehaviour 
{


	public bool wasLocked = false;
	public bool paused = false;
	public float hSliderValue = 0.0F;
	
	public MouseLook m1;
	public MouseLook m2;
	public GUISkin s1;
	
	public Texture2D button;
	private Color dg;
	
	public Score scr;
	

	void Awake()
	{
	dg = new Color(0F,0.3F,0F,1F);
		Screen.lockCursor = true;
		hSliderValue = m1.sensitivityX;
		if(PlayerPrefs.GetFloat("sensitivity") > 0F)
		{
			hSliderValue = PlayerPrefs.GetFloat("sensitivity");
			m1.sensitivityX = hSliderValue;
			m1.sensitivityY = hSliderValue;
			m2.sensitivityX = hSliderValue;
			m2.sensitivityY = hSliderValue;
		}
	}
	
	void OnGUI()
	{
		if(paused)
		{
			GUI.skin = s1;
			GUI.Box(new Rect(0, 0, Screen.width, Screen.height), " ");
			GUI.Label(new Rect(25, 10, 200, 35), "Sensitivity: " + hSliderValue);
			hSliderValue = GUI.HorizontalSlider(new Rect(25, 35, 100, 30), hSliderValue, 0.0F, 20.0F);
			m1.sensitivityX = hSliderValue;
			m1.sensitivityY = hSliderValue;
			m2.sensitivityX = hSliderValue;
			m2.sensitivityY = hSliderValue;
			 
			GUI.Label(new Rect(10, Screen.height - 100, 100, 30), button);
			GUI.Label(new Rect(130, Screen.height - 100, 100, 30), button);
			GUI.Label(new Rect(250, Screen.height - 100, 100, 30), button);
			 GUI.contentColor = dg;
			
			if (GUI.Button(new Rect(15, Screen.height - 95, 100, 30), "Back", "label"))
			{
				Screen.lockCursor = !Screen.lockCursor;
				paused = !paused;
				m1.enabled = !m1.enabled;
			m2.enabled = !m2.enabled;
			}
			
			if (GUI.Button(new Rect(135, Screen.height - 95, 100, 30), "Save Options", "label"))
			{
				PlayerPrefs.SetFloat("sensitivity", hSliderValue);
			}
			if (GUI.Button(new Rect(255, Screen.height - 95, 100, 30), "Main Menu", "label"))
			{
				Application.LoadLevel(0);
			}
			GUI.contentColor = Color.white;  
		}
	}
	
	void Update() 
	{
		if (Input.GetMouseButtonDown(0) && !paused && !scr.vShowing)
		{
			Screen.lockCursor = true;
		}
		
		if (Input.GetKeyDown("escape")&& !scr.vShowing)
		{
			Screen.lockCursor = !Screen.lockCursor;
			paused = !paused;
			
			m1.enabled = !m1.enabled;
			m2.enabled = !m2.enabled;
		}
		
		if (!Screen.lockCursor && wasLocked) 
		{
			
			wasLocked = false;

		} 
		else if (Screen.lockCursor && !wasLocked) 
		{
	
			wasLocked = true;
		}
	}
}