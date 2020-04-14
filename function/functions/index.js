const functions = require('firebase-functions');
const admin = require('firebase-admin');

admin.initializeApp(functions.config().firebase);

const db = admin.firestore();
// // Create and Deploy Your First Cloud Functions
// // https://firebase.google.com/docs/functions/write-firebase-functions
//


exports.reseverTafel = functions.firestore.document("/reseveringen/{docid}").onCreate((snap,context)=>{
    const data = snap.data();
    console.log(data.datum);
    console.log(data.tafel);

    db.collection("blockedTafel").doc().set({
        "datum": data.datum,
        "tafel":data.tafel
    });

    return `tafel: ${data.tafel} gereseveert op: ${data.datum}`;
})