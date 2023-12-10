const express = require('express');
const bodyParser = require('body-parser');
const jwt = require('jsonwebtoken');
const bcrypt = require('bcrypt');
const cors = require('cors');
const crypto = require('crypto-js');
const mysql = require('mysql'); // Importa el paquete mysql
const speakeasy = require("speakeasy");
const qrcode = require("qrcode-terminal");
const axios = require('axios');
const multer = require('multer');
const https = require('https');
const fs = require('fs');
const nodemailer = require("nodemailer");

const app = express();
const port = process.env.PORT || 3002;
const secretKey = '6c26c3c15f6cf684b92e7297717484593ce04f5ece4d4227e77d9b6ccc349122'; // Reemplaza con una clave segura
const saltRounds = 10; // Número de rondas de sal (cifrado más seguro)

const useSSL = true; // Cambia a 'false' si no quieres usar SSL

let credentials = null;

if (useSSL) {
    const privateKey = fs.readFileSync('/etc/letsencrypt/live/billionsoffice.com/privkey.pem', 'utf8');
    const certificate = fs.readFileSync('/etc/letsencrypt/live/billionsoffice.com/fullchain.pem', 'utf8');
    credentials = { key: privateKey, cert: certificate };
}

const db = mysql.createConnection({
    host: 'localhost', // Reemplaza con la dirección de tu servidor MySQL
    user: 'root', // Reemplaza con tu usuario de MySQL
    password: '', // Reemplaza con tu contraseña de MySQL
    database: 'backup' // Reemplaza con el nombre de tu base de datos
});


// Conecta a la base de datos MySQL
db.connect((err) => {
    if (err) {
        console.error('Error al conectar a la base de datos MySQL:', err);
    } else {
        console.log('Conexión exitosa a la base de datos MySQL');
    }
});

app.use(bodyParser.json());
app.use(cors()); // Habilita CORS para todas las rutas


// Configuración de Nodemailer
const transporter = nodemailer.createTransport({
    host: "smtp.gmail.com",
    port: 465,
    secure: true,
    auth: {
        // TODO: replace `user` and `pass` values from <https://forwardemail.net>
        user: "dgonnou@gmail.com",
        pass: "amut ezqj ugir pcoa",
    },
});


app.use('/uploads', express.static('uploads'));

// Configurar multer para manejar la carga de imágenes
const storage = multer.diskStorage({
    destination: (req, file, cb) => {
        cb(null, 'uploads/'); // Directorio donde se guardarán las imágenes
    },

    filename: (req, file, cb) => {
        const fileName = Date.now() + '-' + file.originalname;
        cb(null, fileName);
    },
});

const upload = multer({ storage });
// Ruta para manejar la carga de imágenes
app.post('/api/upload-image', upload.single('image'), (req, res) => {
    if (!req.file) {
        return res.json('No se ha proporcionado ninguna imagen');
    }

    // Aquí puedes obtener la URL de la imagen
    const imageUrl = `/uploads/${req.file.filename}`; // Asumiendo que las imágenes se almacenan en el directorio 'uploads/'

    // Luego, puedes actualizar la fila correspondiente en la tabla 'bills' utilizando el ID de factura
    const billId = req.body.billId; // Supongamos que recibes el ID de factura desde el cliente
    const sql = 'UPDATE bills SET comprobante = ? WHERE bill_id = ?';

    // Ejecuta la consulta SQL para actualizar la URL de la imagen en la base de datos
    db.query(sql, [imageUrl, billId], (error, result) => {
        if (error) {
            return res.status(500).json('Error al actualizar la URL de la imagen');
        }

        return res.json('Imagen cargada con éxito y URL actualizada en la factura');
    });
});

// Ruta para manejar la carga de imágenes
app.post('/api/upload', upload.single('image'), (req, res) => {
    if (!req.file) {
        return res.json('No se ha proporcionado ninguna imagen');
    }

    // Aquí puedes obtener la URL de la imagen
    const imageUrl = `/uploads/${req.file.filename}`; // Asumiendo que las imágenes se almacenan en el directorio 'uploads/'
    return res.json({ url: imageUrl });
});


app.post('/api/updateProfileImagec', verifyToken, upload.single('image'), (req, res) => {
    if (!req.file) {
        return res.status(400).send('No se ha proporcionado un archivo válido.');
    }

    const imageFileName = req.file.filename;
    const imageUrl = `https://billionsoffice.com:3002/uploads/${imageFileName}`; // Reemplaza con la URL de tu servidor

    const userId = req.userId; // Utiliza el userId obtenido del token a través de verifyToken

    const updateQuery = 'UPDATE users SET avatar = ? WHERE user_id = ?';

    db.query(updateQuery, [imageUrl, userId], (updateErr, updateResults) => {
        if (updateErr) {
            return res.status(500).send('Error al actualizar la imagen de perfil.');
        }

        res.status(200).json({ imageUrl: imageUrl });
    });
});

// Ruta para actualizar el perfil del usuario
app.put("/api/updateProfile", verifyToken, (req, res) => {
    const userId = req.userId; // Obtiene el userId del token JWT
    const {
        firstName,
        lastName,
        email
    } = req.body;

    const updateQuery = 'UPDATE users SET firstName = ?, lastName = ?, email = ? WHERE user_id = ?';

    db.query(updateQuery, [firstName, lastName, email, userId], (err, results) => {
        if (err) {
            console.error("Error al actualizar el perfil:", err);
            return res.status(500).json({ error: "Error en la base de datos" });
        }

        res.status(200).json({ message: "Perfil actualizado con éxito" });
    });
});


app.post('/api/updateProfileImage', verifyToken, (req, res) => {
    const { image } = req.body;
    const userId = req.userId; // El userId se extrae automáticamente del token gracias a verifyToken
    const imageUrl = `https://billionsoffice.com:3002/uploads/${image}`; // Reemplaza con la URL de tu servidor

    const updateQuery = 'UPDATE users SET avatar = ? WHERE user_id = ?';

    db.query(updateQuery, [imageUrl, userId], (updateErr, updateResults) => {
        if (updateErr) {
            return res.status(500).json({ error: 'Error al actualizar la imagen de perfil' });
        }

        res.status(200).json({ message: 'Imagen de perfil actualizada con éxito' });
    });
});


