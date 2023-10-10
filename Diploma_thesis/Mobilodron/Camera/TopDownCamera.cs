using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class TopDownCamera : MonoBehaviour
{

    public Camera camera;
    private float targetZoom;
    private float zoomFactor = 3f;
    public float zoomLerpSpeed = 10;

    public float minimumDistance = 3f;
    public float maximumDistance = 10f;

    public float maxCameraMoveValue = 0.1f;

    // Start is called before the first frame update
    void Start()
    {
        gameObject.transform.position = new Vector3(MainGame.GetDroneMovement().transform.position.x, gameObject.transform.position.y, MainGame.GetDroneMovement().transform.position.z);

        if (camera == null)
        {
            camera = gameObject.GetComponent<Camera>();
        }
        targetZoom = camera.orthographicSize;
    }


    void Update()
    {
        targetZoom -= Input.GetAxis("Mouse ScrollWheel") * zoomFactor;
        camera.orthographicSize = Mathf.Lerp(camera.orthographicSize, Mathf.Clamp(targetZoom, minimumDistance, maximumDistance), Time.deltaTime * zoomLerpSpeed);
        camera.transform.Translate(new Vector3(Mathf.Clamp(Input.GetAxis("Horizontal"), -maxCameraMoveValue, maxCameraMoveValue) / 6, Mathf.Clamp(Input.GetAxis("Vertical"), -maxCameraMoveValue, maxCameraMoveValue) / 6, 0.0f));
    }
}
