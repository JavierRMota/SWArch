exports.handler = async (event) => {
    const KITCHEN_PRODUCTS = ['Hamburger', 'Nuggets', 'Cheeseburger', 'French Fries', 'Hashbrown Fries', 'Pizza', 'Fries'];
    const SODA_PRODUCTS = [ 'Coke', 'Fanta', 'Square', 'Sprite', 'Seven Up', 'Ciel']
    const DESSERT_PRODUCTS = ['Cone icecream', 'Cake', 'Apple Pie', 'Pineapple Pie', 'Cookies\'n Cream', 'Sundae']
    if (KITCHEN_PRODUCTS.includes(event.order))
        return {
            order: event.order,
            type: 1
        }
    if (SODA_PRODUCTS.includes(event.order))
        return {
            order: event.order,
            type: 2
        }
    if (DESSERT_PRODUCTS.includes(event.order))
        return {
            order: event.order,
            type: 0
        }
    return { order: event.order, type: -1 };
};
