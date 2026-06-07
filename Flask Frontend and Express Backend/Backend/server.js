const express = require("express");
const cors = require("cors");

const app = express();

app.use(cors());
app.use(express.json());

app.post("/api/submit", (req, res) => {
    const { name, email, message } = req.body;

    console.log("New Form Submission");
    console.log("Name:", name);
    console.log("Email:", email);
    console.log("Message:", message);

    res.json({
        success: true,
        ticketId: Date.now(),
        message: `Thank you ${name}! Your feedback has been recorded.`
    });
});

const PORT = 3000;

app.listen(PORT, () => {
    console.log(`Backend running on port ${PORT}`);
});