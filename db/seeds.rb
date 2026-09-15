[
	"The Left Hand of Darkness",
	"Kindred",
	"The Dispossessed",
	"The Fifth Season",
	"Parable of the Sower"
].each do |title|
	Book.find_or_create_by!(title: title)
end
