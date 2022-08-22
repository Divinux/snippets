using UnityEngine;
using System.Collections;
using System.Collections.Generic; 
using System.Linq;
using System.IO;
using System;
public class xkcdColorReader : MonoBehaviour 
{
	public List<string> file;
	public vColor color;

	//vvvvvv USED FOR TESTING FEEL FREE TO DELETE
	void Start()
	{
		ReadFromFile();
	}
	void Update()
	{
		if (Input.GetButtonDown("Jump"))
		{
			GenerateColor(UnityEngine.Random.Range(0, file.Count));
		}
	}
	//^^^^^^ USED FOR TESTING FEEL FREE TO DELETE
	
	//color class, contains name string, hex color string, and unity color object
	[System.Serializable]
	public class vColor
	{
		public string sName;
		public string sValue;
		public Color cColor;
	}
	//loads the text file into a list that you can keep on a component. 
	//hence the contextmenu attribute, just do it once and delete the .txt file.
	//or keep it automatic. I'm not your boss.
	[ContextMenu ("Read from file")]
	void ReadFromFile() 
	{
		file = new List<string>();
		
		StreamReader sw = File.OpenText("xkcdColors.txt");
		file = sw.ReadToEnd().Split("\n"[0]).ToList();
		sw.Close();
	}
	//generates a vColor object for a given index
	public void GenerateColor (int a) 
	{
		string[] t = file[a].Split("\t"[0]);
		color.sName = t[0];
		color.sValue = t[1];
		color.cColor = GetColor(t[1]);
	}
	//gets color from a hex string. written by HarvesteR
	//http://wiki.unity3d.com/index.php/XKCDColors
	public Color GetColor(string b)
	{
		Color a = FromHtml(b);
		return a;
	}
	
	public Color FromHtml(string hexString)
	{
		return new Color(Convert.ToInt32(hexString.Substring(1, 2), 16) / 255f,
		Convert.ToInt32(hexString.Substring(3, 2), 16) / 255f,
		Convert.ToInt32(hexString.Substring(5, 2), 16) / 255f);
	}
	
}
