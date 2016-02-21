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

	[System.Serializable]
	public class vColor
	{
		public string vName;
		public string vValue;
	}
	
	[ContextMenu ("Read from file")]
	void ReadFromFile() 
	{
		file = new List<string>();
		
		StreamReader sw = File.OpenText("xkcdColors.txt");
		file = sw.ReadToEnd().Split("\n"[0]).ToList();
		sw.Close();
	}
	
	public void GenerateColor (int a) 
	{
		string[] t = file[a].Split("\t"[0]);
		color.vName = t[0];
		color.vValue = t[1];
	}
	public Color GetColor(string b)
	{
		Color a = ColorTranslator.FromHtml(b);
		return a;
	}
	class ColorTranslator
	{
		public static Color FromHtml(string hexString)
		{
			return new Color(Convert.ToInt32(hexString.Substring(1, 2), 16) / 255f,
			Convert.ToInt32(hexString.Substring(3, 2), 16) / 255f,
			Convert.ToInt32(hexString.Substring(5, 2), 16) / 255f);
		}
	}
}
