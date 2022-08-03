const express = require('express');
const adminRouter = express.Router();
const admin = require('../middlewares/admin');
const { Product } = require('../models/product');

//Adding Product
adminRouter.post('/admin/add-product', admin, async (req, res) => {
    try {
        const { name, description, images, quantity, price, category } = req.body;
        let product = new Product({ name, description, images, quantity, price, category });
        //saving to database
        product = await product.save();
        res.json(product);

    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//creating API for getting products
//api name = /admin/get-products

adminRouter.get('/admin/get-products', admin, async (req, res) => {
    try {
        const products = await Product.find({});
        res.json(products);
    } catch (e) {
        res.status(500).json({ error: e.message });
    }
    //        This is just the treail
});

//Deleting the product from the database
adminRouter.post('/admin/delete-product', admin, async (req, res) => {
    try {
        const { id } = req.body;
        let product = await Product.findByIdAndDelete(id);
        res.json(product);


    } catch (e) {
        res.status(500).json({ error: e.message });
    }
});

//6:08:57

module.exports = adminRouter;