// Función para generar un código aleatorio de 8 dígitos con letras y números
function generateRandomCode() {
    const characters = 'ABCDEFGHIJKLMNOPQRSTUVWXYZabcdefghijklmnopqrstuvwxyz0123456789';
    const codeLength = 8;
    let code = '';

    for (let i = 0; i < codeLength; i++) {
        const randomIndex = Math.floor(Math.random() * characters.length);
        code += characters.charAt(randomIndex);
    }

    return code;
}

// Ruta para enviar el código de verificación
app.post("/api/send-verification-code", (req, res) => {
    const { username } = req.body;
    const verificationCode = generateRandomCode(); // Genera un código aleatorio


    const getUserEmailQuery = "SELECT email FROM users WHERE username = ?";

    db.query(getUserEmailQuery, [username], (err, results) => {
        if (err) {
            console.error("Error al consultar el correo del usuario:", err);
            return res.status(500).json({ message: "Error al restablecer la contraseña" });
        }

        if (results.length === 0) {
            return res.status(400).json({ message: "Nombre de usuario no encontrado" });
        }

        const userEmail = results[0].email;

        // Guarda el código de verificación en la base de datos junto con el usuario
        const insertCodeQuery = "INSERT INTO verification_codes (username, code) VALUES (?, ?)";

        db.query(insertCodeQuery, [username, verificationCode], (insertError, insertResults) => {
            if (insertError) {
                console.error("Error al insertar el código de verificación en la base de datos:", insertError);
                res.status(500).json({ message: "Error al enviar el código de verificación" });
            } else {

                const mailOptions = {
                    from: "dgonnou@gmail.com",
                    to: userEmail, // Obtiene el correo del usuario desde la base de datos
                    subject: "BillionsCorp : Código de Verificación",
                    text: `Tu código de verificación para restablecer contraseña es: ${verificationCode}`,
                };

                transporter.sendMail(mailOptions, (error, info) => {
                    if (error) {
                        console.error("Error al enviar el correo de verificación:", error);
                        res.status(500).json({ message: "Error al enviar el código de verificación" });
                    } else {
                        res.status(200).json({ message: "Código de verificación enviado con éxito" });
                    }
                });
            }
        });
    });
});


// Define la ruta para verificar el código
app.post("/api/verify-code", (req, res) => {
    const { username, verificationCode } = req.body;

    // Consulta el código almacenado en la base de datos
    const query = "SELECT code FROM verification_codes WHERE username = ?";

    db.query(query, [username], (error, results, fields) => {
        if (error) {
            console.error("Error al realizar la consulta: " + error);
            res.status(500).json({ message: "Error en el servidor" });
        } else {
            if (results.length === 0) {
                res.status(400).json({ message: "Código de verificación incorrecto." });
            } else {
                const storedCode = results[0].code;

                if (verificationCode === storedCode) {
                    res.status(200).json({ message: "Código de verificación correcto." });
                } else {
                    res.status(400).json({ message: "Código de verificación incorrecto." });
                }
            }
        }
    });
});

// Ruta para restablecer la contraseña
app.post("/api/reset-password", (req, res) => {
    const { username, verificationCode, hashedPassword } = req.body;

    const updatePasswordQuery = "UPDATE users SET password = ? WHERE username = ?";

    db.query(updatePasswordQuery, [hashedPassword, username], (updateError, updateResults) => {
        if (updateError) {
            console.error("Error al actualizar la contraseña en la base de datos:", updateError);
            res.status(500).json({ message: "Error al restablecer la contraseña" });
        } else {
            // Elimina el código de verificación después de usarlo
            const deleteCodeQuery = "DELETE FROM verification_codes WHERE username = ?";

            db.query(deleteCodeQuery, [username], (deleteError, deleteResults) => {
                if (deleteError) {
                    console.error("Error al eliminar el código de verificación en la base de datos:", deleteError);
                }
            });

            res.status(200).json({ message: "Contraseña restablecida con éxito" });
        }
    });

});




app.post('/api/cancelPurchase', verifyToken, async(req, res) => {
    try {
        const { billId } = req.body;
        const userId = req.userId; // userId extraído del token JWT

        // Realiza la lógica necesaria para cancelar la compra y modificar la tabla 'bills' aquí.
        // Por ejemplo, puedes ejecutar una consulta SQL para actualizar el estado de la factura (marcarla como cancelada).
        const updateQuery = 'UPDATE bills SET status = 2 WHERE bill_id = ? AND owner_id = ?';

        db.query(updateQuery, [billId, userId], (error, results) => {
            if (error) {
                console.error('Error al actualizar la factura:', error);
                res.status(500).json({ success: false, message: 'Error al cancelar la compra' });
            } else {
                res.status(200).json({ success: true, message: 'Compra cancelada exitosamente' });
            }
        });
    } catch (error) {
        console.error('Error al cancelar la compra:', error);
        res.status(500).json({ success: false, message: 'Error al cancelar la compra' });
    }
});


app.post('/login', (req, res) => {
    const { username, password } = req.body;

    // Realiza una consulta a la base de datos para obtener los datos del usuario por nombre de usuario
    const query = 'SELECT * FROM users WHERE username = ? AND status_user = 1';
    db.query(query, [username], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(401).json({ message: 'Usuario no encontrado' });
        }

        const user = results[0];

        // Compara el hash SHA-256 generado con el hash almacenado en la base de datos
        if (password !== user.password) {
            return res.status(401).json({ message: 'Contraseña incorrecta' });
        }

        const token = jwt.sign({ userId: user.user_id }, secretKey, { expiresIn: '24h' });
        console.log(token);
        res.json({ token });
    });
});

function pagarBonoDirecto(idReferente, precioPaquete) {
    // Calcula el monto del bono (10% del precio del paquete)
    const montoBono = precioPaquete * 0.10;

    // Consulta SQL para insertar el depósito en la tabla "deposits"
    const sql = "INSERT INTO deposits (mount, bonus_id, user_id, status) VALUES (?, ?, ?, ?)";
    // Ejecuta la consulta
    db.query(sql, [montoBono, 2, idReferente, 1], (error, results, fields) => {
        if (error) {
            console.log("Error al agregar el depósito:", error);
        } else {
            console.log("Depósito agregado con éxito.");
        }
    });
}

