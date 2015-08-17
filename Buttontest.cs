using UnityEngine;
using System.Collections;
using UnityEngine.UI;
using UnityEngine.EventSystems;
//generates new UI buttons programmatically
public class Buttontest : MonoBehaviour 
{
	//instantiates a button and gives it a function
	public GameObject vButtonPrefab;
	public GameObject vCanvas;
	// Use this for initialization
	void Start () 
	{
		GameObject a = Instantiate(vButtonPrefab) as GameObject;
		a.transform.SetParent(vCanvas.transform,false);
		Button b = a.GetComponent<Button>();
		b.onClick.AddListener (() => handleButton(1));
		
		a = Instantiate(vButtonPrefab) as GameObject;
		a.transform.SetParent(vCanvas.transform,false);
		b = a.GetComponent<Button>();
		b.onClick.AddListener (() => handleButton(2));
	}
	
	void handleButton(int i)
	{
		Debug.Log("So far so good" + i);
	}
	
	void ChangeText(GameObject go)
	{
		Button b = go.GetComponent<Button>();
		b.onClick.AddListener(()=>
		{
			go.GetComponentInChildren<Text>().text = "Text";
		});
	}
	
	
}
