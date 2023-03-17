const mongoose = require('mongoose')
const { mndbConnection } = require('../mangoDbConnection')

let conn = mndbConnection()

const UserSchema = new mongoose.Schema(
  {
    buName: { type: String, required: true },
    buPassword: { type: String, required: true },
  },
  { collection: 'flutterbutable' },
)

module.exports = mongoose.model('usermodel', UserSchema)
