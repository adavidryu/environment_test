titles = case Rails.env
				 when "production"
					 [
						 "Production Catalog: The Odyssey",
						 "Production Catalog: Jane Eyre",
						 "Production Catalog: Beloved",
						 "Production Catalog: The Hobbit",
						 "Production Catalog: Dune"
					 ]
				 when "test"
					 [
						 "Test Fixture: Book One",
						 "Test Fixture: Book Two",
						 "Test Fixture: Book Three",
						 "Test Fixture: Book Four",
						 "Test Fixture: Book Five"
					 ]
				 else
					 [
						 "The Left Hand of Darkness",
						 "Kindred",
						 "The Dispossessed",
						 "The Fifth Season",
						 "Parable of the Sower"
					 ]
				 end

		Book.delete_all

titles.each do |title|
	Book.find_or_create_by!(title: title)
end
