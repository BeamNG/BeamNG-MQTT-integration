This directory contains the `mqtt_example_broker.py` script, which is a sample application that listens for MQTT messages on port 1883 and prints them to the standard output. You can use it to test the integration before you use your own [MQTT broker](https://mqtt.org/software/).

If you are using this example, you should run the broker before running the `MQTToutput.lua` controller.

# Setup
1. Install the requirements for the broker script.
```bash
pip install -r requirements.txt
```

2. Run the script.
```
python mqtt_example_broker.py
```