const body = document.querySelector('body'),
      sidebar = document.querySelector('.sidebar'),
      toggle = document.querySelector('.toggle'),
      searchBtn = document.querySelector('.search-box'),
      modeSwitch = document.querySelector('.toggle-switch'),
      modeText = document.querySelector('.mode-text'),
      sections = document.querySelectorAll('section'),
      navLinks = document.querySelectorAll('.nav-link a');

// Check and apply dark mode from localStorage
if (localStorage.getItem('darkMode') === 'enabled') {
    body.classList.add('dark');
    modeText.innerText = 'Light Mode';
}

// Check and apply sidebar state from localStorage
if (localStorage.getItem('sidebarState') === 'closed') {
    sidebar.classList.add('close');
}

// Function to highlight active link based on scroll
function activateLink() {
    let index = sections.length;
    while (--index && window.scrollY + 50 < sections[index].offsetTop) {}
    navLinks.forEach((link) => link.classList.remove('active'));
    navLinks[index].classList.add('active');
}

activateLink();
window.addEventListener('scroll', activateLink);

// Highlight clicked nav link
navLinks.forEach(link => {
    link.addEventListener('click', function () {
        navLinks.forEach(link => link.classList.remove('active'));
        this.classList.add('active');
    });
});

// Toggle sidebar open/close and save state
toggle.addEventListener('click', () => {
    sidebar.classList.toggle('close');
    if (sidebar.classList.contains('close')) {
        localStorage.setItem('sidebarState', 'closed');
    } else {
        localStorage.setItem('sidebarState', 'open');
    }
});

// Toggle dark mode and save state
modeSwitch.addEventListener('click', () => {
    body.classList.toggle('dark');
    if (body.classList.contains('dark')) {
        modeText.innerText = 'Light Mode';
        localStorage.setItem('darkMode', 'enabled'); 
    } else {
        modeText.innerText = 'Dark Mode';
        localStorage.setItem('darkMode', 'disabled');
    }
});
