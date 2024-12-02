
---

**This repository is deprecated, the MQTT integration is included with BeamNG.tech builds, documentation available at https://documentation.beamng.com/beamng_tech/mqtt/.**

---

# BeamNG MQTT Integration

MQTT is a lightweight publish/subscribe messaging protocol for the Internet of Things (IoT). This repository provides an integration of the protocol to BeamNG.tech, allowing sending of data from BeamNG to a MQTT broker.

This repository consists of a sample vehicle controller exporting the data from BeamNG to a MQTT broker with help of the included [luamqtt](https://github.com/xHasKx/luamqtt) library with minor edits to be compatible with the BeamNG codebase.

## Recommended Setup
0. If you are not using your own MQTT broker, you can test with the example one provided in the [tools/](tools) folder. In this case, follow the instructions in [the subfolder](tools) first.
1. Clone this repository.
2. Copy over the [mqtt-integration](mqtt-integration) folder to the `unpacked` subfolder of your mods folder (if it does not exist, create it). You can find the folder by running BeamNG, going to the `Mods` menu, and then clicking the `Open Mod folder` button.

    The default location is `%localappdata%\BeamNG.drive\<VERSION>\mods\unpacked`.

3. Restart the simulator. You should see that the `mqtt-integration` mod is now installed.
4. Spawn a car you want to send the data for, open the BeamNG console (by pressing `` ` ``) and switch to `BeamNG - Current Vehicle` in the bottom-left combobox.
5. Write:
    ```lua
    controller.loadControllerExternal('tech/MQTToutput', 'MQTToutput', {uri = '127.0.0.1', topic='car_data'})
    ```

    into the console to start exporting data. If you are using the example broker, you should see that data are being sent.
6. To stop, use the same console to execute the following command:
    ```lua
    controller.unloadControllerExternal('MQTToutput')
    ```

## Customization
To add more data to the MQTT output, edit [MQTToutput.lua](mqtt-integration/lua/vehicle/controller/tech/MQTToutput.lua). The function of interest is `updateData`.
