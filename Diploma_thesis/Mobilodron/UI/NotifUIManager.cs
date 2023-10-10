using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NotifUIManager : MonoBehaviour
{
    // Start is called before the first frame update

    public bool isActiveAtStart = true;

    void Start()
    {
        gameObject.SetActive(isActiveAtStart);
    }

    public void toggleQuestUI()
    {
        gameObject.SetActive(!gameObject.activeSelf);
    }
}