app.post('/api/purchasePlan', verifyToken, async(req, res) => {
    const userId = req.userId; // Obtiene el userId del token JWT
    const { selectedPlan } = req.body;

    // Construct the data to send to NowPayments API
    const nowPaymentsData = {
        price_amount: selectedPlan.price, // Use the selected plan's price
        price_currency: 'usd', // The currency in which to make the payment
        pay_currency: 'btc', // Use 'usd' as the payment currency
        ipn_callback_url: "http://45.32.162.155:3003/api/ipn",
        order_id: "RGDBP-21314",
    };

    try {
        // Make a request to NowPayments API to obtain the pay_address
        const response = await axios.post('https://api.nowpayments.io/v1/payment', nowPaymentsData, {
            headers: {
                'x-api-key': '2T7GC59-FXJ4GJH-QF9STCM-H94DMSK', // Replace with your NowPayments API key
            },
        });


        const nowPaymentsResponse = response.data;

        // Create a record in the database for the payment
        const paymentRecord = {
            id_pack: selectedPlan.pack_id, // Use the selected plan's ID
            owner_id: userId, // Assuming 'id' is the unique identifier for users
            status: 1, // Assuming 1 represents 'active' status
            date_buyed: new Date(), // Assuming the current date for the purchase
            pay_address: "TFkjL3zDeTSK4Sh8hzpib8syDLrSBKYpS3" //nowPaymentsResponse.pay_address, // Store the pay_address from NowPayments
        };

        // Execute the database query to insert the payment record
        // Replace 'connection' with your actual MySQL database connection
        db.query('INSERT INTO bills SET ?', paymentRecord, (err, result) => {
            if (err) {
                res.json({ success: false, message: 'Error al procesar el pago' });
                console.error('Error inserting payment record:', err);
            } else {
                console.log('Payment record inserted successfully');

                db.query('SELECT directo FROM users WHERE user_id = ?', [userId], (error, results, fields) => {
                    if (error) {
                        console.log("Error al obtener el referente:", error);
                        res.json({ success: false, message: 'Error al obtener el referente' });
                    } else {
                        const referenteId = results[0].directo;

                        // Llama a la función pagarBonoDirecto para pagar el bono al referente
                        // pagarBonoDirecto(referenteId, selectedPlan.price);

                        // ... (Resto del código para responder al cliente)
                    }
                });

                res.json({ success: true, message: 'Compra exitosa' });
            }
        });

    } catch (error) {
        res.json({ success: false, message: 'Error al realizar la solicitud a NowPayments' });
        console.error('Error making request to NowPayments:', error);
    }
});

app.get("/api/bills", verifyToken, async(req, res) => {

    const userId = req.userId; // Obtiene el userId del token JWT

    const query = 'SELECT * FROM bills JOIN packs ON bills.id_pack = packs.pack_id WHERE bills.owner_id = ? AND bills.status = 1';
    db.query(query, userId, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        res.json(results);
    });
});


app.post("/api/users", async(req, res) => {
    // Aquí puedes acceder a req.userId para obtener el user_id
    const query = 'SELECT * FROM users';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        res.json(results);
    });
});

app.post("/api/plans", verifyToken, async(req, res) => {
    const query = 'SELECT * FROM packs';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'Wallets no encontradas' });
        }

        res.json(results);
    });
});

app.put('/api/users/:userId', (req, res) => {
    const { userId } = req.params; // Obtiene el ID del usuario de los parámetros de la URL
    const { firstName, username, email, referrer, status } = req.body; // Obtiene los nuevos datos del usuario del cuerpo de la solicitud

    // Verifica si el usuario ya existe en la base de datos
    const checkUserSql = 'SELECT * FROM users WHERE user_id = ?';
    db.query(checkUserSql, [userId], (checkErr, checkResult) => {
        if (checkErr) {
            console.error('Error al verificar el usuario:', checkErr);
            res.status(500).json({ error: 'Error al verificar el usuario' });
            return;
        }

        if (checkResult.length === 0) {
            // Si el usuario no existe, realiza una operación de inserción
            const insertUserSql = 'INSERT INTO users (firstName, username, email, referrer, status_user) VALUES (?, ?, ?, ?, ?)';
            db.query(insertUserSql, [firstName, username, email, referrer, status], (insertErr, insertResult) => {
                if (insertErr) {
                    console.error('Error al insertar el usuario:', insertErr);
                    res.status(500).json({ error: 'Error al insertar el usuario' });
                    return;
                }

                if (insertResult.affectedRows === 1) {
                    res.json({ message: 'Usuario agregado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al agregar el usuario' });
                }
            });
        } else {
            // Si el usuario ya existe, realiza una operación de actualización
            const updateSql = 'UPDATE users SET firstName = ?, username = ?, email = ?, referrer = ?, status_user = ? WHERE user_id = ?';
            db.query(updateSql, [firstName, username, email, referrer, status, userId], (updateErr, updateResult) => {
                if (updateErr) {
                    console.log('Error al actualizar el usuario:', updateErr);
                    res.status(500).json({ error: 'Error al actualizar el usuario' });
                    return;
                }

                if (updateResult.affectedRows === 1) {
                    res.json({ message: 'Usuario actualizado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al actualizar el usuario' });
                    console.log('Error al actualizar el usuario');
                }
            });
        }
    });
});









// Obtener todos los packs ordenados por la columna 'posicion'
app.post("/api/ranks", async(req, res) => {
    const query = 'SELECT * FROM rangos ORDER BY posicion ASC';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        res.json(results);
    });
});


