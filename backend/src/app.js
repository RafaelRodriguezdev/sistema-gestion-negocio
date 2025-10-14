
import express from "express";
import { pool } from "./config/db.js";

const app = express();
app.use(express.json());


app.get("/test-db", async (req, res) => {
    try {
        const [rows] = await pool.query("SELECT NOW() as fecha;");
        res.json(rows);
    } catch (error) {
        res.status(500).json({ error:error.message });
    }
});

app.listen(3000, () => console.log("Servidor backend en puerto 3000"));
