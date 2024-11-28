const express = require('express');
const bcrypt = require('bcrypt');
const jwt = require('jsonwebtoken');
const db = require('../db');
const router = express.Router();

// Registro de usuario
// Registro de usuario
router.post('/register', async (req, res) => {
    const { nombre_usuario, correo, contrasena } = req.body;
    try {
        const queryCheck = 'SELECT * FROM usuarios WHERE correo = ?';
        db.query(queryCheck, [correo], async (err, results) => {
            if (err) {
                console.error('Error al verificar el correo:', err); // Registro del error
                return res.status(500).json({ error: 'Error al verificar el correo.' });
            }

            if (results.length > 0) {
                return res.status(400).json({ error: 'El correo ya está registrado.' });
            }

            const hashedPassword = await bcrypt.hash(contrasena, 10);
            const query = 'INSERT INTO usuarios (nombre_usuario, correo, contrasena) VALUES (?, ?, ?)';
            db.query(query, [nombre_usuario, correo, hashedPassword], (err) => {
                if (err) {
                    console.error('Error al insertar el usuario:', err); // Registro del error
                    return res.status(500).json({ error: 'Error al registrar el usuario.' });
                }
                res.status(201).json({ message: 'Usuario registrado correctamente.' });
            });
        });
    } catch (error) {
        console.error('Error en el servidor:', error); // Registro del error
        res.status(500).json({ error: 'Error en el servidor.' });
    }
});



// Login de usuario
router.post('/login', async (req, res) => {
    const { correo, contrasena } = req.body;

    try {
        const query = 'SELECT * FROM usuarios WHERE correo = ?';
        db.query(query, [correo], async (err, results) => {
            if (err) {
                console.error('Error al buscar el usuario:', err);
                return res.status(500).json({ error: 'Error al buscar el usuario.' });
            }

            if (results.length === 0) {
                return res.status(400).json({ error: 'Correo o contraseña incorrectos.' });
            }

            const user = results[0];
            const isMatch = await bcrypt.compare(contrasena, user.contrasena);

            if (!isMatch) {
                return res.status(400).json({ error: 'Correo o contraseña incorrectos.' });
            }

            const token = jwt.sign(
                { id: user.id, correo: user.correo },
                process.env.JWT_SECRET,
                { expiresIn: '1h' }
            );

            res.status(200).json({
                message: 'Inicio de sesión exitoso.',
                token,
            });
        });
    } catch (error) {
        console.error('Error en el servidor:', error);
        res.status(500).json({ error: 'Error en el servidor.' });
    }
});

// Ruta para obtener los datos del usuario
router.get('/user', (req, res) => {
    const token = req.headers.authorization?.split(' ')[1];
    if (!token) {
        return res.status(401).json({ error: 'Token no proporcionado' });
    }

    jwt.verify(token, process.env.JWT_SECRET, (err, decoded) => {
        if (err) {
            return res.status(403).json({ error: 'Token inválido' });
        }

        // Cambié 'nombre' por 'nombre_usuario'
        const query = 'SELECT id, nombre_usuario, correo FROM usuarios WHERE id = ?';
        db.query(query, [decoded.id], (err, results) => {
            if (err || results.length === 0) {
                return res.status(404).json({ error: 'Usuario no encontrado' });
            }

            res.json({ usuario: results[0] });
        });
    });
});

 




module.exports = router;
