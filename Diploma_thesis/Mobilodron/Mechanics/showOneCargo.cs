using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class showOneCargo : MonoBehaviour
{

    public List<GameObject> allCargos;

    private bool showed = true;
    
    // Start is called before the first frame update
    void Start()
    {
        hideAll();
    }

    void hideAll() {
        if (allCargos.Count >0 && showed) {

            foreach (GameObject cargo in allCargos) {
                cargo.gameObject.SetActive(false);
            }
            showed = false;
        }
    }

    void showRandom() {
        if (allCargos.Count > 0 && !showed) {
            allCargos[Random.Range(0,allCargos.Count)].gameObject.SetActive(true);
            showed = true;
        }
    }

    void Update() 
    {
        if (MainGame.getPerformingCommands()) {
            showRandom();
        }

        if (!MainGame.getPerformingCommands()) {
            hideAll();
        }
    }

}
