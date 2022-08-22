//https://www.reddit.com/r/Unity3D/comments/4seo67/here_is_silly_little_npc_name_generator_i_wrote/
using UnityEngine;
using System.Collections;

public class NameGen : MonoBehaviour 
{
	//amount of names to be generated
	public int namesToGenerate = 10;
	
	//array of name particles. fill this with syllables
	public string[] nameParticles;
	//array that will be filled with generated names. no need to set the size or anything.
	public Name[] nameList;
	
	//structure for the names
	[System.Serializable]
	public struct Name
	{
		public string FirstName;
		public string LastName;
	}

	void Start()
	{
		//initialize the name list
		nameList = new Name[namesToGenerate];
		
		//loop through and generate all names
		for (int i = 0; i < namesToGenerate; i++)
		{
			nameList[i].FirstName = GetName();
			nameList[i].LastName = GetName();
		}
	}
	
	string GetName()
	{
		//set random name length
		int syllables = Random.Range(1, 5);
		string str = "";
		//loop through and generate all syllables
		for(int i = 0; i < syllables; i++)
		{
			str += nameParticles[Random.Range(0, nameParticles.Length)];
		}
		return str;
	}
}
