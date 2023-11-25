const router = require('express').Router();
const User = require('../models/Users'); 
const DepositWithdrawal = require('../models/Deposit_Withdrawal');

//Deposit into User's account
/**
 * @swagger
 * /api/depoWith/deposit:
 *   post:
 *     summary: Deposit Money
 *     tags:
 *       - Deposit/Withdraw
 *     requestBody:
 *       required: true
 *       content:
 *          application/json:
 *            schema:
 *              type: object
 *              properties:
 *                phone:
 *                  type: integer
 *                amount:
 *                  type: integer     
 *     responses:
 *       200:
 *         description: Successful login   
 *       401:
 *         description: Invalid credentials
 */
router.post('/deposit', async (req, res) => {
    try {
        const {phone, amount} = req.body;
        const user = await User.findOne({phone: phone});
        if(!user){
            res.status(404).json('User not found');
            return;
        }

        user.balance += amount;
        await user.save();

        const deposit = new DepositWithdrawal({
            phoneNumber: phone,
            type: 'deposit',
            amount: amount,
            description: 'Deposit',
            timestamp: new Date()
          });
          await deposit.save();

        res.status(200).json(`Deposited $${amount} into the account. New balance: $${user.balance}`)
    } catch (error) {
        res.status(500).json(error);
    }
});

//Withdraw Money from the User's account
/**
 * @swagger
 * /api/depoWith/withdraw:
 *   post:
 *     summary: Withdraw Money from one's account
 *     tags:
 *       - Deposit/Withdraw
 *     requestBody:
 *       required: true
 *       content:
 *          application/json:
 *            schema:
 *              type: object
 *              properties:
 *                phone:
 *                  type: integer
 *                amount:
 *                  type: integer     
 *     responses:
 *       200:
 *         description: Successful login   
 *       401:
 *         description: Invalid credentials
 */
router.post('/withdraw', async (req, res) => {
    try {
        const {phone, amount} = req.body;
        const user = await User.findOne({phone: phone});
        !user && res.status(404).json('User not found');

        if(user.balance < amount){
            res.status(400).json('Insufficient funds');
            return;
        }
        user.balance -= amount;
        await user.save();

        const withdrawal = new DepositWithdrawal({
            phoneNumber: phone,
            type: 'withdrawal',
            amount: amount,
            description: 'Withdrawal',
            timestamp: new Date()
          });
          await withdrawal.save();
          console.log(withdrawal);

        res.status(200).json(`Withdrawn $${amount} from the account. New balance: $${user.balance}`);
    } catch (error) {
        res.status(500).json('Withdrawal Failed: ${error}')
    }
})

module.exports = router;