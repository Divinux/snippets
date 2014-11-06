import System.IO;

function ReadFile(file : String)
{
	if(File.Exists(file))
	{
		var sr = File.OpenText(file);
		var line = sr.ReadLine();
		while(line != null)
		{
			Debug.Log(line); // prints each line of the file
			line = sr.ReadLine();
		}   
	} 
	else 
	{
		Debug.Log("Could not Open the file: " + file + " for reading.");
		return;
	}
}