document.addEventListener('DOMContentLoaded', function() {
    
    // NAVBAR SCROLL
    const navbar = document.getElementById('navbar');
    window.addEventListener('scroll', () => {
        if (window.scrollY > 100) {
            navbar.style.background = 'rgba(10, 10, 10, 0.98)';
            navbar.style.padding = '0.7rem 0';
        } else {
            navbar.style.background = 'rgba(10, 10, 10, 0.95)';
            navbar.style.padding = '1rem 0';
        }
    });

    // HAMBURGER MENU
    const hamburger = document.getElementById('hamburger');
    const navMenu = document.getElementById('navMenu');
    
    hamburger.addEventListener('click', () => {
        navMenu.classList.toggle('active');
    });

    document.querySelectorAll('.nav-link').forEach(link => {
        link.addEventListener('click', () => {
            navMenu.classList.remove('active');
        });
    });

    // STEAM PARTICLES
    function createSteam() {
        const container = document.getElementById('steamContainer');
        if (!container) return;
        
        setInterval(() => {
            const steam = document.createElement('div');
            steam.className = 'steam-particle';
            steam.style.left = Math.random() * 100 + '%';
            steam.style.bottom = '10%';
            steam.style.animationDuration = (Math.random() * 4 + 4) + 's';
            steam.style.width = (Math.random() * 40 + 40) + 'px';
            steam.style.height = steam.style.width;
            container.appendChild(steam);
            
            setTimeout(() => steam.remove(), 8000);
        }, 800);
    }
    createSteam();

    // MENU TABS
    const tabBtns = document.querySelectorAll('.tab-btn');
    const menuCategories = document.querySelectorAll('.menu-category');

    tabBtns.forEach(btn => {
        btn.addEventListener('click', () => {
            tabBtns.forEach(b => b.classList.remove('active'));
            btn.classList.add('active');

            const tab = btn.getAttribute('data-tab');
            menuCategories.forEach(cat => {
                if (cat.id === tab) {
                    cat.classList.add('active');
                } else {
                    cat.classList.remove('active');
                }
            });
        });
    });

    // PRENOTAZIONE FORM
    const form = document.getElementById('prenotazioneForm');
    const formMessage = document.getElementById('formMessage');
    const dataInput = document.getElementById('data');
    
    const today = new Date().toISOString().split('T')[0];
    dataInput.setAttribute('min', today);

    form.addEventListener('submit', function(e) {
        e.preventDefault();

        const data = new Date(document.getElementById('data').value);
        const ora = document.getElementById('ora').value;
        
        if (data.getDay() === 1 && ora >= '19:00') {
            showMessage('Ci dispiace, il lunedì sera siamo chiusi!', 'error');
            return;
        }

        showMessage('✅ Prenotazione inviata con successo! Ti contatteremo presto.', 'success');
        form.reset();
    });

    function showMessage(text, type) {
        formMessage.textContent = text;
        formMessage.className = `form-message ${type}`;
        setTimeout(() => {
            formMessage.className = 'form-message';
        }, 5000);
    }

    // SMOOTH SCROLL
    document.querySelectorAll('a[href^="#"]').forEach(anchor => {
        anchor.addEventListener('click', function(e) {
            e.preventDefault();
            const target = document.querySelector(this.getAttribute('href'));
            if (target) {
                const offset = navbar.offsetHeight;
                const targetPosition = target.offsetTop - offset;
                window.scrollTo({
                    top: targetPosition,
                    behavior: 'smooth'
                });
            }
        });
    });

    // SCROLL ANIMATIONS
    const observerOptions = {
        threshold: 0.1,
        rootMargin: '0px 0px -50px 0px'
    };

    const observer = new IntersectionObserver((entries) => {
        entries.forEach(entry => {
            if (entry.isIntersecting) {
                entry.target.style.opacity = '1';
                entry.target.style.transform = 'translateY(0)';
            }
        });
    }, observerOptions);

    document.querySelectorAll('.chi-siamo-image, .chi-siamo-text, .proposta-item, .menu-category-image, .menu-item-with-image').forEach(el => {
        el.style.opacity = '0';
        el.style.transform = 'translateY(30px)';
        el.style.transition = 'all 0.8s ease';
        observer.observe(el);
    });

    // PARALLAX
    window.addEventListener('scroll', () => {
        const scrolled = window.pageYOffset;
        const heroBg = document.querySelector('.hero-bg img');
        if (heroBg && scrolled < window.innerHeight) {
            heroBg.style.transform = `scale(${1 + scrolled * 0.0005}) translateY(${scrolled * 0.3}px)`;
        }
    });

    console.log('%c Benvenuto da Bella Forno!', 'color: #FF6F00; font-size: 24px; font-weight: bold;');
    console.log('%cVia Adamello 12, Vedano al Lambro (MB)', 'color: #D32F2F; font-size: 14px;');
});