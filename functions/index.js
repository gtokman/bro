"use strict";
const functions = require('firebase-functions');
const admin = require('firebase-admin');
admin.initializeApp(functions.config().firebase);

exports.sendNotification = functions.database.ref('/notifications/messages/{pushId}')
    .onWrite(event => {

        console.log('Data is: ', event.data.current.val());
        const messageObject = event.data.current.val();
        const senderUid = messageObject.sender;
        const receiverUid = messageObject.receiver;
        const receiverAPNToken = admin.database().ref('/users/' + receiverUid + '/token').once('value');
        const receiverUserInfo = admin.auth().getUser(receiverUid);

        return Promise.all([receiverAPNToken, receiverUserInfo]).then(results => {
            const token = results[0].val();
            const receiver = results[1];

            console.log('Send notification to ' + receiverUid + ' message ' + messageObject.body + ' sender ' + senderUid);

            const payload = {
                notification: {
                    title: receiver.email,
                    body: messageObject.body,
                    icon: messageObject.icon
                }
            };

            admin.messaging().sendToDevice(token, payload).then(response => {
                console.log('Sent notification successfully ', response);
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