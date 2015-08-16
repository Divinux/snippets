using UnityEngine;
using UnityEngine.UI;
using System.Collections;

//http://armedunity.com/topic/12330-csplash-screen-manager/
public class SplashManager : MonoBehaviour {


    [System.Serializable]
    public class Splash
    {
        public Texture splash;
        public float waitTime;
    }


    public RawImage splashScreen; //GUI Raw Image
    public string loadLevel; //Level to load when all splash screens has been shown, or skipped
    public float fadeTime = 1.0f; //Fade In/Out time
    public Splash[] splashScreens; //All splash screens


    private bool isSkipping = false; //Used to check if skipping
    private int currentSplash = -1; //Current splash index
    private Coroutine currentCoroutine; //Current running coroutine. Used for stopping the running one, really only used for skipping


    void Start()
    {
        currentCoroutine = StartCoroutine(LoadNext());
    }


    void Update()
    {
        if(Input.GetKeyDown(KeyCode.Space) || Input.GetKeyDown(KeyCode.Return)) //If Space or Return(Enter) is pressed, then skip
        {
            if (!isSkipping)
            {
                isSkipping = true;
                StopCoroutine(currentCoroutine); //Stopping the running coroutine|Reason: If you skip, the coroutine will still run and will cause problems. That's why i'm stopping the current one
                currentCoroutine = StartCoroutine(LoadNext()); //Starting a new coroutine and assigning currentCoroutine to it
            }
        }
    }


    IEnumerator LoadNext()
    {
        if ((currentSplash + 1) < splashScreens.Length) //If the next index is not out of range, then increment currentSplash by 1. Else, load level
        {
            currentSplash++;
        }
        else
        {
            Application.LoadLevelAsync(loadLevel);
        }


        if (isSkipping)
        {
            splashScreen.CrossFadeAlpha(0, fadeTime, false);
            yield return new WaitForSeconds(fadeTime);
            isSkipping = false;
        }


        splashScreen.texture = splashScreens[currentSplash].splash;
        splashScreen.CrossFadeAlpha(1, fadeTime, false);


        yield return new WaitForSeconds((splashScreens[currentSplash].waitTime + fadeTime));
        splashScreen.CrossFadeAlpha(0, fadeTime, false);
        yield return new WaitForSeconds(fadeTime);


        currentCoroutine = StartCoroutine(LoadNext());
    }
}