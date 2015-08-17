using UnityEngine;
using System.Collections;
//cheats can be entered at runtime
public class Cheat : MonoBehaviour 
{

	private string[] cheatCode;
	private int index;
	
	private string[] cheatCode2;
	private int index2;
	//script objects
	public GameObject vCam;
	public Notif vN;
	public Turret vT;

	void Awake() 
	{
		cheatCode = new string[] { "b", "o", "o", "p"};
		index = 0;   
		
		cheatCode2 = new string[] { "w", "o", "o", "p"};
		index2 = 0; 
	}

	void Update() 
	{
		// Check if any key is pressed
		if (Input.anyKeyDown) 
		{
			// Check if the next key in the code is pressed
			if (Input.GetKeyDown(cheatCode[index])) 
			{
				// Add 1 to index to check the next key in the code
				index++;
			}
			// Wrong key entered, we reset code typing
			else 
			{
				index = 0;    
			}
			
			// Check if the next key in the code is pressed
			if (Input.GetKeyDown(cheatCode2[index2])) 
			{
				// Add 1 to index to check the next key in the code
				index2++;
			}
			// Wrong key entered, we reset code typing
			else 
			{
				index2 = 0;    
			}
		}
		
		// If index reaches the length of the cheatCode string, 
		// the entire code was correctly entered
		if (index == cheatCode.Length) 
		{
			//do cheat stuff here
			index = 0;
		}
		if (index2 == cheatCode2.Length) 
		{
			//do cheat2 stuff here
			index2 = 0;
		}
	}
}