// Agregar o actualizar un pack
app.put('/api/ranks/:rankId', (req, res) => {
    const { rankId } = req.params; // Obtiene el ID del pack de los parámetros de la URL
    const { rango_nombre, puntos, estado, imagen, puntos_inicio, puntos_final } = req.body; // Obtiene los nuevos datos del pack del cuerpo de la solicitud

    // Verifica si el pack ya existe en la base de datos
    const checkPackSql = 'SELECT * FROM rangos WHERE rango_id = ?';
    db.query(checkPackSql, [rankId], (checkErr, checkResult) => {
        if (checkErr) {
            console.error('Error al verificar el rango:', checkErr);
            res.status(500).json({ error: 'Error al verificar el rango' });
            return;
        }

        if (checkResult.length === 0) {
            // Si el pack no existe, realiza una operación de inserción
            // Si el retiro no existe, realiza una operación de inserción
            const insertRetiroSql = 'INSERT INTO rangos (puntos, estado, imagen, puntos_inicio, puntos_final, rango_nombre) VALUES (?, ?, ?, ?, ?, ?)';
            db.query(insertRetiroSql, [puntos, estado, imagen, puntos_inicio, puntos_final, rango_nombre], (insertErr, insertResult) => {
                if (insertErr) {
                    console.error('Error al insertar el rango:', insertErr);
                    res.status(500).json({ error: 'Error al insertar el rango' });
                    return;
                }

                if (insertResult.affectedRows === 1) {
                    // Después de insertar el rango, obtén el ID generado automáticamente
                    const newRangoId = insertResult.insertId;

                    // Devuelve el ID en la respuesta JSON al cliente
                    res.json({ message: 'Rango agregado con éxito', newRangoId });
                } else {
                    res.status(500).json({ error: 'Error al agregar el retiro' });
                }
            });
        } else {
            // Si el pack ya existe, realiza una operación de actualización
            const updateSql = 'UPDATE rangos SET rango_nombre = ?, puntos = ?, estado = ?, imagen = ?, puntos_inicio = ?, puntos_final = ? WHERE rango_id = ?';
            db.query(updateSql, [rango_nombre, puntos, estado, imagen, puntos_inicio, puntos_final, rankId], (updateErr, updateResult) => {
                if (updateErr) {
                    console.error('Error al actualizar el rango:', updateErr);
                    res.status(500).json({ error: 'Error al actualizar el rango' });
                    return;
                }

                if (updateResult.affectedRows === 1) {
                    res.json({ message: 'Rango actualizado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al actualizar el rango' });
                }
            });
        }
    });
});











app.get('/api/datos/:userId', (req, res) => {
    // Realiza consultas SQL para obtener los datos necesarios
    const userID = req.params.userId; // Captura el userID de la URL

    const consultas = [
        `SELECT SUM(mount) as totalROI FROM deposits WHERE bonus_id = 1 AND user_id = ${userID}`,
        `SELECT SUM(mount) as totalDirecto FROM deposits WHERE bonus_id = 2 AND user_id = ${userID}`,
        `SELECT SUM(mount) as totalBinario FROM deposits WHERE bonus_id = 3 AND user_id = ${userID}`,
        `SELECT SUM(packs.price) as totalMembresias FROM bills
    JOIN packs ON bills.id_pack = packs.pack_id
    WHERE bills.owner_id = ${userID} AND bills.status = 3`,
        `SELECT SUM(mount) as totalGanancias FROM deposits WHERE user_id = ${userID}`,
        `SELECT COUNT(*) as totalVouchers FROM bills WHERE bills.owner_id = ${userID} AND bills.voucher = 2`, // Consulta para verificar si el usuario tiene un paquete con voucher = 2
    ];

    const resultados = {};

    Promise.all(consultas.map(consulta => {
            return new Promise((resolve, reject) => {
                db.query(consulta, (err, result) => {
                    if (err) {
                        reject(err);
                    } else {
                        resolve(result[0]);
                    }
                });
            });
        }))
        .then(results => {
            resultados.totalROI = results[0].totalROI;
            resultados.totalDirecto = results[1].totalDirecto;
            resultados.totalBinario = results[2].totalBinario;
            resultados.totalMembresias = results[3].totalMembresias;
            resultados.totalGanancias = results[4].totalGanancias;
            resultados.totalVouchers = results[5].totalVouchers;
            res.json(resultados);
        })
        .catch(error => {
            console.error('Error al obtener datos:', error);
            res.status(500).json({ message: 'Error al obtener los datos.' });
        });
});



// Configura una ruta para obtener los datos de la tabla "rangos"
app.get("/api/rangos", (req, res) => {
    const sql = "SELECT * FROM rangos"; // Reemplaza "rangos" con el nombre de tu tabla
    db.query(sql, (err, result) => {
        if (err) {
            console.error("Error al obtener los datos de rangos:", err);
            res.status(500).json({ error: "Error al obtener los datos de rangos" });
        } else {
            res.json(result);
        }
    });
});





// Obtener todos los packs
app.post("/api/packs", async(req, res) => {
    const query = 'SELECT * FROM packs';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        res.json(results);
    });
});





// Agregar o actualizar un pack
app.put('/api/packs/:packId', (req, res) => {
    const { packId } = req.params; // Obtiene el ID del pack de los parámetros de la URL
    const { description, price, roi, months, image_url } = req.body; // Obtiene los nuevos datos del pack del cuerpo de la solicitud

    // Verifica si el pack ya existe en la base de datos
    const checkPackSql = 'SELECT * FROM packs WHERE pack_id = ?';
    db.query(checkPackSql, [packId], (checkErr, checkResult) => {
        if (checkErr) {
            console.error('Error al verificar el pack:', checkErr);
            res.status(500).json({ error: 'Error al verificar el pack' });
            return;
        }

        if (checkResult.length === 0) {
            // Si el pack no existe, realiza una operación de inserción
            const insertPackSql = 'INSERT INTO packs (description, price, roi, months, pack_imagen) VALUES (?, ?, ?, ?, ?)';
            db.query(insertPackSql, [description, price, roi, months, image_url], (insertErr, insertResult) => {
                if (insertErr) {
                    console.error('Error al insertar el pack:', insertErr);
                    res.status(500).json({ error: 'Error al insertar el pack' });
                    return;
                }

                if (insertResult.affectedRows === 1) {
                    res.json({ message: 'Pack agregado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al agregar el pack' });
                }
            });
        } else {
            // Si el pack ya existe, realiza una operación de actualización
            const updateSql = 'UPDATE packs SET description = ?, price = ?, roi = ?, months = ?, pack_imagen = ? WHERE pack_id = ?';
            db.query(updateSql, [description, price, roi, months, image_url, packId], (updateErr, updateResult) => {
                if (updateErr) {
                    console.error('Error al actualizar el pack:', updateErr);
                    res.status(500).json({ error: 'Error al actualizar el pack' });
                    return;
                }

                if (updateResult.affectedRows === 1) {
                    res.json({ message: 'Pack actualizado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al actualizar el pack' });
                }
            });
        }
    });
});






