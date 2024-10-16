# Staticize

**Staticize** is a lightweight, fast, and modular static site generator that allows you to build static websites effortlessly. It comes with a simple dynamic content loader and page generator, making it perfect for developers who want to quickly create and deploy static sites with minimal setup.

## Features

- Dynamic loading of HTML components (e.g., nav, footer, content).
- Modular architecture for easy page creation and management.
- Custom page generator to automate adding and removing pages.
- Flexible hosting options with built-in support for deploying via [Surge](https://surge.sh).

## Getting Started

### Installation

1. Clone this repository:

   ```bash
   git clone https://github.com/mojaveco/staticize.git
   cd staticize
   ```

### Project Structure

- `public/`: Contains all the public HTML files, including components like `nav.html`, `footer.html`, and pages in the `pages/` folder.
- `assets/css/`: Contains stylesheets for the project.
- `assets/js/`: Contains JavaScript for dynamically loading content into the main layout.
- `scripts/`: Contains the shell scripts for generating and destroying pages, deploying, and cleaning up.
- `Makefile`: Provides easy-to-use commands for managing the site.

### Usage

We provide several `make` commands for creating and managing your site.

#### 1. **Create a New Page**

You can easily create a new page using the `make create` command:

```bash
make create <page-name>
```

For example, to create an "About" page:

```bash
make create about
```

This will:
- Create `public/pages/about.html` with some boilerplate content.
- Add a link to the navigation for the new page.

#### 2. **Remove (Destroy) a Page**

You can remove a page using the `make destroy` command:

```bash
make destroy <page-name>
```

For example, to remove the "About" page:

```bash
make destroy about
```

This will:
- Remove `public/pages/about.html`.
- Remove the link to the page from the navigation in `nav.html`.

#### 3. **Clean Up Temporary Files**

To clean up any temporary files (e.g., `.tmp` or `.log` files), use the `make clean` command:

```bash
make clean
```

## Deployment

For deploying the site, Staticize comes with a built-in `make deploy` command that allows you to deploy your site easily. The default deployment configuration is designed to work with [Surge](https://surge.sh).

### Prerequisites for Deployment (Optional)

If you choose to deploy using Surge, you’ll need to install Surge:

```bash
npm install --global surge
```

### Deploying Your Site

To deploy your site, simply follow these steps:

1. **Create a CNAME File**: Before deploying, create a `public/CNAME` file with your custom domain (e.g., `staticize.co`):

   ```bash
   echo "staticize.co" > public/CNAME
   ```

2. **Run Deployment**: Once the `CNAME` file is in place, you can deploy the site by running:

   ```bash
   make deploy
   ```

This will deploy your site to the domain specified in the `CNAME` file. If you are using [Surge](https://surge.sh), the domain will be configured automatically.

### Custom Domain Setup (for Surge)

To use a custom domain (e.g., `staticize.co`) with Surge:

1. Set up a **CNAME record** with your domain registrar:
   - **Host/Name**: `www` (or leave blank for root domain).
   - **Type**: `CNAME`.
   - **Value**: `na-west1.surge.sh`.

2. The site will be deployed using the custom domain defined in your `CNAME` file.

3. (Optional) To enforce HTTPS for your custom domain:

   ```bash
   surge ssl staticize.co
   ```

### Contributing

We welcome contributions! Please fork this repository, submit pull requests, or open issues if you find any bugs or have suggestions for improvements.

---

### License

This project is licensed under the MIT License. See the [LICENSE](LICENSE.md) file for more details.