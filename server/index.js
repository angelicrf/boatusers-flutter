require('dotenv').config({ path: './.env' })
const express = require('express')
const cors = require('cors')
const upload = require('./middleware/multermiddleware')
const { mndbConnection } = require('./mangoDbConnection')
const app = express()
const path = require('path')
const port = process.env.PORT || 3000

const {
  mnDbInsert,
  mnDbGet,
  mnDbUpdate,
  mnDbDelete,
  mnDbById,
} = require('./schemas/mongodbFuncs')
require('dotenv').config({ path: './.env' })

app.use(cors())
var bodyParser = require('body-parser')

app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

let conn = mndbConnection()
app.get('/', async (req, res) => {
  return res.json({ msg: 'buHome' })
})
app.post('/api/postData', upload.single('buFile'), async (req, res) => {
  console.log(req.body.buName)

  let getResult = await mnDbInsert(req.body.buName, req.body.buPassword)
  if (getResult.err == null && getResult !== 'exists') {
    return res.status(200).json({ msg: getResult })
  } else if (getResult.err == null && getResult == 'exists') {
    return res.status(200).json({ msg: 'Data Exists Already' })
  } else {
    return res.status(400).json({ msg: 'mndbInsert Error' })
  }
})
app.get('/api/getData', async (req, res) => {
  res.setHeader('Access-Control-Allow-Origin', '*')
  let getResult = await mnDbGet()
  if (getResult.err == null) {
    return res.status(200).json({ msg: getResult })
  } else {
    return res.status(400).json({ msg: 'mndbGet Error' })
  }
})
app.get('/api/getId', async (req, res) => {
  let getResult = await mnDbById()
  if (getResult.err == null) {
    return res.status(200).json({ msg: getResult })
  } else {
    return res.status(400).json({ msg: 'mndbGetById Error' })
  }
})
app.delete('/api/deleteData', async (req, res) => {
  let getReq = req.query.buName
  console.log(getReq)
  if (getReq != undefined) {
    let result = await mnDbDelete(getReq)
    if (result.err == null) {
      console.log(result)
      return res.json({ msg: `deleted data: ${result}` })
    } else {
      return res.status(400).json({ msg: 'mndbDelete Error' })
    }
  }
})
app.put('/api/updateData', async (req, res) => {
  let result = await mnDbUpdate(req.query.thisId, req.body)
  if (result.err == null) {
    return res.json({ msg: result })
  } else {
    return res.status(400).json({ msg: 'mndbUpdate Error' })
  }
})

app.listen(port, () => {
  console.log(`app listening to port ${port}`)
})
