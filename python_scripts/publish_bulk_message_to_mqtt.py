import paho.mqtt.client as mqtt
import time
import uuid
import json
import random 
from random import randrange

def on_connect(client, obj, flags, rc):
    if rc == 0:
        print(f"[green] connected with result code")
    else:
        print(f"[red] Bad connection returned code = ", rc)

def on_message(client, obj, msg):
    print(f"{msg.topic} {str(msg.payload)}")

Connected = False   # global variable for the state of the connection

# Set use_websockets to True and use the ws:// or wss:// prefix in the broker URL
broker_url = "wss://mq.commstaging.com:443/mqtt"  # Adjust the base path accordingly
client = mqtt.Client(client_id="communicator-admin-01", transport='websockets')  # Set transport to websockets
client.username_pw_set("server55", "teV55UghKEHh")
client.on_connect = on_connect
client.on_message = on_message
client.connect(broker_url, keepalive=60, bind_address="")

client.subscribe("communicator/0/+/call_events")
time.sleep(1)

groupId = "1378c548-6fd0-4502-bb17-7897e16e93e6"
my_list = ["Hello", "World"]  # Adjust the list of messages accordingly
id = ["6b6f8105-ad81-41ff-8d50-021e41a04147"]

try:
    for i in range(10):
        aiGuess = randrange(1)

        ack = {"from": str(uuid.uuid4()), "messageId": str(uuid.uuid4()), "groupId": "9db0f261-e677-4b9e-85e0-e1062ea4c2a8", "msgOriginator": "ebb2cf5c-2aa3-43c9-8647-7180c047bc4e", "type": "ack-deliver", "encryptionMode": "plain", "id": str(uuid.uuid4())}

        value = {"messageType": "QUERY", "payloads": [], "receivers": [], "conversationRefId": "", "groupRefId": "9db0f261-e677-4b9e-85e0-e1062ea4c2a8", "lastMessageId": "", "limit": 25, "offset": 0, "timestamp": round(time.time() * 1000), "messageId": str(uuid.uuid4()), "senderId": "89126870-3f3e-4029-b8f6-dde2a6d02960", "ttl": 30000, "priority": 1, "queryType": "MESSAGE"}

        message = {"attachmentKey": "", "attachmentIV": "", "attachmentAlgorithm": "", "thumbRemoteFileIds": [], "thumbUrls": [], "conversationRefId": "1378c548-6fd0-4502-bb17-7897e16e93e6", "contentRemoteFileIds": [], "contentUrls": [], "messageId": str(uuid.uuid4()), "from": "6b6f8105-ad81-41ff-8d50-021e41a04147", "fromLinkId": "7347b94a-17b9-4a4e-b577-3c50e5571aa9", "contentType": "Text", "msg": i, "createAt": (time.time() * 1000), "type": "plaintext", "messageStatus": 1, "modifyAt": (time.time() * 1000), "contentJson": "", "quoteJson": "", "mentionUsers": {}, "senderName": "", "senderAvatar": "", "target": [], "groupId": "1378c548-6fd0-4502-bb17-7897e16e93e6", "isSent": "true"}

        formatedMessage = json.dumps(message)

        print("#### ", i)

        client.publish("communicator/0/1378c548-6fd0-4502-bb17-7897e16e93e6/ginbox", formatedMessage)

except KeyboardInterrupt:
    client.disconnect()
    client.loop_stop()
client.loop_forever()
