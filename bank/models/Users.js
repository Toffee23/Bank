const mongoose = require('mongoose');

const UserSchema = new mongoose.Schema(
    {
        phone: {type: Number, required: true, unique: true,},
        email: {type: String, required: true, unique:true},
        password: {type: String, required: true},
        balance: {
            type: Number,
            default: 0, // Initialize with a balance of 0
          },
    }, {timestamps: true}
);

module.exports = mongoose.model('User', UserSchema);