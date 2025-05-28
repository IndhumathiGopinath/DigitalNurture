// JavaScript for Community Event Portal

// Global variables and state
let events = [];
let registrations = [];
let totalRegistrationsByCategory = {};

// Event constructor/class
class Event {
    constructor(id, name, date, category, location, seats, price, description) {
        this.id = id;
        this.name = name;
        this.date = new Date(date);
        this.category = category;
        this.location = location;
        this.seats = seats;
        this.availableSeats = seats;
        this.price = price;
        this.description = description;
    }

    // Method to check availability
    checkAvailability() {
        return this.availableSeats > 0 && this.date > new Date();
    }

    // Method to register a user
    register() {
        if (this.checkAvailability()) {
            this.availableSeats--;
            return true;
        }
        return false;
    }

    // Method to format display
    formatDisplay() {
        return `${this.category.charAt(0).toUpperCase() + this.category.slice(1)} - ${this.name}`;
    }
}

// Initialize sample events
function initializeEvents() {
    const sampleEvents = [
        new Event(1, "Pottery Workshop", "2024-02-15", "workshop", "Community Center", 20, 25, "Learn basic pottery techniques"),
        new Event(2, "Jazz Night", "2024-02-20", "music", "City Park", 100, 15, "Live jazz performance under the stars"),
        new Event(3, "Basketball Tournament", "2024-02-25", "sports", "Sports Complex", 50, 10, "Annual community basketball championship"),
        new Event(4, "Town Hall Meeting", "2024-03-01", "community", "City Hall", 200, 0, "Monthly community discussion"),
        new Event(5, "Cooking Class", "2024-03-05", "workshop", "Community Kitchen", 15, 30, "Italian cuisine basics"),
        new Event(6, "Rock Concert", "2024-03-10", "music", "Amphitheater", 500, 20, "Local bands showcase")
    ];
    
    events = sampleEvents;
    displayEvents(events);
}

// Display events function
function displayEvents(eventsToShow) {
    const container = document.getElementById('eventsContainer');
    if (!container) return;

    container.innerHTML = '';

    eventsToShow.forEach(event => {
        const eventCard = document.createElement('div');
        eventCard.className = 'eventCard';
        
        const isAvailable = event.checkAvailability();
        const statusClass = isAvailable ? 'available' : 'unavailable';
        
        eventCard.innerHTML = `
            <h4>${event.formatDisplay()}</h4>
            <p><strong>Date:</strong> ${event.date.toLocaleDateString()}</p>
            <p><strong>Location:</strong> ${event.location}</p>
            <p><strong>Available Seats:</strong> ${event.availableSeats}/${event.seats}</p>
            <p><strong>Price:</strong> $${event.price}</p>
            <p>${event.description}</p>
            <button onclick="registerForEvent(${event.id})" 
                    ${!isAvailable ? 'disabled' : ''} 
                    class="cta-button ${statusClass}">
                ${isAvailable ? 'Register' : 'Full/Past'}
            </button>
        `;
        
        container.appendChild(eventCard);
    });
}

// Filter events by category
function filterEventsByCategory(category, callback) {
    const filtered = events.filter(event => {
        if (!category) return true;
        return event.category === category;
    });
    
    if (callback) callback(filtered);
    return filtered;
}

// Search events by name
function searchEvents(searchTerm) {
    return events.filter(event => 
        event.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
        event.description.toLowerCase().includes(searchTerm.toLowerCase())
    );
}

// Register for event function
function registerForEvent(eventId) {
    try {
        const event = events.find(e => e.id === eventId);
        if (!event) {
            throw new Error('Event not found');
        }
        
        if (event.register()) {
            // Track registrations by category using closure
            const categoryTracker = (function() {
                if (!totalRegistrationsByCategory[event.category]) {
                    totalRegistrationsByCategory[event.category] = 0;
                }
                totalRegistrationsByCategory[event.category]++;
                return totalRegistrationsByCategory[event.category];
            })();
            
            alert(`Successfully registered for ${event.name}! Total ${event.category} registrations: ${categoryTracker}`);
            displayEvents(events); // Refresh display
        } else {
            throw new Error('Event is full or no longer available');
        }
    } catch (error) {
        alert(`Registration failed: ${error.message}`);
        console.error('Registration error:', error);
    }
}

