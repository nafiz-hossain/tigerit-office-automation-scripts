const fs = require('fs');
const crypto = require('crypto');

function decryptFile(encryptedFilePath, key, iv, decryptedFilePath) {
    const inputStream = fs.createReadStream(encryptedFilePath);
    const outputStream = fs.createWriteStream(decryptedFilePath);

    const decipher = crypto.createDecipheriv('aes-256-gcm', key, iv);


    // inputStream.pipe(decipher).pipe(outputStream);
    inputStream.on('data', (data) => {
        const decrypted = decipher.update(data);
        outputStream.write(decrypted);
    });
    outputStream.on('finish', () => {
        console.log('Decryption complete. Decrypted file saved at:', decryptedFilePath);
    });

    outputStream.on('error', (err) => {
        console.error('Error writing decrypted file:', err);
    });
}


 base64ToArrayBuffer = (base64) => {
    const binary_string = Buffer.from(base64, 'base64').toString('binary');
    const len = binary_string.length;
    const bytes = new Uint8Array(len);
    for (let i = 0; i < len; i++) {
      bytes[i] = binary_string.charCodeAt(i);
    }
    return bytes;
  };
  

// Example usage
const encryptedFilePath = '/home/nafiz/Downloads/056f9719-f878-4883-891a-89719eb8ac89.jpeg';
const decryptedFilePath = '/home/nafiz/Downloads/056f9719-f878-4883-891a-89719eb8ac89-decrypt.jpeg';




const key = base64ToArrayBuffer('KkVkwts/TVE12KodR2M4w4ZxMRBHZeCpU9/ykKnW8aU=\n'); // Replace 'YourEncryptionKey' with your actual encryption key
const iv = base64ToArrayBuffer('PLKKLIvYIcE4o4lO'); // Replace with the IV used for encryption

decryptFile(encryptedFilePath, key, iv, decryptedFilePath);
