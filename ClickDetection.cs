using UnityEngine;
using UnityEngine.UI;
using UnityEngine.EventSystems;
 
//detects left/mid/right clicks on ui elements
public class ClickDetection : MonoBehaviour, IPointerClickHandler {
 
    public void OnPointerClick(PointerEventData eventData)
    {
        if (eventData.button == PointerEventData.InputButton.Left)
            Debug.Log("Left click");
        else if (eventData.button == PointerEventData.InputButton.Middle)
            Debug.Log("Middle click");
        else if (eventData.button == PointerEventData.InputButton.Right)
            Debug.Log("Right click");
    }
}