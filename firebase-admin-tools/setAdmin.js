const admin = require('firebase-admin');
const serviceAccount = require('./serviceAccountKey.json');

admin.initializeApp({
  credential: admin.credential.cert(serviceAccount),
});

const uid = 'ditAf3SJ0KaxAbb8oS9k0lM0i7F3'; // Replace this with the user's UID

admin.auth().setCustomUserClaims(uid, { admin: true })
  .then(() => {
    console.log(`✅ Admin claim added to user ${uid}`);
    process.exit();
  })
  .catch((error) => {
    console.error('❌ Error setting custom claims:', error);
    process.exit(1);
  });
