using UnityEngine;
using System;
using System.Collections;

public class CardManager : MonoBehaviour 
{
	//deck array
	public Card[] vDeck;
	//hands arrays
	public int[] vHandP1;
	public int[] vHandP2;
	//trump var
	public int vTrump = 0;
	//cards left 
	public int vLeft;
	
	//variables for deck init
	private int vColor = 1;
	private int vSize = 1;
	
	//variables for hand init
	private int vHandInt = 0;
	
	
	
	[System.Serializable]
	public class Card
	{
		//1blue2yellow3green4red
		public int color;
		//1-13
		public int size;
		//0deck1playerone2playertwo3table4grave
		public int location;
	}
	

	void Awake () 
	{
		
		fFillDeck();
		fShuffle(ref vDeck);
		vLeft = vDeck.Length;
		//fill hands
		fFillhand(ref vHandP1, 1);
		fFillhand(ref vHandP2, 2);
		fNewTrump();
		
	}
	
	//fills the entire deck with cards
	public void fFillDeck()
	{
		vColor = 1;
		vSize = 1;
		foreach(Card a in vDeck)
		{
			a.color = vColor;
			a.size = vSize;
			vSize++;
			if(vSize == 14)
			{
				vColor++;
				vSize = 1;
			}
		}
	}
	//fills the hand of player n
	public void fFillhand(ref int[] n, int p)
	{
		vHandInt = 0;
		Array.Resize(ref n, 0);
		fFillRec(ref n, p);
	}
	//recursive fill
	public void fFillRec(ref int[] m, int pp)
	{
		//generate random number
		int r = UnityEngine.Random.Range(0,vDeck.Length);
		
		
		//if card is still in the deck
		if(vDeck[r].location == 0)
		{
			//resize handarray
			Array.Resize(ref m, m.Length+1);
			//Debug.Log(m.Length);
			//add card index r to hand
			m[vHandInt] = r;
			
			//set location in deck array
			vDeck[r].location = pp;
			//increase counter
			vHandInt++;
			//decrease cards left
			vLeft--;
		}
		
		if(vHandInt < 6)
		{
			fFillRec(ref m, pp);
		}
	}
	//shuffles the deck
	public void fShuffle(ref Card[] input)
	{
		for (int t = 0; t < input.Length; t++ )
		{
			Card tmp = input[t];
			int rnd = UnityEngine.Random.Range(t, input.Length);
			input[t] = input[rnd];
			input[rnd] = tmp;
		}
	}
	//assigns a trump color
	public void fNewTrump()
	{
		vTrump = UnityEngine.Random.Range(1,5);
	}
}