// Obtener todos los retiros
app.post("/api/retiros", async(req, res) => {
    const query = 'SELECT * FROM withdrawals JOIN users ON users.user_id = withdrawals.user_id';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        res.json(results);
    });
});

// Agregar o actualizar un retiro
app.put('/api/retiros/:retiroId', (req, res) => {
    const { retiroId } = req.params; // Obtiene el ID del retiro de los parámetros de la URL
    const { user_id, total, date, wallet, status } = req.body; // Obtiene los nuevos datos del retiro del cuerpo de la solicitud

    // Verifica si el retiro ya existe en la base de datos
    const checkRetiroSql = 'SELECT * FROM withdrawals WHERE withdrawal_id = ?';
    db.query(checkRetiroSql, [retiroId], (checkErr, checkResult) => {
        if (checkErr) {
            console.error('Error al verificar el retiro:', checkErr);
            res.status(500).json({ error: 'Error al verificar el retiro' });
            return;
        }

        if (checkResult.length === 0) {
            // Si el retiro no existe, realiza una operación de inserción
            const insertRetiroSql = 'INSERT INTO withdrawals (user_id, total, date, wallet, status) VALUES (?, ?, ?, ?, ?)';
            db.query(insertRetiroSql, [user_id, total, date, wallet, status], (insertErr, insertResult) => {
                if (insertErr) {
                    console.error('Error al insertar el retiro:', insertErr);
                    res.status(500).json({ error: 'Error al insertar el retiro' });
                    return;
                }

                if (insertResult.affectedRows === 1) {
                    res.json({ message: 'Retiro agregado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al agregar el retiro' });
                }
            });
        } else {
            // Si el retiro ya existe, realiza una operación de actualización
            const updateSql = 'UPDATE withdrawals SET user_id = ?, total = ?, date = ?, wallet = ?, status = ? WHERE withdrawal_id = ?';
            db.query(updateSql, [user_id, total, date, wallet, status, retiroId], (updateErr, updateResult) => {
                if (updateErr) {
                    console.error('Error al actualizar el retiro:', updateErr);
                    res.status(500).json({ error: 'Error al actualizar el retiro' });
                    return;
                }

                if (updateResult.affectedRows === 1) {
                    res.json({ message: 'Retiro actualizado con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al actualizar el retiro' });
                }
            });
        }
    });
});




// Obtener todas las facturas
app.post("/api/bills", async(req, res) => {
    const query = 'SELECT * FROM bills JOIN users ON users.user_id = bills.owner_id JOIN packs ON packs.pack_id = bills.id_pack';
    db.query(query, (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        res.json(results);
    });
});

// Agregar o actualizar una factura
app.put('/api/bills/:billId', (req, res) => {
    const { billId } = req.params; // Obtiene el ID de la factura de los parámetros de la URL
    const { id_pack, owner_id, status, voucher } = req.body; // Obtiene los nuevos datos de la factura del cuerpo de la solicitud

    // Verifica si la factura ya existe en la base de datos
    const checkBillSql = 'SELECT * FROM bills WHERE bill_id = ?';
    db.query(checkBillSql, [billId], (checkErr, checkResult) => {
        if (checkErr) {
            console.error('Error al verificar la factura:', checkErr);
            res.status(500).json({ error: 'Error al verificar la factura' });
            return;
        }

        if (checkResult.length === 0) {
            // Si la factura no existe, realiza una operación de inserción
            const insertBillSql = 'INSERT INTO bills (id_pack, owner_id, status, voucher) VALUES (?, ?, ?, ?, ?)';
            db.query(insertBillSql, [id_pack, owner_id, status, voucher], (insertErr, insertResult) => {
                if (insertErr) {
                    console.error('Error al insertar la factura:', insertErr);
                    res.status(500).json({ error: 'Error al insertar la factura' });
                    return;
                }

                if (insertResult.affectedRows === 1) {
                    res.json({ message: 'Factura agregada con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al agregar la factura' });
                }
            });
        } else {
            // Si la factura ya existe, realiza una operación de actualización
            const updateSql = 'UPDATE bills SET id_pack = ?, owner_id = ?, status = ?, voucher = ? WHERE bill_id = ?';
            db.query(updateSql, [id_pack, owner_id, status, voucher, billId], (updateErr, updateResult) => {
                if (updateErr) {
                    console.error('Error al actualizar la factura:', updateErr);
                    res.status(500).json({ error: 'Error al actualizar la factura' });
                    return;
                }

                if (updateResult.affectedRows === 1) {
                    res.json({ message: 'Factura actualizada con éxito' });
                } else {
                    res.status(500).json({ error: 'Error al actualizar la factura' });
                }
            });
        }
    });
});






















app.get("/api/getBillData", async(req, res) => {
    // Aquí puedes acceder a req.userId para obtener el user_id
    const userId = req.userId;

    const query = 'SELECT * FROM bills JOIN users ON bills.owner_id = users.user_id JOIN packs ON bills.id_pack = packs.pack_id ORDER BY bills.bill_id DESC';
    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'No hay informacion' });
        }

        res.json(results);
    });
});



// Function to find the referring user in bills.user_id and pay the direct bonus
function findAndPayDirectBonus(billId) {
    // Retrieve the user_id from the bills table
    const getUserIDSQL = "SELECT * FROM bills JOIN packs ON bills.id_pack = packs.pack_id WHERE bills.bill_id = ?";
    db.query(getUserIDSQL, [billId], (error, results) => {
        if (error) {
            console.error("Error al obtener el user_id del paquete:", error);
            // Handle the error appropriately
        } else {
            const userId = results[0].owner_id;
            const pricePack = results[0].price;

            // Now that you have the user_id, find the directo user from the users table
            const findDirectoSQL = "SELECT directo FROM users WHERE user_id = ?";
            db.query(findDirectoSQL, [userId], (error, results) => {
                if (error) {
                    console.error("Error al obtener el referente directo:", error);
                    // Handle the error appropriately
                } else {
                    const referenteId = results[0].directo;

                    pagarBonoDirecto(referenteId, pricePack);

                }
            });
        }
    });
}