// Form validation functions
function validatePhone() {
    const phoneInput = document.getElementById('userPhone');
    const phone = phoneInput.value;
    const phoneRegex = /^$$\d{3}$$\s\d{3}-\d{4}$/;
    
    if (phone && !phoneRegex.test(phone)) {
        alert('Please enter phone number in format: (555) 123-4567');
        phoneInput.focus();
    }
}

function showEventFee() {
    const select = document.getElementById('eventType');
    const feeDisplay = document.getElementById('eventFee');
    const selectedOption = select.options[select.selectedIndex];
    
    if (selectedOption && selectedOption.dataset.fee) {
        const fee = selectedOption.dataset.fee;
        feeDisplay.textContent = fee === '0' ? 'Free Event' : `Registration Fee: $${fee}`;
        
        // Save preference
        localStorage.setItem('preferredEventType', select.value);
    } else {
        feeDisplay.textContent = '';
    }
}

function countCharacters(elementId = 'userMessage', counterId = 'charCount') {
    const textarea = document.getElementById(elementId);
    const counter = document.getElementById(counterId);
    
    if (textarea && counter) {
        const count = textarea.value.length;
        counter.textContent = `${count} characters`;
        
        // Change color based on length
        if (count > 500) {
            counter.style.color = 'red';
        } else if (count > 300) {
            counter.style.color = 'orange';
        } else {
            counter.style.color = '#666';
        }
    }
}

function showConfirmation(event) {
    event.preventDefault();
    
    const form = document.getElementById('registrationForm');
    const formData = new FormData(form);
    const output = document.getElementById('confirmationOutput');
    
    // Basic form validation
    const name = formData.get('userName');
    const email = formData.get('userEmail');
    const eventType = formData.get('eventType');
    
    if (!name || !email || !eventType) {
        alert('Please fill in all required fields');
        return;
    }
    
    // Simulate form submission with async operation
    submitRegistration(formData)
        .then(result => {
            output.textContent = `Thank you, ${name}! Your registration for ${eventType} has been submitted successfully.`;
            output.style.display = 'block';
            form.reset();
        })
        .catch(error => {
            output.textContent = `Registration failed: ${error.message}`;
            output.style.backgroundColor = '#f8d7da';
            output.style.color = '#721c24';
        });
}

// Async function to simulate registration submission
async function submitRegistration(formData) {
    // Show loading spinner
    const spinner = document.getElementById('loadingSpinner');
    if (spinner) {
        spinner.style.display = 'block';
    }
    
    try {
        // Simulate API call with fetch
        const response = await fetch('/api/register', {
            method: 'POST',
            body: formData
        });
        
        // Simulate delay
        await new Promise(resolve => setTimeout(resolve, 1000));
        
        if (!response.ok) {
            throw new Error('Registration failed');
        }
        
        return await response.json();
    } catch (error) {
        // For demo purposes, we'll simulate success
        console.log('Simulated registration submission');
        return { success: true, message: 'Registration successful' };
    } finally {
        if (spinner) {
            spinner.style.display = 'none';
        }
    }
}

// Event handling functions
function handleKeyEvents(event) {
    const textarea = event.target;
    
    // Handle specific key combinations
    if (event.ctrlKey && event.key === 'Enter') {
        event.preventDefault();
        submitFeedback();
    }
    
    // Log key events for debugging
    console.log(`Key pressed: ${event.key}, Ctrl: ${event.ctrlKey}, Alt: ${event.altKey}`);
}

function updateRating() {
    const select = document.getElementById('rating');
    const display = document.getElementById('ratingDisplay');
    const value = select.value;
    
    if (value) {
        const stars = '★'.repeat(parseInt(value)) + '☆'.repeat(5 - parseInt(value));
        display.textContent = `Rating: ${stars} (${value}/5)`;
    } else {
        display.textContent = '';
    }
}

function submitFeedback() {
    const feedbackText = document.getElementById('feedbackText').value;
    const rating = document.getElementById('rating').value;
    
    if (!feedbackText || !rating) {
        alert('Please provide both feedback and rating');
        return;
    }
    
    alert('Thank you for your feedback! It has been submitted successfully.');
    
    // Clear form
    document.getElementById('feedbackForm').reset();
    document.getElementById('ratingDisplay').textContent = '';
    document.getElementById('feedbackCharCount').textContent = '0 characters';
}

function clearFeedback() {
    if (confirm('Are you sure you want to clear all feedback?')) {
        document.getElementById('feedbackForm').reset();
        document.getElementById('ratingDisplay').textContent = '';
        document.getElementById('feedbackCharCount').textContent = '0 characters';
    }
}

