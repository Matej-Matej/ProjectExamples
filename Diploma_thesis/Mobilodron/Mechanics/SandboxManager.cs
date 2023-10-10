using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEngine.UI;

public class SandboxManager : MonoBehaviour
{

    public Toggle droneOrGoal;
    public Transform goal;

    public void changePositionUp()
    {
        if (!droneOrGoal.isOn) {
            MainGame.GetDroneMovement().moveDroneAndSaveNewPosition(2,DroneMovement.Directions.FORWARD);
        } else {
            if (!MainGame.getPerformingCommands() && goal != null) {
                goal.transform.position = goal.transform.position + (new Vector3(0, 0, 1) * 2);
            }
        }
    }

    public void changePositionDown()
    {
        if (!droneOrGoal.isOn) {
            MainGame.GetDroneMovement().moveDroneAndSaveNewPosition(2,DroneMovement.Directions.BACKWARD);
        } else {
            if (!MainGame.getPerformingCommands() && goal != null) {
                goal.transform.position = goal.transform.position + (new Vector3(0, 0, -1) * 2);
            }
        }
    }

    public void changePositionLeft()
    {
        if (!droneOrGoal.isOn) {
            MainGame.GetDroneMovement().moveDroneAndSaveNewPosition(2,DroneMovement.Directions.LEFT);
        } else {
            if (!MainGame.getPerformingCommands() && goal != null) {
                goal.transform.position = goal.transform.position + (new Vector3(-1, 0, 0) * 2);
            }
        }
    }

    public void changePositionRight()
    {
        if (!droneOrGoal.isOn) {
            MainGame.GetDroneMovement().moveDroneAndSaveNewPosition(2,DroneMovement.Directions.RIGHT);
        } else {
            if (!MainGame.getPerformingCommands() && goal != null) {
                goal.transform.position = goal.transform.position + (new Vector3(1, 0, 0) * 2);
            }
        }
    }
}
