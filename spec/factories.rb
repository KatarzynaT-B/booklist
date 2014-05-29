FactoryGirl.define do
  factory :book do
    title "Zwycięzca"
    author "Jerzy Żuławski"
    url "http://wolnelektury.pl/katalog/lektura/trylogia-ksiezycowa-zwyciezca/"
    kind "Epika"
    genre "Powieść"
    epoch "Modernizm"
    audio false
    mobi false
    pdf false
    txt false
    epub false
  end
end
