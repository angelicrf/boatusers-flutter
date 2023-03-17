const express = require('express')
const app = express()
const port = process.env.PORT || 3000

const {
  mnDbInsert,
  mnDbGet,
  mnDbUpdate,
  mnDbDelete,
  mnDbById,
} = require('./schemas/mongodbFuncs')
require('dotenv').config({ path: './.env' })

var bodyParser = require('body-parser')
const { reset } = require('nodemon')
app.use(bodyParser.json())
app.use(bodyParser.urlencoded({ extended: true }))

app.get('/', async (req, res) => {
  return res.json({ msg: 'buHome' })
})
app.post('/api/postData', async (req, res) => {
  let getResult = await mnDbInsert()
  if (getResult.err == null && getResult !== 'exists') {
    return res.status(200).json({ msg: getResult })
  } else if (getResult.err == null && getResult == 'exists') {
    return res.status(200).json({ msg: 'Data Exists Already' })
  } else {
    return res.status(400).json({ msg: 'mndbInsert Error' })
  }
})
app.get('/api/getData', async (req, res) => {
  let getResult = await mnDbGet()
  if (getResult.err == null && getResult !== 'exists') {
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
app.post('/api/deleteData', async (req, res) => {
  let getReq = req.query.buName
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
app.post('/api/updateData', async (req, res) => {
  let getReq = req.query.buName
  let updatedParams = req.query.newData
  if (getReq !== undefined && updatedParams !== undefined) {
    let result = await mnDbUpdate(getReq)
    if (result.err == null) {
      return res.json({ msg: result })
    } else {
      return res.status(400).json({ msg: 'mndbUpdate Error' })
    }
  }
})

app.listen(port, () => {
  console.log(`app listening to port ${port}`)
})
