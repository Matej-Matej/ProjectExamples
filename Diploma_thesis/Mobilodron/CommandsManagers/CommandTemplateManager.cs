using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;
using TMPro;

public class CommandTemplateManager : MonoBehaviour
{

    /*
     * Stara sa o menenie textu aktualnych pouziti u commandov
     */

    public Text numberOfUseText = null;
    public TextMeshProUGUI numberOfLoops = null;
    private Command commandRef;

    void Start()
    {
        commandRef = gameObject.GetComponent<Command>();
        if (commandRef != null && commandRef.numberOfUse <= 0)
        {
            Destroy(commandRef.gameObject);
        }

        if (numberOfUseText == null)
        {
            numberOfUseText = gameObject.GetComponentsInChildren<Text>()[0];
        }
    }


    void Update()
    {
        if (commandRef != null)
        {
            if (commandRef.numberOfUse > 999)
            {
                numberOfUseText.text = "";
            }
            else
            {
                numberOfUseText.text = commandRef.numberOfUse.ToString();
            }
            
            if (commandRef.getNumberOfLoops() > 0)
            {
                numberOfLoops.text = commandRef.getNumberOfLoops().ToString();
            }
            else
            {
                if (numberOfLoops.gameObject.activeSelf) numberOfLoops.gameObject.SetActive(false);
            }
        }
        else
        {
            Debug.LogError("Nepodarilo sa najst referenciu na command skript.");
        }
    }
}
