# Staticize

[![MIT License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE.md)  
**Staticize** is a lightweight, fast, and modular static site generator. It helps developers build static websites effortlessly, with a focus on speed, simplicity, and minimal setup.

---

## 🚀 Features

- **Dynamic HTML loading** (e.g., nav, footer, content)
- **Modular architecture** for easy page management
- **Automated page generation** (add and remove pages instantly)
- **Seamless deployment** with [Surge](https://surge.sh)

---

## 📦 Project Structure

| Directory         | Description |
|-------------------|-------------|
| `public/`         | HTML files, including components (nav, footer) and pages |
| `assets/css/`     | Stylesheets for your site |
| `assets/js/`      | JavaScript for dynamic content loading |
| `scripts/`        | Shell scripts for page generation, deployment, and cleanup |
| `Makefile`        | Easy-to-use commands for site management |

---

## 🛠️ Getting Started

### 1. Installation

```bash
git clone https://github.com/mojaveco/staticize.git
cd staticize
```

### Git Version Control for Generated Websites

By default, Staticize does not track user-generated websites within the framework repository. If you want to track changes for a specific website, you can initialize a new Git repository inside the generated website folder:

Navigate to your website directory:
   ```bash
   cd websites/MyWebsite
   git init
   ```

### 2. Usage

Staticize uses `make` commands for effortless site management:

#### ➕ Create a New Page

```bash
make create <page-name>
```

Example:

```bash
make create about
```

This will:
- Generate `public/pages/about.html`
- Add a link to the navigation bar

#### ➖ Remove (Destroy) a Page

```bash
make destroy <page-name>
```

Example:

```bash
make destroy about
```

This will:
- Remove `public/pages/about.html`
- Remove the page link from the navigation

#### 🧹 Clean Temporary Files

```bash
make clean
```

Removes unnecessary files (e.g., `.tmp`, `.log`).

---

## 🌍 Deployment

Deploy your site effortlessly with the built-in `make deploy` command.

### Prerequisite (Optional for Surge)

Install Surge globally:

```bash
npm install --global surge
```

### Deploying Your Site

1. **Create a CNAME File**:  
   Add your custom domain to the `CNAME` file:

   ```bash
   echo "staticize.co" > public/CNAME
   ```

2. **Run the Deployment**:  
   Use the `make deploy` command to deploy:

   ```bash
   make deploy
   ```

If you are using [Surge](https://surge.sh), the deployment will automatically configure your domain from the `CNAME` file.

#### 🌐 Custom Domain Setup (For Surge)

1. Set up a **CNAME record** with your domain registrar:
   - **Host/Name**: `www` or leave blank for root
   - **Type**: `CNAME`
   - **Value**: `na-west1.surge.sh`

2. To enforce HTTPS for your custom domain:

   ```bash
   surge ssl staticize.co
   ```

---

## 🤝 Contributing

We welcome contributions! Fork the repository, submit pull requests, or open issues if you find any bugs or have ideas for improvements.

---

## 📜 License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for more details.