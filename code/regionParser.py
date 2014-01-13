from lxml import etree

regionXml = etree.parse('region.xml')
region_dict = dict()

for region in regionXml.iterfind('region'):
	#print region.find('name').text
	
	for prefecture in region.find('prefectures').iterfind('prefecture'):
		region_dict.update({prefecture.text:region.find('name').text})




