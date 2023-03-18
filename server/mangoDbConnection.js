const mongoose = require('mongoose')

const mndbConnection = () => {
  try {
    const mongoUrl = process.env.MONGODB_URL
    const options = {
      autoIndex: false,
      maxPoolSize: 10,
      serverSelectionTimeoutMS: 5000,
      socketTimeoutMS: 45000,
      family: 4,
      useNewUrlParser: true,
      useUnifiedTopology: true,
    }
    let conn = mongoose
      .connect(
        'mongodb+srv://boatusersflutter:flutterboatusers123@cluster0.hyd0txd.mongodb.net/flutterbudb?retryWrites=true&w=majority',
        options,
      )
      .then(() => console.log('Database connected'))
      .catch((error) => console.log(error))

    return conn
  } catch (error) {
    console.log(error)
  }
}

module.exports = {
  mndbConnection,
}
