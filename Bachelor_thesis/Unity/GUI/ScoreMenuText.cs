using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class ScoreMenuText : MonoBehaviour
{
    private Text text;


    // Start is called before the first frame update
    void Start()
    {
        this.text = GetComponent<Text>();
        this.text.text = FindObjectsOfType<GameState>()[0].transferToString();
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
