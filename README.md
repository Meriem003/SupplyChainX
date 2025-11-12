# SupplyChainX - Système de Gestion de la Supply Chain

[![Spring Boot](https://img.shields.io/badge/Spring%20Boot-3.5.7-brightgreen.svg)](https://spring.io/projects/spring-boot)
[![Java](https://img.shields.io/badge/Java-17-blue.svg)](https://www.oracle.com/java/)
[![License](https://img.shields.io/badge/License-Apache%202.0-blue.svg)](https://opensource.org/licenses/Apache-2.0)

## 📋 Description

SupplyChainX est une application monolithique Spring Boot dédiée à la gestion complète de la chaîne d'approvisionnement. Elle couvre l'ensemble du processus depuis l'achat des matières premières jusqu'à la livraison des produits finis aux clients.

### Modules Principaux

- **Module Approvisionnement** : Gestion des fournisseurs, matières premières et commandes d'approvisionnement
- **Module Production** : Gestion des produits finis, nomenclatures (BOM) et ordres de production
- **Module Livraison** : Gestion des clients, commandes clients et livraisons
- **Module Utilisateur** : Gestion des utilisateurs avec authentification basée sur les rôles

## 🚀 Technologies Utilisées

### Backend
- **Spring Boot 3.5.7** - Framework principal
- **Spring Data JPA** - Gestion de la persistance
- **Hibernate** - ORM (Object-Relational Mapping)
- **Liquibase** - Gestion des migrations de base de données
- **MySQL** - Base de données relationnelle
- **MapStruct 1.5.5** - Mapping DTO ↔ Entité
- **Lombok** - Réduction du code boilerplate
- **Spring AOP** - Programmation orientée aspect (sécurité)
- **Bean Validation** - Validation des données

### Documentation & Test
- **SpringDoc OpenAPI 2.7.0** - Documentation Swagger/OpenAPI
- **JUnit 5** - Tests unitaires
- **Mockito** - Mock pour les tests

### Architecture
- **Architecture MVC** : Repository → Service → Controller
- **Pattern DTO** : Séparation entre les entités et l'API
- **Gestion centralisée des exceptions** : `@ControllerAdvice`
- **Pagination** : Support natif avec Spring Data

## 📦 Installation

### Prérequis
- Java 17 ou supérieur
- Maven 3.8+
- MySQL 8.0+
- Git

### Étapes d'installation

1. **Cloner le dépôt**
```bash
git clone https://github.com/Meriem003/SupplyChainX.git
cd SupplyChainX
```

2. **Configurer la base de données**

Créer une base de données MySQL :
```sql
CREATE DATABASE supplychainx;
CREATE USER 'supplychainx_user'@'localhost' IDENTIFIED BY 'votre_mot_de_passe';
GRANT ALL PRIVILEGES ON supplychainx.* TO 'supplychainx_user'@'localhost';
FLUSH PRIVILEGES;
```

3. **Configurer application.properties**

Modifier `src/main/resources/application.properties` :
```properties
spring.datasource.url=jdbc:mysql://localhost:3306/supplychainx
spring.datasource.username=supplychainx_user
spring.datasource.password=votre_mot_de_passe
```

4. **Compiler et lancer l'application**
```bash
# Compiler le projet
mvn clean install

# Lancer l'application
mvn spring-boot:run
```

L'application sera disponible sur : `http://localhost:8080`

## 📚 Documentation API

### Swagger UI
Une fois l'application lancée, accédez à la documentation interactive Swagger :
- **Interface Swagger UI** : http://localhost:8080/swagger-ui.html
- **Spécification OpenAPI JSON** : http://localhost:8080/v3/api-docs

### Authentification

L'API utilise une authentification simulée basée sur un header HTTP personnalisé :

```http
X-User-Id: 1
```

**Exemples d'utilisateurs** (après initialisation des données) :
- `X-User-Id: 1` → Admin (accès complet)
- `X-User-Id: 2` → Gestionnaire Approvisionnement
- `X-User-Id: 3` → Chef Production
- `X-User-Id: 4` → Gestionnaire Commercial

### Endpoints Principaux

#### Module Utilisateur
- `GET /api/users` - Liste des utilisateurs (paginée)
- `GET /api/users/{id}` - Détails d'un utilisateur
- `POST /api/users` - Créer un utilisateur
- `PUT /api/users/{id}` - Modifier un utilisateur
- `DELETE /api/users/{id}` - Supprimer un utilisateur

#### Module Approvisionnement
- `GET /api/suppliers` - Liste des fournisseurs
- `GET /api/raw-materials` - Liste des matières premières
- `GET /api/raw-materials/low-stock` - Matières en stock critique
- `GET /api/supply-orders` - Liste des commandes d'approvisionnement
- `POST /api/suppliers` - Créer un fournisseur
- `POST /api/supply-orders` - Créer une commande

#### Module Production
- `GET /api/products` - Liste des produits finis
- `GET /api/production-orders` - Liste des ordres de production
- `GET /api/bom` - Liste des nomenclatures
- `POST /api/production-orders` - Créer un ordre de production
- `POST /api/planning/check-availability` - Vérifier disponibilité matières
- `POST /api/planning/calculate-time/{orderId}` - Calculer temps de production

#### Module Livraison
- `GET /api/customers` - Liste des clients
- `GET /api/orders` - Liste des commandes clients
- `GET /api/deliveries` - Liste des livraisons
- `POST /api/orders` - Créer une commande client
- `POST /api/deliveries` - Créer une livraison
- `PUT /api/deliveries/{id}/cost` - Calculer le coût de livraison

### Guide Postman
Consultez le fichier [README_POSTMAN.md](README_POSTMAN.md) pour un guide détaillé d'utilisation avec Postman.

## 🗄️ Gestion de la Base de Données (Liquibase)

### Structure des Migrations

```
src/main/resources/db/changelog/
├── db.changelog-master.xml          # Fichier principal
├── v1.0/                            # Version 1.0 - Création des tables
│   ├── 01-create-user-table.xml
│   ├── 02-create-supplier-table.xml
│   ├── 03-create-raw-material-table.xml
│   ├── 04-create-supply-order-table.xml
│   ├── 05-create-supplier-raw-material-table.xml
│   ├── 06-create-product-table.xml
│   ├── 07-create-bill-of-material-table.xml
│   ├── 08-create-production-order-table.xml
│   ├── 09-create-customer-table.xml
│   ├── 10-create-order-table.xml
│   └── 11-create-delivery-table.xml
├── v1.1/                            # Version 1.1 - Données initiales
│   └── insert-initial-data.xml
└── v1.2/                            # Version 1.2 - Évolutions
    ├── add-customer-email-phone.xml
    └── update-order-status.xml
```

### Commandes Liquibase

```bash
# Afficher l'état des migrations
mvn liquibase:status

# Appliquer les migrations
mvn liquibase:update

# Générer un diff
mvn liquibase:diff

# Rollback de la dernière migration
mvn liquibase:rollback -Dliquibase.rollbackCount=1
```

Les migrations sont automatiquement appliquées au démarrage de l'application.

## 🏗️ Structure du Projet

```
SupplyChainX/
├── src/main/java/com/supplychainx/
│   ├── SupplyChainXApplication.java      # Classe principale
│   ├── approvisionnement/                # Module Approvisionnement
│   │   ├── controller/
│   │   ├── service/
│   │   ├── repository/
│   │   ├── entity/
│   │   ├── dto/
│   │   └── mapper/
│   ├── production/                       # Module Production
│   │   ├── controller/
│   │   ├── service/
│   │   ├── repository/
│   │   ├── entity/
│   │   ├── dto/
│   │   └── mapper/
│   ├── livraison/                        # Module Livraison
│   │   ├── controller/
│   │   ├── service/
│   │   ├── repository/
│   │   ├── entity/
│   │   ├── dto/
│   │   └── mapper/
│   ├── user/                             # Module Utilisateur
│   │   ├── controller/
│   │   ├── service/
│   │   ├── repository/
│   │   ├── entity/
│   │   ├── dto/
│   │   └── mapper/
│   ├── common/                           # Classes communes
│   │   ├── dto/
│   │   └── util/
│   ├── config/                           # Configuration
│   │   └── SwaggerConfig.java
│   ├── security/                         # Sécurité (AOP)
│   │   ├── aspect/
│   │   └── annotation/
│   └── exception/                        # Gestion des exceptions
│       ├── GlobalExceptionHandler.java
│       └── custom exceptions...
└── src/main/resources/
    ├── application.properties
    └── db/changelog/                     # Scripts Liquibase
```

## 🔐 Sécurité

L'application implémente une sécurité simulée via **Spring AOP** :
- Vérification du header `X-User-Id` dans les requêtes HTTP
- Contrôle d'accès basé sur les rôles (RBAC)
- Annotations personnalisées pour la sécurisation des endpoints

### Rôles Disponibles

**Module Approvisionnement :**
- `GESTIONNAIRE_APPROVISIONNEMENT`
- `RESPONSABLE_ACHATS`
- `SUPERVISEUR_LOGISTIQUE`

**Module Production :**
- `CHEF_PRODUCTION`
- `PLANIFICATEUR`
- `SUPERVISEUR_PRODUCTION`

**Module Livraison :**
- `GESTIONNAIRE_COMMERCIAL`
- `RESPONSABLE_LOGISTIQUE`
- `SUPERVISEUR_LIVRAISONS`

**Administration :**
- `ADMIN` (accès complet à tous les modules)

## 🧪 Tests

```bash
# Lancer tous les tests
mvn test

# Lancer les tests avec couverture
mvn test jacoco:report

# Lancer uniquement les tests d'une classe
mvn test -Dtest=NomDeLaClasseTest
```

## 📊 Fonctionnalités Clés

### Module Approvisionnement
- ✅ Gestion CRUD des fournisseurs avec validation
- ✅ Gestion CRUD des matières premières
- ✅ Création et suivi des commandes d'approvisionnement
- ✅ Alertes stock minimum
- ✅ Recherche et filtrage avancés
- ✅ Pagination de toutes les listes

### Module Production
- ✅ Gestion CRUD des produits finis
- ✅ Gestion des nomenclatures (BOM)
- ✅ Création et suivi des ordres de production
- ✅ Vérification de disponibilité des matières
- ✅ Calcul du temps de production estimé
- ✅ Gestion des statuts (EN_ATTENTE, EN_PRODUCTION, TERMINE, BLOQUE)

### Module Livraison
- ✅ Gestion CRUD des clients
- ✅ Création et suivi des commandes clients
- ✅ Gestion des livraisons
- ✅ Calcul automatique des coûts de livraison
- ✅ Suivi des statuts (EN_PREPARATION, EN_ROUTE, LIVREE)
- ✅ Association commande-livraison

## 🚧 Évolutions Futures

- [ ] Scheduler pour alertes stock minimum par email (SMTP)
- [ ] Authentification JWT
- [ ] Interface frontend (React/Angular)
- [ ] Reporting et tableaux de bord
- [ ] Export de données (PDF, Excel)

**SupplyChainX** - Gestion Intégrée de la Supply Chain 🚀
=======
# 🚀 SupplyChainX - Système de Gestion de la Supply Chain

## 📖 Description

**SupplyChainX** est une application monolithique Spring Boot qui gère l'ensemble de la chaîne d'approvisionnement, de l'achat des matières premières jusqu'à la livraison des produits finis aux clients.

### 🎯 Modules Principaux

1. **📦 Approvisionnement** - Gestion des fournisseurs, matières premières et commandes
2. **🏭 Production** - Gestion des produits finis, nomenclatures (BOM) et ordres de production
3. **🚚 Livraison** - Gestion des clients, commandes clients et livraisons

---

## 🚀 Démarrage Rapide (3 étapes)

### 1️⃣ Créer la base de données
Ouvrez MySQL et exécutez :
```sql
CREATE DATABASE supply_chainx_db;
```

### 2️⃣ Configurer le mot de passe
Ouvrez : `src/main/resources/application.properties`

Changez cette ligne :
```properties
spring.datasource.password=VOTRE_MOT_DE_PASSE
```

### 3️⃣ Démarrer l'application
Double-cliquez sur : **`start.bat`**

Ou utilisez la commande :
```bash
.\mvnw.cmd spring-boot:run
```

✅ **C'est tout !** L'application démarre sur : http://localhost:8080

---

## 📚 Guide Complet

Lisez le fichier **[GUIDE_SIMPLE.md](GUIDE_SIMPLE.md)** pour apprendre à :
- Créer vos premières entités (tables)
- Créer des API REST
- Comprendre la structure du projet

---

## � Structure du Projet

```
src/main/java/com/supplychainx/
├── security/         → 🔒 Système de sécurité AOP (NOUVEAU)
│   ├── RequiresAuth.java
│   ├── RequiresRole.java
│   ├── SecurityAspect.java
│   └── AuthenticationService.java
├── exception/        → Gestion des erreurs
├── common/           → Utilisateurs et entités communes
│   ├── entity/       → User
│   ├── repository/   → UserRepository
│   ├── service/      → UserService
│   └── controller/   → UserController
├── approvisionnement/→ Module Approvisionnement
│   ├── entity/       → Supplier, RawMaterial, SupplyOrder
│   ├── repository/   → Accès base de données
│   ├── service/      → Logique métier
│   └── controller/   → API REST
├── production/       → Module Production
│   ├── entity/       → Product, BillOfMaterial, ProductionOrder
│   ├── repository/
│   ├── service/
│   └── controller/
└── livraison/        → Module Livraison
    ├── entity/       → Customer, Order, Delivery
    ├── repository/
    ├── service/
    └── controller/
```

---

## 📋 Quel rôle utiliser pour chaque User Story ?

### Module Approvisionnement

| User Story | Rôle à utiliser |
|------------|-----------------|
| US3: Ajouter un fournisseur | `UserRole.GESTIONNAIRE_APPROVISIONNEMENT` |
| US4: Modifier un fournisseur | `UserRole.GESTIONNAIRE_APPROVISIONNEMENT` |
| US5: Supprimer un fournisseur | `UserRole.GESTIONNAIRE_APPROVISIONNEMENT` |
| US6: Consulter tous les fournisseurs | `UserRole.SUPERVISEUR_LOGISTIQUE` |
| US7: Rechercher un fournisseur | `UserRole.RESPONSABLE_ACHATS` |
| US8: Ajouter une matière première | `UserRole.GESTIONNAIRE_APPROVISIONNEMENT` |
| US9: Modifier une matière première | `UserRole.GESTIONNAIRE_APPROVISIONNEMENT` |
| US10: Supprimer une matière première | `UserRole.GESTIONNAIRE_APPROVISIONNEMENT` |
| US11: Consulter toutes les matières | `UserRole.SUPERVISEUR_LOGISTIQUE` |
| US12: Filtrer matières (stock bas) | `UserRole.SUPERVISEUR_LOGISTIQUE` |
| US13: Créer commande approvisionnement | `UserRole.RESPONSABLE_ACHATS` |
| US14: Modifier commande | `UserRole.RESPONSABLE_ACHATS` |
| US15: Supprimer commande | `UserRole.RESPONSABLE_ACHATS` |
| US16: Consulter toutes les commandes | `UserRole.SUPERVISEUR_LOGISTIQUE` |
| US17: Suivre statut commandes | `UserRole.SUPERVISEUR_LOGISTIQUE` |

### Module Production

| User Story | Rôle à utiliser |
|------------|-----------------|
| US18: Ajouter un produit | `UserRole.CHEF_PRODUCTION` |
| US19: Modifier un produit | `UserRole.CHEF_PRODUCTION` |
| US20: Supprimer un produit | `UserRole.CHEF_PRODUCTION` |
| US21: Consulter tous les produits | `UserRole.SUPERVISEUR_PRODUCTION` |
| US22: Rechercher un produit | `UserRole.SUPERVISEUR_PRODUCTION` |
| US23: Créer ordre de production | `UserRole.CHEF_PRODUCTION` |
| US24: Modifier un ordre | `UserRole.CHEF_PRODUCTION` |
| US25: Annuler un ordre | `UserRole.CHEF_PRODUCTION` |
| US26: Consulter tous les ordres | `UserRole.SUPERVISEUR_PRODUCTION` |
| US27: Suivre statut ordres | `UserRole.SUPERVISEUR_PRODUCTION` |
| US28: Vérifier disponibilité matières | `UserRole.PLANIFICATEUR` |
| US29: Calculer temps production | `UserRole.PLANIFICATEUR` |

### Module Livraison

| User Story | Rôle à utiliser |
|------------|-----------------|
| US30: Ajouter un client | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US31: Modifier un client | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US32: Supprimer un client | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US33: Consulter tous les clients | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US34: Rechercher un client | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US35: Créer commande client | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US36: Modifier commande | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US37: Annuler commande | `UserRole.GESTIONNAIRE_COMMERCIAL` |
| US38: Consulter toutes les commandes | `UserRole.SUPERVISEUR_LIVRAISONS` |
| US39: Suivre statut commandes | `UserRole.SUPERVISEUR_LIVRAISONS` |
| US40: Créer livraison et calculer coût | `UserRole.RESPONSABLE_LOGISTIQUE` |

## 🔗 Relations entre Entités

```
┌─────────────┐
│    User     │
│ (Utilisateurs)│
└─────────────┘

┌──────────────┐         ┌──────────────┐
│   Supplier   │ 1     * │ SupplyOrder  │
│ (Fournisseur)│◄────────│  (Commande)  │
└──────┬───────┘         └──────┬───────┘
       │                        │
       │ *                      │ *
       │                        │
       ▼ *                      ▼ *
┌──────────────┐         ┌──────────────┐
│ RawMaterial  │         │ RawMaterial  │
│  (Matière)   │         │  (Matière)   │
└──────┬───────┘         └──────────────┘
       │
       │ *
       │
       ▼ *
┌──────────────┐         ┌──────────────┐
│BillOfMaterial│ *     1 │   Product    │
│    (BOM)     │────────►│  (Produit)   │
└──────────────┘         └──────┬───────┘
                                │
                                │ 1
                                │
                                ▼ *
                         ┌──────────────┐
                         │ProductionOrder│
                         │    (Ordre)    │
                         └──────┬───────┘
                                │
                                │ 1
                                │
                                ▼ *
┌──────────────┐         ┌──────────────┐
│   Customer   │ 1     * │    Order     │
│   (Client)   │◄────────│ (Commande)   │
└──────────────┘         └──────┬───────┘
                                │
                                │ 1
                                │
                                ▼ 1
                         ┌──────────────┐
                         │   Delivery   │
                         │ (Livraison)  │
                         └──────────────┘
```

**Légende:**
- `1` : Un seul
- `*` : Plusieurs
- `◄───` : Relation

---

---

## 👥 Les 10 Rôles Expliqués

### Module Approvisionnement 📦

| Rôle | Qui c'est ? | Que fait-il ? |
|------|-------------|---------------|
| `GESTIONNAIRE_APPROVISIONNEMENT` | Le manager | Gère fournisseurs et matières |
| `RESPONSABLE_ACHATS` | L'acheteur | Passe les commandes |
| `SUPERVISEUR_LOGISTIQUE` | Le superviseur | Surveille tout |

### Module Production 🏭

| Rôle | Qui c'est ? | Que fait-il ? |
|------|-------------|---------------|
| `CHEF_PRODUCTION` | Le chef d'atelier | Gère les produits et ordres |
| `PLANIFICATEUR` | Le planneur | Organise la production |
| `SUPERVISEUR_PRODUCTION` | Le superviseur | Surveille la production |

### Module Livraison 🚚

| Rôle | Qui c'est ? | Que fait-il ? |
|------|-------------|---------------|
| `GESTIONNAIRE_COMMERCIAL` | Le commercial | Gère clients et commandes |
| `RESPONSABLE_LOGISTIQUE` | Le logisticien | Organise les livraisons |
| `SUPERVISEUR_LIVRAISONS` | Le superviseur | Surveille les livraisons |

### Super Utilisateur 👑

| Rôle | Qui c'est ? | Que fait-il ? |
|------|-------------|---------------|
| `ADMIN` | L'administrateur | Peut TOUT faire |

---

## 🔧 Technologies

- **Java 17**
- **Spring Boot 3.5.7** (Framework)
- **MySQL** (Base de données)
- **Lombok** (Simplifier le code)

---
