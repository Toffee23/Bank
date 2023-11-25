const router = require('express').Router();
const User = require('../models/Users');
const DepositWithdrawal = require('../models/Deposit_Withdrawal');


//Transfer money to another user
/**
 * @swagger
 * /api/transact/transfer:
 *   post:
 *     summary: Transfer to others account
 *     tags:
 *       - Transfer
 *     requestBody:
 *       required: true
 *       content:
 *          application/json:
 *            schema:
 *              type: object
 *              properties:
 *                sender_email:
 *                  type: string
 *                receiver_phone:
 *                  type: integer  
 *                amount:
 *                  type: integer     
 *     responses:
 *       200:
 *         description: Successful login   
 *       401:
 *         description: Invalid credentials
 */
router.post('/transfer', async (req, res) => {
    try {
        const {sender_email, receiver_phone, amount } = req.body;
        const sender = await User.findOne({email: sender_email});
        const receiver = await User.findOne({phone: receiver_phone});

        if(!sender){
            res.status(404).json('sender not found');
            return;
        }

        if(!receiver){
            res.status(404).json('reciever not found');
            return;
        }

        if(sender.balance < amount){
            res.status(400).json('Insufficient balance')
        }

        sender.balance -= amount;
        await sender.save();

        receiver.balance += amount;
        await receiver.save();

        const transfer = new DepositWithdrawal({
            phoneNumber: receiver_phone,
            type: 'transfer',
            amount,
            description: `Transfer from ${sender_email}`,
          });
          await transfer.save();
        res.status(200).json({
            message: `Transferred $${amount} from ${sender_email} to ${receiver_phone}`,
            senderBalance: sender.balance
          })
    } catch (error) {
        res.status(500).json('Transfer Failed');
    }
});

//Transaction history
/**
 * @swagger
 * /api/transact/transaction-history/{phoneNumber}:
 *   get:
 *     summary: Transaction History
 *     tags:
 *       - Transfer
 *     parameters:
 *       - name: phoneNumber
 *         in: path
 *         type: integer
 *         required: true
 *         description: Transaction history for a particular user
 *     responses:
 *       200:
 *         description: Successful login
 *       401:
 *         description: Invalid credentials
 */
router.get('/transaction-history/:phone', async (req, res) => {

    try {
        const phone = req.params.phone
        console.log('Fetching transaction history for phone number:', phone);
        const user = await User.findOne({phone});

        !user && res.status(404).json('User not found');


        const transactions = await DepositWithdrawal.find({phoneNumber: phone }).sort({ timestamp: 'desc' });

        // Map transactions to include a description
        const transactionHistory = transactions.map(transaction => ({
          _id: transaction._id,
          phoneNumber: transaction.phone,
          type: transaction.type,
          amount: transaction.amount,
          description: getTransactionDescription(transaction.type),
          timestamp: transaction.timestamp,
        }));
    
        res.status(200).json(transactionHistory);
        // const transactions = await Transaction.find({
        //     $or: [{sender: phone}, {reciever: phone}]
        // });

        // res.status(200).json(transactionHistory);
    } catch (error) {
        res.status(500).json(error);
    }

})

function getTransactionDescription(type) {
    switch (type) {
      case 'deposit':
        return 'Deposit';
      case 'withdrawal':
        return 'Withdrawal';
      case 'transfer':
        return 'Transfer';
      default:
        return 'Unknown';
    }
  }


module.exports = router;