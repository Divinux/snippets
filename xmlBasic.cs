using UnityEngine;
using System.Collections;
using System.Xml;
public class lt : MonoBehaviour {

	void Start () 
	{
		
	}
	
	public void LoadReader()
	{
		XmlReader xmlReader = XmlReader.Create("http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml");
		while(xmlReader.Read())
		{
			if((xmlReader.NodeType == XmlNodeType.Element) && (xmlReader.Name == "Cube"))
			{
				if(xmlReader.HasAttributes)
				Debug.Log(xmlReader.GetAttribute("currency") + ": " + xmlReader.GetAttribute("rate"));                    
			}
		}
	}
	public void WriteWriter()
	{
		XmlWriter xmlWriter = XmlWriter.Create("test.xml");

		xmlWriter.WriteStartDocument();
		xmlWriter.WriteStartElement("users");

		xmlWriter.WriteStartElement("user");
		xmlWriter.WriteAttributeString("age", "452");
		xmlWriter.WriteString("John Doe");
		xmlWriter.WriteEndElement();

		xmlWriter.WriteStartElement("user");
		xmlWriter.WriteAttributeString("age", "39");
		xmlWriter.WriteString("Jane Doe");

		xmlWriter.WriteEndDocument();
		xmlWriter.Close();
	}
	public void LoadDocument()
	{
		XmlDocument xmlDoc = new XmlDocument();
		xmlDoc.Load("http://www.ecb.int/stats/eurofxref/eurofxref-daily.xml");
		foreach(XmlNode xmlNode in xmlDoc.DocumentElement.ChildNodes[2].ChildNodes[0].ChildNodes)
		Debug.Log(xmlNode.Attributes["currency"].Value + ": " + xmlNode.Attributes["rate"].Value);
	}
	public void WriteDocument()
	{
		XmlDocument xmlDoc = new XmlDocument();
		XmlNode rootNode = xmlDoc.CreateElement("users");
		xmlDoc.AppendChild(rootNode);

		XmlNode userNode = xmlDoc.CreateElement("user");
		XmlAttribute attribute = xmlDoc.CreateAttribute("age");
		attribute.Value = "45";
		userNode.Attributes.Append(attribute);
		userNode.InnerText = "John5 Doe";
		rootNode.AppendChild(userNode);

		userNode = xmlDoc.CreateElement("user");
		attribute = xmlDoc.CreateAttribute("age");
		attribute.Value = "395";
		userNode.Attributes.Append(attribute);
		userNode.InnerText = "Jane5 Doe";
		rootNode.AppendChild(userNode);

		xmlDoc.Save("test-doc.xml");
	}
}
using UnityEngine;
using System.Collections;
using System.Collections.Generic;
using System.Xml;
using UnityEngine.UI;
public class xmlBasic : MonoBehaviour 
{
	public Options Op;
	public Slider SliderSens;
	public CursorLocker cl;
	public Player pl;
	public PlayerStats ps;
	public AudioSource asrc;
	void Awake()
	{
		LoadOptions();
		if(pl != null){
		LoadPlayer();
	}
	}
	//not used
	[ContextMenu ("read")]
	public void LoadDocument()
	{
		XmlDocument xmlDoc = new XmlDocument();
		xmlDoc.Load("Player.xml");
		XmlNode rootNode = xmlDoc.FirstChild;
		Debug.Log(rootNode["money"].InnerText);
	}
	//not used
	[ContextMenu ("write")]
	public void WriteDocument()
	{
		//open new document
		XmlDocument xmlDoc = new XmlDocument();
		//create root node
		XmlNode rootNode = xmlDoc.CreateElement("playersave");
		xmlDoc.AppendChild(rootNode);
		//player stats
		//create playernode
		XmlNode userNode = xmlDoc.CreateElement("playerstats");
		//attahc to root
		rootNode.AppendChild(userNode);
		//reference to playerstats node
		XmlNode refNode = userNode;
		//create health node
		userNode = xmlDoc.CreateElement("health");
		userNode.InnerText = "" + ps.health;
		refNode.AppendChild(userNode);
		
		//inventory
		userNode = xmlDoc.CreateElement("inventory");
		rootNode.AppendChild(userNode);
		refNode = userNode;
		
		userNode = xmlDoc.CreateElement("slot1");
		userNode.InnerText = "1";
		refNode.AppendChild(userNode);
		xmlDoc.Save("Player.xml");
	}
	//used
	public void SaveOptions()
	{
		//open new document
		XmlDocument xmlDoc = new XmlDocument();
		//create root node
		XmlNode rootNode = xmlDoc.CreateElement("options");
		xmlDoc.AppendChild(rootNode);
		
		XmlNode userNode = xmlDoc.CreateElement("sensitivity");
		userNode.InnerText = "" + Op.Sensitivity;
		rootNode.AppendChild(userNode);
		
		if(cl != null){
			cl.m1.sensitivityX = Op.Sensitivity;
			cl.m1.sensitivityY = Op.Sensitivity;
			cl.m2.sensitivityX = Op.Sensitivity;
			cl.m2.sensitivityY = Op.Sensitivity;}
		
		userNode = xmlDoc.CreateElement("musicvolume");
		userNode.InnerText = "" + Op.MusicVol;
		rootNode.AppendChild(userNode);
		
		if(asrc != null)
		{
			asrc.volume = Op.MusicVol;
		}
		
		userNode = xmlDoc.CreateElement("soundvolume");
		userNode.InnerText = "" + Op.SoundVol;
		rootNode.AppendChild(userNode);
		
		AudioListener.volume = Op.SoundVol;
		
		xmlDoc.Save("Options.xml");
	}
	//used
	[ContextMenu ("LoadOptions")]
	public void LoadOptions()
	{
		XmlDocument xmlDoc = new XmlDocument();
		xmlDoc.Load("Options.xml");
		XmlNode rootNode = xmlDoc.FirstChild;
		Op.Sensitivity = float.Parse(rootNode["sensitivity"].InnerText);
		SliderSens.value = Op.Sensitivity;
		if(cl != null){
			cl.m1.sensitivityX = Op.Sensitivity;
			cl.m1.sensitivityY = Op.Sensitivity;
			cl.m2.sensitivityX = Op.Sensitivity;
			cl.m2.sensitivityY = Op.Sensitivity;}
		
		Op.MusicVol = float.Parse(rootNode["musicvolume"].InnerText);
		Op.mVol.value = Op.MusicVol;
		if(asrc != null)
		{
			asrc.volume = Op.MusicVol;
		}
		else
		{
			GameObject mp = GameObject.FindWithTag("MusicPlayer");
			if(mp != null){
			asrc = mp.GetComponent<AudioSource>();
			
			asrc.volume = Op.MusicVol;
		}
		}
		
		Op.SoundVol = float.Parse(rootNode["soundvolume"].InnerText);
		Op.sVol.value = Op.SoundVol;
		AudioListener.volume = Op.SoundVol;
		//Debug.Log("sound " + Op.SoundVol);
		//Debug.Log("al vol " + AudioListener.volume);
		
	}
	//used
	[ContextMenu ("saveplayer")]
	public void SavePlayer()
	{
		XmlDocument xmlDoc = new XmlDocument();
		//create root node
		XmlNode rootNode = xmlDoc.CreateElement("Player");
		xmlDoc.AppendChild(rootNode);
		//position
		XmlNode userNode = xmlDoc.CreateElement("x");
		userNode.InnerText = "" + pl.transform.position.x;
		rootNode.AppendChild(userNode);
		userNode = xmlDoc.CreateElement("y");
		userNode.InnerText = "" + pl.transform.position.y;
		rootNode.AppendChild(userNode);
		userNode = xmlDoc.CreateElement("z");
		userNode.InnerText = "" + pl.transform.position.z;
		rootNode.AppendChild(userNode);
		//stats
		userNode = xmlDoc.CreateElement("money");
		userNode.InnerText = "" + ps.money;
		rootNode.AppendChild(userNode);
		
		userNode = xmlDoc.CreateElement("health");
		userNode.InnerText = "" + ps.health;
		rootNode.AppendChild(userNode);
		
		userNode = xmlDoc.CreateElement("maxhealth");
		userNode.InnerText = "" + ps.maxhealth;
		rootNode.AppendChild(userNode);
		//levelstuff
		userNode = xmlDoc.CreateElement("level");
		userNode.InnerText = "" + ps.vLevel;
		rootNode.AppendChild(userNode);
		userNode = xmlDoc.CreateElement("exp");
		userNode.InnerText = "" + ps.vCurrExp;
		rootNode.AppendChild(userNode);
		userNode = xmlDoc.CreateElement("expleft");
		userNode.InnerText = "" + ps.vExpLeft;
		rootNode.AppendChild(userNode);
		
		//inventory
		userNode = xmlDoc.CreateElement("inventory");
		rootNode.AppendChild(userNode);
		//reference to inventory node
		XmlNode refNode = userNode;
		if(pl.inventory.Count >= 1)
		{
			for(int i = 0; i <= pl.inventory.Count-1; i++)
			{
				//slot node
				userNode = xmlDoc.CreateElement("slot" + i);
				refNode.AppendChild(userNode);
				//reference to slot node
				XmlNode slotNode = userNode;
				//id node
				userNode = xmlDoc.CreateElement("id");
				userNode.InnerText = "" + pl.inventory[i].ID;
				slotNode.AppendChild(userNode);
				//amount node
				XmlNode amountNode = xmlDoc.CreateElement("amount");
				amountNode.InnerText = "" + pl.inventory[i].amount;
				slotNode.AppendChild(amountNode);
				//refNode.AppendChild(userNode);
			}
		}
		
		xmlDoc.Save("Player.xml");
	}
	//used
	[ContextMenu ("loadplayer")]
	public void LoadPlayer()
	{
		XmlDocument xmlDoc = new XmlDocument();
		xmlDoc.Load("Player.xml");
		XmlNode rootNode = xmlDoc.FirstChild;
		//position
		Vector3 p = new Vector3(float.Parse(rootNode["x"].InnerText),float.Parse(rootNode["y"].InnerText),float.Parse(rootNode["z"].InnerText));
		pl.transform.position = p;
		//stats
		ps.money = int.Parse(rootNode["money"].InnerText);
		ps.health = int.Parse(rootNode["health"].InnerText);
		ps.maxhealth = int.Parse(rootNode["maxhealth"].InnerText);
		//levelstuff
		ps.vLevel = int.Parse(rootNode["level"].InnerText);
		ps.vCurrExp = int.Parse(rootNode["exp"].InnerText);
		ps.vExpLeft = int.Parse(rootNode["expleft"].InnerText);
		//inventory
		XmlNode invnode = rootNode["inventory"];
		if (invnode.HasChildNodes)
		{
			//all inv nodes
			XmlNodeList xItems = invnode.ChildNodes;
			pl.inventory.Clear();
			for (int i=0; i<xItems.Count; i++)
			{
				
				XmlNode idnode = xItems[i];
				pl.AddItem(int.Parse(idnode["id"].InnerText));
				pl.inventory[i].amount = int.Parse(idnode["amount"].InnerText);
			}
		}
	}
}