app.post("/api/activatePackage", (req, res) => {
    const { billId, type } = req.body;

    // Obtiene la fecha actual en formato MySQL (YYYY-MM-DD HH:MM:SS)
    const fechaActivacion = new Date().toISOString().slice(0, 19).replace("T", " ");

    // Actualiza el estado del paquete a 3 (Completado) y establece la fecha de activación
    const sql = "UPDATE bills SET status = 3, fecha_activacion = ?, voucher = ? WHERE bill_id = ?";

    db.query(sql, [fechaActivacion, type, billId], (err, result) => {
        if (err) {
            console.error("Error al activar el paquete:", err);
            res.json({ status: false, message: "Error al activar el paquete" });
        } else {
            console.log("Paquete activado con éxito");

            if (type == 1) {
                findAndPayDirectBonus(billId);
                res.json({ status: true, message: "Paquete activado con éxito y pago bono directo." });
            } else {
                res.json({ status: true, message: "Paquete activado con éxito, sin bono directo." });
            }

        }
    });
});



app.post("/api/rejectPackage", (req, res) => {
    const { billId } = req.body;

    // Actualiza el estado del paquete a 3 (Completado) en la base de datos
    const sql = "UPDATE bills SET status = 2 WHERE bill_id = ?";

    db.query(sql, [billId], (err, result) => {
        if (err) {
            console.error("Error al activar el paquete:", err);
            res.json({ status: false, message: "Error al activar el paquete" });
        } else {
            console.log("Paquete activado con éxito");
            res.json({ status: true, message: "Paquete rechazado con éxito" });
        }
    });
});







// Ruta para obtener los retiros
app.post("/api/wallets", verifyToken, async(req, res) => {
    // Aquí puedes acceder a req.userId para obtener el user_id
    const userId = req.userId;

    const query = 'SELECT * FROM wallets WHERE user_id = ?';
    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'Wallets no encontradas' });
        }

        res.json(results);
    });
});



app.post("/api/deposits", verifyToken, async(req, res) => {
    // Aquí puedes acceder a req.userId para obtener el user_id
    const userId = req.userId;

    const query = 'SELECT * FROM deposits WHERE user_id = ?';
    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'Wallets no encontradas' });
        }

        res.json(results);
    });
});

app.post("/api/memberships", verifyToken, async(req, res) => {
    // Aquí puedes acceder a req.userId para obtener el user_id
    const userId = req.userId;

    const query = 'SELECT * FROM bills JOIN packs ON packs.pack_id = bills.id_pack WHERE owner_id = ?';
    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'No hay informacion' });
        }

        res.json(results);
    });
});

app.post("/api/withdrawals", verifyToken, async(req, res) => {
    // Aquí puedes acceder a req.userId para obtener el user_id
    const userId = req.userId;

    const query = 'SELECT * FROM withdrawals JOIN wallets ON wallets.wallet_id = withdrawals.wallet WHERE withdrawals.user_id = ?';
    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'No hay informacion' });
        }

        res.json(results);
    });
});


// Función para verificar el código de Google Authenticator
function verifyGoogleAuthenticatorCode(secretBase32, code) {
    const verified = speakeasy.totp.verify({
        secret: secretBase32,
        encoding: "base32",
        token: code,
    });

    return verified;
}

// Ruta para guardar una nueva wallet con autenticación de Google Authenticator
app.post("/api/add_wallet", verifyToken, (req, res) => {
    const user_id = req.userId;
    const { name, wallet, code } = req.body;
    const secretBase32 = "IBZVIKD3OURVEWDGGVTVIP2QMNKDK3LXOF6XG32VJZEEC6BFFQ2A";

    // Verifica el código de Google Authenticator utilizando la función
    const isVerified = verifyGoogleAuthenticatorCode(secretBase32, code);

    //if (!isVerified) {
    //  return res.json({ status: false, message: "Código de Google Authenticator incorrecto" });
    //}

    // Si el código es correcto, aquí puedes proceder a guardar la wallet
    const sql = "INSERT INTO wallets (user_id, label, wallet_name) VALUES (?, ?, ?)";
    const values = [user_id, name, wallet];

    db.query(sql, values, (err, result) => {
        if (err) {
            res.json({ status: false, message: "The wallet could not be added to your account" });
            console.error("Error al insertar la wallet:", err);
            throw err;
        }
        res.json({ status: true, message: "Billetera creada exitosamente!" });
    });
});



// Ruta protegida
app.get('/protected', verifyToken, (req, res) => {
    res.json({ message: 'Esta es una ruta protegida' });
});

function verifyToken(req, res, next) {
    const token = req.headers.authorization;

    if (!token) {
        return res.status(403).json({ message: 'Token no proporcionado' });
    }

    jwt.verify(token, secretKey, (err, decoded) => {
        if (err) {
            return res.status(401).json({ message: 'Token inválido' });
        }

        req.userId = decoded.userId;
        next();
    });
}

// Ruta protegida
app.get('/', verifyToken, (req, res) => {
    // Si el token es válido, se permite el acceso al dashboard
    res.json({ message: 'Bienvenido al dashboard' });
});

// Endpoint protegido para obtener la información del usuario basado en el token JWT
app.get('/user', verifyToken, (req, res) => {
    const userId = req.userId; // Obtiene el userId del token JWT

    // Realiza una consulta a la base de datos para obtener los datos del usuario por su ID
    const query = 'SELECT * FROM users WHERE user_id = ?';
    db.query(query, [userId], (err, results) => {
        if (err) {
            console.error('Error al realizar la consulta:', err);
            return res.status(500).json({ message: 'Error en la base de datos' });
        }

        if (results.length === 0) {
            return res.status(404).json({ message: 'Usuario no encontrado' });
        }

        const user = results[0];

        // No envíes la contraseña en la respuesta
        delete user.password;

        res.json(user);
    });
});

