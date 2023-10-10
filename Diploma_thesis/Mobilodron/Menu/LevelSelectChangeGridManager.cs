using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class LevelSelectChangeGridManager : MonoBehaviour
{

    public GameObject grid1to4;
    public GameObject grid5to8;
    public GameObject grid9to12;
    public GameObject grid12to16;
    public GameObject grid16to20;
    public GameObject grid20to24;

    public GameObject leftArrow;
    public GameObject rightArrow;

    private int currentPage = 1;
    private int maxPage = 6;

    // Start is called before the first frame update
    void Start()
    {
        updateUi();
    }

    public void increasePage()
    {
        currentPage++;
        if (currentPage > maxPage)
        {
            currentPage = maxPage;
        }
        updateUi();
    }

    public void decreasePage()
    {
        currentPage--;
        if (currentPage < 1)
        {
            currentPage = 1;
        }
        updateUi();
    }


    public void updateUi()
    {
        if (currentPage == 1)
        {
            leftArrow.SetActive(false);
        }
        else
        {
            leftArrow.SetActive(true);
        }

        if (currentPage == maxPage)
        {
            rightArrow.SetActive(false);
        }
        else
        {
            rightArrow.SetActive(true);
        }

        grid1to4.SetActive(false);
        grid5to8.SetActive(false);
        grid9to12.SetActive(false);
        grid12to16.SetActive(false);
        grid16to20.SetActive(false);
        grid20to24.SetActive(false);

        switch (currentPage)
        {
            case 1:
                grid1to4.SetActive(true);
                break;
            case 2:
                grid5to8.SetActive(true);
                break;
            case 3:
                grid9to12.SetActive(true);
                break;
            case 4:
                grid12to16.SetActive(true);
                break;
            case 5:
                grid16to20.SetActive(true);
                break;
            case 6:
                grid20to24.SetActive(true);
                break;
            default:
                break;
        }
    }

}
