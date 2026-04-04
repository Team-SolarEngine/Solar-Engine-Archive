package sys;

class TempStateData
{
    public var curState:FlxState;
    public var stateData:Map<String, Dynamic>;
    public static var instance:TempStateData;

    public function new()
    {
        instance = this;
        FlxG.signals.postStateSwitch.add(newInstance);
    }

    public function newInstance()
    {
        if (curState == null)
        {
            curState = FlxG.state;
            stateData = new Map<String, Dynamic>();
        }
        else if (FlxG.state != curState)
        {
            curState = FlxG.state;
            clear();
        }
    }

    // Basic map array functions.
    public function set(k:String, v:Dynamic) stateData.set(k, v);
    public function get(k:String):Dynamic return stateData.get(k);
    public function exists(k:String):Bool return stateData.exists(k);
    public function remove(k:String):Bool return stateData.remove(k);
    public function iterator():Iterator<Dynamic> return stateData.iterator();
    public function keyValueIterator():KeyValueIterator<String, Dynamic> return stateData.keyValueIterator();
    /**
     * Copies the underlying map array via it's copy function.
     */
    public function copy():Map<String, Dynamic> return stateData.copy();
    /**
     * Destroys/Closes objects and clears the underlying map array.
     */
    public function clear()
    {
            for (key => data in stateData)
            {
                // call destroy functions.
                if (Reflect.hasField(data, "destroy"))
                {
                    data.destroy();
                }
                else if (Reflect.hasField(data, "close"))
                {
                    data.close();
                }
            }
            stateData.clear();
    }
}