require 'capybara'
require 'capybara/dsl'

ort = 'Rentkammer'
datum = '17.06.2025'
uhrzeit = '14:00'

person1anrede = 'Herr'
person1vorname = 'Max'
person1nachname = 'Mustermann'
person1geburtsdatum = '01.01.1990'
person1staatsangehoerigkeit = 'Deutsch'

person2anrede = 'Frau'
person2vorname = 'Maria'
person2nachname = 'Musterfrau'
person2geburtsdatum = '01.01.1990'
person2staatsangehoerigkeit = 'Deutsch'

mail = 'test@test.com'


#############################################
#############################################


case ort
when 'Rathaus Porz'
  ort = 'location_7bb784f5-37e7-4aaf-9529-0a0aeee15b66'
when 'Rathaus Spanischer Bau'
  ort = 'location_c41ef34d-0423-4ad5-afb4-4cb669ac941d'
when 'Rentkammer'
  ort = 'location_f87de751-2f50-4993-8b45-32e11e4028aa'
when 'Weißer Saal'
  ort = 'location_b268b9a2-8141-4156-8e91-66edc1f618ca'
else
  puts 'Ort nicht bekannt'
end

include Capybara::DSL

Capybara.default_driver = :selenium_chrome

visit('https://www.stadt-koeln.de/leben-in-koeln/familie-kinder/ehe-lebenspartnerschaft/trautermin-online')

new_window = window_opened_by do
  click_link('Hier geht es zum Kalender')
end

within_window(new_window) do
  find("##{ort}").click
  find('#next-button').click
  begin
    click_button(datum)
  rescue Capybara::ElementNotFound
    sleep 10
  end
  begin
    find("[aria-label=\"Termin um #{uhrzeit} Uhr auswählen und zum nächsten Schritt wechseln.\"]").click
  rescue Capybara::ElementNotFound
    sleep 10
  end
  sleep 1
  select person1anrede, from: 'person1anrede'
  fill_in('person1vorname', with: person1vorname)
  fill_in('person1nachname', with: person1nachname)
  fill_in('person1geburtsdatum', with: person1geburtsdatum)
  fill_in('person1staatsangehoerigkeit', with: person1staatsangehoerigkeit)
  select('Ja', from: 'person1wohnsitzkoeln')

  select person2anrede, from: 'person1anrede'
  fill_in('person2vorname', with: person2vorname)
  fill_in('person2nachname', with: person2nachname)
  fill_in('person2geburtsdatum', with: person2geburtsdatum)
  fill_in('person2staatsangehoerigkeit', with: person2staatsangehoerigkeit)
  select('Ja', from: 'person2wohnsitzkoeln')

  fill_in('mail', with: mail)
  fill_in('mail_validation', with: mail)
  check('accept_data_privacy')

  sleep 1000
end
