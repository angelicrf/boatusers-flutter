const mogoose = require('mongoose')
const UserSchema = require('./userSchema')

const dataExists = async (buName) => {
  let found = await UserSchema.findOne({ buName: `${buName}` })
  console.log('fountId is', found)
  if (found !== null) {
    return true
  }
}
const mnDbInsert = (buName, buPassword) => {
  return new Promise(async (resolve, reject) => {
    try {
      let isExist = await dataExists(buName)
      if (!isExist) {
        let buData = new UserSchema({
          buName: `${buName}`,
          buPassword: `${buPassword}`,
        })
        if (buData.buName !== '') {
          try {
            let result = await buData.save()
            resolve(result)
          } catch (error) {
            reject(error)
          }
        }
      } else {
        resolve('exists')
      }
    } catch (error) {
      console.log(`error from post ${error}`)
    }
  })
}
const mnDbDelete = (thisName) => {
  return new Promise(async (resolve, reject) => {
    try {
      let getId = await mnDbById(thisName)
      console.log(getId)
      let doc = await UserSchema.findByIdAndDelete(getId)
      if (doc !== null) {
        resolve(doc)
      }
    } catch (error) {
      reject(error)
    }
  })
}
const mnDbUpdate = (thisId, newData) => {
  return new Promise(async (resolve, reject) => {
    try {
      if (newData !== null) {
        let doc = await UserSchema.findByIdAndUpdate(thisId, newData)
        if (doc !== null) {
          resolve(doc)
        }
      }
    } catch (error) {
      reject(error)
    }
  })
}
const mnDbGet = () => {
  return new Promise((resolve, reject) => {
    try {
      let filter = {}
      let result = UserSchema.find(filter)
      if (result.name !== '') {
        resolve(result)
      }
    } catch (error) {
      reject(error)
    }
  })
}
const mnDbById = (thisName) => {
  return new Promise(async (resolve, reject) => {
    try {
      let filter = { buName: `${thisName}` }
      let doc = await UserSchema.findOne(filter)
      if (doc._id !== null) {
        resolve(doc._id)
      }
    } catch (error) {
      reject(error)
    }
  })
}
const mnDbByIdData = (thisId) => {
  return new Promise(async (resolve, reject) => {
    try {
      let doc = await UserSchema.findById(thisId)
      if (doc._id !== null) {
        resolve(doc)
      }
    } catch (error) {
      reject(error)
    }
  })
}
module.exports = {
  mnDbInsert,
  mnDbDelete,
  mnDbUpdate,
  mnDbGet,
  mnDbById,
  mnDbByIdData,
}
