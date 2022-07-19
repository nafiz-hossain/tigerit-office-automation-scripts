const mqtt = require('mqtt');
const { v4: uuidv4 } = require('uuid');

const brokerUrl = 'wss://mq.commstaging.com:443/mqtt'; // Adjust the base path accordingly
const options = {
  clientId: 'communicator-admin-01',
  transport: 'websockets',
  username: 'server55',
  password: 'teV55UghKEHh',
};

const client = mqtt.connect(brokerUrl, options);

client.on('connect', function () {
  console.log('[green] connected with result code');
  client.subscribe('communicator/0/+/call_events', function (err) {
    if (!err) {
      console.log('[green] Subscribed to call_events');
    } else {
      console.error('[red] Error subscribing to call_events:', err);
    }
  });
});

client.on('message', function (topic, message) {
  console.log(`${topic} ${message.toString()}`);
});

const groupId = '1378c548-6fd0-4502-bb17-7897e16e93e6';
const myMessages = ['Hello', 'Samiul'];
const id = ['6b6f8105-ad81-41ff-8d50-021e41a04147'];

try {
  for (let i = 0; i < 10; i++) {
    const aiGuess = Math.floor(Math.random() * 2);

    const ack = {
      from: uuidv4(),
      messageId: uuidv4(),
      groupId: '9db0f261-e677-4b9e-85e0-e1062ea4c2a8',
      msgOriginator: 'ebb2cf5c-2aa3-43c9-8647-7180c047bc4e',
      type: 'ack-deliver',
      encryptionMode: 'plain',
      id: uuidv4(),
    };

    const value = {
      messageType: 'QUERY',
      payloads: [],
      receivers: [],
      conversationRefId: '',
      groupRefId: '9db0f261-e677-4b9e-85e0-e1062ea4c2a8',
      lastMessageId: '',
      limit: 25,
      offset: 0,
      timestamp: Date.now(),
      messageId: uuidv4(),
      senderId: '89126870-3f3e-4029-b8f6-dde2a6d02960',
      ttl: 30000,
      priority: 1,
      queryType: 'MESSAGE',
    };

    const message = {
      attachmentKey: '',
      attachmentIV: '',
      attachmentAlgorithm: '',
      thumbRemoteFileIds: [],
      thumbUrls: [],
      conversationRefId: '1378c548-6fd0-4502-bb17-7897e16e93e6',
      contentRemoteFileIds: [],
      contentUrls: [],
      messageId: uuidv4(),
      from: '6b6f8105-ad81-41ff-8d50-021e41a04147',
      fromLinkId: '7347b94a-17b9-4a4e-b577-3c50e5571aa9',
      contentType: 'Text',
      msg: String(i),
      createAt: Date.now(),
      type: 'plaintext',
      messageStatus: 1,
      modifyAt: Date.now(),
      contentJson: '',
      quoteJson: '',
      mentionUsers: {},
      senderName: '',
      senderAvatar: '',
      target: [],
      groupId: '1378c548-6fd0-4502-bb17-7897e16e93e6',
      isSent: true,
    };

    const formattedMessage = JSON.stringify(message);

    console.log('#### ', i);
    
    client.publish('communicator/0/1378c548-6fd0-4502-bb17-7897e16e93e6/ginbox', formattedMessage);
  }
} catch (error) {
  console.error('[red] An error occurred:', error);
  client.end();
}

