express = require('express');

const app = express();
const cors = require('cors');
const mongoose = require('mongoose');
const bodyParser = require('body-parser');
const User = require('./model/userModel');

mongoose.connect('mongodb+srv://burhanudddinfidaali:Malirwala5253@cluster0.8hofi.mongodb.net/?retryWrites=true&w=majority&appName=Cluster0/users')
    .then(() => console.log('Database connected successfully'))
    .catch((err) => console.error('Database connection error:', err));

app.use(cors());
app.use(express.json());
app.use(bodyParser.json());

app.get('/api/userdata', async (req, res) => {
    try {
        const users = await User.find();
        res.status(200).json(users);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to fetch user data' });
    }
});

app.post('/api/useradd' ,async (req, res) => {
    try {
        const { firstName, lastName, surName, gender, email, dateOfBirth, phoneNo, streetAddress, city, region, zipCode, country, profession } = req.body;
        const newUser = new User({
            firstName,
            lastName,
            surName,
            gender,
            email,
            dateOfBirth,
            phoneNo,
            streetAddress,
            city,
            region, 
            zipCode,
            country,
            profession,
        });

        const savedUser = await newUser.save();

        res.status(201).json({
            message: 'User created successfully',
            user: savedUser,
        });
        consile.log(savedUser);
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to create user' });
    }
});

app.put('/api/userdata', async (req, res) => {
    try {
        const { email, ...updatedData } = req.body;

        if (!email) {
            return res.status(400).json({ error: 'Email is required to update user data' });
        }

        const updatedUser = await User.findOneAndUpdate({ email }, updatedData, { new: true, runValidators: true });

        if (!updatedUser) {
            return res.status(404).json({ error: 'User not found' });
        }

        res.status(200).json({
            message: 'User updated successfully',
            user: updatedUser,
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to update user data' });
    }
});


app.delete('/api/userdata', async (req, res) => {
    try {
        await User.deleteMany();
        res.status(200).json({
            message: 'All users deleted successfully',
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to delete all user data' });
    }
});

app.delete('/api/userdata/del', async (req, res) => {
    try {
        const {email} = req.body;
        if (!email) {
            return res.status(400).json({ error: 'Email is required to delete user data' });
        }

        const prevUser = await User.findOneAndDelete({email});
        if (!prevUser) {
            return res.status(404).json({ error: 'User not found' });
        }
        res.status(200).json({
            message: 'User deleted successfully',
        });
    } catch (err) {
        console.error(err);
        res.status(500).json({ error: 'Failed to delete user data' });
    }
});

const PORT = 5050;
app.listen(PORT, () => {
    console.log(`API is running on http://localhost:${PORT}`);
})