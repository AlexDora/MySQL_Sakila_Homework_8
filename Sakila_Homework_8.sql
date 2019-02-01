USE sakila;

#1A
SELECT first_name, last_name FROM actor

#1B
SELECT CONCAT(first_name, ' ', last_name) AS "Actor Name" FROM actor;

#2A
SELECT actor_id, first_name, last_name FROM actor WHERE first_name = 'Joe';

#2B
SELECT actor_id, first_name, last_name FROM actor WHERE last_name LIKE '%GEN%';

#2C
SELECT actor_id, last_name, first_name FROM actor WHERE last_name LIKE '%LI%';

#2D
SELECT country_id, country FROM country WHERE country IN ('Afghanistan', 'Bangladesh', 'China');

#3A
ALTER TABLE actor ADD COLUMN Description BLOB;

#3B
ALTER TABLE actor DROP COLUMN Description;

#4A
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name;

#4B
SELECT last_name, COUNT(last_name) FROM actor GROUP BY last_name HAVING COUNT(last_name) >= 2;

#4C (First detect the ID)
SELECT actor_id, first_name, last_name FROM actor WHERE last_name = 'WILLIAMS'

UPDATE actor SET first_name = 'HARPOR' WHERE actor_id = 172;

#4D
UPDATE actor SET first_name = 'GROUCHO' WHERE actor_id = 172;

#5A
DESCRIBE address;

#6A
SELECT first_name, last_name, address FROM staff JOIN address ON staff.address_id = address.address_id;

#6B
SELECT amount, payment_date FROM payment JOIN staff ON payment.staff_id= staff.staff_id AND payment_date LIKE '2005-08%';

#6C
SELECT title, COUNT(film_actor.actor_id) FROM film INNER JOIN film_actor ON film.film_id = film_actor.film_id GROUP BY film.film_id;

#6D
SELECT title, COUNT(inventory.inventory_id) FROM film INNER JOIN inventory ON film.film_id = inventory.film_id AND film.title 
LIKE 'Hunchback Impossible';

#6E
SELECT first_name, last_name, SUM(payment.amount) FROM customer INNER JOIN payment ON customer.customer_id = payment.customer_id 
GROUP BY customer.first_name, customer.last_name
ORDER BY last_name ASC;

#7A
SELECT title FROM film JOIN language ON film.language_id = language.language_id WHERE name = 'English' AND title LIKE 'K%' OR title LIKE 'Q%';

#7B
SELECT first_name, last_name FROM actor WHERE actor_id IN 
(SELECT actor_id FROM film_actor WHERE film_id IN 
(SELECT film_id FROM film WHERE title = 'Alone Trip'));

#7C 
SELECT first_name, last_name, email FROM customer JOIN address ON (customer.address_id = address.address_id) 
JOIN city ON (address.city_id = city.city_id) 
JOIN country ON (city.country_id = country.country_id) 
WHERE country = 'Canada';  

#7D
SELECT title FROM film WHERE film_id IN 
(SELECT film_id FROM film_category WHERE category_id IN 
(SELECT category_id FROM category WHERE name = 'Family'));

#7E
SELECT title, COUNT(rental.rental_id) FROM film 
JOIN inventory ON (film.film_id = inventory.film_id) 
JOIN rental ON (inventory.inventory_id = rental.inventory_id)
GROUP BY title ORDER BY COUNT(rental.rental_id) DESC;

#7F
SELECT store.store_id, SUM(payment.amount) FROM store
JOIN customer ON (store.store_id = customer.store_id)
JOIN payment ON (customer.customer_id = payment.customer_id)
GROUP BY store.store_id;

#7G
SELECT store.store_id, city.city, country.country FROM store
JOIN address ON store.address_id = address.address_id
JOIN city ON address.city_id = city.city_id
JOIN country ON city.country_id = country.country_id
GROUP BY store.store_id, city.city, country.country;

#7H
SELECT name, SUM(payment.amount) FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY name
ORDER BY SUM(payment.amount) DESC 
LIMIT 5;

#8A
CREATE VIEW top_five_genres AS
SELECT name AS 'Genre', SUM(payment.amount) AS 'Gross Revenue' FROM category
JOIN film_category ON category.category_id = film_category.category_id
JOIN inventory ON film_category.film_id = inventory.film_id
JOIN rental ON inventory.inventory_id = rental.inventory_id
JOIN payment ON rental.rental_id = payment.rental_id
GROUP BY name
ORDER BY SUM(payment.amount) DESC
LIMIT 5;

#8B
SELECT * FROM top_five_genres;

#8C
DROP VIEW top_five_genres;