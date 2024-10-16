document.addEventListener('DOMContentLoaded', function() {
    // Load the nav and footer on page load
    fetch('nav.html')
      .then(response => response.text())
      .then(data => document.getElementById('nav-placeholder').innerHTML = data);
  
    fetch('footer.html')
      .then(response => response.text())
      .then(data => document.getElementById('footer-placeholder').innerHTML = data);
  
    // Function to load different content into the content-placeholder
    function loadContent(page) {
      fetch(page)
        .then(response => response.text())
        .then(data => document.getElementById('content-placeholder').innerHTML = data);
    }
  
    // Handle clicks on nav links
    document.addEventListener('click', function(event) {
      if (event.target.matches('[data-page]')) {
        const page = event.target.getAttribute('data-page');
        loadContent(`pages/${page}.html`);
        event.preventDefault();
      }
    });
  
    // Load default homepage content
    loadContent('pages/home.html');
  });
  
  