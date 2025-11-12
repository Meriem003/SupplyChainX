USE supply_chainx_db;
INSERT INTO users (first_name, last_name, email, password, role)
VALUES ('Admin', 'SupplyChainX', 'admin@supplychainx.com', '$2a$10$DHw7RIEJ97K33x6Q2iIupOe2bd90FNZQbZbzAK39cGKLRnjAKtMni', 'ADMIN');
SELECT id_user, first_name, last_name, email, role 
FROM users 
WHERE role = 'ADMIN';