async function obtenerArbolBinario(idUsuario, totalUsuariosConPaquetes, posicionPadre) {
    const queryUsuarios = `SELECT * FROM users WHERE referrer = ?`;
    const queryBills = `SELECT b.*, p.* FROM bills AS b INNER JOIN packs AS p ON b.id_pack = p.pack_id WHERE b.owner_id = ? AND b.status = 3
    `; // Realizamos un JOIN con la tabla packs para obtener el precio

    return new Promise((resolve, reject) => {
        db.query(queryUsuarios, [idUsuario], async(error, resultsUsuarios) => {
            if (error) {
                reject(error);
                return;
            }

            const tree = {
                usuarios: [],
                paquetesTotales: 0,
                totalPaquetes: 0,
                totalCostoPaquetesIzquierdo: 0, // Inicializar totalCostoPaquetesIzquierdo
                totalCostoPaquetesDerecho: 0, // Inicializar totalCostoPaquetesDerecho
                totalPaquetesIzquierdo: 0,
                totalPaquetesDerecho: 0,
                totalUsuariosConPaquetesIzquierdo: 0,
                totalUsuariosConPaquetesDerecho: 0,
                usuariosConPaquetes: 0, // Inicializar usuariosConPaquetes
            };

            if (resultsUsuarios.length > 0) {
                for (const row of resultsUsuarios) {
                    const usuario = {
                        name: row.username,
                        user_id: row.user_id,
                        position: row.position,
                        referrer: row.referrer,
                    };


                    const piernaUsuario = (usuario.position === 1) ? 'izquierda' : 'derecha';

                    // Verifica si el usuario actual tiene referidos en su pierna
                    if (piernaUsuario === posicionPadre) {
                        totalUsuariosConPaquetes[piernaUsuario] += 1;
                    }

                    // Consulta las facturas (bills) del usuario actual y obtén el precio del paquete
                    const resultsBills = await new Promise((resolveBills, rejectBills) => {
                        db.query(queryBills, [row.user_id], (errorBills, resultsBills) => {
                            if (errorBills) {
                                rejectBills(errorBills);
                                return;
                            }
                            resolveBills(resultsBills);
                        });
                    });

                    // Calcula el total de paquetes adquiridos y el costo total de los paquetes
                    let paquetesAdquiridos = 0;
                    let costoPaquetes = 0;
                    let packDescription = ''; // Inicializa la descripción del paquete

                    resultsBills.forEach((bill) => {
                        paquetesAdquiridos += 1; // Cada factura representa un paquete adquirido
                        costoPaquetes += bill.price;
                        packDescription = bill.description; // Obtiene la descripción del paquete

                    });

                    usuario.paquetesAdquiridos = paquetesAdquiridos;
                    usuario.costoPaquetes = costoPaquetes;
                    usuario.packDescription = packDescription; // Agrega la descripción del paquete al usuario

                    // Recupera los referidos del usuario actual de forma recursiva
                    const subarbolReferidos = await obtenerArbolBinario(row.user_id, totalUsuariosConPaquetes, piernaUsuario);

                    if (subarbolReferidos.usuarios.length > 0) {
                        usuario.referidos = subarbolReferidos.usuarios;
                        // Suma los paquetes adquiridos de los referidos de esta posición
                        paquetesAdquiridos += subarbolReferidos.paquetesTotales;
                        costoPaquetes += subarbolReferidos.totalPaquetes;

                        if (paquetesAdquiridos > 0) {
                            if (usuario.position === 1) {
                                totalUsuariosConPaquetes.izquierda += 1;
                            } else if (usuario.position === 2) {
                                totalUsuariosConPaquetes.derecha += 1;
                            }
                        }
                    }

                    tree.usuarios.push(usuario);

                    // Suma el total de paquetes adquiridos y el costo de los paquetes al total del árbol
                    tree.paquetesTotales += paquetesAdquiridos;
                    tree.totalPaquetes += costoPaquetes;


                    // Si el usuario actual tiene referidos en su pierna, actualiza el total de usuarios en esa pierna
                    if (piernaUsuario === posicionPadre) {
                        totalUsuariosConPaquetes[piernaUsuario] += subarbolReferidos.totalUsuariosConPaquetes;
                    }

                    // Actualiza totalCostoPaquetesIzquierdo o totalCostoPaquetesDerecho según la posición
                    if (usuario.position === 1) {
                        tree.totalCostoPaquetesIzquierdo += costoPaquetes;
                        tree.totalPaquetesIzquierdo += paquetesAdquiridos;
                        tree.totalUsuariosConPaquetesIzquierdo += 1;
                    } else if (usuario.position === 2) {
                        tree.totalCostoPaquetesDerecho += costoPaquetes;
                        tree.totalPaquetesDerecho += paquetesAdquiridos;
                        tree.totalUsuariosConPaquetesDerecho += 1;
                    }
                }
            }

            // Actualiza la cantidad de usuarios con paquetes en el árbol completo
            totalUsuariosConPaquetes += tree.usuariosConPaquetes;

            // Si se llegó al usuario raíz, resuelve la promesa con los resultados completos
            if (idUsuario) {
                tree.totalUsuariosConPaquetes = totalUsuariosConPaquetes;
                resolve(tree);
            } else {
                resolve(tree); // Resuelve el resultado parcial para los nodos intermedios
            }
        });
    });
}


// Define una ruta para manejar la solicitud GET del árbol binario
app.get('/arbol/:idUsuario', async(req, res) => {
    const idUsuario = req.params.idUsuario;

    try {
        // Llama a la función recursiva para obtener el árbol binario del usuario
        const arbolCompleto = await obtenerArbolBinario(idUsuario, 0);

        res.json(arbolCompleto);
    } catch (error) {
        console.error('Error al obtener el árbol binario:', error);
        res.status(500).json({ error: 'Error al obtener el árbol binario' });
    }
});

app.post("/pos_change", (req, res) => {
    const { userId, newPosition } = req.body;

    // Ejecuta una consulta SQL para actualizar la posición del usuario
    const sql = "UPDATE users SET lado = ? WHERE user_id = ?";

    db.query(sql, [newPosition, userId], (err, result) => {
        if (err) {
            console.error("Error al actualizar la posición del usuario: " + err.message);
            res.status(500).json({ error: "Error al actualizar la posición del usuario" });
        } else {
            console.log("Posición actualizada con éxito");
            res.json({ message: "Posición actualizada con éxito" });
        }
    });
});


