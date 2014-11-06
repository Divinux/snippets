import System;
import System.IO;

var  fileName = "MyFile.txt";

function Start()
{
	if (File.Exists(fileName)) 
	{
		Debug.Log(fileName+" already exists.");
		return;
	}

	var sr = File.CreateText(fileName);
	sr.WriteLine ("This is my file.");
	sr.WriteLine ("I can write ints {0} or floats {1}, and so on.", 1, 4.2);
	sr.Close();
}