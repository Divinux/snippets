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
