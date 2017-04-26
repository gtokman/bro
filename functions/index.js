"use strict";
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendFriendRequestNotification = functions.database.ref('/request/{receiver}/{sender}')
    .onWrite(event => {

        const requestObject = event.data.val();
        const requestReceiver = requestObject.receiver;
        const requestSender = requestObject.sender;
        const receiverAPNToken = admin.database().ref('/users/' + requestReceiver + '/token').once('value');
        const senderInfo = admin.database().ref('/users/' + requestSender).once('value');

        return Promise.all([receiverAPNToken, senderInfo]).then(results => {
            const token = results[0].val();
            const sender = results[1].val();

            console.log('Sender: ' + sender.displayName + ' to: ' + token);

            const payload = {
                notification: {
                    title: 'New Bro Request',
                    body: 'From ' + sender.displayName
                }
            };

            admin.messaging().sendToDevice(token, payload).then(response => {
                console.log('Sent notification successfully ', response);

                return admin.database().ref('/notifications/' + requestReceiver + '/' + requestSender).set(sender);
            }).catch(error => {
                console.log('Error sending notification: ', response);
            });
        });
    });

exports.sendNotification = functions.database.ref('/bro-notifications/{friendUID}/{pushId}')
    .onWrite(event => {

        console.log('Data is: ', event.data.current.val());
        const messageObject = event.data.current.val();
        const senderUid = messageObject.sender;
        const receiverUid = messageObject.receiver;
        const receiverUserInfo = admin.database().ref('/users/' + receiverUid).once('value');
        const senderUserInfo = admin.database().ref('/users/' + senderUid).once('value');

        return Promise.all([receiverUserInfo, senderUserInfo]).then(results => {
            const receiverObject = results[0].val();
            const senderObject = results[1].val();

            console.log('Send notification to ' + receiverObject.displayName + ' sender ' + senderObject.displayName);

            const payload = {
                notification: {
                    title: messageObject.title,
                    body: senderObject.displayName
                }
            };

            admin.messaging().sendToDevice(receiverObject.token, payload).then(response => {
                console.log('Sent notification successfully ', response);
                const timestamp = new Date().toDateString();
                const messageInfo = {
                    sender: senderObject.displayName,
                    receiver: receiverObject.displayName,
                    body: "Bro",
                    timestamp: timestamp
                };
                return admin.database().ref('/bro-messages/' + receiverUid).push().set(messageInfo);
            }).catch(error => {
                console.log('Error sending notification: ', error);
            });
        });

    });

exports.uppercaseUserName = functions.database.ref('/users/{uid}/displayName').onWrite(event => {

    const original = event.data.current.val();
    console.log('uppercasing username ', event.params, original);
    const uppercase = original.toUpperCase();

    return event.data.ref.parent.child('displayName').set(uppercase);
});