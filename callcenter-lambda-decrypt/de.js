const AWS = require('aws-sdk');
AWS.config.update({ region: 'us-west-2' });

const functionName = process.env.AWS_LAMBDA_FUNCTION_NAME;
const encrypted = process.env['DB'];
let decrypted;


function processEvent(event) {
    // TODO handle the event here
}

exports.handler = async (event) => {
    if (!decrypted) {
        // Decrypt code should run once and variables stored outside of the
        // function handler so that these are decrypted once per container
        const kms = new AWS.KMS();
        try {
            const req = {
                CiphertextBlob: Buffer.from(encrypted, 'base64'),
                EncryptionContext: { LambdaFunctionName: functionName },
            };
            const data = await kms.decrypt(req).promise();
            decrypted = data.Plaintext.toString('ascii');
        } catch (err) {
            console.log('Decrypt error:', err);
            throw err;
        }
    }
    processEvent(event);
};