async function findLastReferido(userId, position) {
    return new Promise((resolve, reject) => {
        // Consultar si el usuario actual tiene un referido en la posición dada
        const getLastReferidoQuery = 'SELECT MAX(user_id) AS lastReferidoId FROM users WHERE referrer = ? AND position = ?';
        db.query(getLastReferidoQuery, [userId, position], async(err, lastReferidoResult) => {
            if (err) {
                console.error('Error al obtener el último referido del usuario:', err);
                reject(err);
                return;
            }

            if (lastReferidoResult.length === 0 || lastReferidoResult[0].lastReferidoId === null) {
                // No hay referido en la posición actual o el resultado es nulo,
                // detener la recursión y devolver el userId actual
                resolve(userId);
                return;
            }

            // Obtener el último referido de la consulta
            const lastReferidoId = lastReferidoResult[0].lastReferidoId;

            // Llamar recursivamente a la función para el último referido actual
            try {
                const result = await findLastReferido(lastReferidoId, position);
                resolve(result);
            } catch (error) {
                reject(error);
            }
        });
    });
}


// Ruta para el registro de usuarios
app.post("/api/signup", async(req, res) => {
    const { username, email, referrer, firstName, lastName, password, confirmPassword } = req.body;


    // Verifica si es un correo electrónico válido
    const emailRegex = /^[A-Za-z0-9._%+-]+@[A-Za-z0-9.-]+\.[A-Za-z]{2,}$/;
    if (!emailRegex.test(email)) {
        return res.status(400).json({ message: 'Por favor, ingresa una dirección de correo electrónico válida.' });
    }

    // Verifica que la contraseña tenga al menos 6 caracteres
    if (password.length < 6) {
        return res.status(400).json({ message: 'La contraseña debe tener al menos 6 caracteres.' });
    }
    // Verifica si el usuario ya existe en la base de datos
    const checkUserQuery = 'SELECT * FROM users WHERE username = ? OR email = ?';
    db.query(checkUserQuery, [username, email], async(err, results) => {
        if (err) {
            console.error('Error al verificar el usuario:', err);
            return res.status(500).json({ message: 'Error interno del servidor.' });
        }

        if (results.length > 0) {
            return res.status(400).json({ message: 'Usuario o correo ya existe.' });
        }

        // Verifica que las contraseñas coincidan
        if (password !== confirmPassword) {
            return res.status(400).json({ message: 'Las contraseñas no coinciden.' });
        }

        try {
            // Obtener el 'lado' del 'referrer' para determinar la posición
            const getLadoQuery = 'SELECT * FROM users WHERE username = ?';
            db.query(getLadoQuery, [referrer], async(err, ladoResult) => {
                if (err) {
                    console.error('Error al obtener el lado del referrer:', err);
                    return res.status(500).json({ message: 'Error interno del servidor.' });
                }

                let referrerId = null; // Valor predeterminado si no se encuentra el referrer
                let position = null; // Valor predeterminado si no se encuentra el 'lado'

                if (ladoResult.length > 0) {
                    position = ladoResult[0].lado;
                    referrerId = ladoResult[0].user_id;
                }

                // Encontrar el último referido disponible en la posición dada
                const lastReferidoId = await findLastReferido(referrerId, position);

                // Insertar un nuevo usuario en la base de datos con la posición determinada
                const insertUserQuery = 'INSERT INTO users (username, email, referrer, firstName, lastName, password, position, directo) VALUES (?, ?, ?, ?, ?, ?, ?, ?)';
                db.query(insertUserQuery, [username, email, lastReferidoId, firstName, lastName, password, position, referrerId], (err, result) => {
                    if (err) {
                        console.error('Error al insertar el usuario:', err);
                        return res.status(500).json({ message: 'Error interno del servidor.' });
                    }

                    res.status(200).json({ message: 'Registro exitoso.' });
                });
            });
        } catch (error) {
            console.error('Error al cifrar la contraseña:', error);
            res.status(500).json({ message: 'Error al procesar la contraseña.' });
        }
    });
});

// Ruta POST para eliminar una billetera por su ID
app.post('/api/eliminarBilletera', verifyToken, (req, res) => {
    const user_id = req.userId;
    const { walletId } = req.body;

    const query = 'DELETE FROM wallets WHERE wallet_id = ? AND user_id = ?';

    db.query(query, [walletId, user_id], (error, results) => {
        if (error) {
            console.error('Error al eliminar la billetera: ' + error.message);
            res.json({ status: false, message: 'Error al eliminar la billetera' });
            return;
        }

        if (results.affectedRows === 0) {
            console.log('La billetera no fue encontrada');
            res.json({ status: false, message: 'La billetera no fue encontrada' });
            return;
        }

        console.log('Billetera eliminada correctamente');
        res.json({ status: true, message: 'Billetera eliminada correctamente' });
    });
});



// Ruta para cambiar la contraseña
app.post('/api/cambiar-contrasena/', verifyToken, (req, res) => {
    const userId = req.userId;
    const { oldpassword, newpassword, confirmpassword } = req.body;

    // Verificar el token
    const token = req.headers.authorization;

    // Verificar que las contraseñas coincidan
    if (newpassword !== confirmpassword) {
        return res.json({ status: false, message: 'Las contraseñas no coinciden' });
    }

    // Obtener la contraseña actual del usuario desde la base de datos
    const getPasswordQuery = 'SELECT password FROM users WHERE user_id = ?';

    db.query(getPasswordQuery, [userId], async(err, results) => {
        if (err) {
            console.error('Error al obtener la contraseña actual:', err);
            return res.json({ status: false, message: 'Error al verificar la contraseña actual' });
        }

        if (results.length === 0) {
            return res.json({ status: false, message: 'Usuario no encontrado' });
        }

        const storedPassword = results[0].password;

        // Verificar si la contraseña antigua coincide
        if (storedPassword !== oldpassword) {
            return res.json({ status: false, message: 'La contraseña antigua es incorrecta' });
        }

        // Actualizar la contraseña en la base de datos
        const updatePasswordQuery = 'UPDATE users SET password = ? WHERE user_id = ?';

        db.query(updatePasswordQuery, [newpassword, userId], (updateErr, updateResult) => {
            if (updateErr) {
                console.error('Error al cambiar la contraseña:', updateErr);
                return res.json({ status: false, message: 'Error al cambiar la contraseña' });
            }

            return res.json({ status: true, message: 'Contraseña cambiada exitosamente' });
        });
    });
});

if (useSSL) {
    const httpsServer = https.createServer(credentials, app);

    httpsServer.listen(port, () => {
        console.log(`Servidor en ejecución en el puerto ${port}`);
    });
} else {
    app.listen(port, () => {
        console.log(`Servidor en ejecución en el puerto ${port}`);
    });
}