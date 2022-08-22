using UnityEngine;
using System.Collections;

public class Experience : MonoBehaviour 
{

    //current level
    public int vLevel = 1;
    //current exp amount
    public int vCurrExp = 0;
    //exp amount needed for lvl 1
    public int vExpBase = 10;
    //exp amount left to next levelup
    public int vExpLeft = 10;
    //modifier that increases needed exp each level
    public float vExpMod = 1.15f;
    
    //vvvvvv USED FOR TESTING FEEL FREE TO DELETE
    void Update () 
    {
        if (Input.GetButtonDown("Jump"))
        {
            GainExp(1);
        }
    }
    //^^^^^^ USED FOR TESTING FEEL FREE TO DELETE
	
    //leveling methods
    public void GainExp(int e)
    {
        vCurrExp += e;
        if(vCurrExp >= vExpLeft)
        {
            LvlUp();
        }
    }
    void LvlUp()
    {
        vCurrExp -= vExpLeft;
        vLevel++;
        float t = Mathf.Pow(vExpMod, vLevel);
        vExpLeft = (int)Mathf.Floor(vExpBase * t);
    }
}
