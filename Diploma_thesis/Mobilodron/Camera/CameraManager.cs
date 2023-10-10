using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CameraManager : MonoBehaviour
{

    public Camera freeCamera;
    public Camera topDownCamera;
    public Camera thirdPersonCamera;
    // Start is called before the first frame update
    void Start()
    {
        disableAllCameras();
        switchToFreeCamera();
    }

    public void disableAllCameras()
    {
        freeCamera.enabled = false;
        freeCamera.gameObject.GetComponent<AudioListener>().gameObject.SetActive(false);
        topDownCamera.enabled = false;
        topDownCamera.gameObject.GetComponent<AudioListener>().gameObject.SetActive(false);
        thirdPersonCamera.enabled = false;
        thirdPersonCamera.gameObject.GetComponent<AudioListener>().gameObject.SetActive(false);
    }

    public void switchToFreeCamera()
    {
        disableAllCameras();
        freeCamera.enabled = true;
        freeCamera.gameObject.GetComponent<AudioListener>().gameObject.SetActive(true);
    }

    public void switchToTopDownCamera()
    {
        disableAllCameras();
        topDownCamera.enabled = true;
        topDownCamera.gameObject.GetComponent<AudioListener>().gameObject.SetActive(true);
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKeyDown(KeyCode.Alpha1))
        {
            switchToTopDownCamera();
        }
        if (Input.GetKeyDown(KeyCode.Alpha2))
        {
            switchToFreeCamera();
        }
    }
}
