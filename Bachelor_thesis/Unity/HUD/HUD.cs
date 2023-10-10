using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using UnityEngine.SceneManagement;


public class HUD : MonoBehaviour
{
    private LevelState levelState;
    private GameState state;
    private GameObject child;
    private Animator animator;
    private Sprite fullHeart, emptyHeart, gemBlue, gemGreen, gemRed, gemBlueEmpty, gemGreenEmpty, gemRedEmpty;
    private Text levelNameText;
    private float levelNameTimer = 3f;
    [SerializeField] GameObject pauseMenu;
    private AudioSource audioSource;

    private bool pauseOpened = false;
    // Start is called before the first frame update
    void Start()
    {
        this.levelNameText = GameObject.Find("levelNameText").GetComponent<Text>();
        this.animator = GameObject.Find("worldCompleteHUD").GetComponent<Animator>();
        this.levelState = GameObject.Find("LevelState").GetComponent<LevelState>();
        this.audioSource = GetComponent<AudioSource>();
        this.state = FindObjectsOfType<GameState>()[0];
        this.fullHeart = Resources.Load<Sprite>("hudHeart_full");
        this.emptyHeart = Resources.Load<Sprite>("hudHeart_empty");
        this.gemBlue = Resources.Load<Sprite>("hudJewel_blue");
        this.gemGreen = Resources.Load<Sprite>("hudJewel_green");
        this.gemRed = Resources.Load<Sprite>("hudJewel_red");
        this.gemBlueEmpty = Resources.Load<Sprite>("hudJewel_blue_empty");
        this.gemGreenEmpty = Resources.Load<Sprite>("hudJewel_green_empty");
        this.gemRedEmpty = Resources.Load<Sprite>("hudJewel_red_empty");

        this.transform.Find("gems/redGem").gameObject.GetComponent<Image>().sprite = gemRedEmpty;
        this.transform.Find("gems/blueGem").gameObject.GetComponent<Image>().sprite = gemBlueEmpty;
        this.transform.Find("gems/greenGem").gameObject.GetComponent<Image>().sprite = gemGreenEmpty;
        this.update();
        this.state.IsUpdated = true;
        this.levelNameText.text = SceneManager.GetActiveScene().name;
    }

    // Update is called once per frame
    void Update()
    {

        if (levelNameTimer >= 0)
        {
            levelNameTimer -= Time.deltaTime;
        }
        else this.levelNameText.text = "";

        if (state.IsUpdated)
        {
            state.IsUpdated = false;

            if (this.state.MusicEffect)
            {
                if (!audioSource.isPlaying)
                    audioSource.Play();
            }
            else
            {
                audioSource.Stop();
            }

            this.update();
            if (state.BossLevel)
            {
                this.transform.Find("gems/redGem").gameObject.SetActive(false);
                this.transform.Find("gems/blueGem").gameObject.SetActive(false);
                this.transform.Find("gems/greenGem").gameObject.SetActive(false);
            }
            else
            {
                this.transform.Find("gems/redGem").gameObject.SetActive(true);
                this.transform.Find("gems/blueGem").gameObject.SetActive(true);
                this.transform.Find("gems/greenGem").gameObject.SetActive(true);
            }
        }
        if (Input.GetButtonDown("ui_pause"))
        {
            pauseMenu.SetActive(!pauseMenu.activeSelf);
         }
    }

    private void update()
    {
        this.setLives();
        this.setGem();
        this.setStar();
        this.setScore();

    }

    private void setLives()
    {
        this.transform.Find("heart_1").gameObject.GetComponent<Image>().sprite = emptyHeart;
        this.transform.Find("heart_2").gameObject.GetComponent<Image>().sprite = emptyHeart;
        this.transform.Find("heart_3").gameObject.GetComponent<Image>().sprite = emptyHeart;
        int lifes = state.Lifes;
        if (lifes > 0)
        {
            this.transform.Find("heart_1").gameObject.GetComponent<Image>().sprite = fullHeart;
        }
        if (lifes > 1)
        {
            this.transform.Find("heart_2").gameObject.GetComponent<Image>().sprite = fullHeart;
        }
        if (lifes > 2)
        {
            this.transform.Find("heart_3").gameObject.GetComponent<Image>().sprite = fullHeart;
        }

    }

    private void setGem()
    {
        if (levelState.BlueGem)
        {
            this.transform.Find("gems/blueGem").gameObject.GetComponent<Image>().sprite = gemBlue;
        }
        if (levelState.RedGem)
        {
            this.transform.Find("gems/redGem").gameObject.GetComponent<Image>().sprite = gemRed;
        }
        if (levelState.GreenGem)
        {
            this.transform.Find("gems/greenGem").gameObject.GetComponent<Image>().sprite = gemGreen;
        }
    }

    private void setStar()
    {
        if (levelState.Star)
        {
            this.animator.SetBool("haveStar", true);
        }
    }

    private void setScore()
    {
        this.transform.Find("score").gameObject.GetComponent<Text>().text = state.Score.ToString();
    }

    public void writeToPlayer(string text)
    {
        this.transform.Find("informativeText").gameObject.GetComponent<Text>().text = text;
    }
}
