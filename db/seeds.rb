# This file should contain all the record creation needed to seed the database with its default values.
# The data can then be loaded with the rails db:seed command (or created alongside the database with db:setup).
#
# Examples:
#
#   movies = Movie.create([{ name: 'Star Wars' }, { name: 'Lord of the Rings' }])
#   Character.create(name: 'Luke', movie: movies.first)
Pet.destroy_all
# ShelterReview.destroy_all
Shelter.destroy_all

shelter1 = Shelter.create!(name: "Happy Shelter", address: "114 Test Blvd", city: "Aurora", state: "CO", zip: "80202")
shelter2 = Shelter.create!(name: "Pups R Us", address: "222 Sample St", city: "Denver", state: "CO", zip: "80211")

pet1 = shelter1.pets.create!(image: "http://www.gsgsrescue.org/assets/files/dogs/2020/06/IMG_1639_1.jpg", name: "Bailey", age: "3", sex: "Female", description: "A good dog", status: "Adoptable")
pet2 = shelter1.pets.create!(image: "https://s3.amazonaws.com/cdn-origin-etr.akc.org/wp-content/uploads/2017/11/12234558/Chinook-On-White-03.jpg", name: "Ruby", age: "3", sex: "Female", description: "A loving dog", status: "Adoptable")
pet3 = shelter1.pets.create!(image: "https://www.thesprucepets.com/thmb/kV_cfc9P4QWe-klxZ8y--awxvY4=/960x0/filters:no_upscale():max_bytes(150000):strip_icc():format(webp)/adorable-white-pomeranian-puppy-spitz-921029690-5c8be25d46e0fb000172effe.jpg", name: "Bubba", age: "13", sex: "Male", description: "A fetching good dog", status: "Adoptable")
pet4 = shelter2.pets.create!(image: "https://www.sciencemag.org/sites/default/files/styles/article_main_image_-_1280w__no_aspect_/public/pearl_16x9.jpg?itok=tbir55jF", name: "Socks", age: "3", sex: "Female", description: "A nice dog", status: "Adoptable")

# shelter_review1 = shelter1.shelter_reviews.create!(title: "Okay shelter!", rating: 2, content: "Too many sad dogs.", picture: "https://imagesvc.meredithcorp.io/v3/mm/image?url=https%3A%2F%2Fstatic.onecms.io%2Fwp-content%2Fuploads%2Fsites%2F20%2F2019%2F01%2Fpuppies.jpg")
# shelter_review2 = shelter2.shelter_reviews.create!(title: "Pretty good shelter", rating: 4, content: "Has good dogs.")