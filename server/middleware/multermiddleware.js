const multer = require('multer')
const storage = multer.diskStorage({
  destination: function (req, file, callback) {
    callback(null, './uploads')
  },
  filename: function (req, file, callback) {
    console.log(file)
    if (file.originalname.length > 0)
      callback(null, file.fieldname + '-' + Date.now() + file.originalname)
  },
})
const fileFilter = (req, file, cb) => {
  if (
    file.mimetype == 'image/png' ||
    file.mimetype == 'image/jpg' ||
    file.mimetype == 'image/jpeg'
  ) {
    cb(null, true)
  } else {
    cb(null, false)
    const err = new Error('Only .png, .jpg and .jpeg format allowed!')
    err.name = 'ExtensionError'
    return cb(err)
  }
}
module.exports = multer({
  storage: storage,
  limits: {
    fileSize: 1024 * 1024 * 2,
  },
  fileFilter: fileFilter,
})
