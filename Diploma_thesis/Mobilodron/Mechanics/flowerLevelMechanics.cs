using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class flowerLevelMechanics : MonoBehaviour
{

    public List<GameObject> listOfFlowers;

    public GameObject ending;
    // Start is called before the first frame update
    private bool showed = true;
    
    // Start is called before the first frame update
    void Start()
    {
        showAll();
    }

    void hideOne() {
        if (listOfFlowers.Count > 0) {
            int randomIndex = Random.Range(0,listOfFlowers.Count);
            listOfFlowers[randomIndex].gameObject.SetActive(false);
            listOfFlowers[randomIndex].gameObject.GetComponent<Obstacles>().disable = true;
            ending.transform.position = listOfFlowers[randomIndex].gameObject.transform.position;
            ending.transform.position += new Vector3(-1,0,7);
        }
    }

    void showAll() {
        if (listOfFlowers.Count >0) {
            foreach (GameObject flower in listOfFlowers) {
                flower.gameObject.SetActive(true);
                flower.gameObject.GetComponent<Obstacles>().disable = false;
                foreach (Transform subFlower in flower.gameObject.transform) {
                    subFlower.gameObject.SetActive(false);
                }
                flower.transform.GetChild(Random.Range(0,3)).gameObject.SetActive(true);
            }
        }
    }

    void Update() 
    {
        if (MainGame.getPerformingCommands() && !showed) {
            showAll();
            hideOne();
            showed = true;
        }

        if (!MainGame.getPerformingCommands() && showed) {
            showed = false;
        }
    }
}