// Local storage functions
function savePreferences() {
    const eventType = document.getElementById('eventType').value;
    const categoryFilter = document.getElementById('categoryFilter').value;
    
    const preferences = {
        eventType: eventType,
        categoryFilter: categoryFilter,
        timestamp: new Date().toISOString()
    };
    
    localStorage.setItem('userPreferences', JSON.stringify(preferences));
    sessionStorage.setItem('sessionPreferences', JSON.stringify(preferences));
    
    document.getElementById('preferencesStatus').textContent = 'Preferences saved successfully!';
}

function loadPreferences() {
    const stored = localStorage.getItem('userPreferences');
    
    if (stored) {
        try {
            const preferences = JSON.parse(stored);
            
            if (preferences.eventType) {
                document.getElementById('eventType').value = preferences.eventType;
                showEventFee();
            }
            
            if (preferences.categoryFilter) {
                document.getElementById('categoryFilter').value = preferences.categoryFilter;
                filterEvents();
            }
            
            document.getElementById('preferencesStatus').textContent = 
                `Preferences loaded from ${new Date(preferences.timestamp).toLocaleDateString()}`;
        } catch (error) {
            console.error('Error loading preferences:', error);
        }
    } else {
        document.getElementById('preferencesStatus').textContent = 'No saved preferences found.';
    }
}

function clearPreferences() {
    localStorage.removeItem('userPreferences');
    sessionStorage.removeItem('sessionPreferences');
    
    // Reset form fields
    document.getElementById('eventType').value = '';
    document.getElementById('categoryFilter').value = '';
    document.getElementById('eventFee').textContent = '';
    
    document.getElementById('preferencesStatus').textContent = 'All preferences cleared.';
    
    // Refresh events display
    displayEvents(events);
}

// Geolocation functions
function findNearbyEvents() {
    const resultDiv = document.getElementById('locationResult');
    const nearbyDiv = document.getElementById('nearbyEvents');
    
    if (!navigator.geolocation) {
        resultDiv.textContent = 'Geolocation is not supported by this browser.';
        return;
    }
    
    const options = {
        enableHighAccuracy: true,
        timeout: 10000,
        maximumAge: 60000
    };
    
    resultDiv.textContent = 'Getting your location...';
    
    navigator.geolocation.getCurrentPosition(
        function(position) {
            const lat = position.coords.latitude;
            const lon = position.coords.longitude;
            const accuracy = position.coords.accuracy;
            
            resultDiv.innerHTML = `
                <p><strong>Your Location:</strong></p>
                <p>Latitude: ${lat.toFixed(6)}</p>
                <p>Longitude: ${lon.toFixed(6)}</p>
                <p>Accuracy: ${accuracy} meters</p>
            `;
            
            // Simulate finding nearby events
            const nearbyEventsList = events.filter(event => event.checkAvailability()).slice(0, 3);
            
            if (nearbyEventsList.length > 0) {
                nearbyDiv.innerHTML = '<h4>Nearby Events:</h4>' + 
                    nearbyEventsList.map(event => `
                        <div class="eventCard">
                            <h5>${event.name}</h5>
                            <p>Distance: ${(Math.random() * 10 + 1).toFixed(1)} km</p>
                            <p>Date: ${event.date.toLocaleDateString()}</p>
                        </div>
                    `).join('');
            } else {
                nearbyDiv.innerHTML = '<p>No nearby events found.</p>';
            }
        },
        function(error) {
            let errorMessage = 'An error occurred while retrieving your location.';
            
            switch(error.code) {
                case error.PERMISSION_DENIED:
                    errorMessage = 'Location access denied by user.';
                    break;
                case error.POSITION_UNAVAILABLE:
                    errorMessage = 'Location information is unavailable.';
                    break;
                case error.TIMEOUT:
                    errorMessage = 'Location request timed out.';
                    break;
            }
            
            resultDiv.textContent = errorMessage;
            console.error('Geolocation error:', error);
        },
        options
    );
}

// Filter and search event handlers
function filterEvents() {
    const categoryFilter = document.getElementById('categoryFilter').value;
    const searchTerm = document.getElementById('searchInput').value;
    
    let filteredEvents = events;
    
    // Apply category filter
    if (categoryFilter) {
        filteredEvents = filterEventsByCategory(categoryFilter);
    }
    
    // Apply search filter
    if (searchTerm) {
        filteredEvents = filteredEvents.filter(event => 
            event.name.toLowerCase().includes(searchTerm.toLowerCase()) ||
            event.description.toLowerCase().includes(searchTerm.toLowerCase())
        );
    }
    
    displayEvents(filteredEvents);
}

