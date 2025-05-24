const admin = require('firebase-admin');
admin.initializeApp();

const uid = 'ditAf3SJ0KaxAbb8oS9k0IM0i7F3'; // Your user's UID

admin.auth().setCustomUserClaims(uid, { admin: true })
  .then(() => {
    console.log('Custom claim set for admin!');
    process.exit();
  })
  .catch((error) => {
    console.error('Error setting custom claim:', error);
    process.exit(1);
  });