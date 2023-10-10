using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AllCmdPanel : MonoBehaviour
{
    /*
     * Tato metoda sluzi na riadenie panelu so vsetkymi prikazmi ( ten panel dole v strede )
     */
    public bool useHorizontal = true;

    public RectTransform rt; // odkaz na rectTransform, aby sme vedeli menit velkost panelu podla poctu deti 
    public int widthPerChild = 125; // toto je sirka, aku ma mat panel pre jeden prikaz ( ikonky príkazov su aktualne 100x100 px)

    void Start()
    {
        if (rt == null)
        {
            rt = gameObject.GetComponent<RectTransform>();
        }
    }

    public int getChildrenCount()
    {
        int count = 0;

        foreach (Transform child in transform)
        {
            if (child.gameObject.activeSelf)
            {
                count++;
            }
        }

        return count;
    }

    void Update()
    {
        // zvacsuje/ zmensuje panel podla poctu prikazov, ktore sa v danom kole mozu pouzivat
        // MAX to zvladne nejak 15 objektov, potom to uz ide mimo obrazovky, ale predpokladam, ze to nebude problem ani do buducna
        if (useHorizontal)
        {
            rt.sizeDelta = new Vector2(getChildrenCount() * widthPerChild, rt.sizeDelta.y);
        }
        else
        {
            rt.sizeDelta = new Vector2(rt.sizeDelta.x, getChildrenCount() * widthPerChild);
        }
        
    }
}