// Fetch events from mock API (simulation)
async function fetchEventsFromAPI() {
    try {
        const spinner = document.getElementById('loadingSpinner');
        if (spinner) spinner.style.display = 'block';
        
        // Simulate API call
        const response = await fetch('/api/events');
        
        if (!response.ok) {
            throw new Error('Failed to fetch events');
        }
        
        const data = await response.json();
        return data;
    } catch (error) {
        console.error('Error fetching events:', error);
        // Return sample data for demo
        return events;
    } finally {
        const spinner = document.getElementById('loadingSpinner');
        if (spinner) spinner.style.display = 'none';
    }
}

// Modern JavaScript features demonstration
const eventUtils = {
    // Arrow functions and default parameters
    formatEventDate: (date, format = 'short') => {
        const options = format === 'long' ? 
            { weekday: 'long', year: 'numeric', month: 'long', day: 'numeric' } :
            { year: 'numeric', month: 'short', day: 'numeric' };
        return new Date(date).toLocaleDateString('en-US', options);
    },
    
    // Destructuring and spread operator
    createEventSummary: (event) => {
        const { name, date, category, location, price } = event;
        return {
            ...event,
            summary: `${name} - ${category} event at ${location}`,
            formattedDate: eventUtils.formatEventDate(date)
        };
    },
    
    // Template literals and array methods
    generateEventList: (events) => {
        return events
            .filter(event => event.checkAvailability())
            .map(event => eventUtils.createEventSummary(event))
            .sort((a, b) => new Date(a.date) - new Date(b.date));
    }
};

// Initialize everything when DOM is loaded
document.addEventListener('DOMContentLoaded', function() {
    console.log('DOM fully loaded');
    
    // Initialize events
    initializeEvents();
    
    // Load saved preferences
    loadPreferences();
    
    // Set up event listeners
    const categoryFilter = document.getElementById('categoryFilter');
    const searchInput = document.getElementById('searchInput');
    
    if (categoryFilter) {
        categoryFilter.addEventListener('change', filterEvents);
    }
    
    if (searchInput) {
        searchInput.addEventListener('input', filterEvents);
        searchInput.addEventListener('keydown', function(e) {
            if (e.key === 'Enter') {
                e.preventDefault();
                filterEvents();
            }
        });
    }
    
    // Set up feedback character counting
    const feedbackText = document.getElementById('feedbackText');
    if (feedbackText) {
        feedbackText.addEventListener('keyup', function() {
            countCharacters('feedbackText', 'feedbackCharCount');
        });
    }
    
    // Set up image double-click to enlarge
    const galleryImages = document.querySelectorAll('.gallery-image');
    galleryImages.forEach(img => {
        img.addEventListener('dblclick', function() {
            // Create modal or enlarge image
            const modal = document.createElement('div');
            modal.style.cssText = `
                position: fixed;
                top: 0;
                left: 0;
                width: 100%;
                height: 100%;
                background: rgba(0,0,0,0.8);
                display: flex;
                justify-content: center;
                align-items: center;
                z-index: 1000;
                cursor: pointer;
            `;
            
            const enlargedImg = document.createElement('img');
            enlargedImg.src = this.src;
            enlargedImg.style.cssText = 'max-width: 90%; max-height: 90%; object-fit: contain;';
            
            modal.appendChild(enlargedImg);
            document.body.appendChild(modal);
            
            modal.addEventListener('click', function() {
                document.body.removeChild(modal);
            });
        });
    });
});

// Debug functions for Chrome DevTools
window.debugPortal = {
    events: () => events,
    registrations: () => registrations,
    categoryStats: () => totalRegistrationsByCategory,
    clearData: () => {
        events = [];
        registrations = [];
        totalRegistrationsByCategory = {};
        console.log('All data cleared');
    },
    addTestEvent: () => {
        const testEvent = new Event(
            Date.now(),
            'Debug Test Event',
            '2024-12-31',
            'workshop',
            'Debug Location',
            10,
            5,
            'Test event for debugging'
        );
        events.push(testEvent);
        displayEvents(events);
        console.log('Test event added');
    }
};

// Export for testing (if using modules)
if (typeof module !== 'undefined' && module.exports) {
    module.exports = {
        Event,
        filterEventsByCategory,
        searchEvents,
        eventUtils
    };
}
