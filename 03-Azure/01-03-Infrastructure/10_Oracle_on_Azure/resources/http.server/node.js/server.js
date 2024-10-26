const privateKey = fs.readFileSync('path/to/your/private-key.pem', 'utf8');
const certificate = fs.readFileSync('path/to/your/certificate.pem', 'utf8');
const ca = fs.readFileSync('path/to/your/ca.pem', 'utf8');

const credentials = { key: privateKey, cert: certificate, ca: ca };

const httpsServer = https.createServer(credentials, app);

httpsServer.listen(port, () => {
    console.log(`HTTPS Server is running on port ${port}`);
});

const express = require('express');
const oracledb = require('oracledb');
const passport = require('passport');
const { BearerStrategy } = require('passport-azure-ad');
const fs = require('fs');
const https = require('https');

require('dotenv').config();

const app = express();
const port = process.env.PORT || 3000;

// Azure AD configuration
const options = {
    identityMetadata: `https://login.microsoftonline.com/${process.env.TENANT_ID}/v2.0/.well-known/openid-configuration`,
    clientID: process.env.CLIENT_ID,
    validateIssuer: true,
    issuer: `https://sts.windows.net/${process.env.TENANT_ID}/`,
    passReqToCallback: false,
    loggingLevel: 'info',
    scope: ['user.read'],
};

passport.use(new BearerStrategy(options, (token, done) => {
    done(null, {}, token);
}));

app.use(passport.initialize());

app.get('/api/nyc-taxi-records', passport.authenticate('oauth-bearer', { session: false }), async (req, res) => {
    let connection;

    try {
        connection = await oracledb.getConnection({
            user: process.env.DB_USER,
            password: process.env.DB_PASSWORD,
            connectString: process.env.DB_CONNECTION_STRING,
        });

        const result = await connection.execute(
            `SELECT * FROM NYC_TAXI_TRIPS`
        );

        res.json(result.rows);
    } catch (err) {
        console.error(err);
        res.status(500).send('Error retrieving data from the database');
    } finally {
        if (connection) {
            try {
                await connection.close();
            } catch (err) {
                console.error(err);
            }
        }
    }
});

app.listen(port, () => {
    console.log(`Server is running on port ${port}`);
});