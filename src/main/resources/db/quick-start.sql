USE supply_chainx_db;
SELECT COUNT(*) as admin_count FROM users WHERE email = 'admin@supplychainx.com';
INSERT INTO users (first_name, last_name, email, password, role) 
VALUES ('Admin', 'SupplyChainX', 'admin@supplychainx.com', 'admin123', 'ADMIN');
SELECT * FROM users WHERE email = 'admin@supplychainx.com';
