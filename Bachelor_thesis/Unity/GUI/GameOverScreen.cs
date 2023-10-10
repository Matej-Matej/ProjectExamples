using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;

public class GameOverScreen : MonoBehaviour
{
    [SerializeField] private InputField inputField;
    [SerializeField] private Text warningText;
    [SerializeField] private Text titleText;
    [SerializeField] private Text scoreText;

    private GameState state;
    private string inputText = "Vložte meno pre uloženie skóre";
    private string standardChar = "Prosím, vložte iba alfanumerické znaky";
    private string winScreen = "Gratulujem k výhre";
    private string looseScreen = "Koniec hry";
    private string maxLettersText;
    private string normalChar = "qwertyuiopasdfghjklzxcvbnmQWERTYUIOPASDFGHJKLZXCVBNMéýúíóáŕĺťšďľžč123456789";
    private bool standardText = true;
    private string scoreName = "";

    void Start()
    {
        this.state = FindObjectsOfType<GameState>()[0];
        if (!this.state.isNewScore(this.state.Score))
        {

            inputField.gameObject.SetActive(false);
            warningText.gameObject.SetActive(false);
        }
        this.maxLettersText = "Maximálne " + inputField.characterLimit + " znakov!";
        warningText.text = inputText;
        if (this.state.Lifes <= 0)
        {
            titleText.text = looseScreen;    
        }
        else
        {
            titleText.text = winScreen;
        }

        scoreText.text = "Dosiahnuté skóre: " + this.state.Score;
    }

    public void backToMenu()
    {
        if (standardText && (scoreName !=null || scoreName != ""))
        {
            this.state.addHighScore(this.state.Score,scoreName);
            this.state.restartGame();
            Destroy(gameObject);
            SceneManager.LoadScene("MenuScreen");
        }
        if (!inputField.gameObject.active)
        {
            this.state.restartGame();
            Destroy(gameObject);
            SceneManager.LoadScene("MenuScreen");
        }
    }

    public void onValueChange()
    {
        bool found = false;
        var text = inputField.text.ToCharArray();
        if (text.Length == 0)
        {
            warningText.text = inputText;
        }
        if (text.Length != 0)
        {
            foreach (var newCharacter in text)
            {
                found = false;
                foreach (var character in normalChar)
                {
                    if (newCharacter == character)
                    {
                        standardText = true;
                        if (text.Length < inputField.characterLimit)
                        {
                            warningText.text = "";
                            scoreName = new string(text);
                        }
                        else
                        {
                            warningText.text = maxLettersText;
                        }
                        found = true;
                    }
                }
                if (!found)
                {
                    standardText = false;
                    warningText.text = standardChar;
                    break;
                }
            }
        }
    }
}
