var aiCharacters : AICharacter[];
var characterNames:CharacterNames;
var propertyManager:Properties;

class AICharacter
{
	var name:String;
	var gender:Gender;
	var health:float;
	var hunger:float;
	var energy:float;
	var mood:Mood;
	var workObject:GameObject;
	var homeObject:GameObject;
	var characterObject:GameObject;
	var currentStatus:AvailabilityStatus;
	var money:float;
}
class CharacterNames
{
firstNamesMale:String[];
firstNamesFemale:String[];
lastNames:String[];
}

enum Gender
{
	Female=0,
	Male=1
}
enum Mood
{
	Happy=0,
	Angry=1,
	Annoyed=2,
	Scared=3
}
enum AvailabilityStatus
{
	Available=0,
	Busy=1
}


//ojiisan gay variables i won't touch
var vPref : GameObject; //le comments le XD
var vInstPos : GameObject;

@HideInInspector
var nameList:NameList;

function fBirth (index:int)
{
	aiCharacters[index].health = 100;
	aiCharacters[index].hunger = 100;
	aiCharacters[index].energy = 100;
	aiCharacters[index].money = 10000;
	aiCharacters[index].gender = Random.Range(0,2);

	SetCharacterName(index);
	SetCharacterHome(index);
	if(aiCharacters[index].homeObject.GetComponent(Prop).vEntry != null)
	aiCharacters[index].characterObject.GetComponent(AI).fMoveOrder(aiCharacters[index].homeObject.GetComponent(Prop).vEntry);
}

function SetCharacterName(index:int)
{
	aiCharacters[index].name="";
	if(vGender == 0)
	aiCharacters[index].name+=characterNames.firstNamesMale[Random.Range(0,characterNames.firstNamesMale.length)];
	else
	aiCharacters[index].name+=characterNames.firstNamesFemale[Random.Range(0,characterNames.firstNamesFemale.length)];
	aiCharacters[index].name+=" "+characterNames.lastNames[Random.Range(0,characterNames.lastNames.length)];
} 

function SetCharacterHome(index:int)
{
	if(aiCharacters[index].homeObject==null)
	{
		for(var home in propertyManager.properties)
		{
			if(home.owner==-2&&home.workplace==false)
			{
				if(aiCharacters[index].money>=home.value)
				{
					home.owner=index;
					aiCharacters[index].homeObject=home.propertyObject;
					aiCharacters[index].money-=home.value;
					return;
				}
			}
		}
		aiCharacters[index].homeObject = propertyManager.vHomeless;
	}
}

function Start ()
{
	nameList=GetComponent(NameList);
	propertyManager=GetComponent(Properties);
	//check if current index is empty and fill it with a prefab
	for(var a:int;a<aiCharacters.length;a++)
	{
		if(aiCharacters[a].characterObject==null)
		{
			aiCharacters[a].characterObject=Instantiate(vPref,vInstPos.transform.position,vPref.transform.rotation);
			aiCharacters[a].characterObject.GetComponent(AI).aiManager=this;
			aiCharacters[a].characterObject.GetComponent(AI).poolIndex=a;
			fBirth(a);
		}
	}
}

