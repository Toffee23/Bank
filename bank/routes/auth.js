const router = require('express').Router();
const { json } = require('express');
const User = require('../models/Users'); 


//Register Api
/**
 * @swagger
 * /api/auth/register:
 *   post:
 *     summary: SignUp to the application
 *     tags:
 *       - Authentication
 *     requestBody:
 *       required: true
 *       content:
 *          application/json:
 *            schema:
 *              type: object
 *              properties:
 *                phone:
 *                  type: string
 *                email:
 *                  type: string
 *                password:
 *                  type: string      
 *     responses:
 *       200:
 *         description: Successful login   
 *       401:
 *         description: Invalid credentials
 */
router.post('/register', async (req, res) => {
    try {
        const newUser = new User({
            phone: req.body.phone,
            email: req.body.email,
            password: req.body.password
        });
        const user = await newUser.save();
        res.status(200).json(user)

    } catch (error) {
        res.status(400).json({message: 'duplicate datas in the databse'})
    }
});

//Login Api
/**
 * @swagger
 * /api/auth/login:
 *   post:
 *     summary: Login to the application
 *     tags:
 *       - Authentication
 *     requestBody:
 *       required: true
 *       content:
 *          application/json:
 *            schema:
 *              type: object
 *              properties:
 *                email:
 *                  type: string
 *                password:
 *                  type: string      
 *     responses:
 *       200:
 *         description: Successful login   
 *       401:
 *         description: Invalid credentials
 */
router.post('/login', async (req, res) => {
    const { email, password } = req.body;
    try {
        const user = await User.findOne({email})
        !user && res.status(400).json('wrong email')
        
        const userPass = await User.findOne({password})
        !userPass && res.status(422).json('Incorrect Password')

        res.status(200).json(user)
    } catch (error) {
        
    }
})

module.exports = router;