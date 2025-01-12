const mongoose = require('mongoose');
const { Schema } = mongoose;

const userSchema = new Schema({
    firstName: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 50,
    },
    lastName: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 50,
    },
    surName: {
        type: String,
        required: false,
        trim: true,
        maxlength: 50,
    },
    dateOfBirth: {
        type: String,
        required: true,
        trim: true,
        minlength: 3,
        maxlength: 50,
    },
    gender: {
        type: String,
        required: true,
        minlength: 4,
        maxlength: 6,
    },
    email: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        match: /^[^\s@]+@[^\s@]+\.[^\s@]+$/,
    },
    phoneNo: {
        type: String,
        required: true,
        unique: true,
        trim: true,
        match: /^\+?[0-9]{7,15}$/,
    },
    streetAddress: {
        type: String,
        required: false,
        trim: true,
        maxlength: 200,
    },
    city: {
        type: String,
        required: false,
        trim: true,
        maxlength: 50,
    },
    region: {
        type: String,
        required: false,
        trim: true,
        maxlength: 50,
    },
    zipCode: {
        type: String,
        required: false,
        trim: true,
        maxlength: 50,
    },
    country: {
        type: String,
        required: false,
        trim: true,
        maxlength: 50,
    },
    profession: {
        type: String,
        required: false,
        trim: true,
        maxlength: 100,
    },
},
);

module.exports = mongoose.model('User', userSchema);
