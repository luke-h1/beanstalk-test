const express = require('express');


const app = express();


app.get('/', (req, res) => {
    return res.status(200).json({ status: 'OK' })
})

app.listen(process.env.PORT ?? 8000, () => {
    console.log('server up')
});