namespace :db do
    desc "Adatbázis kiürítése és új adatokkal feltöltése"
    task :populate => :environment do
      require 'populator'
      require 'faker'
      require_relative('populator_fixes.rb')
      
      [User, Item, Category].each(&:delete_all)
         
      password = "password"

      User.populate 3 do |user|
        user.email    = Faker::Internet.email
        user.encrypted_password = User.new(:password => password).encrypted_password
        Category.populate 1 do |category|
            category.name = Populator.words(1..2).titleize
            category.created_at = 2.years.ago..Time.now
            Item.populate 2 do |item|
                item.name = Populator.words(1..3).titleize
                item.description = Populator.sentences(10..20)
                item.created_at = 2.years.ago..Time.now
                item.user_id = user.id
            end
        end
      end

      Item.all.each { |item| item.item_img = File.open(Dir.glob(File.join(Rails.root, 'sampleimages', '*')).sample); item.save! }
    end
end