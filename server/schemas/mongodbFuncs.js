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
      let doc = await UserSchema.findByIdAndRemove(getId)
      if (doc !== null) {
        resolve(doc)
      }
    } catch (error) {
      reject(error)
    }
  })
}
const mnDbUpdate = (thisName, newData) => {
  return new Promise(async (resolve, reject) => {
    try {
      let getId = await mnDbById(thisName)
      console.log(getId)
      let update =
        newData.buPassword == undefined && newData.bUsername !== undefined
          ? { bUsername: `${newData.bUsername}` }
          : null
      newData.buPassword !== undefined && newData.bUsername == undefined
        ? { buPassword: `${newData.buPassword}` }
        : null
      if (update !== null) {
        let doc = await UserSchema.findByIdAndUpdate(getId, update)
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
module.exports = {
  mnDbInsert,
  mnDbDelete,
  mnDbUpdate,
  mnDbGet,
  mnDbById,
}
