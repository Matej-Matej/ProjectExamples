using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class GameStateWinHandler : MonoBehaviour
{

    public Text winText = null;
    public Text score = null;

    public void changeWinText(string newText)
    {
        winText.text = newText;
    }

    public void changeScore(string newScore)
    {
        score.text = "Skóre: " + newScore;
    }

}
