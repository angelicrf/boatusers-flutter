const mongoose = require('mongoose')

const mndbConnection = () => {
  try {
    //console.log(process.env.MONGODB_URL)
    const options = {
      autoIndex: false, // Don't build indexes
      maxPoolSize: 10, // Maintain up to 10 socket connections
      serverSelectionTimeoutMS: 5000, // Keep trying to send operations for 5 seconds
      socketTimeoutMS: 45000, // Close sockets after 45 seconds of inactivity
      family: 4, // Use IPv4, skip trying IPv6
    }
    const conn = mongoose
      .connect(
        'mongodb+srv://boatusersflutter:flutterboatusers123@cluster0.hyd0txd.mongodb.net/flutterbudb?retryWrites=true&w=majority',
        options,
      )
      .then(() => console.log('connected'))
      .catch((e) => console.log(e))
    return conn
  } catch (error) {
    console.log(error)
  }
}

module.exports = {
  mndbConnection,
}
