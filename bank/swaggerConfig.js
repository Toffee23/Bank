/**
 * @swagger
 * components:
 *   schemas:
 *     User:
 *       type: object
 *       properties:
 *         _id:
 *           type: string
 *         name:
 *           type: string
 *         email:
 *           type: string
 *         balance:
 *           type: number
 *       example:
 *         _id: 12345
 *         name: John Doe
 *         email: john@example.com
 *         balance: 1000
 * 
 *     DepositWithdrawal:
 *       type: object
 *       properties:
 *         userId:
 *           type: string
 *         type:
 *           type: string
 *           enum: [deposit, withdrawal]
 *         amount:
 *           type: number
 *         timestamp:
 *           type: string
 *           format: date-time
 *       example:
 *         userId: 12345
 *         type: deposit
 *         amount: 500
 *         timestamp: '2023-11-05T12:00:00Z'
 */

/**
 * @swagger
 * tags:
 *   name: User
 *   description: Operations related to users
 * 
 *   name: Transaction
 *   description: Operations related to transactions
 */

/**
 * @swagger
 * /:
 *   get:
 *     summary: Returns a welcome message
 *     tags: [User]
 *     responses:
 *       '200':
 *         description: A welcome message
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/User'
 * 
 * /deposit:
 *   post:
 *     summary: Deposit money into the user's account
 *     tags: [Transaction]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: string
 *               amount:
 *                 type: number
 *             required:
 *               - userId
 *               - amount
 *     responses:
 *       '200':
 *         description: Deposit successful
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/DepositWithdrawal'
 * 
 * /withdraw:
 *   post:
 *     summary: Withdraw money from the user's account
 *     tags: [Transaction]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               userId:
 *                 type: string
 *               amount:
 *                 type: number
 *             required:
 *               - userId
 *               - amount
 *     responses:
 *       '200':
 *         description: Withdrawal successful
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/DepositWithdrawal'
 * 
 * /transfer:
 *   post:
 *     summary: Transfer money from one user to another
 *     tags: [Transaction]
 *     requestBody:
 *       required: true
 *       content:
 *         application/json:
 *           schema:
 *             type: object
 *             properties:
 *               senderId:
 *                 type: string
 *               receiverId:
 *                 type: string
 *               amount:
 *                 type: number
 *             required:
 *               - senderId
 *               - receiverId
 *               - amount
 *     responses:
 *       '200':
 *         description: Transfer successful
 *         content:
 *           application/json:
 *             schema:
 *               $ref: '#/components/schemas/DepositWithdrawal'
 * 
 * /transaction-history/{userId}:
 *   get:
 *     summary: Get transaction history for a specific user
 *     tags: [Transaction]
 *     parameters:
 *       - in: path
 *         name: userId
 *         required: true
 *         schema:
 *           type: string
 *     responses:
 *       '200':
 *         description: Transaction history retrieved successfully
 *         content:
 *           application/json:
 *             schema:
 *               type: array
 *               items:
 *                 $ref: '#/components/schemas/DepositWithdrawal'
 */
