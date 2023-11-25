const express = require('express');
const mongoose = require('mongoose');
const authRoute = require('./routes/auth.js');
const depositWithdrawalRoute = require('./routes/deposit_withdraw.js');
const transferRoute = require('./routes/transfer.js');
const swaggerJsdoc = require('swagger-jsdoc');
const swaggerUi = require('swagger-ui-express');
require('dotenv').config();
const {MONGO_URI} = process.env;


const app = express();


const swaggerOptions = {
    swaggerDefinition: {
      openapi: '3.0.0',
      info: {
        title: 'Swagger Bank API',
        version: '1.0.0',
        description: 'A simple BankAPI system',
      },
      servers: [
        {
          url: 'https://bank-app01-f13d87348993.herokuapp.com',
          
        },
      ],
      components: {
        securitySchemas: {
          bearerAuth: {
            type: 'http',
            scheme: 'bearer',
            bearerFormat: 'JWT'
          }
        }
      },
      security: [
        {
          bearerAuth: []
        }
      ]
    },
    apis: ['./routes/*.js'],
  };

mongoose.connect('mongodb://localhost:27017',{
    useNewUrlParser: true,
    useUnifiedTopology: true,
}).then(() => console.log('Mongodb connection is successfull')).catch((err) => {
    console.log(err);
});


const swaggerSpec = swaggerJsdoc(swaggerOptions);

//All Apis goes here
app.use(express.json());
app.use('/docs', swaggerUi.serve, swaggerUi.setup(swaggerSpec));
app.use('/api/auth', authRoute);
app.use('/api/depoWith', depositWithdrawalRoute);
app.use('/api/transact', transferRoute);

// app.get('docs.json', swaggerUi.serve, swaggerUi.setup(swaggerSpec), (req,res) => {
  
//   // res.status(200).json('Welcome to my banking system')
//   res.setHeader('Content-Type', 'application/json');
//   res.send(swaggerSpec)
// })




const port = process.env.PORT || 5000;
app.listen(port, ()=>{
    console.log(`server running on PORT ${port}`);
})