module ServicesHelper
     #for google map
  def google_map(center)
    "https://maps.googleapis.com/maps/api/staticmap?center=#{center}&size=824x365&zoom=17&key=#{ENV['API_KEY']}"
  end
end
