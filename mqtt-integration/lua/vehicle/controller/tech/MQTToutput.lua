-- This Source Code Form is subject to the terms of the bCDDL, v. 1.1.
-- If a copy of the bCDDL was not distributed with this
-- file, You can obtain one at http://beamng.com/bCDDL-1.1.txt

local M = {}
M.type = "auxiliary"

local mqtt = require("libs/luamqtt/mqtt/init")
local logTag = "MQTToutput"

local client = nil
local isClientConnected = false

local topicName
local data = {}
local wheelLookup = {}

local function sendData(dt)
  if isClientConnected then
    client:publish({topic = topicName, payload = jsonEncode(data)})
  end
end

local function updateData(dt)
  -- per wheel angular velocity [rad/s]
  data.AngularVelocityFrontAxleLeft = wheels.wheels[wheelLookup.FL].angularVelocity
  data.AngularVelocityFrontAxleRight = wheels.wheels[wheelLookup.FR].angularVelocity
  data.AngularVelocityRearAxleLeft = wheels.wheels[wheelLookup.RL].angularVelocity
  data.AngularVelocityRearAxleRight = wheels.wheels[wheelLookup.RR].angularVelocity

  -- TODO: here you can add any other data you want to be sent
end

local function updateGFX(dt)
  updateData(dt)
  sendData(dt)
end

local function reset(jbeamData)
end

local function init(jbeamData)
  for wheelId, wheel in pairs(wheels.wheels) do
    wheelLookup[wheel.name] = wheelId
  end

  local uri = jbeamData.uri or "127.0.0.1"
  topicName = jbeamData.topic or "car_data"

  client = mqtt.client({uri = uri, clean = true})
  if client == nil then
    local msg = "Cannot connect to MQTT client: " .. uri
    log("E", logTag, msg)
    return false, msg
  end
  log("I", logTag, "Created MQTT client: " .. uri)

  local success, error = client:start_connecting()
  if not success then
    client = nil
    log("E", logTag, error)
    return false, error
  end

  isClientConnected = true
  table.clear(data)

  log("I", logTag, "MQTT connected.")
end

M.init = init
M.reset = reset

M.updateGFX = updateGFX

return M
