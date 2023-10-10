using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class DroneMovement : MonoBehaviour
{

    public enum Directions { FORWARD, LEFT, BACKWARD, RIGHT };
    /*
     * Trieda sluzi na kontrolu pohybu drona
     * sklada sa z par metod, ktorymi ho dokazeme ovladat
    */

    public Vector3 dronePosition;
    public Quaternion droneRotation;
    public ChangeDroneColor changeDroneColor;
    public bool movingForward = false;
    private bool movingVertical = false;
    private Vector3 endPosition = new Vector3();
    private float timeToPerformAction = 1f;
    public Animator anim;
    private Directions currentDirection = Directions.FORWARD;

    // v niektorych leveloch bude treba namapovat kde je pre drona vpredu, kde vzadu a pod 
    public Vector3 mapForward = new Vector3(0, 0, 1);
    public Vector3 mapBackward = new Vector3(0, 0, -1);
    public Vector3 mapLeft = new Vector3(-1, 0, 0);
    public Vector3 mapRight = new Vector3(1, 0, 0);

    public GameObject lights;

    private int forwardValue = 1;

    void Start()
    {
        if(anim == null)
        {
            anim = gameObject.GetComponent<Animator>();
        }
        // ulozenie uvodnej pozicie a rotacie
        turnLights(false);
        dronePosition = transform.position;
        droneRotation = transform.rotation;
        anim.Play("DroneDefault");
    }

    private void Update()
    {
        if (MainGame.performingCommands)
        {
            if (movingForward)
            {
                if (transform.localPosition == endPosition)
                {
                    movingForward = false;
                }
                transform.localPosition = Vector3.MoveTowards(transform.localPosition, endPosition, (forwardValue / timeToPerformAction * Time.deltaTime)); // to 1/1 je distance/time
            }
            if (movingVertical)
            {
                if (transform.localPosition == endPosition)
                {
                    movingVertical = false;
                }
                transform.localPosition = Vector3.MoveTowards(transform.localPosition, endPosition, ((1 / timeToPerformAction) * Time.deltaTime));
            }
        }
    }

    // Metoda na pohyb dopredu urcitu dlzku
    public void moveForward(int stepLength,float time)
    {
        forwardValue = stepLength;
        if (currentDirection == Directions.FORWARD)
        {
            endPosition = transform.localPosition + (mapForward * stepLength);
        }
        if (currentDirection == Directions.BACKWARD)
        {   
            endPosition = transform.localPosition + (mapBackward * stepLength);
        }
        if (currentDirection == Directions.LEFT)
        {
            endPosition = transform.localPosition + (mapLeft * stepLength);
        }
        if (currentDirection == Directions.RIGHT)
        {
            endPosition = transform.localPosition + (mapRight * stepLength);
        }
        timeToPerformAction = time;
        movingForward = true;
     //   transform.Translate(stepLength,0,0);
    }

    // Otocenie sa o urcity uhol
    public void rotate(int rotateValue,float time)
    {
        anim.speed = 1/time;
        if (currentDirection == Directions.FORWARD)
        {
            if (mapForward == new Vector3(1,0,0) )
            {
                anim.Play("DroneRotate90");
            }
            else if (mapForward == new Vector3(-1,0,0))
            {
                anim.Play("DroneRotate270");
            }
            else if (mapForward == new Vector3(0,0,1))
            {
                anim.Play("DroneRotate90");
            }
            else
            {
                anim.Play("DroneRotate270");
            }
            currentDirection = Directions.LEFT;
        }
        else if (currentDirection == Directions.LEFT)
        {
            if (mapForward == new Vector3(1, 0, 0))
            {
                anim.Play("DroneRotate180");
            }
            else if (mapForward == new Vector3(-1, 0, 0))
            {
                anim.Play("DroneRotate360");
            }
            else if (mapForward == new Vector3(0, 0, 1))
            {
                anim.Play("DroneRotate180");
            }
            else
            {
                anim.Play("DroneRotate360");
            }
            currentDirection = Directions.BACKWARD;

        }
        else if (currentDirection == Directions.BACKWARD)
        {
            if (mapForward == new Vector3(1, 0, 0))
            {
                anim.Play("DroneRotate270");
            }
            else if (mapForward == new Vector3(-1, 0, 0))
            {
                anim.Play("DroneRotate90");
            }
            else if (mapForward == new Vector3(0, 0, 1))
            {
                anim.Play("DroneRotate270");
            }
            else
            {
                anim.Play("DroneRotate90");
            }
            currentDirection = Directions.RIGHT;
        }
        else if (currentDirection == Directions.RIGHT)
        {
            if (mapForward == new Vector3(1, 0, 0))
            {
                anim.Play("DroneRotate360");
            }
            else if (mapForward == new Vector3(-1, 0, 0))
            {
                anim.Play("DroneRotate180");
            }
            else if (mapForward == new Vector3(0, 0, 1))
            {
                anim.Play("DroneRotate360");
            }
            else
            {
                anim.Play("DroneRotate180");
            }
            currentDirection = Directions.FORWARD;
        }
     //  transform.Rotate(0,rotateValue,0);
    }

    public void moveVertical(int stepLength,float time)
    {
        movingVertical = true;
        endPosition = transform.localPosition + new Vector3(0, stepLength, 0);
        timeToPerformAction = time;
        //transform.Translate(0, stepLength, 0);
    }

    /*
     * Resetne poziciu a rotaciu drona na povodnu hodnotu
     */
    public void resetDroneTransform()
    {
        turnLights(false);
        transform.position = dronePosition;
        transform.rotation = droneRotation;
        movingForward = false;
        movingVertical = false;
        anim.Play("DroneDefault");
        currentDirection = Directions.FORWARD;
    }

    public void moveDroneAndSaveNewPosition(int stepLength, Directions direction)
    {
        if (!MainGame.getPerformingCommands()) {
            if (direction == Directions.FORWARD)
            {
                transform.localPosition = transform.localPosition + (mapForward * stepLength);
            }
            if (direction == Directions.BACKWARD)
            {   
                transform.localPosition = transform.localPosition + (mapBackward * stepLength);
            }
            if (direction == Directions.LEFT)
            {
                transform.localPosition = transform.localPosition + (mapLeft * stepLength);
            }
            if (direction == Directions.RIGHT)
            {
                transform.localPosition = transform.localPosition + (mapRight * stepLength);
            }
            dronePosition = transform.position;
        }
    }

    public void turnLights(bool on) {
        if (on) {
            lights.SetActive(true);
        } else {
            lights.SetActive(false);
        }
    }
}
