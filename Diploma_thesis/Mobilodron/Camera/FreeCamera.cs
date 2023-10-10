using UnityEngine;
using System.Collections;

public class FreeCamera : MonoBehaviour
{
    private float mainSpeed = 15f; 
    private float camSens = 0.07f;
    private int minimalHeight = 2;
    private int maximalHeight = 15;
    private Vector3 lastMouse = new Vector3(255, 255, 255); 

    void Update()
    {
        lastMouse = Input.mousePosition - lastMouse;
        lastMouse = new Vector3(-lastMouse.y * camSens, lastMouse.x * camSens, 0);
        lastMouse = new Vector3(transform.eulerAngles.x + lastMouse.x, transform.eulerAngles.y + lastMouse.y, 0);
        if (Input.GetMouseButton(1)) transform.eulerAngles = lastMouse;
        lastMouse = Input.mousePosition;

        transform.Translate(GetBaseInput() * mainSpeed * Time.deltaTime);
    }

    private Vector3 GetBaseInput()
    { 
        Vector3 p_Velocity = new Vector3();
        if (Input.GetKey(KeyCode.W))
        {
            p_Velocity += new Vector3(0, 0, 1);
        }
        if (Input.GetKey(KeyCode.S))
        {
            p_Velocity += new Vector3(0, 0, -1);
        }
        if (Input.GetKey(KeyCode.A))
        {
            p_Velocity += new Vector3(-1, 0, 0);
        }
        if (Input.GetKey(KeyCode.D))
        {
            p_Velocity += new Vector3(1, 0, 0);
        }
        if (Input.GetKey(KeyCode.Space))
        {
            if (transform.position.y < maximalHeight)
            {
                p_Velocity += new Vector3(0, 1, 0);
            }
        }
        if (Input.GetKey(KeyCode.LeftControl))
        {
            if (transform.position.y > minimalHeight)
            {
                p_Velocity += new Vector3(0, -1, 0);
            }
        }
        return p_Velocity;
    }
}