const monggose = require('mongoose');
const ratingSchema = monggose.Schema({
    userId: {
        type: String,
        required: true,
    },
    rating: {
        type: Number,
        required: true,
    },

});

module.exports = ratingSchema;