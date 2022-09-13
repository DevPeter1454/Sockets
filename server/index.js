const express = require('express');
const app = express();
const cors = require('cors');
require('dotenv').config();
app.use(cors());
app.use(express.json({limit: '50mb'}));
app.use(express.urlencoded({ extended: true }));

const PORT = process.env.PORT || 5080;
var connection = app.listen(PORT, ()=>{
    console.log(`Listening on port ${PORT}`);
});

const socketServer = require('socket.io');
const io = socketServer(connection, {cors: {options: '*'}});


io.on('connection', (socket)=>{
    console.log('A user connected');
    socket.on('disconnect', ()=>{
        console.log('A user disconnected');
    });
    socket.on('send-msg', (msg)=>{
        console.log(msg);
        io.emit('broadcast-msg', msg);
    });
});




