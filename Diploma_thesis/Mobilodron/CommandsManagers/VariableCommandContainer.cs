using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class VariableCommandContainer : Container
{

    public changeVariableMechanic changeVariableMechanic;

    // Start is called before the first frame update
    void Start()
    {
        base.initialize();
    }

    // Update is called once per frame
    void Update()
    {

    }

    public override void add(Command cmd, CurrentCommandItem currentCommandItem)
    {
        base.add(cmd, currentCommandItem);
    }

    public override IEnumerator performAll()
    {
        changeVariableMechanic.changeVariable();

        yield return new WaitForSeconds(MainGame.timeToPerformCommand);
    }

}
