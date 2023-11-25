const mongoose = require('mongoose');
const User = require('../models/Users');

const depositWithdrawalSchema = new mongoose.Schema({
  phoneNumber: {
    type: Number,
    ref: User,
    required: true,
  },
  type: {
    type: String, // 'deposit', 'withdrawal', or 'transfer'
    enum: ['deposit', 'withdrawal', 'transfer'],
    required: true,
  },
  amount: {
    type: Number,
    required: true,
  },
  description: {
    type: String,
    required: true,
  },
  timestamp: {
    type: Date,
  },
},);


module.exports =  mongoose.model('DepositWithdrawal', depositWithdrawalSchema);
