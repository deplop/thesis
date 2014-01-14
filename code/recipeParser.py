#!/usr/bin/python -tt
# -*- coding: utf-8 -*-
import codecs
import sys 
import math

UTF8Writer = codecs.getwriter('utf8')
sys.stdout = UTF8Writer(sys.stdout)

from lxml import etree

regionXml = etree.parse('region.xml')
region_dict = dict()

i=1
for region in regionXml.iterfind('region'):
	#print region.find('name').text
	
	for prefecture in region.find('prefectures').iterfind('prefecture'):
		region_dict.update({prefecture.text:[region.find('name').text,i]})
	i+=1


recipeXml = etree.parse('first.xml')
content_id=1	
recipe_id=1
ingredient_id=1
#ingredient_id=1
ingredient_dict=dict()
f1=open("tbl_recipe.sql","w")
f2=open("tbl_ingredient.sql","w")
f3=open("tbl_content.sql","w")

print "DROP TABLE IF EXISTS tbl_recipe;"
print "DROP TABLE IF EXISTS tbl_ingredient;"
print "DROP TABLE IF EXISTS tbl_content;"

print """
DROP TABLE IF EXISTS `tbl_content`;
CREATE TABLE IF NOT EXISTS `tbl_content` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `recipe_id` int(11) DEFAULT NULL,
  `ingredient_id` int(11) DEFAULT NULL,
  `amount` float DEFAULT NULL,
  PRIMARY KEY (`id`),
  KEY `fk_content_1_idx` (`ingredient_id`),
  KEY `fk_content_2_idx` (`recipe_id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
"""

print """
DROP TABLE IF EXISTS `tbl_ingredient`;
CREATE TABLE IF NOT EXISTS `tbl_ingredient` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `unit` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `IU` float DEFAULT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=1 ;
"""

print """
DROP TABLE IF EXISTS `tbl_recipe`;
CREATE TABLE IF NOT EXISTS `tbl_recipe` (
  `id` int(11) NOT NULL AUTO_INCREMENT,
  `name` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `intro` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `instruction` varchar(45) COLLATE utf8_unicode_ci DEFAULT NULL,
  `image` varchar(256) COLLATE utf8_unicode_ci DEFAULT NULL,
  `region_id` int(11) NOT NULL,
  `user_id` int(11) NOT NULL,
  `url` varchar(128) COLLATE utf8_unicode_ci NOT NULL,
  PRIMARY KEY (`id`)
) ENGINE=InnoDB  DEFAULT CHARSET=utf8 COLLATE=utf8_unicode_ci AUTO_INCREMENT=3 ;
"""

for recipe in recipeXml.iterfind('recipe'):
	region_id=region_dict.get(recipe.find('prefecture').text)[1]
	recipe_name=recipe.find('name').text
	recipe_intro='NULL'#recipe.find('intro').text
	recipe_instruction='NULL'#recipe.find('instruction').text
	recipe_image='NULL'
	recipe_userid=0
	recipe_url=recipe.find('url').text
	# insert to tbl_recipe
	print u"INSERT INTO tbl_recipe VALUES (%d,'%s',%s,%s,%s,%d,%d,'%s');"%(recipe_id,recipe_name,recipe_intro,recipe_instruction,recipe_image,region_id,recipe_userid,recipe_url)
 	# f1.write("INSERT INTO tbl_recipe VALUES (%d,%s,%s,%s,%s,%d,%d,%s);"%(recipe_id,recipe_name,recipe_intro,recipe_instruction,recipe_image,region_id,recipe_userid,recipe_url))
	recipe_id+=1
	for ingredient in recipe.iterfind('ingredient'):
		name=ingredient.find('name').text
		unit=ingredient.find('unit').text
		amount=float(ingredient.find('amount').text)

		
		if(ingredient_dict.has_key(name)==False):
			region_list=[region_id]	
			ingredient_dict.update({name:region_list})
			#ingredient_id=ingredient_dict.keys().index(name)+1
			# insert to tbl_ingredient	
			print u"INSERT INTO tbl_ingredient VALUES (%d,'%s','%s',NULL);"%(ingredient_id,name,unit)
			ingredient_id+=1
			# f2.write("INSERT INTO tbl_ingredient VALUES (%d,%s,%s,%0.2f);"%(ingredient_id,name,unit,8/len(ingredient_dict.get(name))))
		else:
			region_list=ingredient_dict.get(name)
			if(region_id not in region_list):
				region_list.append(region_id)	
			ingredient_dict[name]=region_list
		
		
		# insert to tbl_content
		print u"INSERT INTO tbl_content VALUES (%d,%d,%d,%0.2f);"%(content_id,recipe_id,ingredient_id,amount)
		content_id+=1
		# f3.write("INSERT INTO tbl_content VALUES (%d,%d,%d,%f);"%(content_id,recipe_id,ingredient_id,amount))

for key,value in ingredient_dict.iteritems():
	print "UPDATE tbl_ingredient SET IU='%0.2f' WHERE name='%s';"%(math.log(8/len(value)+1),key) 
	
f1.close()
f2.close()
f3.close()

		


