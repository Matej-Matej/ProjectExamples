using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ToggleManager : MonoBehaviour
{
    /*
     * Skript sa stará o zmenu obrázku toggle pri kliknutí. Ak by sa pridal skript obrázku, kde nie je toggle, vypise warning 
     */


    private Toggle toggle;
    private Image image;
    public Sprite offImage;
    public Sprite offImageHighlight;
    public Sprite onImage;
    public Sprite onImageHighlight;

    void Start()
    {
        toggle = gameObject.GetComponent<Toggle>();
        image = gameObject.GetComponent<Image>();
        if (toggle != null && image != null && offImage != null && onImage != null) // rovno tu skontrolujeme,  ci existuju aj obrazky
        {
            toggle.onValueChanged.AddListener(delegate
            {
                changedValue(toggle);
            });

            if (toggle.isOn)
            {
                changeSprite(onImage, onImageHighlight);
            }
            else
            {
                changeSprite(offImage, offImageHighlight);
            }
        }
        else
        {
            Debug.LogWarning("Objekt "+gameObject.name+" nema definovanu jednu z hodnot: toggle, image, sprite");
        }
    }

    void changeSprite(Sprite sprite, Sprite spriteHightlight)
    {
        SpriteState st = new SpriteState();
        st.highlightedSprite = spriteHightlight;
        image.sprite = sprite;
        toggle.spriteState = st;
    
    }

    void changedValue(Toggle change)
    {
        if (change.isOn)
        {
            changeSprite(onImage, onImageHighlight);
        }
        else
        {
            changeSprite(offImage, offImageHighlight);
        }
    }
}
