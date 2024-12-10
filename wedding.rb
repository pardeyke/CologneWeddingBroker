require 'capybara'
require 'capybara/dsl'

# Include the Capybara DSL
include Capybara::DSL

# Configure Capybara
Capybara.default_driver = :selenium # Uses Selenium WebDriver

# Start the browser
visit('https://www.stadt-koeln.de/leben-in-koeln/familie-kinder/ehe-lebenspartnerschaft/trautermin-online')

new_window = window_opened_by do
  click_link('Hier geht es zum Kalender')
end

# Switch to the new window
within_window(new_window) do
  # Interact with the new tab's content
  find('#location_f87de751-2f50-4993-8b45-32e11e4028aa').click
  find('#next-button').click
  click_button('10.06.2025')
  # Locate the element with the specific aria-label and click it
  find('[aria-label="Termin um 11:20 Uhr auswählen und zum nächsten Schritt wechseln."]').click
  sleep 1
  select 'Herr', from: 'person1anrede'
  fill_in('person1vorname', with: 'Max')
  fill_in('person1nachname', with: 'Mustermann')
  fill_in('person1geburtsdatum', with: '01.01.1990')
  fill_in('person1staatsangehoerigkeit', with: 'Deutsch')
  select('Ja', from: 'person1wohnsitzkoeln')

  select 'Frau', from: 'person1anrede'
  fill_in('person2vorname', with: 'Maria')
  fill_in('person2nachname', with: 'Musterfrau')
  fill_in('person2geburtsdatum', with: '01.01.1990')
  fill_in('person2staatsangehoerigkeit', with: 'Deutsch')
  select('Ja', from: 'person2wohnsitzkoeln')

  fill_in('mail', with: 'test@mail.com')
  check('accept_data_privacy')

  sleep 10
end
